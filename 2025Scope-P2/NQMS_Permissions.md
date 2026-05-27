# NQMS Cross-Affiliate Permissions Feature Request

## Document Purpose
This document consolidates client requests for enhancements to NQMS permissions to allow cross-affiliate (out-of-state) program access. The goal is to conduct discovery to identify scope and requirements, which will inform the solution proposal and estimation.

---

## Current System Analysis

### How Permissions Work Today

**ZIP Code-Based Affiliate Assignment:**
- Programs are automatically assigned to affiliates based on their ZIP code location
- Affiliates can only access programs within their service area ZIP codes
- Service areas are defined by ZIP code ranges in the `service_areas` and `postal_codes` tables
- This works well for Mentoring Connector (recruitment) but creates issues for NQMS work

**Access Level System:**
The system uses three access levels defined in `UniversalEnumerations`:
1. **Full Access (1)**: Complete access to program and affiliate functionality
2. **MC-Access Only (2)**: Mentoring Connector only (recruitment, searches)
3. **NQMS-Access Only (3)**: NQMS assessments, documents, goals only

**User Roles:**
- `global`: System administrators (full access everywhere)
- `affiliate`: Affiliate staff with Full Access to their service area programs
- `mc_affiliate`: MC-only affiliate staff (recruitment focused)
- `nqms_affiliate`: NQMS affiliate staff (assessments focused)
- `nqms_affiliate_limited`: NQMS contractors with limited access
- `program`: Program staff with Full Access to their program
- `nqms_program`: Program staff with NQMS-only access
- `nqms_program_limited`: Program contractors with limited NQMS access

**Permission Check Flow:**
1. Check if user is superuser (bypass all checks)
2. Check `programs_users` table for direct program assignment
3. Check `affiliates_users` table for affiliate assignment
4. Get affiliate's ZIP codes from `service_areas` → `postal_codes`
5. Get programs in those ZIP codes from `program_locations`
6. Grant access if program is in affiliate's service area

**The Problem:**
- MENTOR Washington cannot help a California program with NQMS work
- Current workaround: Enter fake ZIP codes to reassign programs (not sustainable)
- ZIP code system works for recruitment but not for NQMS consulting relationships
- No way to grant secondary/override permissions for NQMS-specific work

---

## Request 1: Enable Cross-Affiliate NQMS Permissions

### Description
Allow affiliate staff to access programs outside their geographic service area specifically for NQMS purposes (assessments, documents, goals, I&I plans), without affecting the primary ZIP code-based affiliate assignment used for recruitment.

### Priority
HIGH

### Meeting Notes Update (10/23/24 - Meeting 3)
Key decisions made regarding permissions during discovery session:
- **Assessment Archive/Delete**: Only affiliate staff and national staff should have permission to archive assessments. Program users (external clients) should NOT have this capability.
- **Goal Management**: Only affiliate staff and national staff should have permission to add, edit, and delete goals. Program users should NOT have this capability (though Tim suggested building for both groups from a technical perspective, with policy restrictions).
- **Rationale**: Maintaining data integrity and preventing programs from manipulating their goals/assessments without reviewer oversight.

### Problem Statement
Affiliate staff (e.g., MENTOR Washington) need to work with programs in other states (e.g., California) on NQMS assessments and improvement plans. Currently, the ZIP code-based permission system prevents this cross-state collaboration, forcing staff to use fake ZIP codes as a workaround.

### Addresses
- Inability for out-of-state affiliate staff to open assessments for programs they're consulting with
- No way to assign secondary affiliates to programs for NQMS work
- Geographic service area restrictions blocking legitimate NQMS consulting relationships
- Need for NQMS-specific permissions that override ZIP code assignments
- Staff having to manipulate ZIP codes to create workaround access

### Current Issues
- `UserPermissionsTrait::hasAccess()` only checks ZIP code-based affiliate assignment (line 157-164)
- `canAccessNQMS()` relies on `hasAccess()` which only considers geographic service areas (line 175-192)
- No concept of "secondary affiliates" or "NQMS partner affiliates" in the data model
- Programs only have one implicit affiliate (determined by ZIP code)
- `affiliates_users` table links users to their home affiliate, not to programs they support

