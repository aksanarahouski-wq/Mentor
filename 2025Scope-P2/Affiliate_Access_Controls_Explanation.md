# How Account → Affiliate Access Controls Works

## Overview

**Affiliate Access Controls** is an administrative feature that allows system administrators to grant users access to specific affiliate organizations and their associated programs. It's part of the user management interface found at: **Account → Users → Edit User → Affiliate Access Controls section**

---

## The Three-Tier Access Level System

The system uses three distinct access levels defined in `UniversalEnumerations.php`:

| Access Level | Value | What It Grants |
|--------------|-------|----------------|
| **Full Access** | 1 | Complete access to affiliate data, programs, NQMS, and Mentoring Connector |
| **MC-Only** (Mentoring Connector) | 2 | Limited to recruitment features: program inquiries, search data, inquiry responses |
| **NQMS-Only** | 3 | Limited to NQMS features: self-assessments, documents, goals, I&I plans |

---

## How It Works

### 1. Database Structure
Affiliate-user relationships are stored in the `affiliates_users` table:

```
affiliates_users table:
├── id (primary key)
├── affiliate_id (which affiliate)
├── user_id (which user)
├── access_level (1, 2, or 3)
└── is_limited_contractor (boolean flag)
```

### 2. Admin Interface
When editing a user account, admins see a form with:
- **Multi-input widget** to add multiple affiliate assignments
- **Autocomplete field** to search for affiliates by name
- **Radio buttons** to select access level (Full/MC-Only/NQMS-Only)
- **Checkbox** to mark as "Limited Contractor" (even more restricted)

### 3. Permission Resolution
The system determines what a user can access through this chain:

```
User → Affiliate Assignment → Service Areas (ZIP codes) → Programs in those ZIPs
```

**Example:**
- Sarah is assigned to "MENTOR Colorado" with Full Access
- MENTOR Colorado serves ZIP codes: 80201, 80202, 80203
- Programs located in those ZIPs become accessible to Sarah
- Sarah can view/edit all NQMS and Connector data for those programs

---

## Access Level Behavior

### Full Access (Level 1)
- Can access **all** affiliate features
- Can work with programs in NQMS (assessments, goals, documents)
- Can work with programs in Mentoring Connector (recruitment)
- Grants the 'affiliate' permission role

### MC-Only (Level 2)
- **Cannot** access NQMS features
- **Can** access Mentoring Connector features
- Useful for recruitment-focused staff who don't need quality management tools

### NQMS-Only (Level 3)
- **Can** access NQMS features (assessments, goals, documents)
- **Cannot** access Mentoring Connector features
- Useful for quality consultants who don't need recruitment tools

### Limited Contractor Flag
- Additional restriction on top of access levels
- Even more limited permissions within their assigned scope
- Used for contractors with minimal access needs

---

## Key Technical Details

### Permission Checking
From `UserPermissionsTrait.php`, the system:
1. Checks if user is superuser (bypass all checks)
2. Checks direct program assignments in `programs_users` table
3. Checks affiliate assignments in `affiliates_users` table
4. Gets affiliate's service area ZIP codes
5. Finds programs in those ZIP codes
6. Grants access based on access level

### Cache Invalidation
When affiliate assignments change:
- User's permission cache is automatically cleared
- Ensures permissions are recalculated on next request
- Prevents stale access data

### Visibility Control
Only these users can see/manage Affiliate Access Controls:
- **Superusers** (global admins)
- **Users with 'affiliate' permission** (affiliate admins)

---

## Example Workflow

**Scenario:** Adding Sarah as a NQMS reviewer for MENTOR Colorado

1. Admin navigates to: **Users → Edit Sarah → Affiliate Access Controls**
2. Admin searches for "MENTOR Colorado" in autocomplete field
3. Admin selects **"NQMS-Only"** access level
4. Admin saves the user
5. System creates record in `affiliates_users`:
   - `affiliate_id` = MENTOR Colorado's ID
   - `user_id` = Sarah's ID
   - `access_level` = 3 (NQMS-Only)
6. Sarah can now:
   - ✅ Access NQMS assessments for Colorado programs
   - ✅ Manage goals and documents
   - ❌ Access Mentoring Connector features
   - ❌ Access programs outside Colorado's service area

---

## Technical Implementation Files

### Key Files Reference

