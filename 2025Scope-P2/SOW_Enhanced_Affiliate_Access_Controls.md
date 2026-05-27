# Scope of Work: Enhanced Affiliate Access Controls

**Project:** NQMS Cross-Affiliate Permissions Enhancement
**Prepared By:** Aksana Rahouski, Senior Product Manager
**Date:** 2024-10-28
**Status:** Ready for Developer Estimation

---

## 1. Problem Statement

**Current State:**
- Affiliate staff can only access programs in their geographic service area (determined by ZIP codes)
- Direct program access exists but doesn't maintain affiliate context or grant approval permissions
- MENTOR Washington cannot support California programs through NQMS without workarounds (fake ZIP codes)

**Business Impact:**
- Blocks cross-affiliate NQMS consulting relationships
- Requires manual workarounds that compromise data integrity
- Prevents proper approval workflows for out-of-state support

**Root Cause:**
The `affiliates_users` table only supports "all programs in region" access based on ZIP code matching. There's no mechanism to assign specific programs while maintaining the affiliate relationship required for:
1. Assessment approval permissions (`canApproveAssessment()` only checks affiliate relationships)
2. Reporting (affiliate-based reports)
3. Audit trails (who from which affiliate did what)

---

## 2. Proposed Solution

### High-Level Approach
Enhance the existing Affiliate Access Controls to support **two scope options**:
1. **All programs in region** (current behavior, remains default)
2. **Specific programs only** (new capability)

### How It Works
When assigning a user to an affiliate, admins can now choose:
- **Scope = "All programs"** → User gets access to all programs in affiliate's service area (existing behavior)
- **Scope = "Specific programs"** → User selects which programs to grant access to (new)

Both maintain the affiliate relationship, so approval permissions and reporting work correctly.

### Data Model Changes

**Add to `affiliates_users` table:**
- `scope` ENUM('all_programs', 'specific_programs') DEFAULT 'all_programs'
- `created`, `modified`, `created_by`, `modified_by` (audit trail)

**New `affiliates_users_programs` junction table:**
- Links `affiliates_users.id` to specific `program_id` values
- Only populated when scope='specific_programs'
- CASCADE delete when affiliate assignment or program is deleted

### Permission Logic Changes

Update `hasAccess()` and `canApproveAssessment()` to check:
1. Superuser (existing)
2. Direct program access via `programs_users` (existing)
3. **Specific program access via `affiliates_users_programs` (NEW)**
4. All-programs access via ZIP codes (existing)

### UI Changes

In the User Edit page, Affiliate Access Controls section:
- Add **"Scope"** radio buttons: "All programs in region" / "Specific programs only"
- Add **"Programs"** multi-select dropdown (hidden by default)
- When "Specific programs" selected: Show dropdown, load programs via AJAX
- When affiliate changes: Reload program list for that affiliate
- Validate: If scope='specific_programs', must select at least 1 program

---

## 3. Acceptance Criteria

### 3.1 Database & Models
- [ ] Migration adds `scope` column to `affiliates_users` with default 'all_programs'
- [ ] Migration creates `affiliates_users_programs` junction table
- [ ] Existing affiliate assignments default to scope='all_programs' and continue working unchanged
- [ ] `AffiliatesUsersTable` has associations to `AffiliatesUsersPrograms` and `Programs`
- [ ] Validation prevents saving scope='specific_programs' without at least 1 program
- [ ] Cascade delete: Deleting affiliate assignment removes specific program assignments
- [ ] Cascade delete: Deleting program removes its specific program assignments

### 3.2 UI & Form Behavior
- [ ] User edit page shows new "Scope" radio buttons in Affiliate Access Controls section
- [ ] Default scope is "All programs in region"
- [ ] Programs multi-select is hidden when "All programs" is selected
- [ ] Programs multi-select appears when "Specific programs" is selected
- [ ] Programs multi-select loads options via AJAX when affiliate is selected
- [ ] Programs list is filtered to only show programs in selected affiliate's service area
- [ ] Form validation shows error if scope='specific_programs' and no programs selected
- [ ] When editing existing user, scope and selected programs load correctly
- [ ] Multiple affiliate assignments can have different scopes (one "all", another "specific")