### Use Cases
1. **Scenario 1**: MENTOR Washington staff needs to open an assessment for a New York program
   - Washington affiliate user should have NQMS permissions for specific NY program
   - Should be able to view/edit assessments, documents, goals
   - Should NOT appear in NY affiliate's program list for recruitment purposes
   - **CONFIRMED (Meeting 3)**: Should be able to archive assessments and manage goals

2. **Scenario 2**: Emily (Minnesota affiliate) is working with a New York program on NQMS
   - Emily needs NQMS permissions for that specific NY program
   - Emily runs a report on "my NQMS programs" → NY program should appear
   - Emily's primary affiliate is still Minnesota (for her other programs)

3. **Scenario 3**: Program contact changes at the New York program Emily is supporting
   - **Discovery needed**: Can Emily edit contact info? Or must NY affiliate? Or must program?
   - **Discovery needed**: What program information can secondary affiliate edit?

4. **Scenario 4**: Emily needs to work with a new program that's not yet in the Connector
   - **Discovery needed**: Can Emily approve their application or must primary affiliate?
   - **Discovery needed**: Can Emily create/add program or must it be approved by geographic affiliate first?

5. **Scenario 5 (NEW - Meeting 3)**: Sarah (Colorado affiliate) needs to archive a half-completed assessment
   - Program started assessment process but staff left mid-way
   - New staff doesn't want to continue with NQMS
   - Sarah needs to archive the dead assessment so it doesn't appear in reports
   - Archived assessment should not show in active program list or aggregate reports
   - Data should be retained in database but not accessible via UI (soft delete)

6. **Scenario 6 (NEW - Meeting 3)**: Mike needs to delete a test goal that was entered incorrectly
   - Goal was attached to wrong assessment question
   - Need to permanently delete incorrect goal and create new one on correct question
   - Goal deletion is for data entry errors only, not for unmet goals
   - Deletion should be hard delete (permanent removal)

### Discovery Questions

#### 1. Scope of Access
- **What specific actions should secondary affiliates be able to perform?**
  - Open/create assessments? *(Assumed: Yes)*
  - Submit/approve assessments? *(Discovery needed)*
  - Upload/manage documents? *(Assumed: Yes)*
  - Create/edit goals and I&I plans? *(Assumed: Yes)*
  - View program details? *(Assumed: Yes)*
  - Edit program information (contact, address, etc.)? *(Discovery needed)*
  - Approve new program applications? *(Discovery needed)*
  - Add users to the program? *(Discovery needed)*
  - Archive/delete assessments? *(CONFIRMED: Yes - Meeting 3, 10/23/24)*
  - Delete/manage goals? *(CONFIRMED: Yes - Meeting 3, 10/23/24)*

#### 2. Assignment & Approval Workflow
- **Who can assign secondary affiliates to programs?**
  - Option A: Global admins only (Nicki, National staff)
  - Option B: Primary affiliate admins can assign secondary affiliates
  - Option C: Secondary affiliate staff can self-assign
  - Option D: Program admins can invite secondary affiliates
  - **Recommended**: Option A (Global admins) for control, or Option B (Primary affiliate) for scalability

- **Is approval required for secondary affiliate assignments?**
  - Does primary affiliate need to approve secondary affiliate access?
  - Does program need to consent to secondary affiliate access?
  - Or is assignment administrative only (no approval needed)?

- **Can a program have multiple secondary affiliates?**
  - E.g., Could both MENTOR Washington and MENTOR Texas support the same California program?
  - Is there a limit to how many secondary affiliates per program?

#### 3. Terminology & Relationships
- **What should we call these relationships?**
  - "Secondary Affiliate"? "Partner Affiliate"? "NQMS Affiliate"? "Supporting Affiliate"?
  - "Primary Affiliate" vs. "Geographic Affiliate" vs. "Home Affiliate"?
  - **Recommended**: "Primary Affiliate" (ZIP code-based) and "Secondary Affiliate" (NQMS assignment)

- **Should the primary affiliate always be visible/known?**
  - Should programs see which affiliate is their "primary" (ZIP-based)?
  - Should programs see all secondary affiliates assigned to them?
  - Should affiliates see which programs they're primary vs. secondary for?

