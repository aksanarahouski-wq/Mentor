# Enhanced Affiliate Access Controls Proposal

## Executive Summary

**Proposal:** Expand the existing Affiliate Access Controls to support **program-level granularity** while maintaining the same three-tier access level system (Full Access, MC-Only, NQMS-Only).

**Current State:**
- Affiliate Access grants access to ALL programs in the affiliate's service area (ZIP-based)
- Program Access grants access to specific programs (no affiliate context)

**Proposed State:**
- Affiliate Access can grant:
  - **Option A:** Access to ALL programs in affiliate's service area (existing behavior)
  - **Option B:** Access to SPECIFIC programs under that affiliate (new capability)
- Maintains all existing access levels (Full Access, MC-Only, NQMS-Only)
- Preserves affiliate relationship for reporting and approval permissions

---

## Business Value

### Problems This Solves

1. **Cross-Affiliate NQMS Support** (Request 1)
   - MENTOR Washington can support specific California programs
   - Maintains affiliate context (shows in reports, approval authority works)
   - No need for fake ZIP codes workaround

2. **Granular Access Without Losing Affiliate Context**
   - Currently: Either ALL programs in region OR specific programs with no affiliate tie
   - Proposed: Specific programs WITH affiliate relationship maintained

3. **Simplified Permission Model**
   - Users no longer need both "Affiliate Access" AND "Program Access"
   - Single interface for all affiliate-based access (whole region or specific programs)

4. **Better Reporting**
   - Reports can show "MENTOR Washington programs" including secondary programs
   - Affiliate assignments are explicit, not inferred from ZIP codes

5. **Approval Authority for Secondary Programs**
   - Secondary affiliate access through this system grants approval permissions
   - Solves the `canApproveAssessment()` limitation with direct program access

---

## Proposed Solution

### Concept: Add "Scope" to Affiliate Access

Each affiliate assignment can specify:
1. **Affiliate** - Which affiliate organization
2. **Access Level** - Full Access / MC-Only / NQMS-Only (existing)
3. **Scope** - NEW FIELD:
   - `all_programs` (default) - All programs in affiliate's service area
   - `specific_programs` - Only specified programs
4. **Programs** - NEW FIELD (only when scope = specific_programs):
   - Multi-select list of specific programs

---

## Database Schema Changes

### Option 1: Modify Existing `affiliates_users` Table (Recommended)

**Add new columns to `affiliates_users`:**

```sql
ALTER TABLE affiliates_users
ADD COLUMN scope ENUM('all_programs', 'specific_programs')
    DEFAULT 'all_programs'
    COMMENT 'Access scope: all programs in service area or specific programs only',
ADD COLUMN created DATETIME DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
ADD COLUMN created_by INT NULL COMMENT 'User ID who created this assignment',
ADD COLUMN modified_by INT NULL COMMENT 'User ID who last modified';

-- Add foreign keys for audit trail
ALTER TABLE affiliates_users
ADD CONSTRAINT fk_affiliates_users_created_by
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
ADD CONSTRAINT fk_affiliates_users_modified_by
    FOREIGN KEY (modified_by) REFERENCES users(id) ON DELETE SET NULL;
```

**Create new junction table for specific program assignments:**

```sql
CREATE TABLE affiliates_users_programs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    affiliates_user_id INT NOT NULL COMMENT 'Reference to affiliates_users record',
    program_id INT NOT NULL COMMENT 'Specific program assigned',
    created DATETIME DEFAULT CURRENT_TIMESTAMP,
    modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY idx_affiliates_user_program (affiliates_user_id, program_id),
    INDEX idx_affiliates_user (affiliates_user_id),
    INDEX idx_program (program_id),
    FOREIGN KEY (affiliates_user_id) REFERENCES affiliates_users(id) ON DELETE CASCADE,
    FOREIGN KEY (program_id) REFERENCES programs(id) ON DELETE CASCADE
) COMMENT='Junction table for specific program assignments within affiliate access';
```

**Why this approach:**
- ✅ Maintains backward compatibility (default scope = 'all_programs')
- ✅ Preserves existing affiliate-user relationships
- ✅ Clear separation of scope and specific assignments
- ✅ Easy to query: "Give me all programs this user can access via affiliate X"
- ✅ Audit trail built in

### Alternative Option 2: Use Proposed `programs_affiliates` Table