### 3.3 Permissions & Access Control
- [ ] User with scope='all_programs' can access all programs in affiliate's service area (existing behavior)
- [ ] User with scope='specific_programs' can ONLY access selected programs
- [ ] User with scope='specific_programs' CANNOT access other programs in affiliate's service area
- [ ] Access respects access_level (Full Access / MC-Only / NQMS-Only)
- [ ] User with specific program access can view assessments for those programs (if not MC-Only)
- [ ] User with specific program access can edit assessments for those programs (if not MC-Only)
- [ ] **User with specific program access can APPROVE assessments for those programs (if not MC-Only)**
- [ ] User with MC-Only access cannot approve, even with specific program access
- [ ] User cache is cleared when affiliate assignments are saved/deleted
- [ ] Permissions recalculate immediately after changes

### 3.4 API Endpoint
- [ ] New endpoint: `GET /admin/api/affiliates/{id}/programs` returns JSON array of programs
- [ ] Endpoint returns programs in affiliate's service area (based on ZIP codes)
- [ ] Programs are sorted alphabetically by name
- [ ] Endpoint returns empty array if no programs found
- [ ] Endpoint returns 404 if affiliate not found
- [ ] Endpoint requires authentication and appropriate permissions

### 3.5 Edge Cases
- [ ] User with both "all programs" (Affiliate A) and "specific programs" (Affiliate B) has correct access to both
- [ ] User assigned to same affiliate twice (different access levels) - system prevents duplicate or handles gracefully
- [ ] Program with no ZIP code / affiliate with no service areas - system handles gracefully
- [ ] Deleting affiliate removes all user assignments and specific program assignments (cascade)
- [ ] Changing scope from "specific" to "all" clears program selections
- [ ] Changing scope from "all" to "specific" requires program selection before save

---

## 4. Test Cases

### 4.1 Database & Model Tests

#### Test: Migration runs successfully
- Run migration on fresh database → succeeds
- Run migration on existing database with data → succeeds, existing records default to scope='all_programs'
- Rollback migration → succeeds, removes added columns/tables

#### Test: Model validations
- Create affiliate assignment with scope='all_programs', no programs → saves successfully
- Create affiliate assignment with scope='specific_programs', no programs → validation error
- Create affiliate assignment with scope='specific_programs', 1+ programs → saves successfully
- Save includes nested `affiliates_users_programs` records correctly

#### Test: Cascade deletes
- Delete affiliate assignment with specific programs → program assignments deleted
- Delete program that has specific assignments → program assignments deleted
- User cache cleared after save/delete

---

### 4.2 Permission Logic Tests

#### Test: hasAccess() with specific program access
```
Given: User assigned to MENTOR Washington with scope='specific_programs'
  And: Programs [100, 200] selected
  And: User has access_level=NQMS_ONLY
When: Check hasAccess(programId=100)
Then: Returns TRUE

When: Check hasAccess(programId=300)
Then: Returns FALSE
```

#### Test: hasAccess() with all programs access
```
Given: User assigned to MENTOR Colorado with scope='all_programs'
  And: Colorado service area includes ZIP 80201
  And: Program 100 is located in ZIP 80201
When: Check hasAccess(programId=100)
Then: Returns TRUE
```

#### Test: canApproveAssessment() with specific program access
```
Given: User assigned to MENTOR Washington with scope='specific_programs'
  And: Programs [100, 200] selected
  And: User has access_level=NQMS_ONLY
When: Check canApproveAssessment(programId=100)
Then: Returns TRUE

When: Check canApproveAssessment(programId=300)
Then: Returns FALSE
```

#### Test: canApproveAssessment() respects MC-Only restriction
```
Given: User assigned to MENTOR Washington with scope='specific_programs'
  And: Programs [100] selected
  And: User has access_level=MC_ONLY
When: Check canApproveAssessment(programId=100)
Then: Returns FALSE
```

#### Test: User with multiple affiliate assignments
```
Given: User assigned to MENTOR Colorado with scope='all_programs', access_level=FULL_ACCESS
  And: User assigned to MENTOR Washington with scope='specific_programs', programs=[100]
  And: Colorado includes program 200 in service area
When: Check hasAccess(programId=200)
Then: Returns TRUE (Colorado all-programs)
When: Check hasAccess(programId=100)
Then: Returns TRUE (Washington specific)
When: Check hasAccess(programId=300)
Then: Returns FALSE (not assigned)
```

---

### 4.3 UI & Form Tests

