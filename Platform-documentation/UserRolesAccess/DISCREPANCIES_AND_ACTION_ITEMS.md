# MENTOR Connector - Permission System Discrepancies & Action Items

**Version:** 1.0
**Last Updated:** December 3, 2025
**Priority:** HIGH - Requires Team Review & Decision

---

## Executive Summary

This document outlines critical discrepancies found between the Confluence documentation and the actual code implementation of the MENTOR Connector permission system. These discrepancies may lead to confusion about user capabilities and should be addressed to ensure alignment between documentation and functionality.

**Status:** 3 major discrepancies identified, 0 show-stopping bugs

**Risk Level:** MEDIUM - Documentation misalignment could lead to incorrect role assignments and user frustration

---

## Discrepancy #1: Program User Role Consolidation

### Severity: HIGH
### Impact: Affects documentation accuracy and user expectations

### The Issue

**What the Confluence Documentation Shows:**
- Two separate role columns in the permission matrix:
  1. "Program User (Full Access)"
  2. "Program User (MC-only)"
- These columns show IDENTICAL permissions across all modules

**What the Code Actually Does:**
- Creates only ONE role: `program`
- This role is assigned when `access_level IN (1, 2)` (both Full Access AND MC-Access Only)
- There is no differentiation in the code between program users with Full Access vs MC-Only access

**Code Location:**
```
File: plugins/Users/src/Trait/UserPermissionsTrait.php
Lines: 569-584
```

**Code Evidence:**
```php
// This code creates the "program" role for ANY access level that's NOT NQMS-only
if ($userProgram->access_level != UniversalEnumerations::getValue(
    UniversalEnumerations::KEY_ACCESS_LEVELS,
    UniversalEnumerations::NQMS_ONLY
)) {
    $permissions['program'] = true;
}
```

### Why This Happened

Likely causes:
1. Original design may have intended different permissions for Full vs MC-only program users
2. Implementation consolidated them for simplicity
3. Documentation was created before implementation was finalized
4. No one updated the documentation to match the actual implementation

### Impact Analysis

**Who is affected:**
- Administrators assigning roles expecting different behaviors
- Program users who expect different access based on their access level assignment
- Developers maintaining the system
- Support staff troubleshooting permission issues

**What breaks:**
- Nothing breaks functionally - the system works as coded
- Documentation accuracy is compromised
- User expectations may not match reality

**Data consistency:**
- Database correctly stores `access_level = 1` or `2` in `programs_users` table
- But both values produce identical computed roles and permissions

### Recommended Actions

#### Option A: Update Documentation (RECOMMENDED)

**Pros:**
- No code changes required
- No risk of breaking existing functionality
- Quick to implement
- Reflects actual system behavior

**Cons:**
- Loses granularity in documentation
- May require re-training users on role types

**Steps:**
1. Update Confluence permission matrix to merge the two columns:
   - Remove: "Program User (Full Access)" and "Program User (MC-only)" columns
   - Add: Single "Program User (Full/MC-Access)" column
2. Add note explaining both access levels produce same permissions
3. Update any training materials referencing these separate roles
4. Communicate change to all stakeholders

**Estimated Effort:** 2-3 hours

---

#### Option B: Update Code to Differentiate

**Pros:**
- Makes code match original documentation intent
- Provides more granular control for future needs
- May align better with original business requirements

**Cons:**
- Requires code changes and testing
- Need to define different permissions for the two roles
- Risk of breaking existing user access
- Requires database migration if permission policies change
- Must update authorization policies