**Leverage the table from Request 1 proposal, but use it differently:**

```sql
-- Existing proposal from NQMS_Permissions.md
CREATE TABLE programs_affiliates (
    id INT AUTO_INCREMENT PRIMARY KEY,
    program_id INT NOT NULL,
    affiliate_id INT NOT NULL,
    is_primary TINYINT(1) DEFAULT 0 COMMENT '1=Primary (ZIP-based), 0=Secondary',
    access_type ENUM('full_nqms', 'limited_nqms') DEFAULT 'full_nqms',
    created DATETIME DEFAULT CURRENT_TIMESTAMP,
    ...
);

-- Then query like:
-- Get programs for user -> affiliate -> programs_affiliates (where is_primary=0)
```

**Comparison:**

| Aspect | Option 1 (affiliates_users + new junction) | Option 2 (programs_affiliates) |
|--------|---------------------------------------------|--------------------------------|
| **Clarity** | ✅ User → Affiliate relationship explicit | ⚠️ Must join through affiliate |
| **Scope Control** | ✅ Scope field makes intent clear | ⚠️ Scope inferred from is_primary |
| **Access Level** | ✅ Per-user access level preserved | ⚠️ Access level on affiliate, not user |
| **Backward Compat** | ✅ Existing records work unchanged | ⚠️ Must migrate existing assignments |
| **Simplicity** | ✅ Single interface for affiliate access | ⚠️ Two concepts: primary vs secondary |

**Recommendation:** Option 1 (modify `affiliates_users` + new junction table)

---

## Data Model

### Entities and Relationships

```
┌─────────────────────────────────────────────────────────────┐
│                          User                                │
└──────────────────────────┬──────────────────────────────────┘
                           │
                           │ affiliates_users (with scope field)
                           │
              ┌────────────┴────────────┐
              │                         │
      scope = 'all_programs'    scope = 'specific_programs'
              │                         │
              ▼                         ▼
      ┌──────────────┐          ┌──────────────────────────┐
      │  Affiliate   │          │  Affiliate               │
      └──────┬───────┘          └──────────┬───────────────┘
             │                             │
             │ Service Areas               │ affiliates_users_programs
             │ (ZIP codes)                 │
             │                             │
             ▼                             ▼
      All Programs                  Specific Programs
      in region                     (explicit list)
```

### Example Data Structure

#### User with ALL Programs Access (Existing Behavior)
```
affiliates_users:
- id: 1
- affiliate_id: 100 (MENTOR Colorado)
- user_id: 500 (Sarah)
- access_level: 1 (Full Access)
- scope: 'all_programs'
- is_limited_contractor: 0

affiliates_users_programs:
(no records needed - scope is 'all_programs')

Result: Sarah gets ALL programs in Colorado's service area
```

#### User with SPECIFIC Programs Access (New Capability)
```
affiliates_users:
- id: 2
- affiliate_id: 200 (MENTOR Washington)
- user_id: 600 (Emily)
- access_level: 3 (NQMS-Only)
- scope: 'specific_programs'
- is_limited_contractor: 0

affiliates_users_programs:
- id: 1, affiliates_user_id: 2, program_id: 12345 (Big Brothers LA)
- id: 2, affiliates_user_id: 2, program_id: 67890 (Youth Mentoring SF)
- id: 3, affiliates_user_id: 2, program_id: 11111 (Mentor Plus SD)

Result: Emily (MENTOR Washington) gets NQMS access to ONLY these 3 California programs
```

#### User with BOTH Types (Common Use Case)
```
affiliates_users:
- id: 3
- affiliate_id: 100 (MENTOR Colorado)
- user_id: 700 (Mike)
- access_level: 1 (Full Access)
- scope: 'all_programs'

affiliates_users:
- id: 4
- affiliate_id: 200 (MENTOR Washington)
- user_id: 700 (Mike)
- access_level: 3 (NQMS-Only)
- scope: 'specific_programs'

affiliates_users_programs:
- id: 4, affiliates_user_id: 4, program_id: 12345 (Big Brothers LA)

Result:
- Mike gets Full Access to ALL Colorado programs
- Mike gets NQMS-Only access to Big Brothers LA (via MENTOR Washington)
```

---

## UI/UX Design

### Updated Affiliate Access Controls Form

**Location:** `plugins/Users/templates/Admin/Users/edit.php` (lines 135-207)