#### Test: Default behavior - all programs scope
```
Given: Admin opens User Edit page
  And: Adds new affiliate assignment
When: Scope defaults to "All programs in region"
Then: Programs multi-select is hidden
When: Admin saves form
Then: User has access to all programs in affiliate's service area
```

#### Test: Specific programs scope with AJAX loading
```
Given: Admin opens User Edit page
  And: Adds new affiliate assignment
When: Admin selects "Specific programs only"
Then: Programs multi-select becomes visible
  And: AJAX request sent to /admin/api/affiliates/{id}/programs
When: AJAX returns [{"id": 100, "name": "Big Brothers LA"}, ...]
Then: Programs populate in multi-select dropdown
When: Admin selects 2 programs and saves
Then: User has access to ONLY those 2 programs
```

#### Test: Form validation
```
Given: Admin selects "Specific programs only"
When: Admin saves form without selecting programs
Then: Validation error displays: "At least one program must be selected"
  And: Form does not save
```

#### Test: Editing existing assignment
```
Given: User has affiliate assignment with scope='specific_programs', programs=[100, 200]
When: Admin opens User Edit page
Then: Scope shows "Specific programs only" selected
  And: Programs multi-select shows programs 100 and 200 selected
When: Admin changes scope to "All programs in region"
  And: Admin saves form
Then: User now has access to all programs in service area
  And: Program assignments [100, 200] are deleted
```

#### Test: Affiliate change reloads programs
```
Given: Admin selects "Specific programs only"
  And: Admin selects Affiliate A (programs 100, 200 available)
  And: Admin selects programs 100, 200
When: Admin changes to Affiliate B (programs 300, 400 available)
Then: Program multi-select reloads with programs 300, 400
  And: Previous selections (100, 200) are cleared
```

---

### 4.4 API Endpoint Tests

#### Test: GET /admin/api/affiliates/{id}/programs - success
```
Given: Affiliate 10 has service area with ZIP codes [80201, 80202]
  And: Programs 100, 200 are in ZIP 80201
  And: Programs are named "Youth Mentoring", "Big Brothers"
When: GET /admin/api/affiliates/10/programs
Then: Response status 200
  And: Response body: [
        {"id": 100, "name": "Big Brothers"},
        {"id": 200, "name": "Youth Mentoring"}
      ]
  And: Programs sorted alphabetically
```

#### Test: GET /admin/api/affiliates/{id}/programs - no programs
```
Given: Affiliate 10 has no programs in service area
When: GET /admin/api/affiliates/10/programs
Then: Response status 200
  And: Response body: []
```

#### Test: GET /admin/api/affiliates/{id}/programs - not found
```
Given: Affiliate 999 does not exist
When: GET /admin/api/affiliates/999/programs
Then: Response status 404
```

---

### 4.5 Integration Tests (End-to-End)

#### Test: Cross-affiliate NQMS consulting (Primary Use Case)
```
Scenario: MENTOR Washington consultant supports California program

Given: User "Emily" exists
  And: Affiliate "MENTOR Washington" (ID=100) exists
  And: Affiliate "MENTOR California" (ID=200) exists
  And: Program "Big Brothers LA" (ID=1000) is in California service area

When: Admin assigns Emily to MENTOR Washington with:
  - access_level = NQMS_ONLY
  - scope = specific_programs
  - programs = [1000]

Then: Emily can login and see "Big Brothers LA" in her program list
  And: Emily can open the program
  And: Emily can view assessments for Big Brothers LA
  And: Emily can edit assessments for Big Brothers LA
  And: Emily can submit assessments for review
  And: Emily can APPROVE assessments for Big Brothers LA
  And: Emily CANNOT see any other California programs
  And: Reports show Emily as assigned to MENTOR Washington (not California)
```

#### Test: Mixed scope assignments
```
Scenario: User has full access to home region, specific access to other region

Given: User "Sarah" exists
  And: Affiliate "MENTOR Colorado" (ID=100) has programs [1, 2, 3, 4, 5]
  And: Affiliate "MENTOR Washington" (ID=200) has programs [101, 102, 103]

When: Admin assigns Sarah to MENTOR Colorado with:
  - access_level = FULL_ACCESS
  - scope = all_programs

And: Admin assigns Sarah to MENTOR Washington with:
  - access_level = NQMS_ONLY
  - scope = specific_programs
  - programs = [101]

Then: Sarah can access ALL Colorado programs (1, 2, 3, 4, 5) with Full Access
  And: Sarah can access ONLY program 101 from Washington with NQMS-Only access
  And: Sarah can edit program details for Colorado programs
  And: Sarah CANNOT edit program details for Washington program 101 (NQMS-Only restriction)
  And: Sarah can approve assessments for ALL Colorado programs
  And: Sarah can approve assessments for Washington program 101
  And: Sarah CANNOT access Washington programs 102, 103
```