**Steps:**
1. Modify `UserPermissionsTrait.php` to create separate roles:
   ```php
   // Replace lines 569-584 with:
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

2. Update `getDefaultPermissionSet()` to include `mc_program`:
   ```php
   private function getDefaultPermissionSet(): array
   {
       return [
           'program' => false,
           'affiliate' => false,
           'mc_program' => false,  // ADD THIS
           'nqms_program' => false,
           'nqms_affiliate' => false,
           'mc_affiliate' => false,
           'nqms_affiliate_limited' => false,
           'nqms_program_limited' => false,
       ];
   }
   ```

3. Update `config/request_policy_configs.php` - add `mc_program` to all routes that currently allow `program`:
   ```php
   // Example: Update inquiries access
   [
       'mustBeLoggedIn' => true,
       'roles' => ['affiliate', 'program', 'mc_program', 'mc_affiliate'],  // ADD mc_program
       'routes' => [
           // ... route configs
       ],
   ],
   ```

4. Define different permissions if needed (currently they're identical)

5. Add unit tests for new role

6. Test thoroughly with actual user scenarios

7. Clear all user permission caches on deployment

**Estimated Effort:** 2-3 days (development + testing)

**Risk:** MEDIUM - Could affect existing users if not tested thoroughly

---

#### Decision Matrix

| Criteria | Option A (Update Docs) | Option B (Update Code) |
|----------|------------------------|------------------------|
| **Effort** | Low (2-3 hours) | High (2-3 days) |
| **Risk** | None | Medium |
| **Accuracy** | Matches current behavior | Matches original intent (maybe) |
| **Future Flexibility** | Limited | High |
| **Testing Required** | Minimal | Extensive |
| **Recommended?** | ✅ YES | ❌ Only if business requires differentiation |

---

### Action Items

- [ ] **DECISION REQUIRED:** Team lead to choose Option A or Option B by [DATE]
- [ ] If Option A:
  - [ ] Update Confluence documentation
  - [ ] Update training materials
  - [ ] Notify stakeholders
- [ ] If Option B:
  - [ ] Clarify business requirements for different permissions
  - [ ] Create detailed technical specification
  - [ ] Implement code changes
  - [ ] Write unit tests
  - [ ] Perform QA testing
  - [ ] Update documentation
  - [ ] Deploy with cache clearing

---

## Discrepancy #2: Limited Contractor Access Level Not Specified

### Severity: MEDIUM
### Impact: Affects role assignment clarity and administrator understanding

### The Issue

**What the Confluence Documentation Shows:**
- Two role columns for Limited-Use Contractors:
  1. "Affiliate User (Limited-Use Contractor)"
  2. "Program User (Limited-Use Contractor)"
- Shows permissions (Can-Edit for NQMS, No Access for most other modules)
- Does NOT specify what access level contractors must have

**What the Code Actually Does:**
- Contractors can ONLY have `access_level = 3` (NQMS-Access Only)
- The `is_limited_contractor` flag ONLY creates role variants when combined with NQMS-Only access:
  - `nqms_affiliate_limited` (affiliate + NQMS-only + contractor)
  - `nqms_program_limited` (program + NQMS-only + contractor)
- There is NO way to create a contractor with Full Access or MC-Only access

**Code Location:**
```
File: plugins/Users/src/Trait/UserPermissionsTrait.php
Lines: 592-634
```

**Code Evidence:**
```php
// For affiliate users - contractor flag only checked for NQMS-only
if ($userAffiliate->access_level == UniversalEnumerations::getValue(
    UniversalEnumerations::KEY_ACCESS_LEVELS,
    UniversalEnumerations::NQMS_ONLY
)) {
    if ($userAffiliate->is_limited_contractor) {
        $permissions['nqms_affiliate_limited'] = true;
    } else {
        $permissions['nqms_affiliate'] = true;
    }
}

// For program users - contractor flag only checked for NQMS-only
if ($userProgram->access_level == UniversalEnumerations::getValue(
    UniversalEnumerations::KEY_ACCESS_LEVELS,
    UniversalEnumerations::NQMS_ONLY
)) {
    if ($userProgram->is_limited_contractor) {
        $permissions['nqms_program_limited'] = true;
    } else {
        $permissions['nqms_program'] = true;
    }
}
```

### Why This Happened

Likely causes:
1. Business requirement: Contractors should only have limited NQMS access
2. Documentation created before implementation details were finalized
3. Assumption that "contractor" implied "NQMS-only" was not explicit

### Impact Analysis

**Who is affected:**
- Administrators trying to assign contractor roles
- Anyone creating contractor users without understanding the access level requirement
- Support staff explaining contractor limitations

**What could go wrong:**
- Admin assigns contractor flag with Full Access or MC-Only access level
- System ignores the contractor flag (doesn't create limited role)
- User gets full NQMS access instead of limited access
- Security/compliance issue if contractors aren't supposed to see historical assessments

**Current behavior if contractor flag set with wrong access level:**
```
access_level = 1 (Full) + is_limited_contractor = 1
→ System creates: affiliate or program role (full access)
→ Contractor flag is IGNORED

access_level = 2 (MC-Only) + is_limited_contractor = 1
→ System creates: mc_affiliate or program role
→ Contractor flag is IGNORED