#### Current UI (Simplified)
```
Affiliate Access Controls
├─ Select Affiliate: [Autocomplete]
├─ Access Level: ( ) Full ( ) MC-Only ( ) NQMS-Only
└─ Limited Contractor: [ ]
```

#### Proposed UI
```
Affiliate Access Controls
├─ Select Affiliate: [Autocomplete: "MENTOR Colorado"]
├─ Access Level: (•) Full Access ( ) MC-Only ( ) NQMS-Only
├─ Scope: (•) All programs in region
│         ( ) Specific programs only
│              └─ [Multi-select: Programs under MENTOR Colorado]
│                  [x] Big Brothers Denver
│                  [x] Youth Mentoring Boulder
│                  [ ] ...
└─ Limited Contractor: [ ]
```

### Dynamic Form Behavior (JavaScript)

```javascript
// When scope changes
$('input[name*="[scope]"]').on('change', function() {
    var $row = $(this).closest('tr');
    var $programSelect = $row.find('[name*="[programs]"]');

    if ($(this).val() === 'specific_programs') {
        // Show program multi-select
        $programSelect.parent().show();

        // Load programs for selected affiliate via AJAX
        var affiliateId = $row.find('[name*="[affiliate_id]"]').val();
        if (affiliateId) {
            loadAffiliatePrograms(affiliateId, $programSelect);
        }
    } else {
        // Hide program multi-select
        $programSelect.parent().hide();
        $programSelect.val([]);
    }
});

// When affiliate changes and scope is 'specific_programs'
$('input[name*="[affiliate_id]"]').on('change', function() {
    var $row = $(this).closest('tr');
    var scope = $row.find('input[name*="[scope]"]:checked').val();

    if (scope === 'specific_programs') {
        var affiliateId = $(this).val();
        var $programSelect = $row.find('[name*="[programs]"]');
        loadAffiliatePrograms(affiliateId, $programSelect);
    }
});

function loadAffiliatePrograms(affiliateId, $selectElement) {
    $.ajax({
        url: '/admin/api/affiliates/' + affiliateId + '/programs',
        success: function(programs) {
            $selectElement.empty();
            programs.forEach(function(program) {
                $selectElement.append(
                    $('<option>', {
                        value: program.id,
                        text: program.name
                    })
                );
            });
        }
    });
}
```

### Form Template (Twig/PHP)

```php
echo $this->Form->control(
    'affiliates_users',
    [
        'label' => __('Affiliates'),
        'type' => 'multiinput',
        'cols' => 5,  // Increased from 3 to 5
        'inputs' => [
            [
                'name' => 'affiliate_id',
                'type' => 'autocomplete',
                'label' => __('Affiliate'),
                'placeholder' => __('Search for an affiliate...'),
                'sourceUrl' => $this->Url->build([
                    'prefix' => 'Api',
                    'plugin' => 'Affiliates',
                    'controller' => 'Affiliates',
                    'action' => 'search',
                    '?' => ['type' => 'accounts']
                ])
            ],
            [
                'type' => 'radio',
                'name' => 'access_level',
                'label' => __('Access Level'),
                'options' => $accessLevelOptions,
                'default' => UniversalEnumerations::get('FULL_ACCESS')
            ],
            [
                'type' => 'radio',
                'name' => 'scope',
                'label' => __('Scope'),
                'options' => [
                    'all_programs' => __('All programs in region'),
                    'specific_programs' => __('Specific programs only')
                ],
                'default' => 'all_programs'
            ],
            [
                'name' => 'programs',
                'type' => 'select',
                'label' => __('Programs'),
                'multiple' => true,
                'options' => [],  // Populated via AJAX
                'class' => 'specific-programs-select',
                'style' => 'display:none;'  // Hidden by default
            ],
            [
                'type' => 'checkbox',
                'name' => 'is_limited_contractor',
                'label' => __('Limited Contractor'),
                'hiddenField' => true
            ]
        ]
    ]
);
```

---

## Model Changes

### AffiliatesUsersTable.php

**Location:** `plugins/Affiliates/src/Model/Table/AffiliatesUsersTable.php`

