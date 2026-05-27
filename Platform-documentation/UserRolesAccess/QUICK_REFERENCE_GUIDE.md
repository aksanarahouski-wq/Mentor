# MENTOR Connector - Quick Reference Guide
## User Roles & Permissions

**Version:** 2.0 | **Last Updated:** December 3, 2025

---

## Quick Role Lookup

### Access Levels (What You Assign)

| Access Level | Value | Use When... |
|--------------|-------|-------------|
| **Full Access** | 1 | User needs both NQMS and Mentoring Connector access |
| **MC-Access Only** | 2 | User only handles volunteer inquiries and searches |
| **NQMS-Access Only** | 3 | User only works on quality assessments |

### Resulting Roles (What the System Creates)

| If You Assign... | At Level... | With Contractor Flag... | System Creates Role... |
|------------------|-------------|-------------------------|------------------------|
| Full Access (1) | Affiliate | No | `affiliate` |
| MC-Access Only (2) | Affiliate | No | `mc_affiliate` |
| NQMS-Access Only (3) | Affiliate | No | `nqms_affiliate` |
| NQMS-Access Only (3) | Affiliate | Yes | `nqms_affiliate_limited` |
| Full Access (1) OR MC-Access Only (2) | Program | No | `program` |
| NQMS-Access Only (3) | Program | No | `nqms_program` |
| NQMS-Access Only (3) | Program | Yes | `nqms_program_limited` |

**Special Role:**
- **Global Admin** (`global`): Set `is_superuser = 1` on user record. Has full access to everything.

---

## Permission Matrix (Simplified)

| Module | Global | Affiliate Full | Affiliate MC-Only | Affiliate NQMS | Program | Program NQMS | Contractors |
|--------|--------|----------------|-------------------|----------------|---------|--------------|-------------|
| **Reminders** | Edit | Edit | Edit | Edit | Edit | Edit | No Access |
| **Searches** | Edit | Edit | Edit | - | Edit | - | - |
| **Inquiries** | Edit | Edit | Edit | - | Edit | - | - |
| **Programs** | Edit | Edit | Edit | View | Edit | View | View |
| **Affiliates** | Edit | Edit | Edit | View | - | - | - |
| **Accounts** | Edit | Edit | Edit | - | Edit | - | - |
| **Partners** | Edit | - | - | - | - | - | - |
| **Reports** | View | View | - | View | View | View | - |
| **NQMS** | Edit | Edit | - | Edit | Edit | Edit | Edit* |
| **NQMS Admin** | Edit | - | - | - | - | - | - |

**Legend:**
- Edit = Full read/write access
- View = Read-only access
- \- = No access
- Edit* = Limited to most recent assessment only

---

## Decision Tree: Which Access Level to Assign?

```
START: What does this user need to do?
│
├─→ Manage NQMS question templates?
│   └─→ YES: Make them a Global Admin (is_superuser = 1)
│
├─→ Work with multiple affiliates/programs system-wide?
│   └─→ YES: Make them a Global Admin (is_superuser = 1)
│
├─→ Do they work at an Affiliate or Program?
    │
    ├─→ AFFILIATE
    │   │
    │   ├─→ Do they need both volunteer inquiries AND NQMS access?
    │   │   └─→ YES: Assign Full Access (1) at Affiliate level
    │   │
    │   ├─→ Do they ONLY need volunteer inquiries/searches?
    │   │   └─→ YES: Assign MC-Access Only (2) at Affiliate level
    │   │
    │   └─→ Do they ONLY need NQMS assessments?
    │       │
    │       ├─→ Are they a consultant/contractor?
    │       │   └─→ YES: Assign NQMS-Access Only (3) + Check "Limited Contractor"
    │       │
    │       └─→ Regular staff?
    │           └─→ YES: Assign NQMS-Access Only (3)
    │
    └─→ PROGRAM
        │
        ├─→ Do they need both volunteer inquiries AND NQMS access?
        │   └─→ YES: Assign Full Access (1) at Program level
        │
        ├─→ Do they ONLY need volunteer inquiries/searches?
        │   └─→ YES: Assign MC-Access Only (2) at Program level
        │       (Note: This creates the same "program" role as Full Access)
        │
        └─→ Do they ONLY need NQMS assessments?
            │
            ├─→ Are they a consultant/contractor?
            │   └─→ YES: Assign NQMS-Access Only (3) + Check "Limited Contractor"
            │
            └─→ Regular staff?
                └─→ YES: Assign NQMS-Access Only (3)
```