#### Test: Changing assignment scope
```
Scenario: Admin changes user's access from all-programs to specific-programs

Given: User "Mike" is assigned to MENTOR Texas with scope='all_programs'
  And: Texas has programs [501, 502, 503, 504, 505]
  And: Mike currently has access to all 5 programs

When: Admin changes Mike's assignment to:
  - scope = specific_programs
  - programs = [501, 502]

Then: Mike can now access ONLY programs 501 and 502
  And: Mike CANNOT access programs 503, 504, 505
  And: Mike's permissions are immediately updated (cache cleared)
```

---

### 4.6 Negative Tests

#### Test: Cannot approve with MC-Only access
```
Given: User assigned to affiliate with scope='specific_programs', programs=[100]
  And: User has access_level=MC_ONLY
When: User attempts to approve assessment for program 100
Then: Action is denied (canApproveAssessment returns FALSE)
```

#### Test: Cannot bypass scope restriction
```
Given: User assigned to affiliate with scope='specific_programs', programs=[100]
When: User manually navigates to program 200 URL
Then: Access denied / redirected
When: User attempts API call to fetch program 200 data
Then: 403 Forbidden response
```

#### Test: Cannot save invalid data
```
Given: Admin creates affiliate assignment with scope='specific_programs'
When: Admin submits form without selecting programs
Then: Form validation fails, no data saved
```

---

## 5. Definition of Done

This feature is complete when:

- [ ] All acceptance criteria are met
- [ ] All test cases pass (unit, integration, manual)
- [ ] Code review completed and approved
- [ ] Deployed to staging environment
- [ ] PM/client UAT completed and signed off
- [ ] No critical or high-priority bugs
- [ ] Documentation updated (if needed)
- [ ] Performance benchmarks acceptable (no degradation >500ms)

---

## 6. Out of Scope

- ❌ Bulk assignment tools
- ❌ Self-service access requests
- ❌ Approval workflows for access requests
- ❌ Notifications for access changes
- ❌ Audit log UI (data captured, no UI)
- ❌ Changes to existing reports (beyond compatibility)
- ❌ Deprecating existing Program Access Controls

---

## 7. Files to Modify/Create

### Database
- `config/Migrations/[TIMESTAMP]_EnhanceAffiliatesUsersWithProgramScope.php` (NEW)

### Models
- `plugins/Affiliates/src/Model/Table/AffiliatesUsersTable.php` (MODIFY)
- `plugins/Affiliates/src/Model/Table/AffiliatesUsersProgramsTable.php` (NEW)
- `plugins/Affiliates/src/Model/Entity/AffiliatesUser.php` (NEW)

### Controllers
- `plugins/Users/src/Controller/Admin/UsersController.php` (MODIFY)
- `plugins/Affiliates/src/Controller/Api/AffiliatesController.php` (NEW METHOD)

### Views
- `plugins/Users/templates/Admin/Users/edit.php` (MODIFY)

### Permissions
- `plugins/Users/src/Trait/UserPermissionsTrait.php` (MODIFY)

### Tests
- `tests/TestCase/Model/Table/AffiliatesUsersTableTest.php` (MODIFY)
- `tests/TestCase/Model/Table/AffiliatesUsersProgramsTableTest.php` (NEW)
- `tests/TestCase/Trait/UserPermissionsTraitTest.php` (MODIFY)
- `tests/TestCase/Controller/Admin/UsersControllerTest.php` (MODIFY)
- `tests/TestCase/Controller/Api/AffiliatesControllerTest.php` (NEW)

---

## 8. Implementation Reference

For detailed implementation guidance, see:
- [Enhanced Affiliate Access Controls Proposal](/Users/aksana/Documents/Projects/Mentor/NewScope/Enhanced_Affiliate_Access_Controls_Proposal.md)

---

**Status:** ✅ Ready for Developer Estimation