```php
<?php
namespace Affiliates\Model\Table;

use Cake\ORM\Table;
use Cake\Validation\Validator;

class AffiliatesUsersTable extends Table
{
    public function initialize(array $config): void
    {
        parent::initialize($config);

        $this->setTable('affiliates_users');
        $this->setPrimaryKey('id');

        $this->belongsTo('Affiliates')
            ->setClassName('Affiliates.Affiliates')
            ->setForeignKey('affiliate_id');

        $this->belongsTo('Users')
            ->setClassName('Users.Users')
            ->setForeignKey('user_id');

        // NEW: Association for specific programs
        $this->hasMany('AffiliatesUsersPrograms')
            ->setClassName('Affiliates.AffiliatesUsersPrograms')
            ->setForeignKey('affiliates_user_id')
            ->setDependent(true);  // Delete program assignments when affiliate assignment deleted

        $this->belongsToMany('Programs')
            ->setClassName('Programs.Programs')
            ->setThrough('Affiliates.AffiliatesUsersPrograms')
            ->setForeignKey('affiliates_user_id')
            ->setTargetForeignKey('program_id');

        $this->addBehavior('Timestamp');
    }

    public function validationDefault(Validator $validator): Validator
    {
        $validator
            ->notEmptyString('affiliate_id')
            ->notEmptyString('user_id')
            ->notEmptyString('access_level')
            ->inList('scope', ['all_programs', 'specific_programs']);

        return $validator;
    }

    /**
     * Custom validation rule: If scope is 'specific_programs', must have at least one program
     */
    public function buildRules(RulesChecker $rules): RulesChecker
    {
        $rules->add(function ($entity, $options) {
            if ($entity->scope === 'specific_programs') {
                // Check if programs are provided
                if (empty($entity->programs) && empty($entity->affiliates_users_programs)) {
                    return false;
                }
            }
            return true;
        }, 'specificProgramsRequired', [
            'errorField' => 'programs',
            'message' => __('At least one program must be selected when scope is "specific programs".')
        ]);

        return $rules;
    }

    public function afterSave(EventInterface $event, AffiliatesUser $affiliatesUser, \ArrayObject $options): void
    {
        // Invalidate user cache when affiliate assignment changes
        $this->deleteUserCache($affiliatesUser->user_id);
    }

    public function afterDelete(EventInterface $event, AffiliatesUser $affiliatesUser, \ArrayObject $options): void
    {
        // Invalidate user cache when affiliate assignment removed
        $this->deleteUserCache($affiliatesUser->user_id);
    }
}
```

### NEW: AffiliatesUsersProgramsTable.php

**Location:** `plugins/Affiliates/src/Model/Table/AffiliatesUsersProgramsTable.php`

```php
<?php
namespace Affiliates\Model\Table;

use Cake\ORM\Table;
use Cake\Validation\Validator;

class AffiliatesUsersProgramsTable extends Table
{
    public function initialize(array $config): void
    {
        parent::initialize($config);

        $this->setTable('affiliates_users_programs');
        $this->setPrimaryKey('id');

        $this->belongsTo('AffiliatesUsers')
            ->setClassName('Affiliates.AffiliatesUsers')
            ->setForeignKey('affiliates_user_id');

        $this->belongsTo('Programs')
            ->setClassName('Programs.Programs')
            ->setForeignKey('program_id');

        $this->addBehavior('Timestamp');
    }

    public function validationDefault(Validator $validator): Validator
    {
        $validator
            ->notEmptyString('affiliates_user_id')
            ->notEmptyString('program_id');

        return $validator;
    }
}
```

### NEW: AffiliatesUser Entity

**Location:** `plugins/Affiliates/src/Model/Entity/AffiliatesUser.php`

```php
<?php
namespace Affiliates\Model\Entity;

use Cake\ORM\Entity;

class AffiliatesUser extends Entity
{
    protected $_accessible = [
        'affiliate_id' => true,
        'user_id' => true,
        'access_level' => true,
        'scope' => true,
        'is_limited_contractor' => true,
        'programs' => true,  // For associated programs
        'affiliates_users_programs' => true,
        'created_by' => true,
        'modified_by' => true,
    ];
}
```

---

## Permission Logic Updates

### Updated `hasAccess()` Method

**Location:** `plugins/Users/src/Trait/UserPermissionsTrait.php`