---

## Common User Types & How to Set Them Up

### 1. Affiliate Admin (Jane)
**Needs:** Full access to everything in her territory

**Setup:**
1. Go to Users → Add User
2. Create user account
3. Go to Affiliates tab
4. Add affiliate assignment
5. Select: **Full Access**
6. Leave "Limited Contractor" unchecked
7. Save

**Result:** User gets `affiliate` role

---

### 2. MC-Only Affiliate Staff (Wanda)
**Needs:** Only volunteer inquiries and searches, no NQMS

**Setup:**
1. Go to Users → Add User
2. Create user account
3. Go to Affiliates tab
4. Add affiliate assignment
5. Select: **MC-Access Only**
6. Leave "Limited Contractor" unchecked
7. Save

**Result:** User gets `mc_affiliate` role

---

### 3. NQMS Consultant (Steve)
**Needs:** NQMS assessments only, limited to current assessment

**Setup:**
1. Go to Users → Add User
2. Create user account
3. Go to Affiliates tab (if affiliate-level) OR Programs tab (if program-level)
4. Add assignment
5. Select: **NQMS-Access Only**
6. Check "Limited Contractor"
7. Save

**Result:** User gets `nqms_affiliate_limited` or `nqms_program_limited` role

---

### 4. Program Staff (Vis)
**Needs:** Volunteer inquiries for his program, no NQMS

**Setup:**
1. Go to Users → Add User
2. Create user account
3. Go to Programs tab
4. Add program assignment
5. Select: **MC-Access Only** (or **Full Access** - both create same role)
6. Leave "Limited Contractor" unchecked
7. Save

**Result:** User gets `program` role

**Note:** There's no difference in permissions between Program Full Access and Program MC-Only in the current system.

---

### 5. Program NQMS Staff (Peggy)
**Needs:** NQMS assessments for her program only

**Setup:**
1. Go to Users → Add User
2. Create user account
3. Go to Programs tab
4. Add program assignment
5. Select: **NQMS-Access Only**
6. Leave "Limited Contractor" unchecked
7. Save

**Result:** User gets `nqms_program` role

---

### 6. Global Admin (System Administrator)
**Needs:** Full access to everything system-wide

**Setup:**
1. Go to Users → Add User
2. Create user account
3. Check the "Is Superuser" checkbox
4. Save
5. No need to assign affiliates or programs

**Result:** User gets `global` role

---

## Troubleshooting

### User can't see a module they should have access to

**Check:**
1. Is the user's account active? (`is_active = 1`)
2. Is the user verified? (`is_verified = 1`)
3. Do they have the correct affiliate/program assignment?
4. Is their access level correct?
5. Clear user permission cache:
   - Delete cache key: `user_permissions_{user_id}`

---

### User can see a module but can't edit

**Likely Cause:** User has "Can-See" permission but not "Can-Edit"

**Example:**
- NQMS-only users can VIEW programs but cannot EDIT them
- This is by design

**Check:**
- Review the permission matrix in COMPLETE_PERMISSION_MATRIX.md
- Verify their access level matches what they should have

---

### Affiliate user can't access programs in their territory