#### 4. Reporting & Data Visibility
- **How should secondary affiliates appear in reports?**
  - When Emily (Minnesota) runs "NQMS Aggregate Report", should her NY programs appear?
  - Should reports distinguish between primary and secondary affiliate programs?
  - Should there be a "Secondary Affiliates Report" showing all cross-state assignments?

- **How should programs appear in affiliate dashboards?**
  - Should Emily see NY program in her main program list with a badge/indicator?
  - Or should there be a separate "Secondary Programs" section?
  - Should program counts distinguish primary vs. secondary?

- **What happens to assessment approval notifications?**
  - Currently sent to affiliate users based on ZIP codes
  - Should secondary affiliate users also receive notifications?
  - Or only the primary affiliate?

#### 5. Data Integrity & Migration
- **What about existing programs?**
  - Should all existing programs be automatically assigned a "primary affiliate" based on current ZIP code?
  - What happens to programs without ZIP codes (the "necessary ZIP code entries" issue)?
  - Should there be a migration process or reporting tool to identify/fix programs without proper affiliate assignment?

- **What happens when a program's ZIP code changes?**
  - Does the primary affiliate automatically update?
  - Do secondary affiliates remain unchanged?
  - Should there be a notification to old and new primary affiliates?

#### 6. UI/UX Considerations
- **Where should secondary affiliate assignment happen?**
  - On the program edit page? (new section for "Secondary Affiliates")
  - In a separate "Manage Affiliates" page?
  - In user management (assign users to programs directly)?
  - **Recommended**: Program edit page with "Secondary Affiliates" multi-select

- **How should users see their access type?**
  - Should there be a badge/label on programs indicating "Primary" vs. "Secondary" access?
  - Should navigation or breadcrumbs indicate when viewing a secondary program?

- **What permissions warnings/notices are needed?**
  - Should secondary affiliate users see a notice explaining their limited scope?
  - Should programs be notified when secondary affiliates are added/removed?

#### 7. Technical Implementation
- **Should this use the existing `access_level` field or a new field?**
  - Current access levels: Full Access (1), MC-Only (2), NQMS-Only (3)
  - Option A: Add new access level "Secondary NQMS Access" (4)
  - Option B: Create new junction table for secondary affiliate relationships
  - **Recommended**: Option B (new table) to separate concepts clearly

- **Should secondary access be at program level or user level?**
  - Option A: Affiliate-to-Program assignment (all affiliate users get access)
  - Option B: User-to-Program assignment (specific users get access)
  - **Recommended**: Option A (Affiliate-to-Program) with user-level override option

---

## Recommended Solution (Budget-Friendly)

### Approach: Secondary Affiliate Assignment via New Junction Table

**Implementation:**

#### 1. Database Changes

Create new `programs_affiliates` junction table for secondary affiliate relationships:

```sql
CREATE TABLE programs_affiliates (
    id INT AUTO_INCREMENT PRIMARY KEY,
    program_id INT NOT NULL,
    affiliate_id INT NOT NULL,
    is_primary TINYINT(1) DEFAULT 0 COMMENT '1=Primary (ZIP-based), 0=Secondary (manual assignment)',
    access_type ENUM('full_nqms', 'limited_nqms') DEFAULT 'full_nqms' COMMENT 'full_nqms=all NQMS features, limited_nqms=view only',
    created DATETIME DEFAULT CURRENT_TIMESTAMP,
    modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    created_by INT NULL COMMENT 'User ID who created this assignment',
    modified_by INT NULL COMMENT 'User ID who last modified',
    UNIQUE KEY idx_program_affiliate (program_id, affiliate_id),
    INDEX idx_program (program_id),
    INDEX idx_affiliate (affiliate_id),
    INDEX idx_is_primary (is_primary),
    FOREIGN KEY (program_id) REFERENCES programs(id) ON DELETE CASCADE,
    FOREIGN KEY (affiliate_id) REFERENCES affiliates(id) ON DELETE CASCADE,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (modified_by) REFERENCES users(id) ON DELETE SET NULL
);
```