```php
private function hasAccess(int $programId, int $notEqual): bool
{
    $user = $this->getAuthenticatedUser();

    if ($user->is_superuser) {
        return true;
    }

    // Check 1: Direct program user assignment (existing)
    $programCount = TableRegistry::getTableLocator()->get('Programs.ProgramsUsers')->find()
        ->where([
            'user_id' => $user->id,
            'program_id' => $programId,
            'access_level !=' => $notEqual
        ])
        ->limit(1)
        ->count();

    if ($programCount > 0) {
        return true;
    }

    // Check 2: Affiliate access - specific programs (NEW)
    $specificProgramAccess = $this->hasAffiliateSpecificProgramAccess($programId, $user, $notEqual);
    if ($specificProgramAccess) {
        return true;
    }

    // Check 3: Affiliate access - all programs via ZIP codes (existing)
    $programIds = $this->getProgramIdsFromAffiliatesByAccessLevel($user, $notEqual);
    if (!empty($programIds) && in_array($programId, $programIds)) {
        return true;
    }

    return false;
}

/**
 * Check if user has access to specific program via affiliate assignment
 * with scope='specific_programs'
 *
 * @param int $programId Program ID
 * @param User $user Current user
 * @param int $notEqual Access level to exclude
 * @return bool
 */
private function hasAffiliateSpecificProgramAccess(int $programId, $user, int $notEqual): bool
{
    // Get user's affiliate assignments with scope='specific_programs'
    $affiliatesUserIds = TableRegistry::getTableLocator()
        ->get('Affiliates.AffiliatesUsers')
        ->find()
        ->select(['id'])
        ->where([
            'user_id' => $user->id,
            'scope' => 'specific_programs',
            'access_level !=' => $notEqual
        ])
        ->all()
        ->extract('id')
        ->toArray();

    if (empty($affiliatesUserIds)) {
        return false;
    }

    // Check if program is in any of the specific program lists
    $programCount = TableRegistry::getTableLocator()
        ->get('Affiliates.AffiliatesUsersPrograms')
        ->find()
        ->where([
            'affiliates_user_id IN' => $affiliatesUserIds,
            'program_id' => $programId
        ])
        ->count();

    return $programCount > 0;
}
```

### Updated `canApproveAssessment()` Method

**Critical:** This must also check specific program assignments!

```php
protected function canApproveAssessment(int $programId): bool
{
    $user = $this->getAuthenticatedUser();

    // Step 1: Superuser bypass
    if ($user->is_superuser) {
        return true;
    }

    // Get MC-Only access level to exclude
    $notEqual = UniversalEnumerations::get('MENTOR_CONNECTOR_ONLY');

    // Step 2: Check specific program affiliate access (NEW)
    if ($this->hasAffiliateSpecificProgramAccess($programId, $user, $notEqual)) {
        return true;
    }

    // Step 3: Check all-programs affiliate access via ZIP codes (existing)
    $programIds = $this->getProgramIdsFromAffiliatesByAccessLevel($user, $notEqual);
    if (!empty($programIds) && in_array($programId, $programIds)) {
        return true;
    }

    return false;
}
```

**Key Change:** Now checks specific program assignments BEFORE checking ZIP-based access, ensuring secondary affiliate access grants approval authority!

---

## Controller Changes

### UsersController.php

**Location:** `plugins/Users/src/Controller/Admin/UsersController.php`

```php
public function edit(string $id = null): ?Response
{
    // ... existing code ...

    $user = $this->Users->get($id, [
        'contain' => [
            'AffiliatesUsers' => [
                'Affiliates',
                'AffiliatesUsersPrograms' => ['Programs']  // NEW: Include specific programs
            ],
            'ProgramsUsers' => ['Programs'],
            'UserProfiles'
        ]
    ]);

    if ($this->request->is(['patch', 'post', 'put'])) {
        $user = $this->Users->patchEntity($user, $this->request->getData(), [
            'associated' => [
                'AffiliatesUsers' => [
                    'associated' => ['AffiliatesUsersPrograms']  // NEW: Save specific programs
                ],
                'ProgramsUsers',
                'UserProfiles'
            ]
        ]);

        // ... rest of save logic ...
    }

    // ... rest of method ...
}
```

### NEW: AffiliatesController API Endpoint

**Location:** `plugins/Affiliates/src/Controller/Api/AffiliatesController.php`

