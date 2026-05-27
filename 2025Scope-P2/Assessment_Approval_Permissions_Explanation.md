# Assessment Review and Approval Permissions in NQMS

## Quick Answer

**NO - "Full Access" to a program does NOT automatically grant assessment review/approval permissions.**

Approval authority requires an **affiliate relationship**, not just program access. This is a critical distinction in the permission model.

---

## The Permission Model Explained

### What "Full Access" Actually Grants

**Full Access (access_level = 1)** to a program allows you to:
- ✅ View and edit program details
- ✅ Access both NQMS and Mentoring Connector features
- ✅ View and edit assessments
- ✅ Manage goals and documents
- ✅ Submit assessments for review

**Full Access does NOT automatically grant approval authority.**

---

## What Determines Approval Authority

### The `canApproveAssessment()` Method

**Location:** `plugins/Users/src/Trait/UserPermissionsTrait.php` (lines 681-707)

```php
protected function canApproveAssessment(int $programId): bool
{
    // Get the current user
    $user = $this->getAuthenticatedUser();

    // return true if user is super admin
    if ($user->is_superuser) {
        return true;
    }

    // Get the enumeration value for access levels (MC-ONLY user)
    $notEqual = UniversalEnumerations::getEnumeration(
        UniversalEnumerations::KEY_ACCESS_LEVELS,
        UniversalEnumerations::MENTOR_CONNECTOR_ONLY,
    );

    // Get program Ids from affiliates zipcodes other than MC-Only user
    $programIds = $this->getProgramIdsFromAffiliatesByAccessLevel($user, $notEqual);

    // Check if the specified program ID is in the list of program Ids
    // associated with the user's affiliate Ids
    if (!empty($programIds) && in_array($programId, $programIds)) {
        return true;
    }

    // If we've reached this point, the user does not have access to approve
    // assessments for the specified program
    return false;
}
```

### Approval Requirements

To approve an assessment, you must be:

1. **A superuser (global admin)**, OR
2. **An affiliate user** with:
   - Access to the program via affiliate's service area (ZIP code matching)
   - Access level that is NOT MC-Only (can be Full Access or NQMS-Only)

### Key Logic

```
Approval Authority = Affiliate Relationship + (Full Access OR NQMS-Only)
```

**Critical:** The method ONLY checks `affiliates_users` → service areas → ZIP codes → programs. It does NOT check the `programs_users` table for direct program assignments.

---

## The Critical Distinction

### ❌ Direct Program Access Does NOT Grant Approval

**Scenario:**
- User assigned to "Big Brothers Denver" via `programs_users` table
- Access level = 1 (Full Access)
- User tries to approve assessment

**Result:** ❌ **DENIED**

**Why?** `canApproveAssessment()` only checks affiliate relationships via ZIP codes, not direct program assignments.

### ✅ Affiliate Access DOES Grant Approval

**Scenario:**
- User assigned to "MENTOR Colorado" via `affiliates_users` table
- Access level = 1 (Full Access) or 3 (NQMS-Only)
- MENTOR Colorado's service area includes Denver ZIP codes
- "Big Brothers Denver" is located in Denver
- User tries to approve assessment

**Result:** ✅ **APPROVED**

**Why?** `canApproveAssessment()` finds program through affiliate → service area → ZIP code chain.

---

## Real-World Examples

### Example 1: Direct Program Access with Full Access ❌

```
User: Mike Johnson
Assignment: programs_users table
- program_id: 12345 (Big Brothers Denver)
- user_id: Mike's ID
- access_level: 1 (Full Access)
- is_limited_contractor: 0

Mike can:
✅ View program details
✅ Edit program information
✅ View assessments
✅ Edit assessments
✅ Manage goals and documents
❌ CANNOT approve assessments

Reason: canApproveAssessment() returns FALSE
- Mike has no affiliate assignment
- programs_users is not checked by approval logic
```

### Example 2: Affiliate Access with Full Access ✅

