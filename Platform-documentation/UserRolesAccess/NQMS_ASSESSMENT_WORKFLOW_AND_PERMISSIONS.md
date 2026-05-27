# NQMS Assessment Module - Complete Workflow & Permissions

**Version:** 1.0
**Last Updated:** December 3, 2025
**Purpose:** Detailed documentation of NQMS Assessment business flow and role-based permissions

---

## Table of Contents

1. [Assessment Business Flow](#assessment-business-flow)
2. [Status Definitions](#status-definitions)
3. [Complete Permission Matrix](#complete-permission-matrix)
4. [Action-by-Action Breakdown](#action-by-action-breakdown)
5. [Goals Management](#goals-management)
6. [Critical Business Rules](#critical-business-rules)
7. [Special Cases & Restrictions](#special-cases--restrictions)
8. [Code References](#code-references)

---

## Assessment Business Flow

### Visual Workflow

```
┌─────────────────────────────────────────────────────────────────────────┐
│                          ASSESSMENT LIFECYCLE                            │
└─────────────────────────────────────────────────────────────────────────┘

  [1] CREATION
      │
      ├─ User clicks "Start Self Assessment" on program page
      ├─ System creates new assessment with title: "{Year} Self-Assessment"
      ├─ All active NQMS questions copied to assessment
      └─ No status set (implicitly "in-progress")
      │
      ↓
  [2] IN-PROGRESS
      │
      ├─ Program staff fill out assessment questions
      ├─ Ratings, comments, evidence uploaded
      ├─ Can save and return multiple times
      └─ Can edit freely
      │
      ├───→ [ACTION: Submit for Review] ────┐
      │                                      │
      ↓                                      ↓
  [3] PENDING REVIEW                    (Email notification sent)
      │
      ├─ Assessment locked for program edits
      ├─ Affiliate staff review responses
      ├─ May request changes (requires going back to in-progress)
      └─ Affiliate staff can still edit
      │
      ├───→ [ACTION: Approve Assessment] ────┐ (Affiliate ONLY)
      │                                       │
      ↓                                       ↓
  [4] COMPLETED (APPROVED)             (Email notification sent)
      │                                (3-year reminder created)
      ├─ Assessment is READ-ONLY
      ├─ No more edits allowed
      ├─ Can now set improvement goals
      └─ Can archive assessment
      │
      ↓
  [5] GOALS SETTING
      │
      ├─ Create goals for areas needing improvement
      ├─ Set baseline score, target score, timeline
      ├─ Track progress with achieved_score
      └─ Upload supporting documents
      │
      ├───→ [AUTOMATIC TRIGGER] ────────────┐
      │     When ALL goals completed        │
      ↓                                      ↓
  [6] GOAL COMPLETED                  (Assessment status auto-updated)
      │
      ├─ All goals met or exceeded targets
      ├─ Assessment fully satisfied
      └─ Cycle complete, awaits next 3-year assessment

```

---

## Status Definitions

**Source:** `ProgramAssessmentsTable.php:42-47`

| Status Code | Display Name | Description | Who Can Set |
|-------------|--------------|-------------|-------------|
| **(none)** | In-Progress | Assessment actively being filled out | System on creation |
| `in-progress` | Baseline Started | Explicitly set (same as default) | System |
| `pending-review` | Submitted for Review | Assessment submitted by program for affiliate review | Program/NQMS users |
| `completed` | Approved | Assessment approved by affiliate staff | **Affiliate users ONLY** |
| `goal_completed` | Goals Completed | All improvement goals have been achieved | **System automatic** |

### Status Transition Rules

| From Status | To Status | Trigger | Who Can Trigger |
|-------------|-----------|---------|-----------------|
| (none) | in-progress | System creates assessment | System |
| in-progress | pending-review | Click "Submit for Review" button | Program users, NQMS users |
| pending-review | completed | Click "Approve Assessment" button | **Affiliate users ONLY** |
| completed | goal_completed | All goals have `achieved_score >= target_score` | **System automatic** |

**Important:** Status transitions are ONE-WAY. There is no rollback mechanism to move from "completed" back to "pending-review" or "in-progress".

---

## Complete Permission Matrix

### By Role and Action

| Action | Global Admin | Affiliate Full | Affiliate NQMS | Affiliate MC-Only | Affiliate Limited | Program Full | Program NQMS | Program MC-Only | Program Limited |
|--------|--------------|----------------|----------------|-------------------|-------------------|--------------|--------------|-----------------|-----------------|
| **View Program** | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ❌ | ✅ |
| **Create Assessment** | ✅ | ✅ | ✅ | ❌ | ✅ | ✅ | ✅ | ❌ | ✅ |
| **Edit Assessment (in-progress)** | ✅ | ✅ | ✅ | ❌ | ✅¹ | ✅ | ✅ | ❌ | ✅¹ |
| **Edit Assessment (pending-review)** | ✅ | ✅ | ✅ | ❌ | ✅¹ | ✅ | ✅ | ❌ | ✅¹ |
| **Submit for Review** | ✅ | ✅ | ✅ | ❌ | ✅¹ | ✅ | ✅ | ❌ | ✅¹ |
| **Approve Assessment** | ✅ | ✅² | ✅² | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| **View Assessment** | ✅ | ✅ | ✅ | ❌ | ✅¹ | ✅ | ✅ | ❌ | ✅¹ |
| **View Completed Assessment** | ✅ | ✅ | ✅ | ❌ | ✅¹ | ✅ | ✅ | ❌ | ✅¹ |
| **Edit Completed Assessment** | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| **Archive Assessment** | ✅ | ✅² | ✅² | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| **Preview Assessment** | ✅ | ✅ | ✅ | ❌ | ✅ | ✅ | ✅ | ❌ | ✅ |
| **Export Assessment (CSV)** | ✅ | ✅ | ✅ | ❌ | ✅ | ✅ | ✅ | ❌ | ✅ |
| **Print Assessment** | ✅ | ✅ | ✅ | ❌ | ✅ | ✅ | ✅ | ❌ | ✅ |
| **Create Goal** | ✅ | ✅ | ✅ | ❌ | ✅ | ✅ | ✅ | ❌ | ✅ |
| **Edit Goal** | ✅ | ✅ | ✅ | ❌ | ✅ | ✅ | ✅ | ❌ | ✅ |
| **Delete Goal** | ✅ | ✅ | ✅ | ❌ | ✅ | ✅ | ✅ | ❌ | ✅ |
| **View Goals** | ✅ | ✅ | ✅ | ❌ | ✅ | ✅ | ✅ | ❌ | ✅ |
| **Preview Goals** | ✅ | ✅ | ✅ | ❌ | ✅ | ✅ | ✅ | ❌ | ✅ |
| **Export Goals (CSV)** | ✅ | ✅ | ✅ | ❌ | ✅ | ✅ | ✅ | ❌ | ✅ |
| **Access Old Assessments** | ✅ | ✅ | ✅ | ❌ | ❌ | ✅ | ✅ | ❌ | ❌ |

**Legend:**
- ✅ = Allowed
- ❌ = Denied
- ¹ = Limited contractors can only access the LATEST assessment (not historical)
- ² = **CRITICAL:** Requires affiliate assignment via ZIP codes (program assignment alone is NOT sufficient)

### Key Findings

1. **MC-Only Users Have NO Access:** Users with `access_level = 2` (MC-Access Only) cannot access any NQMS features.

2. **Approval is Affiliate-Only:** Only affiliate staff can approve assessments. Direct program assignments do NOT grant approval authority.

3. **Limited Contractors are Restricted:** Contractors can only access the most recent assessment per program.

4. **Completed Assessments are Read-Only:** Once approved, NO ONE can edit the assessment (not even superusers in the UI).

---

## Action-by-Action Breakdown

### 1. Creating an Assessment

**Action:** `AssessmentsController::add()`
**File:** `plugins/Programs/src/Controller/Admin/AssessmentsController.php:265-312`
**Route:** `/admin/programs/assessments/add/{programId}`

#### Permission Requirements
- User must be authenticated
- `canAccessProgram(programId)` must return TRUE

#### Who Can Create
✅ **Allowed:**
- Global Admin
- Affiliate users with Full Access or NQMS-Only access
- Program users with Full Access or NQMS-Only access
- Limited contractors (for their assigned programs)

❌ **Denied:**
- MC-Only users (affiliate or program level)
- Unauthenticated users

#### What Happens
1. System validates user has program access
2. Event `Assessments.addProgramAssessmentQuestions` is dispatched
3. `AssessmentListener::addProgramAssessment()` creates assessment:
   - Title: `{Current Year} Self-Assessment`
   - Copies all active NQMS questions and checkboxes
   - Creates empty response records for each question
   - No status is set (implicitly "in-progress")
4. User redirected to edit page

#### Code Reference
```php
// AssessmentsController.php lines 265-312
public function add(int $programId)
{
    $this->canAccessProgram((int)$programId);

    $event = new Event('Assessments.addProgramAssessmentQuestions',
        $this, ['programId' => $programId]);
    $this->getEventManager()->dispatch($event);

    $this->redirect(['action' => 'edit', $newAssessmentId, $programId]);
}
```

---

### 2. Editing an Assessment (In-Progress or Pending Review)

**Action:** `AssessmentsController::edit()`
**File:** `plugins/Programs/src/Controller/Admin/AssessmentsController.php:82-257`
**Route:** `/admin/programs/assessments/edit/{assessmentId}/{programId}`

#### Permission Requirements
- User must be authenticated
- `canAccessProgram(programId)` must return TRUE
- `canAccessOldAssessment(assessment)` must pass (blocks limited contractors from old assessments)
- Assessment status must NOT be "completed" or "goal_completed"

#### Who Can Edit
✅ **Allowed:**
- Global Admin (all assessments)
- Affiliate users with Full/NQMS access
- Program users with Full/NQMS access
- Limited contractors (ONLY latest assessment per program)

❌ **Denied:**
- MC-Only users
- Limited contractors accessing old assessments
- Anyone trying to edit completed assessments

#### Status-Based Behavior

**If Status = "in-progress" or "pending-review":**
- User can edit all question responses
- Can upload evidence documents
- Can add comments and notes
- Can save draft
- Can submit for review (sets status to "pending-review")

**If Status = "completed":**
- Edit page is not accessible
- System returns error or redirects to view page

#### Code Reference
```php
// Line 677-680: Query excludes completed assessments
$assessmentQuery = $programAssessmentsTable
    ->find()
    ->where([
        'ProgramAssessments.id' => $assessmentId,
        'ProgramAssessments.status NOT IN' => ['completed'],  // KEY RESTRICTION
    ]);

// Lines 747-766: Limited contractor check
private function canAccessOldAssessment(ProgramAssessment $programAssessment): void
{
    if ($this->getCurrentlyAuthenticatedUser()->is_superuser) return;

    if ($programAssessment->id != $programAssessment->program->latest_assessment_id &&
        $this->userIsLimitedContractorOnly()) {
        throw new ForbiddenException(__('Not Authorized'));
    }
}
```

---

### 3. Submitting Assessment for Review

**Action:** Form submission in `AssessmentsController::edit()` with `reviewButton` flag
**File:** `plugins/Programs/src/Controller/Admin/AssessmentsController.php:133-143`

#### Permission Requirements
- Same as "Edit Assessment"
- Assessment status must be "in-progress"

#### Who Can Submit
✅ **Allowed:**
- Any user with edit access (see Edit section above)
- Typically program users submit their own assessments

❌ **Denied:**
- MC-Only users
- Users without program access
- Limited contractors accessing old assessments

#### What Happens
1. User clicks "Submit for Review" button in edit form
2. Assessment status changed to "pending-review"
3. `submitted_for_review_date` timestamp set
4. Email notification sent to affiliate staff (via `afterSave()` event)
5. User redirected to view page

#### Code Reference
```php
// Lines 133-143
if ($formAssessmentResponseData['reviewButton'] ?? null) {
    $programAssessment->status = 'pending-review';
    $programAssessment->submitted_for_review_date = new FrozenTime();
    // Redirects to view action
}
```

#### After-Save Actions
**File:** `ProgramAssessmentsTable.php:163-253`
- Email sent to affiliate staff with NQMS access
- Email subject: "Assessment Submitted for Review: {Program Name}"
- Email contains link to assessment view page

---

### 4. Approving an Assessment

**Action:** Form submission in `AssessmentsController::edit()` with `approveAssessment` flag
**File:** `plugins/Programs/src/Controller/Admin/AssessmentsController.php:144-162`

#### Permission Requirements (CRITICAL)
- User must be authenticated
- `canApproveAssessment(programId)` must return TRUE
  - **Requires affiliate assignment via ZIP codes**
  - **Program assignment alone is NOT sufficient**
  - Superusers always pass this check

#### Permission Check Code
```php
// UserPermissionsTrait.php lines 681-707
protected function canApproveAssessment(int $programId): bool
{
    $user = $this->getCurrentlyAuthenticatedUser();

    if ($user->is_superuser) {
        return true;
    }

    $notEqual = UniversalEnumerations::getValue(
        UniversalEnumerations::KEY_ACCESS_LEVELS,
        UniversalEnumerations::MENTOR_CONNECTOR_ONLY
    );

    // ONLY checks affiliate relationship via ZIP codes
    $programIds = $this->getProgramIdsFromAffiliatesByAccessLevel($user, $notEqual);

    return !empty($programIds) && in_array($programId, $programIds);
}
```

#### Who Can Approve
✅ **Allowed:**
- Global Admin (superuser)
- Affiliate users with Full Access (assigned to affiliate whose ZIP codes include the program)
- Affiliate users with NQMS-Only access (assigned to affiliate whose ZIP codes include the program)

❌ **Denied:**
- Affiliate users with MC-Only access
- Program users (even with Full Access or NQMS access)
- Limited contractors
- Any user without affiliate assignment in the program's service area

#### What Happens
1. User (affiliate staff) clicks "Approve Assessment" button
2. System checks `canApproveAssessment()` - throws `ForbiddenException` if denied
3. Assessment status changed to "completed"
4. `approved_on` timestamp set to current date/time
5. Assessment saved
6. After-save triggers:
   - Email notification sent to program staff
   - 3-year renewal reminder created (due date = approved_on + 3 years)
7. User redirected to view page

#### Code Reference
```php
// Lines 144-162
elseif ($formAssessmentResponseData['approveAssessment'] ?? null) {
    // PERMISSION CHECK
    if (!$this->canApproveAssessment($programAssessment->program_id)) {
        throw new ForbiddenException();
    }

    $programAssessment->status = $this->programAssessments->getApproveStatus(); // 'completed'
    $programAssessment->approved_on = new FrozenTime();
}
```

#### After-Save Actions
**File:** `ProgramAssessmentsTable.php:163-253`

**Email Notification:**
- Sent to: All program users with NQMS access
- Subject: "Assessment Approved: {Program Name}"
- Body: Contains link to view assessment and next steps

**Renewal Reminder:**
- Title: "{Program Name} - Self-Assessment Expires"
- Due Date: `approved_on + 3 years`
- Assigned to: Affiliate NQMS users
- Description: "3-year assessment cycle complete, time for renewal"

---

### 5. Viewing an Assessment

**Action:** `AssessmentsController::view()`
**File:** `plugins/Programs/src/Controller/Admin/AssessmentsController.php:320-372`
**Route:** `/admin/programs/assessments/view/{assessmentId}/{programId}`

#### Permission Requirements
- User must be authenticated
- `canAccessProgram(programId)` must return TRUE
- `canAccessOldAssessment(assessment)` must pass (blocks limited contractors from old assessments)

#### Who Can View
✅ **Allowed:**
- Global Admin (all assessments)
- Affiliate users with Full/NQMS access
- Program users with Full/NQMS access
- Limited contractors (ONLY latest assessment per program)

❌ **Denied:**
- MC-Only users
- Limited contractors viewing old assessments
- Unauthenticated users

#### What's Displayed
- Assessment metadata (title, created date, status)
- All questions and responses grouped by section
- Ratings with color coding
- Comments and evidence links
- Goals (if any)
- Action buttons based on permissions:
  - **Edit** (if status != completed and user has edit access)
  - **Submit for Review** (if status = in-progress)
  - **Approve** (if status = pending-review AND user has `canApproveAssessment()`)
  - **Archive** (if status = completed AND user has `canApproveAssessment()`)
  - **Preview** (all NQMS users)
  - **Export** (all NQMS users)
  - **Print** (all NQMS users)

#### Code Reference
```php
// Lines 320-372
public function view(string $id, int $programId)
{
    $this->canAccessProgram($programId);

    $programAssessment = $this->programAssessments
        ->get($id, ['contain' => ['ProgramAssessmentResponses', 'Goals']]);

    $this->canAccessOldAssessment($programAssessment);

    $this->set(compact('programAssessment'));
}
```

---

### 6. Archiving an Assessment

**Action:** `AssessmentsController::archive()`
**File:** `plugins/Programs/src/Controller/Admin/AssessmentsController.php:383-434`
**Route:** `/admin/programs/assessments/archive/{assessmentId}/{programId}`

#### Permission Requirements (CRITICAL)
- User must be authenticated
- `canApproveAssessment(programId)` must return TRUE
  - **Same strict requirement as approval**
  - **Only affiliate staff and superusers**

#### Who Can Archive
✅ **Allowed:**
- Global Admin (superuser)
- Affiliate users with Full Access or NQMS-Only access (via ZIP code relationship)

❌ **Denied:**
- Affiliate users with MC-Only access
- **Program users (cannot archive even if they created the assessment)**
- Limited contractors
- Any user without affiliate assignment

#### What Happens
1. User clicks "Archive" button on assessment view page
2. System checks `canApproveAssessment()` - throws `ForbiddenException` if denied
3. Assessment is soft-deleted:
   - `deleted` timestamp set to current date/time
   - Record remains in database
4. Assessment excluded from default queries (via `beforeFind()` filter)
5. User redirected to program view page
6. Success message displayed

#### Code Reference
```php
// Lines 383-434
public function archive(string $id)
{
    $this->canAccessProgram($programAssessment->program_id);

    // CRITICAL PERMISSION CHECK
    if (!$this->canApproveAssessment($programAssessment->program_id)) {
        throw new ForbiddenException(__('Not Authorized'));
    }

    // Soft delete
    $programAssessment->deleted = new FrozenTime();
    $this->programAssessments->save($programAssessment);
}
```

#### Recovery
- No UI for unarchiving
- Requires database manual update or support ticket
- Update query: `UPDATE program_assessments SET deleted = NULL WHERE id = '{id}';`

---

### 7. Preview Assessment (Before Export)

**Action:** `AssessmentsController::preview()`
**File:** `plugins/Programs/src/Controller/Admin/AssessmentsController.php:442-471`
**Route:** `/admin/programs/assessments/preview/{assessmentId}/{programId}`

#### Permission Requirements
- User must be authenticated
- `canAccessProgram(programId)` must return TRUE
- `canAccessNQMS(programId)` must return TRUE

#### Who Can Preview
✅ **Allowed:**
- Global Admin
- Affiliate users with Full/NQMS access
- Program users with Full/NQMS access
- Limited contractors (for latest assessment)

❌ **Denied:**
- MC-Only users

#### What Happens
1. User clicks "Preview" button
2. System displays assessment in table format (simulates CSV export view)
3. Shows all sections, questions, ratings, and comments
4. User can review before exporting
5. Export button on preview page links to export action

---

### 8. Export Assessment (CSV)

**Action:** `AssessmentsController::export()`
**File:** `plugins/Programs/src/Controller/Admin/AssessmentsController.php:479-511`
**Route:** `/admin/programs/assessments/export/{assessmentId}/{programId}`

#### Permission Requirements
- Same as Preview

#### Who Can Export
- Same as Preview

#### What Happens
1. User clicks "Export" button
2. System generates CSV file with:
   - Section names
   - Question text
   - Response ratings
   - Response comments
   - Evidence file links
3. File downloaded: `{Program Name}-Self-Assessment-{Timestamp}.csv`

---

### 9. Print Assessment

**Action:** Client-side JavaScript `window.print()`
**File:** `plugins/Programs/templates/Admin/Assessments/view.php:117-119`

#### Permission Requirements
- Must be able to view the assessment (no separate server-side check)

#### Who Can Print
- Anyone who can view the assessment
- Uses browser's native print functionality

#### What Happens
1. User clicks "Print" button
2. JavaScript triggers browser print dialog
3. Page styled for print (via CSS @media print rules)
4. No server-side action or permission check

---

## Goals Management

### Goals Overview

Goals are improvement objectives set for areas where a program scored below their target in an assessment. Goals can only be created AFTER an assessment is approved (status = "completed").

### Goal Statuses

Goals have a computed status based on scores:

| Status | Condition | Description |
|--------|-----------|-------------|
| **Incomplete** | `achieved_score IS NULL` OR `achieved_score <= score` | No progress made yet |
| **Partially Complete** | `score < achieved_score < target_score` | Progress made but target not reached |
| **Completed** | `achieved_score >= target_score` | Target met or exceeded |

**File:** `plugins/Programs/src/Model/Entity/ProgramAssessmentGoal.php:51-69`

```php
protected function _getStatus(): string
{
    if ($this->achieved_score) {
        if ($this->target_score <= $this->achieved_score) {
            return 'Completed';
        } elseif ($this->achieved_score <= $this->score) {
            return 'Incomplete';
        } elseif ($this->achieved_score > $this->score &&
                  $this->achieved_score < $this->target_score) {
            return 'Partially Complete';
        }
    }
    return 'Incomplete';
}
```

---

### 10. Creating a Goal

**Action:** `GoalsController::add()`
**File:** `plugins/Programs/src/Controller/Admin/GoalsController.php:94-205`
**Route:** `/admin/programs/goals/add/{programId}/{assessmentId}/{questionResponseId}`

#### Permission Requirements
- User must be authenticated
- `canAccessProgram(programId)` must return TRUE
- `canAccessNQMS(programId)` must return TRUE

#### Who Can Create Goals
✅ **Allowed:**
- Global Admin
- Affiliate users with Full/NQMS access
- Program users with Full/NQMS access
- Limited contractors

❌ **Denied:**
- MC-Only users

#### Required Fields
- `name` - Goal title (max 100 characters)
- `score` - Baseline rating from assessment (0-5 or N/A)
- `target_score` - Target rating to achieve (must be valid rating)
- `notes` - Goal description/action plan (max 3000 characters)
- `start_date` - When work begins
- `target_completion_date` - Target completion (must be after start_date)
- `program_assessment_response_id` - Link to specific question (required)

#### Optional Fields
- `achieved_score` - Current progress rating
- `achieved_notes` - Notes about progress
- Files/documents can be attached

#### Validation Rules
**File:** `plugins/Programs/src/Model/Table/ProgramAssessmentGoalsTable.php:103-168`

```php
$validator
    ->requirePresence('name', 'create')
    ->maxLength('name', 100)
    ->requirePresence('target_score', 'create')
    ->requirePresence('notes', 'create')
    ->maxLength('notes', 3000)
    ->requirePresence('program_assessment_response_id', 'create')
    ->add('target_completion_date', 'dateComparison', [
        'rule' => function ($value, $context) {
            return $value > $context['data']['start_date'];
        },
        'message' => 'Target completion date must be after start date',
    ]);
```

#### What Happens
1. User fills out goal creation form
2. System validates all fields
3. Goal saved to database
4. File attachments processed (if any)
5. `afterSave()` event triggers assessment status check
6. User redirected to assessment view page
7. Success message displayed

---

### 11. Editing a Goal

**Action:** `GoalsController::edit()`
**File:** `plugins/Programs/src/Controller/Admin/GoalsController.php:215-314`
**Route:** `/admin/programs/goals/edit/{goalId}/{programId}/{assessmentId}`

#### Permission Requirements
- Same as Create Goal

#### Who Can Edit Goals
- Same as Create Goal

#### Additional Editable Fields
- `achieved_score` - Update progress rating
- `achieved_notes` - Add notes about achievement

#### Security Checks
```php
// Lines 238-241: Reject section goals (legacy data)
if (empty($programAssessmentGoalEntity->program_assessment_response_id)) {
    throw new NotFoundException(__('Section goals are no longer supported.'));
}

// Line 251: Ensure goal belongs to this assessment
->where([
    'id' => $goalId,
    'program_assessment_id' => $assessmentId,
])
```

#### What Happens
1. User updates goal fields
2. System validates changes
3. Goal saved
4. `afterSave()` event triggers assessment status check:
   - If ALL goals completed → Assessment status = "goal_completed"
   - If ANY goal incomplete → Assessment status = "completed"
5. User redirected to assessment view page

---

### 12. Deleting a Goal

**Action:** `GoalsController::delete()`
**File:** `plugins/Programs/src/Controller/Admin/GoalsController.php:654-714`
**Route:** `/admin/programs/goals/delete/{goalId}/{programId}/{assessmentId}`

#### Permission Requirements
- Same as Create Goal

#### Who Can Delete Goals
- Same as Create Goal

#### Security Checks
```php
// Lines 673-676: Ensure goal belongs to this assessment
->where([
    'id' => $goalId,
    'program_assessment_id' => $assessmentId,
])
```

#### What Happens
1. User clicks "Delete" button (with confirmation)
2. System validates goal ownership
3. Clean up associated records:
   - Delete entries in `program_documents` join table
   - Files remain in storage (orphaned but safe)
4. Goal deleted from database
5. `afterDelete()` event triggers assessment status check
6. User redirected to assessment view page

---

### 13. Viewing Goals

**Action:** Goals displayed within `AssessmentsController::view()`
**File:** `plugins/Programs/src/Controller/Admin/AssessmentsController.php:320-372`

#### Permission Requirements
- Same as View Assessment

#### Who Can View Goals
- Same as View Assessment

#### What's Displayed
- Goal name and description
- Baseline score vs target score
- Current achieved score (if any)
- Status (Incomplete / Partially Complete / Completed)
- Start date and target completion date
- Notes and achieved notes
- Attached documents
- Action buttons (edit, delete) if user has permissions

---

### 14. Preview Goals (Before Export)

**Action:** `GoalsController::preview()`
**File:** `plugins/Programs/src/Controller/Admin/GoalsController.php:372-432`
**Route:** `/admin/programs/goals/preview/{programId}/{assessmentId}`

#### Permission Requirements
- Same as Create Goal

#### Who Can Preview
- Same as Create Goal

#### What Happens
- Shows goals in table format (simulates CSV export)
- Displays all goal fields
- User can review before exporting

---

### 15. Export Goals (CSV)

**Action:** `GoalsController::export()`
**File:** `plugins/Programs/src/Controller/Admin/GoalsController.php:440-484`
**Route:** `/admin/programs/goals/export/{programId}/{assessmentId}`

#### Permission Requirements
- Same as Create Goal

#### Who Can Export
- Same as Create Goal

#### What Happens
- Generates CSV file with all goals
- Includes: name, scores, dates, status, notes
- File downloaded: `{Program Name}-Goals-{Timestamp}.csv`

---

## Critical Business Rules

### Rule 1: Approval Requires Affiliate Assignment

**The Most Important Permission Rule**

Assessment approval is NOT granted by direct program assignment. It requires:
1. User must be assigned to an affiliate
2. Affiliate must have ZIP codes defined in `affiliates_zip_codes` table
3. Program must have a matching ZIP code in `programs.zip_code` OR `program_locations.location_zip`
4. User's access level must be Full Access (1) or NQMS-Only (3), NOT MC-Only (2)

**Why this matters:**
- A program user with Full Access assigned directly to a program **CANNOT** approve their own assessments
- Only affiliate staff overseeing that program's service area can approve
- This enforces oversight and quality control

**Code Implementation:**
```php
// UserPermissionsTrait.php lines 681-707
protected function canApproveAssessment(int $programId): bool
{
    if ($user->is_superuser) return true;

    // ONLY checks affiliate relationship - NOT programs_users table
    $programIds = $this->getProgramIdsFromAffiliatesByAccessLevel($user, $notEqual);

    return in_array($programId, $programIds);
}
```

**Real-World Example:**

| User | Assignment | Can Approve? | Why |
|------|-----------|--------------|-----|
| Jane | Affiliate A (Full Access)<br>Service Area: ZIP 20001-20010 | ✅ YES | Has affiliate assignment via ZIP codes |
| Thor | Program B (Full Access)<br>Program ZIP: 20005 | ❌ NO | Only has direct program assignment |
| Steve | Affiliate A (NQMS-Only)<br>Service Area: ZIP 20001-20010 | ✅ YES | Has affiliate assignment with NQMS access |
| Admin | Superuser flag = 1 | ✅ YES | Superusers bypass all checks |

---

### Rule 2: Limited Contractors Can Only Access Latest Assessment

**Purpose:** Restrict contractors from viewing historical assessment data

**Implementation:**
```php
// AssessmentsController.php lines 747-766
private function canAccessOldAssessment(ProgramAssessment $programAssessment): void
{
    if ($programAssessment->id != $programAssessment->program->latest_assessment_id &&
        $this->userIsLimitedContractorOnly()) {
        throw new ForbiddenException(__('Not Authorized'));
    }
}
```

**What qualifies as "contractor only":**
- User has `nqms_affiliate_limited` OR `nqms_program_limited` role
- User does NOT have any other roles (no affiliate, program, mc_affiliate, nqms_affiliate, or nqms_program roles)

**Example:**
- Assessment A (ID: 123, created 2022) - OLD
- Assessment B (ID: 456, created 2025) - LATEST
- Contractor can access Assessment B ✅
- Contractor CANNOT access Assessment A ❌

---

### Rule 3: Completed Assessments Cannot Be Edited

**Once approved, an assessment is permanently read-only**

**Implementation:**
```php
// Line 677-680
->where([
    'ProgramAssessments.status NOT IN' => ['completed', 'goal_completed'],
])
```

**Why:**
- Maintains integrity of approved assessments
- Prevents post-approval tampering
- Historical record preservation

**Workarounds:**
- None in the UI
- Database direct update possible (support only)
- Recommended: Archive old assessment, create new assessment

---

### Rule 4: Goals Automatically Update Assessment Status

**System automatically transitions assessment status based on goal completion**

**Implementation:**
```php
// AssessmentGoalListener.php lines 33-71
public function updateAssessmentStatus(\Cake\Event\Event $event): void
{
    $notCompletedGoalsCount = $assessmentGoalsTable->find()
        ->where(['target_score > achieved_score OR achieved_score IS NULL'])
        ->count();

    $newStatus = $notCompletedGoalsCount === 0 ? 'goal_completed' : 'completed';
}
```

**Triggered by:**
- Goal created (afterSave)
- Goal updated (afterSave)
- Goal deleted (afterDelete)

**Logic:**
- IF all goals have `achieved_score >= target_score` → Status = "goal_completed"
- IF any goal has `achieved_score < target_score` OR `achieved_score IS NULL` → Status = "completed"

**Example Scenario:**

| Action | Goals State | Assessment Status |
|--------|-------------|-------------------|
| Assessment approved | No goals yet | completed |
| Goal 1 created (incomplete) | Goal 1: Incomplete | completed |
| Goal 2 created (incomplete) | Goal 1: Incomplete, Goal 2: Incomplete | completed |
| Goal 1 completed | Goal 1: Complete, Goal 2: Incomplete | completed |
| Goal 2 completed | Goal 1: Complete, Goal 2: Complete | **goal_completed** |
| Goal 3 created (incomplete) | All goals + new incomplete | **completed** (reverted) |

---

### Rule 5: Section Goals Are No Longer Supported

**Only question-level goals are allowed**

**Implementation:**
```php
// GoalsController.php lines 238-241
if (empty($programAssessmentGoalEntity->program_assessment_response_id)) {
    throw new NotFoundException(__('Section goals are no longer supported.'));
}
```

**Why:**
- Old system allowed goals at section level (multiple questions)
- New system requires goals linked to specific questions
- More granular tracking and accountability

**Validation:**
- `program_assessment_response_id` field is required
- Cannot be NULL or empty
- Must reference valid assessment response record

---

### Rule 6: Assessment Archive is Soft Delete

**Archived assessments remain in database but are hidden**

**Implementation:**
```php
// Archive action sets deleted timestamp
$programAssessment->deleted = new FrozenTime();

// beforeFind() automatically excludes archived records
public function beforeFind(EventInterface $event, Query $query, $options): void
{
    $query->where(['ProgramAssessments.deleted IS' => null]);
}
```

**Recovery:**
- No UI option to unarchive
- Requires database manual update:
  ```sql
  UPDATE program_assessments SET deleted = NULL WHERE id = '{id}';
  ```
- Support ticket required for recovery

---

### Rule 7: 3-Year Assessment Renewal Cycle

**System automatically creates renewal reminder on approval**

**Implementation:**
```php
// ProgramAssessmentsTable.php afterSave() - lines 163-253
if ($entity->status === 'completed' && $entity->approved_on) {
    // Create reminder with due date = approved_on + 3 years
    $reminderDate = $entity->approved_on->addYears(3);

    $reminder = [
        'title' => "{$program->name} - Self-Assessment Expires",
        'due_date' => $reminderDate,
        'assigned_to' => 'Affiliate NQMS users',
        'description' => '3-year assessment cycle complete',
    ];
}
```

**Timeline:**
- Approval date: January 1, 2025
- Reminder created with due date: January 1, 2028
- Assigned to: All affiliate users with NQMS access for that service area

---

## Special Cases & Restrictions

### Case 1: User with Multiple Roles

**Scenario:** User assigned to both affiliate and program with different access levels

**Example:**
- User is assigned to Affiliate A (NQMS-Only)
- User is also assigned to Program B (Full Access)

**Result:**
- User has BOTH `nqms_affiliate` AND `program` roles
- Gets the UNION of permissions from both roles
- Can approve assessments (from affiliate role)
- Can edit assessments (from both roles)
- Can manage users (from program Full Access)

**Is Limited Contractor Check:**
```php
// Returns FALSE if user has ANY non-contractor role
protected function userIsLimitedContractorOnly(): bool
{
    $userRoles = $this->getUserRoles();

    if ($userRoles['nqms_affiliate_limited'] || $userRoles['nqms_program_limited']) {
        foreach ($userRoles as $role => $value) {
            if (!in_array($role, ['nqms_affiliate_limited', 'nqms_program_limited']) && $value) {
                return false;  // Has another role - NOT contractor-only
            }
        }
        return true;  // ONLY has contractor roles
    }
    return false;
}
```

---

### Case 2: MC-Only Users Have Zero NQMS Access

**Scenario:** User with `access_level = 2` (MC-Access Only)

**Result:**
- CANNOT access any NQMS features
- CANNOT view assessments
- CANNOT create/edit/view goals
- CANNOT even see NQMS tab in navigation

**Permission Check:**
```php
// canAccessNQMS() explicitly excludes MC-Only users
public function canAccessNQMS(int $programId): bool
{
    $notEqual = UniversalEnumerations::MENTOR_CONNECTOR_ONLY;  // Exclude access_level = 2
    return $this->hasAccess($programId, $notEqual);
}
```

---

### Case 3: Status Transitions Are One-Way

**Current Flow:**
```
(none) → in-progress → pending-review → completed → goal_completed
```

**No Rollback Mechanism:**
- Cannot move from "completed" back to "pending-review"
- Cannot move from "pending-review" back to "in-progress"
- Cannot move from "goal_completed" back to "completed" (manual only)

**Workaround for Mistakes:**
- If assessment approved prematurely:
  1. Archive the incorrect assessment
  2. Create new assessment
  3. Copy data manually
- If goal completion triggers wrong status:
  1. Edit goal to make it incomplete
  2. System automatically reverts to "completed"

---

### Case 4: Goals Can Be Created Before Assessment Approval (But Not Recommended)

**Technical Reality:**
- No code explicitly prevents goal creation on in-progress assessments
- Goals can technically be created at any time

**Best Practice:**
- Goals should only be created AFTER assessment is approved
- Goals represent areas for improvement from completed baseline assessment
- Creating goals during assessment could lead to confusion

**Recommendation:** Add validation to prevent goal creation when status != "completed"

---

### Case 5: File Attachments on Goals

**Implementation:**
- Goals can have file attachments via `program_documents` join table
- Files stored in S3 or local storage
- File deletion does NOT cascade from goal deletion

**Code Reference:**
```php
// GoalsController.php lines 685-696
public function delete($id, $programId, $programAssessmentId)
{
    // Clean up join table entries
    TableRegistry::getTableLocator()
        ->get('Programs.ProgramDocuments')
        ->deleteAll(['program_assessment_goal_id' => $id]);

    // Note: Files themselves remain in storage (orphaned)
}
```

**Cleanup Strategy:**
- Orphaned files remain in storage
- No automatic cleanup job
- Manual cleanup required (support task)

---

## Code References

### Controllers

| File | Purpose | Key Methods |
|------|---------|-------------|
| `plugins/Programs/src/Controller/Admin/AssessmentsController.php` | Main assessment CRUD | add() (265-312)<br>edit() (82-257)<br>view() (320-372)<br>archive() (383-434)<br>preview() (442-471)<br>export() (479-511) |
| `plugins/Programs/src/Controller/Admin/GoalsController.php` | Goals CRUD | add() (94-205)<br>edit() (215-314)<br>delete() (654-714)<br>preview() (372-432)<br>export() (440-484) |
| `plugins/Programs/src/Controller/Admin/Api/AssessmentsController.php` | AJAX rating updates | edit() (33-174) |
| `plugins/Programs/src/Controller/Admin/NQMSController.php` | NQMS dashboard | index() (42-99) |

### Models

| File | Purpose | Key Methods |
|------|---------|-------------|
| `plugins/Programs/src/Model/Entity/ProgramAssessment.php` | Assessment entity | Virtual properties |
| `plugins/Programs/src/Model/Table/ProgramAssessmentsTable.php` | Assessment table logic | getStatuses() (258-261)<br>getApproveStatus() (266-269)<br>createNewProgramAssessment() (129-155)<br>afterSave() (163-253) |
| `plugins/Programs/src/Model/Entity/ProgramAssessmentGoal.php` | Goal entity | _getStatus() (51-69) |
| `plugins/Programs/src/Model/Table/ProgramAssessmentGoalsTable.php` | Goal table logic | validationDefault() (103-168)<br>afterSave() (211-225)<br>afterDelete() (235-249) |

### Permission Trait

| File | Purpose | Key Methods |
|------|---------|-------------|
| `plugins/Users/src/Trait/UserPermissionsTrait.php` | Permission checking | canAccessNQMS() (175-192)<br>canApproveAssessment() (681-707)<br>canAccessOldAssessment() (747-766)<br>userIsLimitedContractorOnly() (714-735) |

### Event Listeners

| File | Purpose | Key Methods |
|------|---------|-------------|
| `plugins/Programs/src/Event/AssessmentListener.php` | Assessment creation | addProgramAssessment() (35-208) |
| `plugins/Programs/src/Event/AssessmentGoalListener.php` | Auto status updates | updateAssessmentStatus() (33-71) |

### Templates

| File | Purpose | Key Elements |
|------|---------|--------------|
| `plugins/Programs/templates/Admin/Assessments/view.php` | Assessment view page | Status-based buttons (55-136) |
| `plugins/Programs/templates/Admin/Assessments/edit.php` | Assessment edit form | Question responses, submit buttons |
| `plugins/Programs/templates/Admin/Assessments/preview.php` | Export preview | Table layout for CSV |

### Configuration

| File | Purpose | Relevant Lines |
|------|---------|----------------|
| `config/request_policy_configs.php` | Route authorization | NQMS routes (177-200) |

---

## Summary

### Key Takeaways

1. **Approval is affiliate-only** - Program users cannot approve their own assessments
2. **Status transitions are one-way** - No rollback from completed to pending-review
3. **Limited contractors see only latest assessment** - Historical data is restricted
4. **Goals auto-update assessment status** - System manages completed/goal_completed transitions
5. **MC-Only users have zero NQMS access** - Complete separation of concerns
6. **Completed assessments are permanently read-only** - No edits after approval

### Permission Summary by Role

| Role | Create | Edit | Submit | Approve | Archive | Goals | Old Assessments |
|------|--------|------|--------|---------|---------|-------|-----------------|
| **Global Admin** | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| **Affiliate Full** | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| **Affiliate NQMS** | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| **Affiliate MC-Only** | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| **Affiliate Limited** | ✅ | ✅¹ | ✅¹ | ❌ | ❌ | ✅ | ❌ |
| **Program Full** | ✅ | ✅ | ✅ | ❌ | ❌ | ✅ | ✅ |
| **Program NQMS** | ✅ | ✅ | ✅ | ❌ | ❌ | ✅ | ✅ |
| **Program MC-Only** | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| **Program Limited** | ✅ | ✅¹ | ✅¹ | ❌ | ❌ | ✅ | ❌ |

¹ Limited to latest assessment only

---

**END OF DOCUMENT**