```php
/**
 * Get programs for a specific affiliate
 * Used by AJAX to populate program select when creating specific program access
 *
 * @param int $id Affiliate ID
 * @return Response JSON response
 */
public function programs(int $id): Response
{
    $this->request->allowMethod(['get']);

    // Get affiliate with all programs in service area
    $affiliate = $this->Affiliates->get($id, [
        'contain' => ['ServiceAreas' => ['PostalCodes']]
    ]);

    // Get ZIP codes for affiliate
    $zipCodes = [];
    foreach ($affiliate->service_areas as $serviceArea) {
        foreach ($serviceArea->postal_codes as $postalCode) {
            $zipCodes[] = $postalCode->postal_code;
        }
    }

    // Get programs in those ZIP codes
    $programs = TableRegistry::getTableLocator()
        ->get('Programs.Programs')
        ->find()
        ->select(['id', 'name'])
        ->matching('ProgramLocations', function ($q) use ($zipCodes) {
            return $q->where(['ProgramLocations.zip_code IN' => $zipCodes]);
        })
        ->order(['name' => 'ASC'])
        ->all();

    $this->set([
        'programs' => $programs,
        '_serialize' => ['programs']
    ]);

    return $this->render();
}
```

---

## Migration Plan

### Migration File

**Location:** `config/Migrations/[TIMESTAMP]_EnhanceAffiliatesUsersWithProgramScope.php`

```php
<?php
use Migrations\AbstractMigration;

class EnhanceAffiliatesUsersWithProgramScope extends AbstractMigration
{
    public function change()
    {
        // 1. Add scope column to affiliates_users
        $table = $this->table('affiliates_users');
        $table->addColumn('scope', 'enum', [
                'values' => ['all_programs', 'specific_programs'],
                'default' => 'all_programs',
                'null' => false,
                'comment' => 'Access scope: all programs in service area or specific programs only',
                'after' => 'access_level'
            ])
            ->addColumn('created', 'datetime', [
                'default' => 'CURRENT_TIMESTAMP',
                'null' => false,
                'after' => 'scope'
            ])
            ->addColumn('modified', 'datetime', [
                'default' => 'CURRENT_TIMESTAMP',
                'update' => 'CURRENT_TIMESTAMP',
                'null' => false,
                'after' => 'created'
            ])
            ->addColumn('created_by', 'integer', [
                'null' => true,
                'signed' => true,
                'comment' => 'User ID who created this assignment',
                'after' => 'modified'
            ])
            ->addColumn('modified_by', 'integer', [
                'null' => true,
                'signed' => true,
                'comment' => 'User ID who last modified',
                'after' => 'created_by'
            ])
            ->addForeignKey('created_by', 'users', 'id', [
                'delete' => 'SET_NULL',
                'update' => 'CASCADE'
            ])
            ->addForeignKey('modified_by', 'users', 'id', [
                'delete' => 'SET_NULL',
                'update' => 'CASCADE'
            ])
            ->update();

        // 2. Create affiliates_users_programs junction table
        $table = $this->table('affiliates_users_programs');
        $table->addColumn('affiliates_user_id', 'integer', [
                'null' => false,
                'signed' => true,
                'comment' => 'Reference to affiliates_users record'
            ])
            ->addColumn('program_id', 'integer', [
                'null' => false,
                'signed' => true,
                'comment' => 'Specific program assigned'
            ])
            ->addColumn('created', 'datetime', [
                'default' => 'CURRENT_TIMESTAMP',
                'null' => false
            ])
            ->addColumn('modified', 'datetime', [
                'default' => 'CURRENT_TIMESTAMP',
                'update' => 'CURRENT_TIMESTAMP',
                'null' => false
            ])
            ->addIndex(['affiliates_user_id', 'program_id'], [
                'unique' => true,
                'name' => 'idx_affiliates_user_program'
            ])
            ->addIndex(['affiliates_user_id'], [
                'name' => 'idx_affiliates_user'
            ])
            ->addIndex(['program_id'], [
                'name' => 'idx_program'
            ])
            ->addForeignKey('affiliates_user_id', 'affiliates_users', 'id', [
                'delete' => 'CASCADE',
                'update' => 'CASCADE'
            ])
            ->addForeignKey('program_id', 'programs', 'id', [
                'delete' => 'CASCADE',
                'update' => 'CASCADE'
            ])
            ->create();
    }
}
```

### Data Migration (If Needed)

All existing `affiliates_users` records will default to `scope = 'all_programs'`, maintaining current behavior. No data migration needed.