```
User: Sarah Martinez
Assignment: affiliates_users table
- affiliate_id: 456 (MENTOR Colorado)
- user_id: Sarah's ID
- access_level: 1 (Full Access)
- is_limited_contractor: 0

MENTOR Colorado service area: 80201, 80202, 80203, 80204 (Denver ZIP codes)
Big Brothers Denver location: 80203

Sarah can:
✅ View all Colorado programs
✅ Edit program information
✅ View assessments
✅ Edit assessments
✅ Manage goals and documents
✅ APPROVE assessments for Colorado programs

Reason: canApproveAssessment() returns TRUE
- Sarah is assigned to MENTOR Colorado affiliate
- Big Brothers Denver is in Colorado's service area
- access_level = 1 (not MC-Only)
```

### Example 3: Affiliate Access with NQMS-Only ✅

```
User: Emily Chen
Assignment: affiliates_users table
- affiliate_id: 789 (MENTOR Minnesota)
- user_id: Emily's ID
- access_level: 3 (NQMS-Only)
- is_limited_contractor: 0

MENTOR Minnesota service area: Minnesota ZIP codes
Youth Mentoring Minneapolis location: Minnesota ZIP code

Emily can:
✅ View Minnesota programs (limited to NQMS features)
❌ Edit program information (NQMS-Only restriction)
✅ View assessments
✅ Edit assessments
✅ Manage goals and documents
✅ APPROVE assessments for Minnesota programs

Reason: canApproveAssessment() returns TRUE
- Emily is assigned to MENTOR Minnesota affiliate
- Youth Mentoring Minneapolis is in Minnesota's service area
- access_level = 3 (NQMS-Only is allowed for approval)
```

### Example 4: Affiliate Access with MC-Only ❌

```
User: Tom Wilson
Assignment: affiliates_users table
- affiliate_id: 321 (MENTOR Texas)
- user_id: Tom's ID
- access_level: 2 (MC-Only)
- is_limited_contractor: 0

MENTOR Texas service area: Texas ZIP codes
Austin Youth Mentoring location: Texas ZIP code

Tom can:
✅ View Texas programs
✅ Edit program information
✅ Access Mentoring Connector features
❌ View NQMS assessments
❌ Edit assessments
❌ APPROVE assessments

Reason: canApproveAssessment() returns FALSE
- Tom's access_level = 2 (MC-Only)
- MC-Only users are explicitly excluded from approval
```

### Example 5: Superuser ✅

```
User: Nicki (System Administrator)
Assignment: users table
- is_superuser: 1

Nicki can:
✅ Approve ANY assessment for ANY program
✅ All other permissions (unrestricted)

Reason: canApproveAssessment() returns TRUE
- Superuser check bypasses all other logic
```

---

## Permission Matrix

| Access Type | Access Level | Can View Assessment? | Can Edit Assessment? | Can Approve Assessment? |
|-------------|--------------|---------------------|---------------------|------------------------|
| **Direct Program Access** | Full Access (1) | ✅ | ✅ | ❌ |
| **Direct Program Access** | NQMS-Only (3) | ✅ | ✅ | ❌ |
| **Direct Program Access** | MC-Only (2) | ❌ | ❌ | ❌ |
| **Affiliate Access (ZIP match)** | Full Access (1) | ✅ | ✅ | ✅ |
| **Affiliate Access (ZIP match)** | NQMS-Only (3) | ✅ | ✅ | ✅ |
| **Affiliate Access (ZIP match)** | MC-Only (2) | ❌ | ❌ | ❌ |
| **Superuser** | N/A | ✅ | ✅ | ✅ |

---

## Assessment Approval Workflow

### Assessment Lifecycle

1. **In Progress** - Program fills out self-assessment
2. **Pending Review** - Program submits for reviewer approval
3. **Approved/Completed** - Affiliate reviewer approves the assessment

### Code Implementation