**Check:**
1. Does the affiliate have ZIP codes assigned? (Check `affiliates_zip_codes` table)
2. Do the programs have matching ZIP codes? (Check `programs.zip_code`)
3. Is the user's access level appropriate for the action?
   - NQMS-only users can only VIEW programs, not edit
4. Clear cache and try again

---

### Contractor can't edit old assessments

**This is expected behavior:**
- Limited contractors can ONLY edit the most recent assessment per program
- They cannot access historical/completed assessments
- This is enforced in `canApproveAssessment()` method

---

### User has multiple roles and permissions seem wrong

**This is normal:**
- Users can be assigned to multiple programs and/or affiliates
- Each assignment can have a different access level
- The system computes ALL applicable roles
- User gets the UNION of all permissions from all roles

**Example:**
- User assigned to:
  - Affiliate A (Full Access) → Gets `affiliate` role
  - Program B (NQMS-Only) → Gets `nqms_program` role
- Result: User can access both MC features (from affiliate role) AND NQMS features (from program role)

---

## Cache Management

### When to Clear Cache

**User permission cache must be cleared when:**
- User assigned to new program
- User assigned to new affiliate
- User's access_level changed
- User's is_limited_contractor flag changed
- User removed from program/affiliate

**Cache is automatically cleared in:**
- `ProgramsUsersTable::afterSave()`
- `ProgramsUsersTable::afterDelete()`
- `AffiliatesUsersTable::afterSave()`
- `AffiliatesUsersTable::afterDelete()`

**Cache key format:**
- `user_permissions_{user_id}`

### When NOT to Clear Cache

**DO NOT clear cache when:**
- Programs are modified (name, address, etc.)
- Assessments are created/modified/deleted
- Documents are uploaded/deleted
- Inquiries are created/modified

---

## Database Quick Reference

### Find all roles for a user

```sql
-- Get user's affiliate assignments
SELECT
    a.name AS affiliate_name,
    au.access_level,
    au.is_limited_contractor,
    CASE
        WHEN au.access_level = 1 THEN 'affiliate (Full Access)'
        WHEN au.access_level = 2 THEN 'mc_affiliate (MC-Only)'
        WHEN au.access_level = 3 AND au.is_limited_contractor = 0 THEN 'nqms_affiliate'
        WHEN au.access_level = 3 AND au.is_limited_contractor = 1 THEN 'nqms_affiliate_limited'
    END AS computed_role
FROM affiliates_users au
JOIN affiliates a ON au.affiliate_id = a.id
WHERE au.user_id = '{user_id}';

-- Get user's program assignments
SELECT
    p.name AS program_name,
    pu.access_level,
    pu.is_limited_contractor,
    CASE
        WHEN pu.access_level IN (1, 2) THEN 'program (Full or MC-Only)'
        WHEN pu.access_level = 3 AND pu.is_limited_contractor = 0 THEN 'nqms_program'
        WHEN pu.access_level = 3 AND pu.is_limited_contractor = 1 THEN 'nqms_program_limited'
    END AS computed_role
FROM programs_users pu
JOIN programs p ON pu.program_id = p.id
WHERE pu.user_id = '{user_id}';
```

---

### Find all users with a specific role

```sql
-- Find all Global Admins
SELECT * FROM users WHERE is_superuser = 1;

-- Find all Affiliate Full Access users
SELECT u.*, a.name AS affiliate_name
FROM users u
JOIN affiliates_users au ON u.id = au.user_id
JOIN affiliates a ON au.affiliate_id = a.id
WHERE au.access_level = 1;

-- Find all MC-only affiliate users
SELECT u.*, a.name AS affiliate_name
FROM users u
JOIN affiliates_users au ON u.id = au.user_id
JOIN affiliates a ON au.affiliate_id = a.id
WHERE au.access_level = 2;

-- Find all NQMS-only program users (non-contractor)
SELECT u.*, p.name AS program_name
FROM users u
JOIN programs_users pu ON u.id = pu.user_id
JOIN programs p ON pu.program_id = p.id
WHERE pu.access_level = 3 AND pu.is_limited_contractor = 0;

-- Find all limited contractors
SELECT u.*, p.name AS program_name, a.name AS affiliate_name
FROM users u
LEFT JOIN programs_users pu ON u.id = pu.user_id AND pu.is_limited_contractor = 1
LEFT JOIN programs p ON pu.program_id = p.id
LEFT JOIN affiliates_users au ON u.id = au.user_id AND au.is_limited_contractor = 1
LEFT JOIN affiliates a ON au.affiliate_id = a.id
WHERE pu.is_limited_contractor = 1 OR au.is_limited_contractor = 1;
```

