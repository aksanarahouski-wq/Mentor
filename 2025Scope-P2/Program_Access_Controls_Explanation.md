# How Account → Program Access Controls Works

## Overview

**Program Access Controls** is an administrative feature that allows system administrators to grant users direct access to specific mentoring programs, independent of affiliate-level access. This provides granular, program-by-program access control.

**Location:** Account Settings → Users → Edit User → "Program Access Controls" section

---

## Key Difference: Affiliate vs Program Access

| Aspect | Affiliate Access Controls | Program Access Controls |
|--------|--------------------------|-------------------------|
| **Scope** | All programs in an affiliate region | Specific programs only |
| **How Access is Granted** | Geographic service areas (ZIP codes) | Direct program assignment |
| **Use Case** | Regional management of all programs | Targeted access to individual programs |
| **Example** | "Give Sarah access to all Colorado programs" | "Give Sarah access to Big Brothers Big Sisters Denver only" |
| **Permission Check** | ZIP code matching to programs | Direct `programs_users` table lookup |

**From the UI tooltip:**
> "Providing a user with access to an Affiliate provides them with access to all Programs within that Affiliate Region. Providing a user with access to a Program provides them with access to Program's information."

---

## The Three-Tier Access Level System

The same access levels used for affiliates also apply to programs:

| Access Level | Value | What It Grants |
|--------------|-------|----------------|
| **Full Access** | 1 | Complete access to program data in both NQMS and Mentoring Connector |
| **MC-Only** (Mentoring Connector) | 2 | Limited to Connector features: program inquiries, search data, inquiry responses |
| **NQMS-Only** | 3 | Limited to NQMS features: assessments, documents, goals, I&I plans |

**Plus:** `is_limited_contractor` flag for even more restricted NQMS access

---

## Database Structure

### programs_users Table

```
programs_users:
├── id (primary key)
├── program_id (foreign key to programs)
├── user_id (foreign key to users)
├── access_level (1=Full, 2=MC-Only, 3=NQMS-Only, default: 1)
└── is_limited_contractor (boolean, default: 0)
```

### Schema Evolution

**Initial Creation (2022-09-07):**
```sql
CREATE TABLE programs_users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    program_id INT UNSIGNED NOT NULL,
    user_id VARCHAR(255) NOT NULL,
    FOREIGN KEY (program_id) REFERENCES programs(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);
```

**Access Level Addition (2023-03-05):**
- Added `access_level` column (tinyinteger, default: 1)
- Replaced older `is_nqms` boolean with flexible access levels

**Limited Contractor Addition (2023-07-20):**
- Added `is_limited_contractor` column for restricted NQMS access

---

## Admin Interface

### Form Structure (Users/edit.php, lines 209-284)

When editing a user account, admins see a **multi-input widget** with:

1. **Program Autocomplete Field**
   - Search for programs by name
   - API endpoint: `/Api/Programs/search?type=accounts`

2. **Access Level Radio Buttons**
   - Full Access
   - MC-Access Only
   - NQMS-Access Only

3. **Limited Contractor Checkbox**
   - Only visible when "NQMS-Access Only" is selected
   - Provides additional restriction

### Dynamic UI Behavior

**JavaScript Logic (lines 332-389):**
```javascript
// When access level changes
$('input[name*="[access_level]"]').on('change', function() {
    var value = $(this).val();
    var $limitedContractorCheckbox = $(this).closest('tr').find('[name*="[is_limited_contractor]"]');

    if (value == 3) {  // NQMS-Only selected
        $limitedContractorCheckbox.parent().show();
    } else {
        $limitedContractorCheckbox.parent().hide();
        $limitedContractorCheckbox.prop('checked', false);
    }
});
```

**Result:** The "Limited Contractor" checkbox only appears when NQMS-Access Only is selected.

---

## Permission Checking Logic

### Key Methods in UserPermissionsTrait.php

#### 1. hasAccess(programId, notEqual)
**Purpose:** Check if user can access a specific program