---

## Testing Strategy

### Unit Tests

**Test File:** `tests/TestCase/Model/Table/AffiliatesUsersTableTest.php`

```php
public function testScopeDefaultsToAllPrograms()
{
    $affiliatesUser = $this->AffiliatesUsers->newEntity([
        'affiliate_id' => 1,
        'user_id' => 1,
        'access_level' => 1
    ]);

    $this->assertEquals('all_programs', $affiliatesUser->scope);
}

public function testSpecificProgramsRequiresProgramList()
{
    $affiliatesUser = $this->AffiliatesUsers->newEntity([
        'affiliate_id' => 1,
        'user_id' => 1,
        'access_level' => 1,
        'scope' => 'specific_programs'
        // Missing: programs
    ]);

    $this->assertFalse($this->AffiliatesUsers->save($affiliatesUser));
    $this->assertNotEmpty($affiliatesUser->getError('programs'));
}

public function testSpecificProgramsCanBeSaved()
{
    $affiliatesUser = $this->AffiliatesUsers->newEntity([
        'affiliate_id' => 1,
        'user_id' => 1,
        'access_level' => 1,
        'scope' => 'specific_programs',
        'affiliates_users_programs' => [
            ['program_id' => 100],
            ['program_id' => 200]
        ]
    ], ['associated' => ['AffiliatesUsersPrograms']]);

    $saved = $this->AffiliatesUsers->save($affiliatesUser);
    $this->assertNotFalse($saved);
    $this->assertCount(2, $saved->affiliates_users_programs);
}
```

### Integration Tests

**Test File:** `tests/TestCase/Trait/UserPermissionsTraitTest.php`

```php
public function testHasAccessViaSpecificProgramAssignment()
{
    // Create user with specific program access
    $affiliatesUser = $this->AffiliatesUsers->save([
        'affiliate_id' => 1,
        'user_id' => 1,
        'access_level' => UniversalEnumerations::get('NQMS_ONLY'),
        'scope' => 'specific_programs',
        'affiliates_users_programs' => [
            ['program_id' => 100]
        ]
    ], ['associated' => ['AffiliatesUsersPrograms']]);

    // Test access
    $this->assertTrue($this->hasAccess(100, UniversalEnumerations::get('MENTOR_CONNECTOR_ONLY')));
    $this->assertFalse($this->hasAccess(200, UniversalEnumerations::get('MENTOR_CONNECTOR_ONLY')));
}

public function testCanApproveAssessmentWithSpecificProgramAccess()
{
    // Create user with specific program access
    $this->createAffiliateUserWithSpecificPrograms(
        userId: 1,
        affiliateId: 1,
        programIds: [100, 200],
        accessLevel: UniversalEnumerations::get('NQMS_ONLY')
    );

    // Test approval authority
    $this->assertTrue($this->canApproveAssessment(100));
    $this->assertTrue($this->canApproveAssessment(200));
    $this->assertFalse($this->canApproveAssessment(300));
}
```

### Manual UAT Test Cases

1. **Test: Create affiliate access with all programs scope**
   - Assign user to affiliate
   - Select "All programs in region"
   - Verify user can access all programs in service area

2. **Test: Create affiliate access with specific programs scope**
   - Assign user to affiliate
   - Select "Specific programs only"
   - Select 3 specific programs
   - Verify user can ONLY access those 3 programs

3. **Test: Mix of both scope types**
   - Assign user to Affiliate A with "all programs"
   - Assign same user to Affiliate B with "specific programs"
   - Verify user has correct access to both sets

4. **Test: Approval permissions with specific programs**
   - Create secondary affiliate access with specific programs
   - Verify user can approve assessments for those programs
   - Verify approval fails for programs outside the list

5. **Test: Edit existing affiliate assignment**
   - Change scope from "all programs" to "specific programs"
   - Add programs
   - Verify access changes correctly

6. **Test: Delete affiliate assignment with specific programs**
   - Delete affiliate user record
   - Verify cascading delete removes program assignments
   - Verify user loses access

---

## Benefits Over Alternative Approaches

### vs. Original Request 1 Proposal (programs_affiliates)