**Migration Strategy:**
```sql
-- Populate primary affiliates based on current ZIP code logic
INSERT INTO programs_affiliates (program_id, affiliate_id, is_primary, created_by)
SELECT DISTINCT
    pl.program_id,
    sa.affiliate_id,
    1 as is_primary,
    NULL as created_by
FROM program_locations pl
INNER JOIN postal_codes_service_areas pcsa ON pl.zip_code = pcsa.postal_code_id
INNER JOIN service_areas sa ON pcsa.service_area_id = sa.id
WHERE pl.zip_code IS NOT NULL;
```

#### 2. Update Permission Logic

Modify `UserPermissionsTrait::hasAccess()` to check both ZIP-based and table-based assignments:

```php
// In UserPermissionsTrait.php, update hasAccess() method

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

    // Check 2: Secondary affiliate assignment (NEW)
    $secondaryAffiliateAccess = $this->hasSecondaryAffiliateAccess($programId, $user, $notEqual);
    if ($secondaryAffiliateAccess) {
        return true;
    }

    // Check 3: Primary affiliate via ZIP codes (existing)
    $programIds = $this->getProgramIdsFromAffiliatesByAccessLevel($user, $notEqual);
    if (!empty($programIds) && in_array($programId, $programIds)) {
        return true;
    }

    return false;
}

/**
 * Check if user has access to program via secondary affiliate assignment
 *
 * @param int $programId Program ID
 * @param User $user Current user
 * @param int $notEqual Access level to exclude
 * @return bool
 */
private function hasSecondaryAffiliateAccess(int $programId, $user, int $notEqual): bool
{
    // Get user's affiliate IDs (excluding MC-Only)
    $affiliateIds = TableRegistry::getTableLocator()->get('Affiliates.AffiliatesUsers')->find()
        ->select(['affiliate_id'])
        ->where([
            'user_id' => $user->id,
            'access_level !=' => $notEqual
        ])
        ->all()
        ->extract('affiliate_id')
        ->toArray();

    if (empty($affiliateIds)) {
        return false;
    }

    // Check if any of user's affiliates are assigned to this program (primary or secondary)
    $assignmentCount = TableRegistry::getTableLocator()->get('Programs.ProgramsAffiliates')->find()
        ->where([
            'program_id' => $programId,
            'affiliate_id IN' => $affiliateIds
        ])
        ->count();

    return $assignmentCount > 0;
}
```

#### 3. Create ProgramsAffiliatesTable Model

```php
// plugins/Programs/src/Model/Table/ProgramsAffiliatesTable.php

namespace Programs\Model\Table;

use Cake\ORM\Table;
use Cake\Validation\Validator;

class ProgramsAffiliatesTable extends Table
{
    public function initialize(array $config): void
    {
        parent::initialize($config);

        $this->setTable('programs_affiliates');
        $this->setPrimaryKey('id');

        $this->belongsTo('Programs')
            ->setClassName('Programs.Programs')
            ->setForeignKey('program_id');

        $this->belongsTo('Affiliates')
            ->setClassName('Affiliates.Affiliates')
            ->setForeignKey('affiliate_id');

        $this->belongsTo('CreatedByUser')
            ->setClassName('Users.Users')
            ->setForeignKey('created_by');

        $this->addBehavior('Timestamp');
    }

    public function validationDefault(Validator $validator): Validator
    {
        $validator
            ->notEmptyString('program_id')
            ->notEmptyString('affiliate_id')
            ->boolean('is_primary');

        return $validator;
    }
}
```

#### 4. Update ProgramsTable to Include Association

```php
// In plugins/Programs/src/Model/Table/ProgramsTable.php initialize() method

$this->hasMany('ProgramsAffiliates')
    ->setClassName('Programs.ProgramsAffiliates')
    ->setForeignKey('program_id');

$this->belongsToMany('Affiliates')
    ->setClassName('Affiliates.Affiliates')
    ->setThrough('Programs.ProgramsAffiliates')
    ->setTargetForeignKey('affiliate_id')
    ->setForeignKey('program_id');

// Add helper method to get primary affiliate
$this->hasOne('PrimaryAffiliate')
    ->setClassName('Programs.ProgramsAffiliates')
    ->setForeignKey('program_id')
    ->setConditions(['PrimaryAffiliate.is_primary' => 1]);
```