**Logic Flow:**
```php
private function hasAccess(int $programId, int $notEqual): bool
{
    $user = $this->getAuthenticatedUser();

    // Step 1: Superuser bypass
    if ($user->is_superuser) {
        return true;
    }

    // Step 2: Check direct program assignment (programs_users)
    $programCount = TableRegistry::getTableLocator()
        ->get('Programs.ProgramsUsers')
        ->find()
        ->where([
            'user_id' => $user->id,
            'program_id' => $programId,
            'access_level !=' => $notEqual  // Exclude certain access levels
        ])
        ->count();

    if ($programCount > 0) {
        return true;
    }

    // Step 3: Check affiliate access (via ZIP codes)
    $programIds = $this->getProgramIdsFromAffiliatesByAccessLevel($user, $notEqual);
    if (!empty($programIds) && in_array($programId, $programIds)) {
        return true;
    }

    return false;
}
```

**Key Point:** Direct program access is checked FIRST, then affiliate-based access.

#### 2. canEditProgram(programId)
**Purpose:** Check if user can edit program details

**Logic:**
```php
public function canEditProgram(int $programId): bool
{
    if ($user->is_superuser) {
        return true;
    }

    if ($this->canAccess('Programs.edit')) {
        return true;
    }

    // Exclude NQMS-Only users from editing
    return $this->hasAccess($programId, UniversalEnumerations::get('NQMS_ONLY'));
}
```

**Result:** NQMS-Only users cannot edit program information.

#### 3. canAccessNQMS(programId)
**Purpose:** Check if user can access NQMS features

**Logic:**
```php
public function canAccessNQMS(int $programId): bool
{
    // Exclude MC-Only users from NQMS
    return $this->hasAccess($programId, UniversalEnumerations::get('MENTOR_CONNECTOR_ONLY'));
}
```

**Result:** MC-Only users cannot access NQMS features.

#### 4. getPermissionForEachRole(userId)
**Purpose:** Determine user's permission flags based on program assignments

**Logic:**
```php
// Check for program access (not NQMS-only)
$programCount = TableRegistry::getTableLocator()
    ->get('Programs.ProgramsUsers')
    ->find()
    ->where([
        'user_id' => $userId,
        'access_level !=' => UniversalEnumerations::get('NQMS_ONLY')
    ])
    ->count();

if ($programCount > 0) {
    $permissions['program'] = true;
}

// Check for NQMS-only program access
$nqmsProgramCount = TableRegistry::getTableLocator()
    ->get('Programs.ProgramsUsers')
    ->find()
    ->where([
        'user_id' => $userId,
        'access_level' => UniversalEnumerations::get('NQMS_ONLY'),
        'is_limited_contractor' => 0
    ])
    ->count();

if ($nqmsProgramCount > 0) {
    $permissions['nqms_program'] = true;
}

// Check for limited contractor NQMS access
$nqmsLimitedCount = TableRegistry::getTableLocator()
    ->get('Programs.ProgramsUsers')
    ->find()
    ->where([
        'user_id' => $userId,
        'access_level' => UniversalEnumerations::get('NQMS_ONLY'),
        'is_limited_contractor' => 1
    ])
    ->count();

if ($nqmsLimitedCount > 0) {
    $permissions['nqms_program_limited'] = true;
}
```

**Result:** Sets permission flags used throughout the application.

---

## Model Implementation

### ProgramsUsersTable.php

**Key Features:**

#### Relationships
```php
public function initialize(array $config): void
{
    $this->belongsTo('Users')
        ->setClassName('Users.Users')
        ->setForeignKey('user_id');

    $this->belongsTo('Programs')
        ->setClassName('Programs.Programs')
        ->setForeignKey('program_id');
}
```

#### Default Access Level
```php
public function beforeMarshal(EventInterface $event, \ArrayObject $data, \ArrayObject $options)
{
    if (!isset($data['access_level'])) {
        $data['access_level'] = UniversalEnumerations::get('FULL_ACCESS');
    }
}
```

#### Cache Invalidation
```php
public function afterSave(EventInterface $event, ProgramsUser $programsUser, \ArrayObject $options): void
{
    $this->deleteUserCache($programsUser->user_id);
}

public function afterDelete(EventInterface $event, ProgramsUser $programsUser, \ArrayObject $options): void
{
    $this->deleteUserCache($programsUser->user_id);
}
```

**Purpose:** Ensures permission changes take effect immediately by clearing user cache.