**Location:** `plugins/Programs/src/Controller/Admin/AssessmentsController.php` (lines 144-162)

```php
elseif ($formAssessmentResponseData['approveAssessment'] ?? null) {
    // Check if the authenticated user has permission to approve the assessment
    if (!$this->canApproveAssessment($programAssessment->program_id)) {
        throw new ForbiddenException();
    }

    // overwrite validation to approve form
    $saveAssessmentAssociation['ProgramAssessmentResponses']['validate'] = 'Approve';

    // set status to complete
    $programAssessment->status = $this->programAssessments->getApproveStatus();

    // set success message
    $successMessage = 'The assessment has been approved.';
    // ...
}
```

**Key Point:** Even if a user has Full Access to the program, the system explicitly checks `canApproveAssessment()` before allowing approval. This check REQUIRES an affiliate relationship.

---

## Other Actions Requiring Approval Permission

### "Ready for NQMS" Action

**Location:** `plugins/Programs/src/Controller/Admin/ProgramsController.php` (lines 760-810)

```php
public function readyForNqms(int $id): Response
{
    // Allow only POST method for this action
    $this->getRequest()->allowMethod(['post']);

    // Check if the user have affiliate role for this program
    if (!$this->canApproveAssessment($id)) {
        // Redirect to the view if the user do not have permission
        $this->Flash->error(__('You don\'t have permission to perform this action.'));
        return $this->redirect([...]);
    }

    // Get the program
    $program = $this->Programs->get($id);

    // Update the 'is_nqms_ready' field
    $this->Programs->query()
        ->update()
        ->set(['is_nqms_ready' => true])
        ->where(['id' => $program->id])
        ->execute();

    // ...
}
```

**This shows:** Even marking a program as "ready for NQMS" requires passing the `canApproveAssessment()` check, NOT just having "Full Access"!

---

## Role-Based Access Control

### Request Policy Configuration

**Location:** `config/request_policy_configs.php` (lines 177-200)

```php
[
    'mustBeLoggedIn' => true,
    'roles' => [
        'nqms_program',           // NQMS program-level user
        'nqms_affiliate',         // NQMS affiliate user
        'nqms_affiliate_limited', // Limited NQMS affiliate
        'nqms_program_limited',   // Limited NQMS program user
    ],
    'routes' => [
        [
            'prefix' => 'Admin',
            'plugin' => 'Programs',
            'controller' => 'Programs',
            'action' => 'index|view|readyForNqms',
        ],
        [
            'prefix' => 'Admin',
            'plugin' => 'Programs',
            'controller' => 'Assessments|Documents|Goals|NQMS',
            'action' => '*',
        ],
    ],
]
```

### Roles That Can Access Assessment Features

**Can approve assessments:**
- `global` - System administrators (superusers)
- `nqms_affiliate` - Affiliate users with NQMS access
- `nqms_affiliate_limited` - Limited affiliate contractors
- `nqms_program` - Program users with NQMS access (view/edit only, NOT approve)
- `nqms_program_limited` - Limited program contractors (view/edit only, NOT approve)

**Cannot approve assessments:**
- `program` - Regular program users (Connector-only)
- `affiliate` - Regular affiliate users (Connector-only)
- `mc_affiliate` - MC-Only affiliate users

**Note:** While `nqms_program` roles can access the routes, they will fail the `canApproveAssessment()` check because they lack affiliate relationships.

---

## Critical Implication for Request 1

### The Problem with Cross-Affiliate NQMS Permissions

**Current State:**
```
MENTOR Washington staff wants to approve California program assessments

Current Permission Check:
1. Is user a superuser? NO
2. Is user assigned to affiliate? YES (MENTOR Washington)
3. Does affiliate's service area include California program ZIP? NO
4. Result: ❌ CANNOT APPROVE
```

**The Gap:**
Even if you grant MENTOR Washington users **direct program access** to California programs via `programs_users` table, they still cannot approve assessments because `canApproveAssessment()` doesn't check that table.