#### 5. Update Program Edit Form

Add secondary affiliate management section to program edit page:

```twig
{# In plugins/Programs/templates/Admin/Programs/edit.twig #}

<div class="form-group">
    <label>Primary Affiliate</label>
    <p class="form-control-static">
        {{ program.primary_affiliate.affiliate.name ?? 'Auto-assigned by ZIP code' }}
    </p>
    <small class="form-text text-muted">
        Primary affiliate is automatically determined by program ZIP code.
    </small>
</div>

<div class="form-group">
    {{ form.label('secondary_affiliates', 'Secondary Affiliates (NQMS Support)') }}
    {{ form.select('secondary_affiliates', affiliatesList, {
        'multiple': true,
        'class': 'form-control',
        'data-placeholder': 'Select affiliates...'
    }) }}
    <small class="form-text text-muted">
        Secondary affiliates can access NQMS assessments, documents, and goals for this program.
    </small>
</div>
```

#### 6. Update Reports to Show Secondary Affiliates

Modify NQMS Aggregate Report and other reports to include programs where user's affiliate is secondary:

```php
// In plugins/Reports/src/Controller/Admin/ReportsController.php

// Update query to include both primary and secondary affiliate programs
$query->matching('ProgramsAffiliates', function ($q) use ($affiliateId) {
    return $q->where([
        'ProgramsAffiliates.affiliate_id' => $affiliateId,
        // No is_primary filter - include both primary and secondary
    ]);
});
```

#### 7. Add Admin Management Page (Optional)

Create new page for global admins to manage all secondary affiliate assignments:

```php
// plugins/Programs/src/Controller/Admin/AffiliateAssignmentsController.php

public function index()
{
    $assignments = $this->ProgramsAffiliates->find()
        ->contain(['Programs', 'Affiliates', 'CreatedByUser'])
        ->where(['is_primary' => 0]) // Only secondary
        ->order(['created' => 'DESC']);

    $this->set(compact('assignments'));
}
```

---

## Benefits of This Solution

1. **Preserves Existing ZIP Code Logic**: Primary affiliates still determined by service areas
2. **Clear Separation**: New table makes relationship explicit and auditable
3. **Flexible**: Can assign multiple secondary affiliates per program
4. **Backward Compatible**: Doesn't break existing permission checks
5. **Auditable**: Tracks who created/modified assignments with timestamps
6. **Scalable**: Can add more access types (full_nqms, limited_nqms) in future
7. **Simple Migration**: One SQL query to populate primary affiliates

---

## Files to Modify

### Database
- `config/Migrations/` - New migration for `programs_affiliates` table
- `config/Seeds/` - Optional seed for testing

### Models
- `plugins/Programs/src/Model/Table/ProgramsAffiliatesTable.php` - NEW table class
- `plugins/Programs/src/Model/Entity/ProgramsAffiliate.php` - NEW entity class
- `plugins/Programs/src/Model/Table/ProgramsTable.php` - Add associations
- `plugins/Affiliates/src/Model/Table/AffiliatesTable.php` - Add associations

### Permission Logic
- `plugins/Users/src/Trait/UserPermissionsTrait.php` - Update hasAccess(), add hasSecondaryAffiliateAccess()

### Controllers
- `plugins/Programs/src/Controller/Admin/ProgramsController.php` - Handle secondary_affiliates in add/edit
- `plugins/Programs/src/Controller/Admin/AffiliateAssignmentsController.php` - NEW controller for management page (optional)
- `plugins/Reports/src/Controller/Admin/ReportsController.php` - Update report queries

### Views/Templates
- `plugins/Programs/templates/Admin/Programs/edit.twig` - Add secondary affiliates field
- `plugins/Programs/templates/Admin/Programs/view.twig` - Display affiliates
- `plugins/Programs/templates/Admin/AffiliateAssignments/index.twig` - NEW management page