#### Query Helper Method
```php
public function getProgramUsers(int $programId, array $accessLevels = []): Query
{
    $query = $this->find()
        ->where(['program_id' => $programId])
        ->contain(['Users']);

    if (!empty($accessLevels)) {
        $query->where(['access_level IN' => $accessLevels]);
    }

    return $query;
}
```

---

## Example Workflow

### Scenario: Adding Mike as NQMS reviewer for "Big Brothers Big Sisters Denver"

1. **Admin navigates to:** Users → Edit Mike → Program Access Controls section

2. **Admin searches for program:**
   - Types "Big Brothers" in autocomplete field
   - Selects "Big Brothers Big Sisters Denver" from results

3. **Admin selects access level:**
   - Chooses **"NQMS-Access Only"** radio button
   - "Limited Contractor" checkbox appears
   - Admin leaves it unchecked (full NQMS access)

4. **Admin saves the user**

5. **System creates record in `programs_users`:**
   ```sql
   INSERT INTO programs_users (
       program_id,
       user_id,
       access_level,
       is_limited_contractor
   ) VALUES (
       12345,  -- Big Brothers Big Sisters Denver
       67890,  -- Mike's user ID
       3,      -- NQMS-Only
       0       -- Not limited contractor
   );
   ```

6. **System clears Mike's cache** (via `afterSave` hook)

7. **Mike can now:**
   - ✅ Access NQMS assessments for this specific program
   - ✅ Manage goals and documents for this program
   - ✅ View program details
   - ❌ Access Mentoring Connector features for this program
   - ❌ Edit program information (contact, address, etc.)
   - ❌ Access any other programs (unless separately assigned)

---

## Access Level Behavior Matrix

| Action | Full Access | MC-Only | NQMS-Only | NQMS-Only + Limited |
|--------|-------------|---------|-----------|---------------------|
| View program details | ✅ | ✅ | ✅ | ✅ |
| Edit program info | ✅ | ✅ | ❌ | ❌ |
| Access Connector features | ✅ | ✅ | ❌ | ❌ |
| View assessments | ✅ | ❌ | ✅ | ✅ |
| Edit assessments | ✅ | ❌ | ✅ | ⚠️ Limited |
| Manage goals | ✅ | ❌ | ✅ | ⚠️ Limited |
| Upload documents | ✅ | ❌ | ✅ | ⚠️ Limited |
| Archive assessments | ✅ | ❌ | ✅ | ❌ |
| Approve assessments | ✅ | ❌ | ✅ | ❌ |

---

## Permission Check Priority

When the system checks if a user can access a program:

```
1. Is user a superuser?
   └─ YES → Grant access (bypass all checks)
   └─ NO → Continue to step 2

2. Does programs_users have a matching record?
   └─ YES → Grant access based on access_level
   └─ NO → Continue to step 3

3. Does user belong to affiliate that serves this program's ZIP code?
   └─ YES → Grant access based on affiliate's access_level
   └─ NO → Deny access
```

**Key Insight:** Direct program assignments (step 2) take precedence over affiliate-based access (step 3).

---

## Controller Implementation

### UsersController.php - edit() Action

**Loading User with Associations (lines 158-184):**
```php
$user = $this->Users->get($id, [
    'contain' => [
        'AffiliatesUsers' => ['Affiliates'],
        'ProgramsUsers' => ['Programs'],
        'UserProfiles'
    ]
]);
```

**Saving with Associations (lines 223-253):**
```php
$user = $this->Users->patchEntity($user, $this->request->getData(), [
    'associated' => [
        'ProgramsUsers' => ['validate' => false],
        'AffiliatesUsers',
        'UserProfiles' => [...]
    ]
]);

if ($this->Users->save($user)) {
    $this->Flash->success(__('User has been saved.'));
    return $this->redirect(['action' => 'index']);
}
```

**Form Protection (beforeFilter, line 57):**
```php
$this->FormProtection->setConfig('unlockedFields', [
    'affiliates_users',
    'programs_users'
]);
```

These fields are excluded from CSRF protection because they use dynamic JavaScript-driven multi-input widgets.

---

## Technical Implementation Files

### Key Files Reference