| File | Purpose |
|------|---------|
| `plugins/Users/src/Controller/Admin/UsersController.php` | Handles user editing, sets access level options |
| `plugins/Users/templates/Admin/Users/edit.php` | UI form for Affiliate/Program Access Controls |
| `plugins/Affiliates/src/Model/Entity/AffiliatesUser.php` | Entity definition for affiliate-user relationship |
| `plugins/Affiliates/src/Model/Table/AffiliatesUsersTable.php` | ORM table, handles cache invalidation |
| `src/General/UniversalEnumerations.php` | Defines the three access levels globally |
| `plugins/Users/src/Trait/UserPermissionsTrait.php` | Core logic for permission/access resolution |
| `config/Migrations/20230306001753_*.php` | Added access_level column to affiliates_users |

### Code Examples

#### Access Level Definition (UniversalEnumerations.php)
```php
private static $enumerations = [
    self::KEY_ACCESS_LEVELS => [
        self::FULL_ACCESS => 1,
        self::MENTOR_CONNECTOR_ONLY => 2,
        self::NQMS_ONLY => 3,
    ],
];
```

#### Form Structure (Users/edit.php, lines 135-207)
```php
echo $this->Form->control(
    'affiliates_users',
    [
        'label' => __('Affiliates'),
        'type' => 'multiinput',
        'cols' => 3,
        'inputs' => [
            [
                'name' => 'affiliate_id',
                'type' => 'autocomplete',  // Search affiliates
            ],
            [
                'type' => 'radio',
                'name' => 'access_level',
                'options' => $accessLevelOptions,  // Full Access, MC-Only, NQMS-Only
            ],
            [
                'type' => 'checkbox',
                'name' => 'is_limited_contractor',
            ],
        ],
    ]
);
```

#### Permission Check Logic (UserPermissionsTrait.php)
```php
// Check if user is an affiliate user
$affiliateIds = TableRegistry::getTableLocator()
    ->get('Affiliates.AffiliatesUsers')
    ->find()
    ->select(['affiliate_id'])
    ->where(['user_id =' => $userId])
    ->where(['access_level =' => $fullAccess])
    ->limit(1)
    ->count();

if ($affiliateIds > 0) {
    $permissions['affiliate'] = true;
}
```

#### Cache Invalidation (AffiliatesUsersTable.php)
```php
public function afterSave(EventInterface $event, AffiliatesUser $affiliatesUser, \ArrayObject $options): void
{
    $this->deleteUserCache($affiliatesUser->user_id);
}
```

---

## Relationship to Cross-Affiliate NQMS Permissions (Request 1)

This feature is **directly relevant** to Request 1 (Cross-Affiliate NQMS Permissions) because:

### Current Limitation
- Access is ZIP code-based via `affiliates_users` table
- Affiliate staff can only access programs in their geographic service area
- No way to grant secondary/override permissions for out-of-state work

### The Problem
- MENTOR Washington cannot help California programs (different service areas)
- Current workaround: Enter fake ZIP codes to reassign programs (not sustainable)
- ZIP code system works for recruitment but not for NQMS consulting relationships

### The Proposed Solution
Add a `programs_affiliates` junction table to allow secondary affiliate assignments that override ZIP code restrictions:

```
Current System:
User → affiliates_users (access_level) → Affiliate → Service Areas (ZIP) → Programs

Proposed Addition:
User → affiliates_users (access_level) → Affiliate → programs_affiliates → Programs
                                                          (secondary assignment)
```

### Integration Strategy
The new secondary affiliate system would:
1. **Work alongside** this existing Affiliate Access Controls feature (not replace it)
2. **Respect access levels** - if user has NQMS-Only access to their affiliate, they get NQMS-Only access to secondary programs
3. **Check both paths** - permission logic would check both ZIP-based AND table-based assignments
4. **Maintain current behavior** - primary affiliates still determined by ZIP codes for recruitment

### Permission Check Flow (Proposed)
```php
private function hasAccess(int $programId, int $notEqual): bool
{
    // Check 1: Direct program user assignment (existing)
    if ($this->hasDirectProgramAccess($programId)) {
        return true;
    }

    // Check 2: Secondary affiliate assignment (NEW)
    if ($this->hasSecondaryAffiliateAccess($programId)) {
        return true;
    }

    // Check 3: Primary affiliate via ZIP codes (existing)
    if ($this->hasPrimaryAffiliateAccess($programId)) {
        return true;
    }

    return false;
}
```

---

## Summary

**Affiliate Access Controls** provides granular, role-based access control where:
- Administrators assign users to specific affiliates
- Users get one of three access levels (Full, MC-Only, NQMS-Only)
- Access to programs is determined by affiliate service areas (ZIP codes)
- The system automatically calculates permissions based on these assignments

**The Challenge:** This ZIP code-based approach prevents legitimate cross-state NQMS consulting work.

**The Solution:** Request 1 proposes adding secondary affiliate assignments to enable cross-affiliate NQMS permissions while preserving the existing ZIP code logic for recruitment purposes.