### Solution Requirements

When implementing the `programs_affiliates` junction table for secondary affiliates, you **MUST also update** the approval permission logic:

#### Updated `canApproveAssessment()` Method (Proposed)

```php
protected function canApproveAssessment(int $programId): bool
{
    $user = $this->getAuthenticatedUser();

    // Step 1: Superuser bypass (existing)
    if ($user->is_superuser) {
        return true;
    }

    // Get MC-Only access level to exclude
    $notEqual = UniversalEnumerations::get('MENTOR_CONNECTOR_ONLY');

    // Step 2: Check primary affiliate access via ZIP codes (existing)
    $programIds = $this->getProgramIdsFromAffiliatesByAccessLevel($user, $notEqual);
    if (!empty($programIds) && in_array($programId, $programIds)) {
        return true;
    }

    // Step 3: Check secondary affiliate access (NEW - REQUIRED FOR REQUEST 1)
    if ($this->hasSecondaryAffiliateAccess($programId, $user, $notEqual)) {
        return true;
    }

    return false;
}

/**
 * Check if user has access via secondary affiliate assignment
 *
 * @param int $programId Program ID
 * @param User $user Current user
 * @param int $notEqual Access level to exclude (MC-Only)
 * @return bool
 */
private function hasSecondaryAffiliateAccess(int $programId, $user, int $notEqual): bool
{
    // Get user's affiliate IDs (excluding MC-Only)
    $affiliateIds = TableRegistry::getTableLocator()
        ->get('Affiliates.AffiliatesUsers')
        ->find()
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

    // Check if any of user's affiliates are assigned as secondary to this program
    $assignmentCount = TableRegistry::getTableLocator()
        ->get('Programs.ProgramsAffiliates')
        ->find()
        ->where([
            'program_id' => $programId,
            'affiliate_id IN' => $affiliateIds,
            'is_primary' => 0  // Secondary affiliates only
        ])
        ->count();

    return $assignmentCount > 0;
}
```

**Without this update:**
- Secondary affiliates can view/edit assessments ✅
- Secondary affiliates CANNOT approve assessments ❌
- This defeats the purpose of cross-affiliate NQMS support!

---

## Summary

### Key Takeaways

1. **"Full Access" ≠ Approval Authority**
   - Full Access grants feature access, not approval permission
   - Approval requires a separate permission check

2. **Approval Requires Affiliate Relationship**
   - Direct program access via `programs_users` is NOT sufficient
   - Must have affiliate access via `affiliates_users` + ZIP code match

3. **Access Level Restrictions**
   - MC-Only users CANNOT approve (excluded)
   - NQMS-Only users CAN approve (allowed)
   - Full Access users CAN approve (allowed)

4. **Superusers Bypass Everything**
   - Global admins can approve any assessment
   - No affiliate or program relationship required

5. **Critical for Request 1**
   - Proposed `programs_affiliates` table must be integrated into `canApproveAssessment()`
   - Otherwise secondary affiliates won't have full NQMS capabilities

---

## Files Referenced

| File | Lines | Purpose |
|------|-------|---------|
| `plugins/Users/src/Trait/UserPermissionsTrait.php` | 681-707 | `canApproveAssessment()` method |
| `plugins/Programs/src/Controller/Admin/AssessmentsController.php` | 144-162 | Assessment approval action |
| `plugins/Programs/src/Controller/Admin/ProgramsController.php` | 760-810 | Ready for NQMS action |
| `config/request_policy_configs.php` | 177-200 | NQMS role access policies |
| `src/General/UniversalEnumerations.php` | N/A | Access level definitions |

---

## Recommendation for NQMS_Permissions.md

This information should be added to your permissions document under the "Permissions Matrix" section to clarify that:
- Secondary affiliates must be granted approval authority
- The `canApproveAssessment()` method needs updating
- This is a critical requirement for Request 1 implementation