| File | Purpose | Lines |
|------|---------|-------|
| `plugins/Users/templates/Admin/Users/edit.php` | UI form for Program Access Controls | 209-284 |
| `plugins/Users/src/Controller/Admin/UsersController.php` | Controller handling user editing | 158-284 |
| `plugins/Programs/src/Model/Table/ProgramsUsersTable.php` | Data model and cache management | Full file |
| `plugins/Programs/src/Model/Entity/ProgramsUser.php` | Entity definition | Full file |
| `plugins/Users/src/Trait/UserPermissionsTrait.php` | Permission checking logic | 133-191, 535-637 |
| `src/General/UniversalEnumerations.php` | Access level definitions | Full file |

### Database Migrations

| Migration | Date | Purpose |
|-----------|------|---------|
| `20220907171238_CreateProgramsUsers.php` | 2022-09-07 | Initial table creation |
| `20230305235226_UpdateIsNQMSColumnToAccessLevelInProgramsUsers.php` | 2023-03-05 | Added access_level column |
| `20230720034044_AddIsLimitedContractorColumnInProgramsUsers.php` | 2023-07-20 | Added is_limited_contractor |

---

## Relationship to Cross-Affiliate NQMS Permissions

### Current System

**Two ways to grant program access:**
1. **Via Affiliate Access** → User gets all programs in affiliate's service area (ZIP-based)
2. **Via Program Access** → User gets specific programs (direct assignment)

**The Problem:**
- Neither method allows cross-affiliate NQMS consulting
- Affiliate access is limited by geography (ZIP codes)
- Program access requires manual assignment of individual programs (not scalable)

### Proposed Solution (Request 1)

Add a **third method** via `programs_affiliates` junction table:

```
Current:
┌─────────┐
│  User   │
└────┬────┘
     │
     ├─ affiliates_users → Affiliate → Service Areas (ZIP) → Programs
     │
     └─ programs_users → Specific Programs

Proposed:
┌─────────┐
│  User   │
└────┬────┘
     │
     ├─ affiliates_users → Affiliate → Service Areas (ZIP) → Programs (Primary)
     │                            │
     │                            └─ programs_affiliates → Programs (Secondary)
     │
     └─ programs_users → Specific Programs
```

### Integration Strategy

The new `programs_affiliates` table would:
1. **Work alongside** both existing access methods
2. **Respect access_level** from the user's affiliate assignment
3. **Check in permission logic** as an additional path to program access
4. **Enable cross-affiliate NQMS** without fake ZIP codes

### Updated Permission Check (Proposed)

```php
private function hasAccess(int $programId, int $notEqual): bool
{
    // Step 1: Superuser (existing)
    if ($user->is_superuser) {
        return true;
    }

    // Step 2: Direct program assignment (existing)
    if ($this->hasDirectProgramAccess($programId)) {
        return true;
    }

    // Step 3: Secondary affiliate assignment (NEW)
    if ($this->hasSecondaryAffiliateAccess($programId)) {
        return true;
    }

    // Step 4: Primary affiliate via ZIP codes (existing)
    if ($this->hasPrimaryAffiliateAccess($programId)) {
        return true;
    }

    return false;
}
```

---

## Summary

**Program Access Controls** provides granular, program-level access control:
- Administrators assign users to **specific programs** (not all programs in a region)
- Users get one of three access levels (Full, MC-Only, NQMS-Only)
- Access is **direct** (no ZIP code matching required)
- Checked **before** affiliate-based access in permission logic
- Includes **Limited Contractor** flag for additional restrictions

**Use Cases:**
- External program staff who should only see their own program
- Consultants working with specific programs across regions
- Temporary access grants for special projects
- Program-specific roles (e.g., NQMS assessor for one program only)

**Difference from Affiliate Access:**
- **Affiliate Access** = "Give Sarah ALL Colorado programs"
- **Program Access** = "Give Sarah ONLY these 3 specific programs"

**The Challenge for Request 1:**
While Program Access provides granularity, it doesn't solve the cross-affiliate NQMS problem because:
- It requires manual assignment of each program
- It doesn't capture the affiliate relationship (secondary affiliate concept)
- It doesn't allow affiliate staff to see "their secondary programs" in reports

The proposed `programs_affiliates` solution addresses these limitations by creating explicit secondary affiliate relationships at the affiliate level, not the user level.