access_level = 3 (NQMS-Only) + is_limited_contractor = 1
→ System creates: nqms_affiliate_limited or nqms_program_limited role
→ Contractor flag is RESPECTED ✓
```

### Recommended Actions

#### Option A: Update Documentation (RECOMMENDED)

**Pros:**
- No code changes
- Clarifies existing behavior
- Quick to implement

**Cons:**
- Doesn't prevent admins from making mistakes in the UI

**Steps:**
1. Update Confluence documentation to explicitly state:
   - "Limited-Use Contractor roles can ONLY be assigned with NQMS-Only access level (3)"
   - "The contractor flag is ignored if the user has Full Access or MC-Only access"
2. Rename columns for clarity:
   - "Affiliate User (Limited-Use Contractor)" → "Affiliate Limited Contractor (NQMS-Only)"
   - "Program User (Limited-Use Contractor)" → "Program Limited Contractor (NQMS-Only)"
3. Add warning note in documentation about this restriction
4. Update training materials

**Estimated Effort:** 1-2 hours

---

#### Option B: Add UI Validation

**Pros:**
- Prevents incorrect assignments at the source
- Better user experience for administrators
- Catches mistakes before they happen

**Cons:**
- Requires code changes to user management forms
- Needs testing

**Steps:**
1. Update user edit form to disable/hide contractor checkbox when access level is not NQMS-Only:
   ```php
   // In plugins/Users/templates/Admin/Users/edit.php
   // Add JavaScript to disable checkbox
   echo $this->Form->control('affiliates.0.is_limited_contractor', [
       'type' => 'checkbox',
       'label' => 'Limited Use Contractor',
       'disabled' => '{{access_level != 3}}',  // Disable if not NQMS-only
   ]);
   ```

2. Add server-side validation in `AffiliatesUser` and `ProgramUser` entities:
   ```php
   // In entity validation
   public function validationDefault(Validator $validator): Validator
   {
       $validator->add('is_limited_contractor', 'validContractor', [
           'rule' => function ($value, $context) {
               if ($value && $context['data']['access_level'] != 3) {
                   return false;  // Contractor flag only valid with NQMS-only
               }
               return true;
           },
           'message' => 'Limited Contractor flag can only be set for NQMS-Only access level',
       ]);
       return $validator;
   }
   ```

3. Add help text to the form explaining the restriction

4. Test with various combinations

**Estimated Effort:** 4-6 hours (development + testing)

---

#### Option C: Both Documentation + UI Validation (BEST)

Combine both approaches for maximum clarity and error prevention.

**Estimated Effort:** 5-7 hours total

---

### Action Items

- [ ] **DECISION REQUIRED:** Choose option by [DATE]
- [ ] Update Confluence documentation (Option A or C)
- [ ] If Option B or C:
  - [ ] Implement UI validation
  - [ ] Add server-side validation
  - [ ] Add help text to forms
  - [ ] Test thoroughly
  - [ ] Deploy changes
- [ ] Update training materials
- [ ] Notify administrators of the restriction

---

## Discrepancy #3: Permission Matrix Shows Non-Existent Role Differences

### Severity: LOW
### Impact: Minor documentation confusion

### The Issue

**What the Confluence Documentation Shows:**
- Different permissions for "Program User (Full Access)" vs "Program User (MC-only)"
- But upon review, ALL permissions are actually IDENTICAL between these two columns

**What the Code Actually Does:**
- Creates single `program` role with identical permissions regardless of access level (1 or 2)

### Impact Analysis

This is actually NOT a discrepancy - the documentation already shows identical permissions. However, it's confusing to have two columns with the same values.

### Recommended Action

Merge the two columns as described in Discrepancy #1, Option A.

**Estimated Effort:** Included in Discrepancy #1 resolution

---

## Summary of Required Decisions

| Discrepancy | Decision Needed | Options | Recommended | Deadline |
|-------------|-----------------|---------|-------------|----------|
| #1: Program Role Consolidation | How to align docs/code? | A) Update docs<br>B) Update code | Option A | [DATE] |
| #2: Contractor Access Level | How to clarify? | A) Update docs<br>B) Add UI validation<br>C) Both | Option C | [DATE] |
| #3: Identical Permissions | Merge columns? | Yes (via #1) | Yes | [DATE] |

---

## Testing Checklist (If Code Changes Are Made)

### Unit Tests
- [ ] Test role computation for all 8 roles
- [ ] Test contractor flag with different access levels
- [ ] Test cache invalidation
- [ ] Test permission checking methods

### Integration Tests
- [ ] Test user creation with all role combinations
- [ ] Test authorization for all modules
- [ ] Test affiliate user accessing programs via ZIP codes
- [ ] Test contractor accessing only recent assessments

### User Acceptance Testing
- [ ] Create test user as affiliate full access - verify permissions
- [ ] Create test user as affiliate MC-only - verify permissions
- [ ] Create test user as affiliate NQMS-only - verify permissions
- [ ] Create test user as affiliate NQMS contractor - verify limited access
- [ ] Create test user as program full access - verify permissions
- [ ] Create test user as program MC-only - verify permissions (should match full)
- [ ] Create test user as program NQMS-only - verify permissions
- [ ] Create test user as program NQMS contractor - verify limited access
- [ ] Create test user with multiple assignments - verify combined permissions
- [ ] Test global admin - verify full access

### Regression Testing
- [ ] Verify existing users still have correct access
- [ ] Verify no users lost access to modules they should have
- [ ] Verify contractors still limited to recent assessments
- [ ] Verify affiliate users can access programs in their ZIP codes

---

## Communication Plan

### Stakeholders to Notify

1. **Product Owner / Project Manager**
   - Needs to make final decision on options
   - Needs to approve any code changes

2. **Development Team**
   - Needs to implement any code changes
   - Needs to understand the discrepancies

3. **QA Team**
   - Needs to test changes
   - Needs updated test cases

4. **System Administrators**
   - Needs to understand role assignment rules
   - Needs training on any UI changes

5. **End Users (if significant changes)**
   - May need notification of permission changes
   - May need re-training

### Communication Timeline

**Week 1:**
- [ ] Present findings to project team
- [ ] Discuss options and get input
- [ ] Make decisions on each discrepancy

**Week 2 (if code changes):**
- [ ] Implement changes
- [ ] Internal testing
- [ ] Update documentation

**Week 3:**
- [ ] QA testing
- [ ] Prepare communication materials
- [ ] Update training materials

**Week 4:**
- [ ] Deploy changes (if any)
- [ ] Notify stakeholders
- [ ] Monitor for issues

---

## Risk Assessment

### Low Risk Items
- Documentation updates only
- No functional changes

### Medium Risk Items
- UI validation changes
- Form behavior modifications

### High Risk Items
- Role computation logic changes
- Authorization policy changes

**Overall Project Risk:** LOW (if Option A chosen for Discrepancy #1)
**Overall Project Risk:** MEDIUM (if Option B chosen for Discrepancy #1)

---

## Questions for Stakeholders

1. **Discrepancy #1:** Was there ever an intention to have different permissions for Program Full Access vs Program MC-Only users? If so, what should the differences be?

2. **Discrepancy #2:** Are there any scenarios where a contractor should have Full Access or MC-Only access? Or should contractors always be NQMS-only?

3. **General:** Are there any other permission-related issues or concerns that users have reported that we should address while making these changes?

4. **Future:** Are there plans to add more granular permissions in the future? If so, should we design for extensibility now?

---

## Appendix: Quick Fix Code Snippets

### Fix for Discrepancy #2 - Form Validation

```javascript
// Add to plugins/Users/templates/Admin/Users/edit.php

<script>
$(document).ready(function() {
    // Function to toggle contractor checkbox based on access level
    function toggleContractorCheckbox() {
        // For affiliate assignments
        $('[name*="[access_level]"]').each(function() {
            var accessLevel = $(this).val();
            var contractorCheckbox = $(this).closest('.assignment-row')
                .find('[name*="[is_limited_contractor]"]');

            if (accessLevel != 3) {  // Not NQMS-Only
                contractorCheckbox.prop('disabled', true);
                contractorCheckbox.prop('checked', false);
                contractorCheckbox.after('<span class="help-text">Only available for NQMS-Only access</span>');
            } else {
                contractorCheckbox.prop('disabled', false);
                contractorCheckbox.next('.help-text').remove();
            }
        });
    }

    // Run on page load
    toggleContractorCheckbox();

    // Run when access level changes
    $('[name*="[access_level]"]').change(function() {
        toggleContractorCheckbox();
    });
});
</script>
```

---

**END OF DOCUMENT**

**Next Steps:**
1. Review this document with the team
2. Make decisions on each discrepancy
3. Implement chosen solutions
4. Update all related documentation
5. Communicate changes to stakeholders