### Configuration
- `config/request_policy_configs.php` - Add permissions for AffiliateAssignments controller (global only)
- `config/navigation.php` - Add "Affiliate Assignments" menu item (global admins only)

---

## Technical Considerations

### Performance
- Add indexes on `programs_affiliates` (program_id, affiliate_id, is_primary)
- Permission checks will query one additional table (minimal overhead)
- Consider caching affiliate assignments if performance becomes an issue

### Data Integrity
- Foreign key constraints ensure orphaned records are cleaned up
- Migration populates primary affiliates based on current ZIP logic
- Programs without ZIP codes will have no primary affiliate (needs manual assignment)

### Edge Cases
- **Program changes ZIP code**: Primary affiliate should auto-update or be manually reviewed
- **Service area changes**: May affect which programs get auto-assigned as primary
- **Affiliate is deleted**: Cascade delete removes assignments (foreign key)
- **Program is deleted**: Cascade delete removes assignments (foreign key)

### Future Enhancements
- Audit log for assignment changes (who added/removed secondary affiliates)
- Notifications when secondary affiliates are added/removed
- Approval workflow for secondary affiliate requests
- Self-service portal for affiliates to request access to programs
- Bulk assignment tool (assign one affiliate to multiple programs at once)

---

## Alternative Approaches Considered

### Alternative 1: Direct User-to-Program Assignment
**Approach**: Add records to `programs_users` table with special access_level

**Pros:**
- Uses existing table structure
- User-level granularity