| Aspect | Enhanced Affiliate Access (This Proposal) | Original programs_affiliates Proposal |
|--------|-------------------------------------------|---------------------------------------|
| **User Experience** | ✅ Single interface for all affiliate access | ⚠️ Separate concept of "secondary affiliates" |
| **Mental Model** | ✅ Simple: "User → Affiliate → Programs (all or some)" | ⚠️ Complex: "Primary vs secondary affiliates" |
| **Access Level Control** | ✅ Per-user, per-affiliate | ⚠️ Unclear if per-user or per-affiliate |
| **Backward Compatibility** | ✅ Perfect - defaults to existing behavior | ⚠️ Requires understanding new concept |
| **Approval Permissions** | ✅ Works automatically (affiliate relationship) | ✅ Works after updating logic |
| **Reporting** | ✅ Clear affiliate assignments | ✅ Can distinguish primary/secondary |
| **Data Migration** | ✅ None needed | ⚠️ Must populate primary affiliates |

### vs. Using programs_users for Cross-Affiliate Access

| Aspect | Enhanced Affiliate Access | Direct programs_users |
|--------|--------------------------|----------------------|
| **Affiliate Context** | ✅ Preserved - shows in reports | ❌ Lost - no affiliate tie |
| **Approval Authority** | ✅ Works automatically | ❌ Doesn't work (canApproveAssessment limitation) |
| **Scalability** | ✅ Assign once per affiliate, select multiple programs | ⚠️ Must assign each program individually |
| **Reporting** | ✅ "MENTOR Washington's programs" includes secondary | ❌ Can't group by affiliate |
| **User Management** | ✅ Centralized in one interface | ⚠️ Scattered across two sections |

---

## Implementation Effort Estimate

### Database Changes
- Add columns to `affiliates_users`: **1-2 hours**
- Create `affiliates_users_programs` table: **1-2 hours**
- Write migration: **1-2 hours**
- **Subtotal: 3-6 hours**

### Model Changes
- Update `AffiliatesUsersTable`: **2-3 hours**
- Create `AffiliatesUsersProgramsTable`: **1-2 hours**
- Create `AffiliatesUser` entity: **1 hour**
- Add associations: **1-2 hours**
- **Subtotal: 5-8 hours**

### UI Changes
- Update form template: **2-3 hours**
- JavaScript for dynamic behavior: **3-4 hours**
- CSS styling: **1-2 hours**
- **Subtotal: 6-9 hours**

### Controller Changes
- Update `UsersController::edit()`: **2-3 hours**
- Create API endpoint for affiliate programs: **2-3 hours**
- **Subtotal: 4-6 hours**

### Permission Logic Updates
- Update `hasAccess()`: **2-3 hours**
- Update `canApproveAssessment()`: **2-3 hours**
- Update `getProgramIdsFromAffiliates()`: **2-3 hours**
- **Subtotal: 6-9 hours**

### Testing
- Unit tests: **4-6 hours**
- Integration tests: **4-6 hours**
- Manual UAT: **2-3 hours**
- **Subtotal: 10-15 hours**

### Documentation
- Update technical docs: **2-3 hours**
- User guide: **2-3 hours**
- **Subtotal: 4-6 hours**

### **TOTAL ESTIMATE: 38-59 hours (5-7 developer days)**

---

## Recommendation

**This proposal is SUPERIOR to the original Request 1 approach** because:

1. ✅ **Simpler conceptual model** - Users understand "all programs vs specific programs" better than "primary vs secondary affiliates"

2. ✅ **Better UX** - Single unified interface for affiliate access, not two separate concepts

3. ✅ **Backward compatible** - Defaults maintain existing behavior, zero migration needed

4. ✅ **Solves the same problem** - MENTOR Washington can support California programs with full NQMS capabilities

5. ✅ **Approval authority works automatically** - Affiliate relationship is preserved, so `canApproveAssessment()` works out of the box

6. ✅ **Future-proof** - Can easily extend with additional scope types if needed

7. ✅ **Cleaner data model** - No need to distinguish "primary" (auto-assigned by ZIP) vs "secondary" (manually assigned)

### Suggested Next Steps

1. **Review this proposal** with stakeholders (Nicki, Mike, Sarah, Tim)
2. **Get approval** on the approach and UI design
3. **Refine estimate** based on any feedback/changes
4. **Prioritize** against other items in the backlog
5. **Implement** in phases:
   - Phase 1: Database + models
   - Phase 2: UI + controllers
   - Phase 3: Permission logic updates
   - Phase 4: Testing + documentation