---

### Find programs accessible by affiliate user

```sql
SELECT DISTINCT p.*
FROM programs p
JOIN affiliates_zip_codes azc ON p.zip_code = azc.zip_code
JOIN affiliates_users au ON azc.affiliate_id = au.affiliate_id
WHERE au.user_id = '{user_id}';
```

---

## Code Quick Reference

### Check if user can edit a program

```php
use Cake\Datasource\ModelAwareTrait;

// In a controller or component
$canEdit = $this->Users->canEditProgram($programId, $user);

if ($canEdit) {
    // Show edit form
} else {
    // Show read-only view
}
```

---

### Check if user can access NQMS

```php
$canAccessNQMS = $this->Users->canAccessNQMS($programId, $user);

if ($canAccessNQMS) {
    // Show NQMS features
} else {
    // Hide NQMS tab
}
```

---

### Get user's computed roles

```php
$roles = $this->Users->getUserRoles($user);

// $roles is an array like:
// [
//     'program' => false,
//     'affiliate' => true,
//     'nqms_program' => false,
//     'nqms_affiliate' => true,
//     'mc_affiliate' => false,
//     'nqms_affiliate_limited' => false,
//     'nqms_program_limited' => false,
// ]

if ($roles['affiliate']) {
    // User has affiliate role
}
```

---

### Clear user permission cache

```php
use Cake\Cache\Cache;

// Clear permission cache for a specific user
Cache::delete('user_permissions_' . $userId);

// This is automatically done when user-program/user-affiliate relationships change
// You should rarely need to do this manually
```

---

## Visual Permission Hierarchy

```
                    GLOBAL ADMIN (is_superuser = 1)
                           |
    ┌──────────────────────┴──────────────────────┐
    |                                              |
AFFILIATE USERS                              PROGRAM USERS
    |                                              |
    ├─ Full Access (1)                            ├─ Full Access (1) ────┐
    │  → affiliate role                           │                       ├→ program role
    │  → Can edit MC + NQMS                       └─ MC-Access Only (2) ─┘
    │                                                → Can edit MC + NQMS
    ├─ MC-Access Only (2)                            (Note: Same role!)
    │  → mc_affiliate role
    │  → Can edit MC only                         ├─ NQMS-Access Only (3)
    │                                             │  ├─ Regular staff
    └─ NQMS-Access Only (3)                       │  │  → nqms_program role
       ├─ Regular staff                           │  │  → Can edit all NQMS
       │  → nqms_affiliate role                   │  │
       │  → Can edit all NQMS in territory        │  └─ Contractor (is_limited_contractor = 1)
       │                                           │     → nqms_program_limited role
       └─ Contractor (is_limited_contractor = 1)  │     → Can edit current NQMS only
          → nqms_affiliate_limited role           │
          → Can edit current NQMS only            └─ (No other combinations allowed)

```

---

## Related Documents

- **COMPLETE_PERMISSION_MATRIX.md** - Full detailed documentation with all discrepancies, code references, and recommendations
- **Original Confluence Document** - https://orases.atlassian.net/wiki/spaces/MTR/pages/667058186/Permission+Levels+NQMS-Only+MC-Only+Full+Access

---

**END OF QUICK REFERENCE**
