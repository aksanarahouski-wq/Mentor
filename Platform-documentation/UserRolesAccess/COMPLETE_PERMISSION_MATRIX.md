# MENTOR Connector - Complete Permission Matrix & User Roles Documentation

**Document Version:** 2.0
**Last Updated:** December 3, 2025
**Status:** Comprehensive Analysis - Code Validated

---

## Table of Contents

1. [Executive Summary](#executive-summary)
2. [Critical Discrepancies Found](#critical-discrepancies-found)
3. [Access Levels (Core System)](#access-levels-core-system)
4. [User Roles (Complete List)](#user-roles-complete-list)
5. [Complete Permission Matrix by Module](#complete-permission-matrix-by-module)
6. [Database Schema](#database-schema)
7. [Permission Flow & Implementation](#permission-flow--implementation)
8. [File Locations](#file-locations)
9. [Recommendations](#recommendations)
10. [Appendix: User Scenarios](#appendix-user-scenarios)

---

## Executive Summary

The MENTOR Connector system implements a multi-layered role-based access control (RBAC) system with:

- **3 Access Levels** that can be assigned at both affiliate and program levels
- **8 Total User Roles** (7 computed roles + 1 superuser role)
- **Geographic-based permissions** via ZIP code mappings for affiliate users
- **10 Protected Modules** with granular permissions (Can-Edit, Can-See, No Access)
- **Request-level authorization** with cached permission resolution

### System Architecture

```
Access Levels (3) + Assignment Context (Affiliate/Program) + Special Flags (is_limited_contractor, is_superuser)
         ↓
Computed User Roles (8)
         ↓
Route Authorization (request_policy_configs.php)
         ↓
Module Permissions (Can-Edit / Can-See / No Access)
```

---

## Critical Discrepancies Found

### Discrepancy #1: Program Role Consolidation

**Confluence Documentation Shows:**
- Separate columns for "Program User (Full Access)" and "Program User (MC-only)"

**Actual Code Implementation:**
- Only ONE `program` role that combines BOTH Full Access and MC-Access Only
- The `program` role is computed as: `access_level != NQMS_ONLY`
- This means a program user with access_level=1 (Full Access) and access_level=2 (MC-Only) both get the same `program` role

**Location:** `/Users/aksana/Documents/Projects/Mentor/mentor-connect/plugins/Users/src/Trait/UserPermissionsTrait.php:569-584`

**Impact:**
- Permission matrix in Confluence shows different permissions for "Program User (Full Access)" vs "Program User (MC-only)", but the code doesn't differentiate between them
- Both types of program users will have identical permissions in the actual system

**Code Evidence:**
```php
// Line 569-584 in UserPermissionsTrait.php
if ($userProgram->access_level != UniversalEnumerations::getValue(UniversalEnumerations::KEY_ACCESS_LEVELS, UniversalEnumerations::NQMS_ONLY)) {
    $permissions['program'] = true;
}
```

---

### Discrepancy #2: Limited-Use Contractor Access Level

**Confluence Documentation Shows:**
- "Affiliate User (Limited-Use Contractor)" and "Program User (Limited-Use Contractor)" as separate role columns
- Does not specify what access level contractors have

**Actual Code Implementation:**
- Contractors can ONLY have NQMS-Only access
- The `is_limited_contractor` flag only creates limited variants of NQMS roles:
  - `nqms_affiliate_limited`
  - `nqms_program_limited`
- There is no way to create a contractor with Full Access or MC-Only access

**Location:** `/Users/aksana/Documents/Projects/Mentor/mentor-connect/plugins/Users/src/Trait/UserPermissionsTrait.php:592-634`

**Code Evidence:**
```php
// Lines 592-608: NQMS-only affiliate users
if ($userAffiliate->access_level == UniversalEnumerations::getValue(UniversalEnumerations::KEY_ACCESS_LEVELS, UniversalEnumerations::NQMS_ONLY)) {
    if ($userAffiliate->is_limited_contractor) {
        $permissions['nqms_affiliate_limited'] = true;
    } else {
        $permissions['nqms_affiliate'] = true;
    }
}

// Lines 617-634: NQMS-only program users
if ($userProgram->access_level == UniversalEnumerations::getValue(UniversalEnumerations::KEY_ACCESS_LEVELS, UniversalEnumerations::NQMS_ONLY)) {
    if ($userProgram->is_limited_contractor) {
        $permissions['nqms_program_limited'] = true;
    } else {
        $permissions['nqms_program'] = true;
    }
}
```

---

### Discrepancy #3: Missing Permission Differences

**Confluence Documentation Shows:**
- Different permissions between roles in various modules

**Issues Found:**
1. The permission matrix shows permissions for "Program User (MC-only)" but this role doesn't exist in code
2. Limited contractors are shown with different access across modules, but the documentation doesn't clarify which access level they have
3. Some modules (like Reports) show different permissions for roles that share the same computed role in code

---

## Access Levels (Core System)

**Source:** `/Users/aksana/Documents/Projects/Mentor/mentor-connect/src/General/UniversalEnumerations.php:14-32`

The system uses three distinct access levels that can be assigned to users at both the affiliate and program level:

| Access Level Name | Numeric Value | Constant Name | Description |
|-------------------|---------------|---------------|-------------|
| **Full Access** | 1 | `FULL_ACCESS` | Complete access to all NQMS and Mentoring Connector features for their assigned affiliate/program |
| **MC-Access Only** | 2 | `MENTOR_CONNECTOR_ONLY` | Limited to Mentoring Connector recruitment features: program inquiries, search data, inquiry responses. No NQMS access. |
| **NQMS-Access Only** | 3 | `NQMS_ONLY` | Limited to NQMS features: assessments, documents, goals, improvement plans. No recruitment/inquiry access. |

### How Access Levels Are Assigned

Access levels are stored in the join tables:
- **`programs_users.access_level`** - For program-level assignments
- **`affiliates_users.access_level`** - For affiliate-level assignments

Default value: `1` (Full Access)

### Code Implementation

```php
// UniversalEnumerations.php
public const FULL_ACCESS = 'Full Access';
public const MENTOR_CONNECTOR_ONLY = 'MC-Access Only';
public const NQMS_ONLY = 'NQMS-Access Only';

private static $enumerations = [
    self::KEY_ACCESS_LEVELS => [
        self::FULL_ACCESS => 1,
        self::MENTOR_CONNECTOR_ONLY => 2,
        self::NQMS_ONLY => 3,
    ],
];
```

---

## User Roles (Complete List)

**Source:** `/Users/aksana/Documents/Projects/Mentor/mentor-connect/plugins/Users/src/Trait/UserPermissionsTrait.php:644-673`

The system computes user roles dynamically based on their relationships in the database. Here are all 8 roles:

### Role Computation Table

| Role Name | Code Identifier | How It's Determined | Assignment Level | Access Level | Contractor Flag |
|-----------|-----------------|---------------------|------------------|--------------|-----------------|
| **Global Admin** | `global` | `users.is_superuser = 1` | System-wide | All | N/A |
| **Affiliate User (Full Access)** | `affiliate` | In `affiliates_users` with `access_level = 1` | Affiliate | Full Access | `is_limited_contractor = 0` |
| **Affiliate User (MC-Only)** | `mc_affiliate` | In `affiliates_users` with `access_level = 2` | Affiliate | MC-Access Only | `is_limited_contractor = 0` |
| **Affiliate User (NQMS-Only)** | `nqms_affiliate` | In `affiliates_users` with `access_level = 3` | Affiliate | NQMS-Access Only | `is_limited_contractor = 0` |
| **Affiliate Limited Contractor** | `nqms_affiliate_limited` | In `affiliates_users` with `access_level = 3` | Affiliate | NQMS-Access Only | `is_limited_contractor = 1` |
| **Program User** | `program` | In `programs_users` with `access_level IN (1, 2)` | Program | Full Access OR MC-Access Only | `is_limited_contractor = 0` |
| **Program User (NQMS-Only)** | `nqms_program` | In `programs_users` with `access_level = 3` | Program | NQMS-Access Only | `is_limited_contractor = 0` |
| **Program Limited Contractor** | `nqms_program_limited` | In `programs_users` with `access_level = 3` | Program | NQMS-Access Only | `is_limited_contractor = 1` |

### Important Notes

1. **Program Role Consolidation:** The `program` role encompasses BOTH "Full Access" (1) and "MC-Access Only" (2). There is no separate role for program users with MC-only access.

2. **Contractor Restrictions:** Limited contractors can ONLY have NQMS-Access Only (access_level = 3). There are no contractor variants for Full Access or MC-Only access levels.

3. **Multi-Role Users:** A single user can have multiple roles simultaneously:
   - Example: User assigned to both an affiliate (as Full Access) and a program (as NQMS-Only) will have both `affiliate` AND `nqms_program` roles

4. **Geographic Permissions:** Affiliate users inherit access to all programs within their affiliate's ZIP codes through the `programs.zip_code` to `affiliates_zip_codes.zip_code` relationship.

### Default Permission Set Structure

```php
// UserPermissionsTrait.php:644-655
private function getDefaultPermissionSet(): array
{
    return [
        'program' => false,
        'affiliate' => false,
        'nqms_program' => false,
        'nqms_affiliate' => false,
        'mc_affiliate' => false,
        'nqms_affiliate_limited' => false,
        'nqms_program_limited' => false,
    ];
}
```

---

## Complete Permission Matrix by Module

### Permission Legend

- **Can-Edit** - Full read/write/delete access to the module
- **Can-See** - Read-only access to the module
- **No Access** - Module not visible to user
- **Conditional** - Access depends on specific business rules (noted in superscript)

### Master Permission Matrix

| Module | Global Admin | Affiliate (Full) | Affiliate (MC-Only) | Affiliate (NQMS-Only) | Affiliate (Limited Contractor) | Program (Full/MC)¹ | Program (NQMS-Only) | Program (Limited Contractor) |
|--------|--------------|------------------|---------------------|----------------------|--------------------------------|-------------------|---------------------|------------------------------|
| **Reminders** | Can-Edit | Can-Edit | Can-Edit | Can-Edit | No Access | Can-Edit | Can-Edit | No Access |
| **Searches** | Can-Edit | Can-Edit | Can-Edit | No Access | No Access | Can-Edit | No Access | No Access |
| **Inquiries** | Can-Edit | Can-Edit | Can-Edit | No Access | No Access | Can-Edit | No Access | No Access |
| **Programs** (minus NQMS tab) | Can-Edit | Can-Edit | Can-Edit | Can-See | Can-See | Can-Edit | Can-See | Can-See |
| **Affiliates** | Can-Edit | Can-Edit | Can-Edit | Can-See | Can-See | No Access | No Access | No Access |
| **Accounts** (User Mgmt) | Can-Edit | Can-Edit | Can-Edit | No Access | No Access | Can-Edit | No Access | No Access |
| **Partners** | Can-Edit | No Access | No Access | No Access | No Access | No Access | No Access | No Access |
| **Reports** | Can-See | Can-See | No Access | Can-See | No Access | Can-See | Can-See | No Access |
| **NQMS Tab & Assessments** | Can-Edit | Can-Edit | No Access | Can-Edit | Can-Edit² | Can-Edit | Can-Edit | Can-Edit² |
| **NQMS Admin** (Question Template) | Can-Edit | No Access | No Access | No Access | No Access | No Access | No Access | No Access |

**Footnotes:**
1. **Program (Full/MC):** This single role in the code represents both "Program User (Full Access)" and "Program User (MC-only)" from the Confluence documentation. They cannot be differentiated in the current implementation.
2. **Limited Contractor NQMS Access:** Can only edit the most recent assessment per program, not historical assessments.

### Detailed Module Permissions

#### 1. Reminders Module
**Purpose:** Task reminders and notifications

| Role | Permission | Notes |
|------|------------|-------|
| Global Admin | Can-Edit | All reminders system-wide |
| Affiliate (Full) | Can-Edit | Reminders for their affiliate's programs |
| Affiliate (MC-Only) | Can-Edit | Reminders for MC-related tasks |
| Affiliate (NQMS-Only) | Can-Edit | Reminders for NQMS-related tasks |
| Affiliate (Limited Contractor) | No Access | Contractors cannot manage reminders |
| Program (Full/MC) | Can-Edit | Reminders for their program |
| Program (NQMS-Only) | Can-Edit | NQMS-related reminders for their program |
| Program (Limited Contractor) | No Access | Contractors cannot manage reminders |

**Code Reference:** `config/request_policy_configs.php` - Reminders controller policies

---

#### 2. Searches Module
**Purpose:** Saved searches for volunteers/mentors

| Role | Permission | Notes |
|------|------------|-------|
| Global Admin | Can-Edit | All searches system-wide |
| Affiliate (Full) | Can-Edit | Create/manage searches in their territory |
| Affiliate (MC-Only) | Can-Edit | MC recruitment searches |
| Affiliate (NQMS-Only) | No Access | NQMS users don't need search functionality |
| Affiliate (Limited Contractor) | No Access | No search access |
| Program (Full/MC) | Can-Edit | Create/manage searches for their program |
| Program (NQMS-Only) | No Access | NQMS users don't need search functionality |
| Program (Limited Contractor) | No Access | No search access |

**Code Reference:** `config/request_policy_configs.php:67-80`

---

#### 3. Inquiries Module
**Purpose:** Volunteer/mentor inquiry management

| Role | Permission | Notes |
|------|------------|-------|
| Global Admin | Can-Edit | All inquiries system-wide |
| Affiliate (Full) | Can-Edit | Inquiries for programs in their territory |
| Affiliate (MC-Only) | Can-Edit | Full inquiry management |
| Affiliate (NQMS-Only) | No Access | NQMS-focused users don't handle inquiries |
| Affiliate (Limited Contractor) | No Access | No inquiry access |
| Program (Full/MC) | Can-Edit | Inquiries for their program only |
| Program (NQMS-Only) | No Access | NQMS-focused users don't handle inquiries |
| Program (Limited Contractor) | No Access | No inquiry access |

**Code Reference:** `config/request_policy_configs.php:37-50`

---

#### 4. Programs Module (excluding NQMS tab)
**Purpose:** Program profile management, contact information, details

| Role | Permission | Notes |
|------|------------|-------|
| Global Admin | Can-Edit | All programs system-wide |
| Affiliate (Full) | Can-Edit | Programs in their territory (via ZIP codes) |
| Affiliate (MC-Only) | Can-Edit | Programs in their territory |
| Affiliate (NQMS-Only) | Can-See | Can view but not edit program details |
| Affiliate (Limited Contractor) | Can-See | Read-only access to program info |
| Program (Full/MC) | Can-Edit | Their own program details |
| Program (NQMS-Only) | Can-See | Can view their program but not edit |
| Program (Limited Contractor) | Can-See | Read-only access |

**Code Reference:** `plugins/Users/src/Trait/UserPermissionsTrait.php:100-124` (canEditProgram method)

---

#### 5. Affiliates Module
**Purpose:** Affiliate organization management

| Role | Permission | Notes |
|------|------------|-------|
| Global Admin | Can-Edit | All affiliates system-wide |
| Affiliate (Full) | Can-Edit | Can edit their own affiliate |
| Affiliate (MC-Only) | Can-Edit | Can edit their own affiliate |
| Affiliate (NQMS-Only) | Can-See | Can view but not edit affiliate details |
| Affiliate (Limited Contractor) | Can-See | Read-only access |
| Program (Full/MC) | No Access | Program users cannot access affiliate management |
| Program (NQMS-Only) | No Access | No affiliate access |
| Program (Limited Contractor) | No Access | No affiliate access |

**Code Reference:** `config/request_policy_configs.php:115-130`

---

#### 6. Accounts Module (User Management)
**Purpose:** Managing user accounts and access

| Role | Permission | Notes |
|------|------------|-------|
| Global Admin | Can-Edit | All users system-wide, can assign any role |
| Affiliate (Full) | Can-Edit | Can manage users for their affiliate and programs in territory |
| Affiliate (MC-Only) | Can-Edit | Can manage users for MC access |
| Affiliate (NQMS-Only) | No Access | Cannot manage user accounts |
| Affiliate (Limited Contractor) | No Access | Cannot manage user accounts |
| Program (Full/MC) | Can-Edit | Can manage users for their program only |
| Program (NQMS-Only) | No Access | Cannot manage user accounts |
| Program (Limited Contractor) | No Access | Cannot manage user accounts |

**Code Reference:** `plugins/Users/src/Controller/Admin/UsersController.php`

---

#### 7. Partners Module
**Purpose:** Managing partner organizations (system-wide)

| Role | Permission | Notes |
|------|------------|-------|
| Global Admin | Can-Edit | Full partner management |
| All Other Roles | No Access | Only global admins can manage partners |

**Code Reference:** `config/request_policy_configs.php:152-165`

---

#### 8. Reports Module
**Purpose:** Reporting and analytics

| Role | Permission | Notes |
|------|------------|-------|
| Global Admin | Can-See | All reports system-wide |
| Affiliate (Full) | Can-See | Reports for their territory |
| Affiliate (MC-Only) | No Access | MC-only users don't have report access |
| Affiliate (NQMS-Only) | Can-See | NQMS-related reports |
| Affiliate (Limited Contractor) | No Access | No report access |
| Program (Full/MC) | Can-See | Reports for their program |
| Program (NQMS-Only) | Can-See | NQMS-related reports for their program |
| Program (Limited Contractor) | No Access | No report access |

**Code Reference:** `config/request_policy_configs.php:133-149`

---

#### 9. NQMS Tab & Assessments
**Purpose:** NQMS quality assessments on program view page

| Role | Permission | Notes |
|------|------------|-------|
| Global Admin | Can-Edit | All assessments system-wide |
| Affiliate (Full) | Can-Edit | All assessments for programs in their territory |
| Affiliate (MC-Only) | No Access | MC-only users don't access NQMS |
| Affiliate (NQMS-Only) | Can-Edit | Full assessment access in their territory |
| Affiliate (Limited Contractor) | Can-Edit | LIMITED: Only most recent assessment per program |
| Program (Full/MC) | Can-Edit | All assessments for their program |
| Program (NQMS-Only) | Can-Edit | Full assessment access for their program |
| Program (Limited Contractor) | Can-Edit | LIMITED: Only most recent assessment for their program |

**Special Business Rule for Limited Contractors:**
- Can only edit the most recent (active) assessment per program
- Cannot access or edit historical/completed assessments
- This restriction is enforced at the controller level

**Code Reference:**
- `plugins/Users/src/Trait/UserPermissionsTrait.php:175-192` (canAccessNQMS method)
- `plugins/Users/src/Trait/UserPermissionsTrait.php:681-707` (canApproveAssessment method)

---

#### 10. NQMS Admin (Question Templates)
**Purpose:** Managing NQMS assessment question templates

| Role | Permission | Notes |
|------|------------|-------|
| Global Admin | Can-Edit | Full template management |
| All Other Roles | No Access | Only global admins can manage NQMS templates |

**Code Reference:** `config/request_policy_configs.php:221-235`

---

### Navigation Menu Rules

**Rule:** A module appears in the navigation menu if the user has "Can-See" OR "Can-Edit" access to ANY data within that module.

**Example:**
- An `nqms_affiliate` user has "Can-See" access to the Programs module
- Therefore, the Programs module will appear in their navigation menu
- However, they will see read-only views and edit buttons will be hidden/disabled

---

## Database Schema

### Core Tables

#### 1. `users` Table
**Migration:** `config/Migrations/20220725132953_CreateUsers.php`

| Column | Type | Description |
|--------|------|-------------|
| `id` | UUID | Primary key |
| `first_name` | VARCHAR(255) | User's first name |
| `last_name` | VARCHAR(255) | User's last name |
| `email` | VARCHAR(255) | Email address (unique, login identifier) |
| `password` | VARCHAR(255) | Hashed password |
| `is_superuser` | BOOLEAN | Global admin flag (grants `global` role) |
| `is_active` | BOOLEAN | Account active status |
| `is_verified` | BOOLEAN | Email verification status |
| `created` | DATETIME | Record creation timestamp |
| `modified` | DATETIME | Record modification timestamp |

---

#### 2. `programs_users` Table (Join Table)
**Migrations:**
- Base: `config/Migrations/20220907171238_CreateProgramsUsers.php`
- Access Level: `config/Migrations/20230305235226_UpdateIsNQMSColumnToAccessLevelInProgramsUsers.php`
- Contractor Flag: `config/Migrations/20230720034044_AddIsLimitedContractorColumnInProgramsUsers.php`

| Column | Type | Default | Description |
|--------|------|---------|-------------|
| `id` | INT | Auto-increment | Primary key |
| `program_id` | INT | Required | Foreign key to `programs.id` |
| `user_id` | UUID | Required | Foreign key to `users.id` |
| `access_level` | TINYINT | 1 | Access level: 1=Full, 2=MC-Only, 3=NQMS-Only |
| `is_limited_contractor` | BOOLEAN | 0 | Limited contractor flag |
| `created` | DATETIME | - | Record creation timestamp |
| `modified` | DATETIME | - | Record modification timestamp |

**Indexes:**
- `program_id` (foreign key)
- `user_id` (foreign key)
- Composite unique key on (`program_id`, `user_id`)

**Entity:** `plugins/Programs/src/Model/Entity/ProgramUser.php`

---

#### 3. `affiliates_users` Table (Join Table)
**Migrations:**
- Base: `config/Migrations/20220803194033_CreateAffiliatesUsers.php`
- Access Level: `config/Migrations/20230306001753_UpdateIsNQMSColumnToAccessLevelInAffiliatesUsers.php`
- Contractor Flag: `config/Migrations/20230719134833_AddIsLimitedContractorColumnInAffiliatesUsers.php`

| Column | Type | Default | Description |
|--------|------|---------|-------------|
| `id` | INT | Auto-increment | Primary key |
| `affiliate_id` | INT | Required | Foreign key to `affiliates.id` |
| `user_id` | UUID | Required | Foreign key to `users.id` |
| `access_level` | TINYINT | 1 | Access level: 1=Full, 2=MC-Only, 3=NQMS-Only |
| `is_limited_contractor` | BOOLEAN | 0 | Limited contractor flag |
| `created` | DATETIME | - | Record creation timestamp |
| `modified` | DATETIME | - | Record modification timestamp |

**Indexes:**
- `affiliate_id` (foreign key)
- `user_id` (foreign key)
- Composite unique key on (`affiliate_id`, `user_id`)

**Entity:** `plugins/Affiliates/src/Model/Entity/AffiliatesUser.php`

---

### Relationship Diagram

```
users (id: UUID, is_superuser)
  |
  +-- affiliates_users (affiliate_id, user_id, access_level, is_limited_contractor)
  |      |
  |      +-- affiliates (id, name, ...)
  |             |
  |             +-- affiliates_zip_codes (affiliate_id, zip_code)
  |                    |
  |                    +-- programs (id, zip_code, ...) [JOIN ON zip_code]
  |
  +-- programs_users (program_id, user_id, access_level, is_limited_contractor)
         |
         +-- programs (id, name, zip_code, ...)
```

---

## Permission Flow & Implementation

### 1. Authentication Flow

```
1. User logs in with email/password
   ↓
2. Authentication middleware validates credentials
   ↓
3. Session is created with user identity
   ↓
4. User entity is loaded into identity
```

**File:** `src/Application.php:304-310` (Authentication middleware setup)

---

### 2. Role Computation Flow

```
1. Request arrives with authenticated user
   ↓
2. Check cache for key: 'user_permissions_{user_id}'
   ↓
3a. IF CACHED: Return cached permission set
   ↓
3b. IF NOT CACHED:
      |
      +-- Query affiliates_users WHERE user_id = {user_id}
      |     |
      |     +-- For each affiliate assignment:
      |           - Check access_level and is_limited_contractor
      |           - Set appropriate role flag (affiliate, mc_affiliate, nqms_affiliate, nqms_affiliate_limited)
      |           - Get ZIP codes for affiliate
      |           - Get programs in those ZIP codes
      |
      +-- Query programs_users WHERE user_id = {user_id}
            |
            +-- For each program assignment:
                  - Check access_level and is_limited_contractor
                  - Set appropriate role flag (program, nqms_program, nqms_program_limited)
   ↓
4. Cache computed permission set
   ↓
5. Return permission set
```

**File:** `plugins/Users/src/Trait/UserPermissionsTrait.php:535-637` (getPermissionForEachRole method)

---

### 3. Authorization Flow (Per Request)

```
1. Request enters application
   ↓
2. AuthorizationMiddleware checks if route requires authorization
   ↓
3. IF unauthorized → Redirect to /authorization/unauthorized
   ↓
4. RequestPolicy.canAccess() is invoked
   ↓
5. Check if user is superuser
   |
   +-- IF YES → Grant access (bypass all checks)
   |
   +-- IF NO → Continue
   ↓
6. Loop through request_policy_configs.php entries
   ↓
7. Match current route (plugin, controller, action, prefix)
   ↓
8. Get required roles for matched route
   ↓
9. Check if user has ANY of the required roles
   |
   +-- IF YES → Grant access
   |
   +-- IF NO → Check next config
   ↓
10. IF no configs match → Use default policy
    |
    +-- IF Admin prefix → Deny access
    |
    +-- IF public area → Grant access
```

**Files:**
- Middleware: `src/Middleware/AuthorizationMiddleware.php`
- Policy: `plugins/Users/src/Policy/RequestPolicy.php:29-140`
- Configuration: `config/request_policy_configs.php`

---

### 4. Cache Management

**Cache Keys:**
- `user_permissions_{user_id}` - Computed role set for user
- `user-permission-programs-id-{searchType}-{userId}` - Program IDs for user

**Cache Invalidation Triggers:**
- User assigned to new program → Clear cache for that user
- User assigned to new affiliate → Clear cache for that user
- User's access_level changed → Clear cache for that user
- User's is_limited_contractor changed → Clear cache for that user

**Important:** Cache is NOT cleared when programs, assessments, or documents are modified. Only when user-program or user-affiliate relationships change.

**File:** `plugins/Users/src/Trait/UserCachesTrait.php`

---

### 5. Permission Checking Methods

#### a. `isSuperuser(?User $user = null): bool`
**Line:** 38-45
**Purpose:** Check if user is global admin
**Returns:** TRUE if `users.is_superuser = 1`

---

#### b. `canEditProgram(int $programId, ?User $user = null): bool`
**Line:** 100-124
**Purpose:** Check if user can edit a specific program
**Logic:**
1. Superuser → TRUE
2. Program user with `access_level != NQMS_ONLY` for that program → TRUE
3. Affiliate user with `access_level != NQMS_ONLY` in program's ZIP code territory → TRUE
4. Otherwise → FALSE

---

#### c. `canAccessNQMS(int $programId, ?User $user = null): bool`
**Line:** 175-192
**Purpose:** Check if user can access NQMS features for a program
**Logic:**
1. Superuser → TRUE
2. Program user with `access_level IN (1, 3)` (Full or NQMS-Only) → TRUE
3. Affiliate user with `access_level IN (1, 3)` in program's territory → TRUE
4. Otherwise → FALSE

---

#### d. `canApproveAssessment(int $programId, ?User $user = null): bool`
**Line:** 681-707
**Purpose:** Check if user can approve/finalize an assessment
**Logic:**
1. Superuser → TRUE
2. Program user (non-contractor) with NQMS access → TRUE
3. Affiliate user (non-contractor) with NQMS access → TRUE
4. Limited contractors → FALSE (cannot approve assessments)

---

#### e. `hasAccess(int $programId, int $notEqual, ?User $user = null): bool`
**Line:** 133-167
**Purpose:** Generic access check (used by canEditProgram and canAccessNQMS)
**Parameters:**
- `$programId` - Program to check access for
- `$notEqual` - Access level to EXCLUDE (e.g., exclude NQMS_ONLY for edit checks)

---

## File Locations

### Core Permission Files

| File Path | Purpose | Lines of Code |
|-----------|---------|---------------|
| `/src/General/UniversalEnumerations.php` | Access level constants and values | 87 |
| `/plugins/Users/src/Trait/UserPermissionsTrait.php` | Core permission computation and checking logic | 778 |
| `/plugins/Users/src/Policy/RequestPolicy.php` | Authorization policy (CakePHP authorization plugin) | 157 |
| `/plugins/Users/src/Model/Entity/User.php` | User entity with role properties | 588 |
| `/config/request_policy_configs.php` | Route-to-role authorization mappings | 284 |
| `/src/Middleware/AuthorizationMiddleware.php` | Custom authorization middleware | 59 |

### Database Layer Files

| File Path | Purpose |
|-----------|---------|
| `/plugins/Programs/src/Model/Table/ProgramsUsersTable.php` | Programs-users join table management |
| `/plugins/Programs/src/Model/Entity/ProgramUser.php` | Program user entity |
| `/plugins/Affiliates/src/Model/Table/AffiliatesUsersTable.php` | Affiliates-users join table management |
| `/plugins/Affiliates/src/Model/Entity/AffiliatesUser.php` | Affiliate user entity |
| `/plugins/Users/src/Model/Table/UsersTable.php` | Users table management |
| `/plugins/Users/src/Trait/UserCachesTrait.php` | Cache management for user permissions |

### Migration Files

| File Path | Purpose |
|-----------|---------|
| `/config/Migrations/20220725132953_CreateUsers.php` | Users table creation |
| `/config/Migrations/20220803194033_CreateAffiliatesUsers.php` | Affiliates-users join table |
| `/config/Migrations/20220907171238_CreateProgramsUsers.php` | Programs-users join table |
| `/config/Migrations/20230305235226_UpdateIsNQMSColumnToAccessLevelInProgramsUsers.php` | Added access_level to programs_users |
| `/config/Migrations/20230306001753_UpdateIsNQMSColumnToAccessLevelInAffiliatesUsers.php` | Added access_level to affiliates_users |
| `/config/Migrations/20230719134833_AddIsLimitedContractorColumnInAffiliatesUsers.php` | Added contractor flag to affiliates_users |
| `/config/Migrations/20230720034044_AddIsLimitedContractorColumnInProgramsUsers.php` | Added contractor flag to programs_users |

### UI/Controller Files

| File Path | Purpose |
|-----------|---------|
| `/plugins/Users/src/Controller/Admin/UsersController.php` | User management controller (includes access level assignment) |
| `/plugins/Users/templates/Admin/Users/edit.php` | User edit form with access level dropdowns |

---

## Recommendations

### Priority 1: High - Alignment Issues

#### 1.1 Separate Program User (Full Access) from Program User (MC-Only)

**Issue:** The code consolidates both access levels into a single `program` role, but documentation shows them as distinct roles with potentially different permissions.

**Recommendation:**
- **Option A (Recommended):** Update the Confluence documentation to reflect that Program User (Full Access) and Program User (MC-only) share the same permissions. Merge these columns in the permission matrix.
- **Option B:** Modify the code to create separate roles:
  ```php
  // In UserPermissionsTrait.php, replace lines 569-584 with:
  if ($userProgram->access_level == UniversalEnumerations::getValue(
      UniversalEnumerations::KEY_ACCESS_LEVELS,
      UniversalEnumerations::FULL_ACCESS
  )) {
      $permissions['program'] = true;
  } elseif ($userProgram->access_level == UniversalEnumerations::getValue(
      UniversalEnumerations::KEY_ACCESS_LEVELS,
      UniversalEnumerations::MENTOR_CONNECTOR_ONLY
  )) {
      $permissions['mc_program'] = true;
  }
  ```
- **Impact:** Option B requires updating `request_policy_configs.php` to add `mc_program` to relevant route policies.

**File to Update:** `plugins/Users/src/Trait/UserPermissionsTrait.php:569-584`

---

#### 1.2 Clarify Limited-Use Contractor Access Levels

**Issue:** Documentation shows "Limited-Use Contractor" as a role without specifying access level. Code only supports contractors with NQMS-Only access.

**Recommendation:**
- Update Confluence documentation to explicitly state:
  - "Limited-Use Contractor roles can ONLY be assigned with NQMS-Only access level"
  - "Contractors cannot have Full Access or MC-Only access"
- Rename the role columns to be more specific:
  - "Affiliate User (Limited-Use Contractor)" → "Affiliate Limited Contractor (NQMS-Only)"
  - "Program User (Limited-Use Contractor)" → "Program Limited Contractor (NQMS-Only)"

---

### Priority 2: Medium - Documentation Improvements

#### 2.1 Add Role Identifier Column to Permission Matrix

**Recommendation:** Add a new row to the Confluence permission matrix showing the code identifier for each role:

| Code Identifier | `global` | `affiliate` | `mc_affiliate` | `nqms_affiliate` | `nqms_affiliate_limited` | `program` | `nqms_program` | `nqms_program_limited` |

This will help developers quickly map documentation roles to code implementation.

---

#### 2.2 Add Database Schema Section

**Recommendation:** Add a section to the Confluence documentation explaining:
- How roles are stored (join tables)
- The two key fields: `access_level` and `is_limited_contractor`
- How role computation works
- Cache invalidation triggers

---

#### 2.3 Document Geographic Permission Inheritance

**Recommendation:** Add explicit documentation explaining that affiliate users get access to programs through ZIP code relationships:

```
Affiliate User → affiliates_users → affiliates → affiliates_zip_codes → programs (via zip_code match)
```

This is a critical aspect of the permission system that's not clearly documented.

---

### Priority 3: Low - Code Quality Improvements

#### 3.1 Add Role Constants

**Recommendation:** Define role identifier constants to avoid string literals throughout the codebase:

```php
// In UserPermissionsTrait.php or new RoleConstants.php file
public const ROLE_GLOBAL = 'global';
public const ROLE_AFFILIATE = 'affiliate';
public const ROLE_MC_AFFILIATE = 'mc_affiliate';
public const ROLE_NQMS_AFFILIATE = 'nqms_affiliate';
public const ROLE_NQMS_AFFILIATE_LIMITED = 'nqms_affiliate_limited';
public const ROLE_PROGRAM = 'program';
public const ROLE_NQMS_PROGRAM = 'nqms_program';
public const ROLE_NQMS_PROGRAM_LIMITED = 'nqms_program_limited';
```

**Benefit:** Prevents typos and makes refactoring easier.

---

#### 3.2 Add Unit Tests for Permission Computation

**Recommendation:** Create comprehensive unit tests for the `getPermissionForEachRole()` method covering all role combinations.

**File to Create:** `/tests/TestCase/Users/Trait/UserPermissionsTraitTest.php`

---

#### 3.3 Document Permission Caching

**Recommendation:** Add inline comments in the cache management code explaining:
- When cache is cleared
- When cache is NOT cleared
- Cache key structure
- TTL (if applicable)

---

### Priority 4: Future Enhancements

#### 4.1 Entity-Level Authorization

**Current State:** The system uses request-level authorization (route-based).

**Future Enhancement:** Consider adding entity-level authorization for finer-grained control:
- Allow editing specific fields based on role
- Row-level security for data access
- More granular permission checking within views

**Benefit:** More flexible permission model without requiring route changes.

---

#### 4.2 Permission Audit Log

**Recommendation:** Add audit logging for permission-related actions:
- User role assignments/changes
- Access level modifications
- Permission check failures
- Cache invalidations

**Benefit:** Compliance, security monitoring, debugging.

---

#### 4.3 Permission Testing UI

**Recommendation:** Build an admin tool to test "What can User X see/do?"

**Features:**
- Select a user
- View all computed roles
- View all accessible routes
- View all accessible programs/affiliates
- Simulate permission checks

**Benefit:** Easier troubleshooting and user support.

---

## Appendix: User Scenarios

*(Preserved from original Confluence document)*

### Scenario 1: NQMS and Program Access (Super User)

**Description:**
This user is often the existing primary staff member in your region interacting with the Mentoring Connector. The "NQMS and Program Access" user is assigned when the current Mentoring Connector administrator is also implementing NQMS work in your region. The responsibility for this user is to follow up with programs about volunteers, as well as duties related to the NQMS process. This user will receive automated emails related to both the Mentoring Connector and NQMS. This user also has the ability to see both volunteer inquiries and NQMS assessment information.

**Role Mapping:** `affiliate` (Affiliate User with Full Access, access_level = 1)

**Examples:**
- **Jane:** Admin coordinator at an affiliate. She may have access to both sides of the Connector to nudge programs for response to inquiries and is the staff person assigned to managing their affiliate's data (approve/deny programs). She is also the person to grant access to the NQMS for programs about to engage in the process.
- **Thor:** Associate director with a program. His work will include approving/denying programs and checking responsiveness to inquiries. As a member of the program's senior leadership, he will be taking the lead to fill out the NQMS assessment for the program.

---

### Scenario 2: NQMS Access Only

**Description:**
The "NQMS only" user is for staff members implementing the NQMS process in their region. This person is not responsible for any Mentoring Connector related responsibilities. They do not have access to any volunteer information or inquiries; their access is limited to program information and the NQMS assessment. This user will receive automated emails regarding NQMS assessments. Multiple staff members within a MENTOR affiliate can have NQMS Access only.

**Role Mapping:**
- `nqms_affiliate` (Affiliate User, access_level = 3, is_limited_contractor = 0)
- `nqms_program` (Program User, access_level = 3, is_limited_contractor = 0)

**Examples:**
- **Steve:** Consultant with an affiliate. He only needs access to the NQMS for the programs he will be assisting through the process. He does not need access to the volunteer inquiry data but may see the program's profile to learn more as he preps for the review (ex: model of program, how many mentors/mentees, program focus area, etc.).
- **Peggy:** Evaluation coordinator for a mentoring program. Her executive director wants her to have access to the NQMS to complete the questions about data outcomes, measurements, and evaluation outcomes. An NQMS-only user is created for her to access the assessment as she does not need access to the volunteer data in the system.

---

### Scenario 3: Mentoring Connector Access Only

**Description:**
This person approves program listings, follows up with unresponsive programs, and updates contact information as needed for program listings in their region. Due to the high amount of automated emails involved and the functionality of the Mentoring Connector tool, only one person at each affiliate level should be assigned this role.

**Role Mapping:** `mc_affiliate` (Affiliate User, access_level = 2)

**Examples:**
- **Wanda:** Marketing associate with an affiliate. She needs access to the Connector data as she will be following up with people as part of an evaluation on program responsiveness. She is a back-up to the super-user staff with access to both sides.
- **Vis:** Volunteer coordinator for a program. He needs access to inquiries that come in for the program in the Connector. He will not be taking part of the NQMS assessment for the program, therefore he does not need access to the assessment.

**Note:** In the current code implementation, there is no separate `mc_program` role. Vis would be assigned the `program` role (access_level = 2 in programs_users table), which gives him the same permissions as a Full Access program user.

---

## Document Change Log

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | 2023-03-03 | Original Team | Initial Confluence documentation |
| 2.0 | 2025-12-03 | System Analysis | Comprehensive code validation, discrepancy identification, complete file inventory, detailed recommendations |

---

**END OF DOCUMENT**