**Cons:**
- Doesn't capture affiliate relationship
- Must assign each user individually (not scalable)
- Reports would be complex (can't group by affiliate)
- No concept of "primary" vs "secondary" affiliate

**Verdict**: Not recommended - loses affiliate concept

### Alternative 2: Add `secondary_affiliate_id` to Programs Table
**Approach**: Add foreign key field to programs table

**Pros:**
- Simple database change
- Easy to query

**Cons:**
- Only supports ONE secondary affiliate per program
- Not scalable to multiple secondary affiliates
- Harder to track history/audit
- Mixing geographic and assigned relationships

**Verdict**: Not recommended - not flexible enough

### Alternative 3: Override ZIP Code Logic with Manual Affiliate Field
**Approach**: Add `affiliate_id` field to programs table, stop using ZIP codes

**Pros:**
- Simplest logic
- Clear single affiliate per program

**Cons:**
- **Breaks existing recruitment functionality** (requires ZIP codes)
- Loses automatic assignment benefit
- Must manually assign every program
- No concept of secondary affiliates for NQMS

**Verdict**: Not recommended - violates requirement to preserve ZIP logic for recruitment

---

## Overall Discovery Questions

### Priority & Timeline
1. **What is the urgency of this feature?**
   - Is the fake ZIP code workaround causing data integrity issues?
   - How many cross-affiliate NQMS relationships exist today?
   - Is this blocking NQMS growth/expansion?

2. **Should this be implemented in phases?**
   - Phase 1: Basic secondary affiliate assignment (global admins only)
   - Phase 2: Self-service affiliate requests
   - Phase 3: Program approval workflow
   - Phase 4: Advanced reporting and analytics

### User Impact
1. **How many affiliate staff work across state lines for NQMS?**
   - Is this a common scenario or edge case?
   - How many programs would need secondary affiliate assignments initially?

2. **Training & Communication:**
   - How should users be notified about this feature?
   - What documentation is needed?
   - Should there be tooltips/help text explaining primary vs. secondary?

### Integration with Other Requests
1. **Relationship to Assessment Requests document:**
   - Request 2B (Delete/Manage Programs) - Who can delete? Primary only? Both?
   - Document access - Do secondary affiliates see all documents or NQMS-only?

2. **Relationship to Document Requests:**
   - Should secondary affiliates have full document access or limited?
   - Should document visibility be configurable per affiliate assignment?

---

## Permissions Matrix (Updated from Meeting 3 - 10/23/24)

This section documents confirmed permission decisions for various NQMS actions.

### Assessment Management Permissions

| Action | Program Users | Affiliate Staff | National Staff | Global Admins |
|--------|--------------|----------------|----------------|---------------|
| Fill out/submit assessment | ✅ Yes | ✅ Yes | ✅ Yes | ✅ Yes |
| View assessment | ✅ Yes | ✅ Yes | ✅ Yes | ✅ Yes |
| Archive assessment | ❌ No | ✅ Yes | ✅ Yes | ✅ Yes |
| Delete assessment (hard) | ❌ No | ❌ No | ❌ No | ✅ Yes (via support request) |
| Restore archived assessment | ❌ No | ❌ No (for now) | ❌ No (for now) | ✅ Yes (via support request) |

**Key Decisions:**
- Archive functionality uses soft delete (data retained in database, not shown in reports or UI)
- No recovery/restore UI will be built initially
- Archive button appears on assessment view page
- Archived assessments do NOT appear in any reports or program views
- Hard deletes only handled by support team on request basis

### Goal Management Permissions

| Action | Program Users | Affiliate Staff | National Staff | Global Admins |
|--------|--------------|----------------|----------------|---------------|
| View goals | ✅ Yes | ✅ Yes | ✅ Yes | ✅ Yes |
| Add goal | ❌ No* | ✅ Yes | ✅ Yes | ✅ Yes |
| Edit goal | ❌ No* | ✅ Yes | ✅ Yes | ✅ Yes |
| Delete goal | ❌ No | ✅ Yes | ✅ Yes | ✅ Yes |
| Set goal start/target dates | ❌ No* | ✅ Yes | ✅ Yes | ✅ Yes |

**Key Decisions:**
- *Tim suggested building for both program and staff technically, but Mike prefers policy restriction to staff only
- Current system already restricts programs from editing goals (was removed previously)
- Affiliate reviewers should maintain control over goal data to ensure data integrity
- Programs can communicate goal updates to reviewers, but reviewers enter the data
- Goal deletion is hard delete (permanent) - used only for data entry errors, not for unmet goals

### Program Management Permissions

| Action | Program Users | Affiliate Staff | National Staff | Global Admins |
|--------|--------------|----------------|----------------|---------------|
| View program details | ✅ Yes (own) | ✅ Yes (service area) | ✅ Yes (all) | ✅ Yes (all) |
| Edit program info | ✅ Yes (own) | ⚠️ TBD | ⚠️ TBD | ✅ Yes |
| Delete program | ❌ No | ❌ No | ❌ No | ✅ Yes (Connector) |
| Assign secondary affiliates | ❌ No | ⚠️ TBD | ⚠️ TBD | ✅ Yes |

**Key Decisions:**
- Program deletion is handled on Mentoring Connector side, NOT in NQMS
- Program inactive status is different from assessment archive status
- Inactive programs retain their assessment data and it appears in reports

### Open Questions (Require Further Discovery)

1. **Secondary Affiliate Assignment Authority**: Who can assign secondary affiliates to programs?
   - Option A: Global admins only
   - Option B: Primary affiliate admins
   - Option C: Both primary and global

2. **Program Information Editing**: Can secondary affiliates edit program contact info?
   - Need to clarify scope of what secondary affiliates can modify

3. **Goal Update Notifications**: Should system send automated reminders based on goal dates?
   - Meeting consensus: NO automated email reminders (adds scope/cost)
   - Consider dashboard indicators for overdue goals instead

4. **Multi-Year Goal Tracking**: How are goals managed across the 3-year assessment cycle?
   - Sarah indicated goals are added in annual chunks (year 1, year 2, year 3)
   - Each year: review, complete old goals, add new goals
   - Year 3: Full reassessment

---

## Next Steps

1. **Schedule discovery session** with Nicki and key stakeholders
2. **Clarify assignment workflow** (who assigns, approval needed?)
3. **Define scope of secondary affiliate access** (what actions allowed?)
4. **Review existing cross-affiliate relationships** (how many? which states?)
5. **Determine program contact edit permissions** (Emily's question)
6. **Identify programs without ZIP codes** (migration/cleanup needed?)
7. **Get approval on terminology** (Primary vs. Secondary Affiliate)
8. **Create detailed solution proposal** with finalized requirements
9. **Develop effort estimate** based on approved scope
10. **Present findings and recommendations** to client for prioritization
