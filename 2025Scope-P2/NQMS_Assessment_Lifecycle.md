# NQMS Assessment Lifecycle Management

## Document Purpose
This document addresses issues related to managing multiple assessments over time, including closing/completing assessments, starting new assessments, and viewing assessment history. These are critical workflow issues for programs that complete assessments periodically (e.g., annually).

---

## Discovery Session Summary

### Issue Overview
Programs currently cannot properly close/complete an existing assessment and start a fresh new assessment. There is no clear assessment lifecycle management, no ability to view all assessments (past and current), and no way to start a new assessment without old ratings pre-populating.

**Status:** CRITICAL ISSUE - Affects programs ready for second assessment cycle
**Priority:** HIGH - Required for ongoing program use

### Key Problems Identified:
1. **No ability to close/complete existing assessment** and mark it as "done"
2. **No ability to start a new assessment** for next cycle (e.g., next year)
3. **Old ratings automatically show up in new assessments** (undesirable behavior)
4. **No ability to view assessment history** (all past assessments for a program)
5. **Unclear what happens when Assessment #2 exists** in the system (untested scenario)

---

## Request 1: Add Assessment Lifecycle Management

### Description
Add the ability to properly manage assessment lifecycle: close/complete current assessment, start a new assessment for next cycle, and ensure new assessments start with blank ratings (not pre-populated from previous assessment).

### Priority
HIGH - CRITICAL for programs in second assessment cycle

### Problem Statement
Programs cannot properly close an existing assessment and start a fresh new one. When programs are ready to complete their second annual assessment, there is no clear workflow to mark the first assessment as complete and begin a new assessment. Additionally, the current system may pre-populate ratings from the previous assessment into the new one, which the client does not want - programs should take each assessment fresh without seeing old ratings.

### Client Clarification

**Mike's Feedback:**

> "Along these lines, will we have a **new button that launches a new assessment without the old assessments ratings**? I prefer programs take the assessment without seeing the old ratings. They would still have the **ability to open the old assessment and see those ratings** but I don't like when the rating automatically shows up and they are just changing the rating for the new assessment."

**Key Requirements from Client:**

1. **New Assessment Button:**
   - Ability to launch a new assessment
   - New assessment should NOT show old ratings
   - Blank slate for programs to complete fresh assessment

2. **Assessment Independence:**
   - Each assessment cycle should be independent
   - Programs should not see previous ratings when completing new assessment
   - Prevents bias/anchoring from previous responses

3. **Access to History:**
   - Programs should still be able to open old assessments
   - View historical ratings separately from current assessment
   - Maintain assessment history for reference

4. **Workflow Preference:**
   - Don't want ratings to "automatically show up"
   - Don't want programs to just be "changing the rating for the new assessment"
   - Each assessment should feel like a new, fresh evaluation

### Addresses
- No way to mark assessment as complete/closed
- Cannot start a new assessment for next cycle
- Old ratings may pre-populate into new assessments (undesirable)
- No clear separation between assessment cycles
- Programs cannot take fresh assessments without previous bias
- No ability to view assessment history
- Confusion about which assessment is "current"

### Current Issues
- Only one assessment exists per program (or behavior with multiple is unclear)
- No "Complete" or "Close" button for assessments
- No "Start New Assessment" button or workflow
- May not be possible to have multiple assessments per program
- If multiple assessments exist, old ratings may carry over to new assessment
- No assessment history view
- Unclear which assessment is active/current

### Use Cases
1. **Program completes Year 1 assessment**, needs to close it and start Year 2 assessment with blank form
2. **Reviewer wants to see program's assessment history** across multiple years
3. **Program wants to reference previous assessment** while working on current one
4. **National staff analyzes improvement** by comparing Assessment 1 vs Assessment 2 ratings
5. **Program takes second assessment** without being influenced by previous ratings
6. **Affiliate admin views all assessments** for a program to track progress over time

### Discovery Questions

#### 1. Assessment Lifecycle Workflow
- **How should programs close/complete an assessment?**
  - "Mark as Complete" button on assessment page?
  - Automatic completion when submitted for review?
  - Automatic completion when approved by reviewer?
  - Manual action required by NQMS staff?

- **What happens when assessment is completed/closed?**
  - Assessment becomes read-only?
  - Assessment archived but viewable?
  - Assessment status changes to "Completed" or "Closed"?
  - Assessment remains open for reference but clearly marked as historical?

- **Who can close/complete an assessment?**
  - NQMS staff only?
  - Programs themselves?
  - Automatic after certain period?

#### 2. Starting New Assessment
- **How should new assessment be created?**
  - "Start New Assessment" button on program page? (Client preference)
  - Automatic creation at beginning of new cycle (e.g., each January)?
  - Created by NQMS staff on behalf of program?
  - Clone previous assessment structure (without ratings)?

- **Where should "Start New Assessment" button be located?**
  - On program details page?
  - On NQMS tab?
  - On current assessment view page?
  - Multiple locations?

- **What happens when new assessment is created?**
  - All questions/sections copied from template?
  - All ratings are blank (Client requirement: "without the old assessments ratings")
  - All comments are blank?
  - Goals do NOT carry over?
  - Status set to "Not Started" or "In Progress"?

- **Who can start new assessment?**
  - NQMS staff only?
  - Programs themselves?
  - Automatic after old assessment is closed?

#### 3. Assessment Independence (Client Requirement)
- **Should new assessments be completely blank?**
  - YES per client: "I prefer programs take the assessment without seeing the old ratings"
  - No pre-population of ratings
  - No pre-population of comments
  - Fresh start for each assessment cycle

- **Should old ratings be visible anywhere during new assessment?**
  - Not in the form fields (Client requirement)
  - Maybe in sidebar for reference? (optional)
  - Accessible via "View Previous Assessment" link?
  - Completely hidden until new assessment submitted?

- **How to prevent accidental rating carry-over?**
  - Technical: Ensure database doesn't copy old ratings
  - UI: Make it clear this is a NEW assessment
  - Display: Show assessment year/cycle clearly
  - Confirmation: "You are starting a new assessment. Previous ratings will not be shown."

#### 4. Assessment History & Viewing
- **How should programs view old assessments?**
  - List of all assessments on program page (Client: "ability to open the old assessment")
  - Dropdown to select assessment to view?
  - Separate "Assessment History" tab/page?
  - Timeline view of all assessments?

- **What should assessment history show?**
  - Assessment date/cycle (e.g., "2024 Assessment", "2025 Assessment")
  - Assessment status (Completed, In Progress, etc.)
  - Submission date
  - Average rating or summary
  - Link to view full assessment

- **Should old assessments be editable?**
  - Read-only after closed? (Recommended)
  - Editable by NQMS staff only?
  - Never editable once closed?
  - Editable within certain timeframe?

- **How to distinguish current vs. historical assessments?**
  - Label "Current" vs "2024 Assessment", "2025 Assessment"
  - Color coding?
  - Different icons or badges?
  - Sort order (current on top)?

#### 5. Assessment Naming & Identification
- **How should assessments be named/identified?**
  - By year? ("2024 Self-Assessment", "2025 Self-Assessment")
  - By cycle number? ("Assessment #1", "Assessment #2")
  - By date submitted? ("Assessment submitted June 2024")
  - Custom name entered by user?

- **Should assessment name be editable?**
  - Yes, to customize (e.g., "Pre-Accreditation Assessment")?
  - No, auto-generated based on date?
  - Hybrid (default name but editable)?

#### 6. Goals Across Multiple Assessments
- **What happens to goals when starting new assessment?**
  - Goals from old assessment remain tied to old assessment?
  - Can set new goals on new assessment?
  - Can continue working on old goals from new assessment?
  - Goals marked as "Assessment 1 Goals" vs "Assessment 2 Goals"?

- **How are improved ratings tracked across assessments?**
  - Improved ratings stay with Assessment 1?
  - Can improve ratings in Assessment 2?
  - Are improvements tracked separately per assessment?

#### 7. Current vs. Historical Ratings (Critical for Reports)
- **Which assessment ratings are "current"?**
  - Most recent assessment submitted?
  - Most recent assessment with status "Completed"?
  - The one marked as "Active" or "Current"?
  - This affects all reports (Request 3 in Reports doc)

- **How do reports handle multiple assessments?**
  - Include all assessments or only current?
  - How to calculate "current rating" when multiple exist?
  - Does Assessment #2 replace Assessment #1 as "current"? (Related to Reports Request 3 question)

#### 8. Technical Considerations
- **Database structure:**
  - Does database already support multiple assessments per program?
  - Need new `status` field on assessments table? (e.g., "active", "completed", "archived")
  - Need new `assessment_year` or `cycle` field?
  - Need new `is_current` boolean field?

- **Data migration:**
  - Are there programs with multiple assessments already?
  - Need to mark existing assessments as "Assessment #1" or "2024"?
  - Set all existing assessments to "Completed" or "Current"?

### Recommended Solution

**Approach: Multi-Assessment Support with Lifecycle Management**

**Implementation:**

#### 1. Update Database Schema
```sql
-- Add fields to assessments table
ALTER TABLE assessments ADD COLUMN status VARCHAR(50) DEFAULT 'in_progress';
  -- Values: 'in_progress', 'submitted', 'completed', 'archived'
ALTER TABLE assessments ADD COLUMN assessment_year INT NULL;
ALTER TABLE assessments ADD COLUMN cycle_number INT NULL;
ALTER TABLE assessments ADD COLUMN is_current BOOLEAN DEFAULT 1;
ALTER TABLE assessments ADD COLUMN completed_date DATETIME NULL;

-- Add index for querying
ALTER TABLE assessments ADD INDEX idx_program_current (program_id, is_current);
ALTER TABLE assessments ADD INDEX idx_status (status);
```

#### 2. Add "Complete Assessment" Functionality
**Location:** Assessment view page (for NQMS staff)

**Workflow:**
1. NQMS staff reviews submitted assessment
2. Clicks "Mark Assessment as Complete" button
3. Confirmation dialog: "This will close the current assessment. The program will be able to start a new assessment. Continue?"
4. Assessment status changes to "completed"
5. `is_current` remains 1 (this is still the current assessment until new one created)
6. `completed_date` set to current date
7. Assessment becomes read-only (except for NQMS staff if needed)

**Access:**
- NQMS staff only (reviewers/admins)
- Not available to programs
- Only available for assessments with status "submitted"

#### 3. Add "Start New Assessment" Functionality
**Location:** Program details page, NQMS tab, or current assessment view page

**Workflow:**
1. Button: "Start New Assessment" (visible when current assessment is completed)
2. Click button opens dialog:
   - "Start new assessment for [Program Name]?"
   - "The new assessment will begin with blank ratings and comments."
   - "Previous assessment will remain accessible in Assessment History."
   - Assessment year input (default: current year)
   - Confirm button
3. System creates new assessment:
   - Copy assessment structure (questions, sections) from template
   - All ratings blank (Client requirement)
   - All comments blank
   - Status: "in_progress"
   - `is_current` = 1
   - `cycle_number` = previous max + 1
4. Previous assessment:
   - `is_current` changed to 0
   - Remains viewable as historical
5. Redirect program to new blank assessment

**Access:**
- NQMS staff can start for any program
- Programs can start their own (optional, needs permission)
- Only available if previous assessment is "completed"

#### 4. Assessment History View
**Location:** Program details page - new "Assessment History" section or tab

**Display:**
- List all assessments for program
- Each row shows:
  - Assessment name (e.g., "2024 Self-Assessment")
  - Status badge (Current, Completed, In Progress)
  - Date submitted
  - Date completed
  - Average rating (optional)
  - "View" button
- Current assessment highlighted/at top
- Sortable by date

**Code Example:**
```php
// In ProgramsController::view()
$assessments = $this->Programs->Assessments->find()
    ->where(['Assessments.program_id' => $programId])
    ->order(['Assessments.is_current DESC', 'Assessments.created DESC'])
    ->all();
```

#### 5. Assessment View with Context
**When viewing any assessment:**
- Display assessment name/year clearly at top
- Show status badge (Current, Completed, Archived)
- Show completion date if applicable
- If viewing historical assessment:
  - Show warning banner: "You are viewing a historical assessment from [year]. View current assessment"
  - Link to current assessment
- If viewing current assessment and old assessments exist:
  - Optional: Show link "View Assessment History"

#### 6. Ensure Rating Independence (Client Requirement)
**Technical safeguards:**
1. When creating new assessment:
   ```php
   // Copy structure only, not data
   $newAssessment = $this->Assessments->newEntity([
       'program_id' => $programId,
       'assessment_year' => $year,
       'cycle_number' => $cycleNumber,
       'is_current' => true,
       'status' => 'in_progress'
   ]);
   // Do NOT copy ratings or comments
   ```

2. In assessment view template:
   ```twig
   {# Only show ratings that belong to THIS assessment #}
   {% for question in questions %}
       <input type="radio" name="q{{ question.id }}_rating"
              value="{{ rating }}"
              {# NO checked attribute from old assessment #}>
   {% endfor %}
   ```

3. Clear visual indicator:
   ```twig
   <h1>{{ assessment.year }} Self-Assessment</h1>
   <div class="alert alert-info">
       You are completing a new assessment. Previous ratings are not shown.
       <a href="{{ url('assessments/history', program.id) }}">View assessment history</a>
   </div>
   ```

#### 7. Update Reports to Handle Multiple Assessments
**Important:** This relates to Reports Request 3 (Full Data Export)

- Reports should allow filtering by assessment year/cycle
- "Current ratings" = ratings from `is_current = 1` assessment
- Full data export should include all assessments (columns: Assess1, Assess2, etc.)
- Average calculations should specify which assessment(s) to include

### Benefits
- **Clear lifecycle**: Programs know when one assessment ends and another begins
- **Fresh assessments**: Programs complete each assessment without bias from previous ratings (Client requirement)
- **Assessment history**: Can view and compare all past assessments
- **Better analytics**: Can track improvement across multiple assessment cycles
- **Reduced confusion**: Clear indication of which assessment is current
- **External evaluator support**: Can export data from specific assessment cycles

### Files to Modify
- **Database:** Add fields to `assessments` table (status, year, cycle, is_current, completed_date)
- `plugins/NQMS/src/Controller/Admin/AssessmentsController.php` - Add complete() and startNew() actions
- `plugins/NQMS/templates/Admin/Assessments/view.twig` - Add "Complete Assessment" button
- `plugins/Programs/templates/Admin/Programs/view.twig` - Add "Start New Assessment" button and Assessment History section
- `plugins/NQMS/templates/Admin/Assessments/history.twig` - NEW template for assessment history list
- `config/request_policy_configs.php` - Add permissions for complete and startNew actions
- All report controllers - Update to handle multiple assessments per program

### Technical Considerations
- **Migration:** Need to update existing assessments with default values
  - Set all existing assessments to `status = 'completed'` or `'submitted'` based on current state
  - Set `is_current = 1` for most recent assessment per program
  - Set `cycle_number = 1` for all existing assessments
  - Set `assessment_year` based on created date or leave NULL
- **Permissions:** Who can complete assessments and start new ones?
- **Validation:** Cannot start new assessment if current one is not completed
- **Cascade:** What happens to goals when assessment is completed? (stay associated with that assessment)
- **UI/UX:** Clear visual distinction between current and historical assessments
- **Performance:** Querying assessments with `is_current = 1` should be indexed

### Testing Scenarios
1. **Complete Assessment:**
   - Mark in-progress assessment as complete
   - Verify status changed to "completed"
   - Verify assessment becomes read-only

2. **Start New Assessment:**
   - Start new assessment after completing previous one
   - Verify new assessment is blank (no ratings pre-filled)
   - Verify previous assessment marked as not current

3. **View Assessment History:**
   - View list of all assessments for program
   - Verify current assessment is clearly indicated
   - Open old assessment and verify it's read-only

4. **Rating Independence:**
   - Complete Assessment 1 with ratings
   - Start Assessment 2
   - Verify Assessment 2 has no ratings pre-filled
   - Verify Assessment 1 ratings still exist

5. **Reports with Multiple Assessments:**
   - Program with 2 assessments
   - Run reports and verify correct assessment used
   - Verify "current" ratings come from `is_current = 1` assessment

### Related Requests
- **Reports Request 3 (Full Data Export):** Multiple assessments impact export structure
  - Client's untested scenario: "what happens when we have the program's next assessment in the system"
  - This request resolves that scenario
- **Assessment Requests Request 1B (Export Assessment):** Should export current assessment or allow selection
- **Assessment Requests Request 6 (Assessment Goals Tab):** Should show goals from all assessments or only current?

---

## Request 2: Assessment History Dashboard/View

### Description
Provide a comprehensive view of all assessments for a program, showing assessment timeline, comparison data, and easy navigation between assessment cycles.

### Priority
MEDIUM (dependent on Request 1)

### Problem Statement
Once multiple assessments exist per program, users need an easy way to view, compare, and navigate between them. A simple list may not be sufficient for analysis and understanding program progress over time.

### Proposed Features
1. **Assessment Timeline:** Visual timeline showing all assessments
2. **Comparison View:** Side-by-side comparison of ratings across assessments
3. **Progress Metrics:** Show improvement/decline trends
4. **Quick Navigation:** Easy switching between assessment cycles
5. **Export Options:** Export specific assessment or comparison data

### Discovery Needed
- What visualizations would be most helpful?
- Should comparison be built into assessment view or separate page?
- What metrics should be calculated automatically?
- How detailed should comparison be?

---

## Next Steps

1. **Confirm client requirements:**
   - Verify "Start New Assessment" button is primary workflow
   - Confirm new assessments should be completely blank
   - Confirm old assessments should be accessible but read-only
   - Who can complete assessments and start new ones?

2. **Clarify assessment naming:**
   - By year, by cycle number, or custom?
   - Auto-generated or user input?

3. **Test current behavior:**
   - Does system already allow multiple assessments?
   - If so, how does it currently behave?
   - Are ratings copying over?

4. **Design database changes:**
   - Confirm fields needed
   - Plan migration for existing data
   - Set up proper indexes

5. **Define permissions:**
   - Who can mark assessment as complete?
   - Who can start new assessment?
   - Should programs have self-service?

6. **Update reports:**
   - Clarify how reports should handle multiple assessments
   - Coordinate with Reports Request 3 implementation

7. **Prototype UI:**
   - Mock up "Start New Assessment" flow
   - Mock up Assessment History view
   - Mock up completed assessment indicator

8. **Create technical specification:**
   - Detailed database schema changes
   - API/controller changes
   - UI/template changes
   - Migration scripts

---

## Critical Questions to Resolve

### Question 1: Assessment Lifecycle Trigger
**When should an assessment be marked as complete?**
- A) Automatic when program submits for review
- B) Manual by NQMS staff after review approval
- C) Manual by NQMS staff at any time
- D) Combination of automatic + manual override

**Recommendation:** Option B or C (manual by NQMS staff) gives most control

### Question 2: "Start New Assessment" Access
**Who should be able to start a new assessment?**
- A) NQMS staff only (more control)
- B) Programs themselves (self-service)
- C) Both (with different permissions)

**Recommendation:** Start with A (NQMS staff only), add B later if needed

### Question 3: Assessment Identification
**How should assessments be identified?**
- A) By year (e.g., "2024 Self-Assessment", "2025 Self-Assessment")
- B) By cycle (e.g., "Assessment Cycle 1", "Assessment Cycle 2")
- C) Custom name (user enters name)
- D) Date submitted (e.g., "Assessment submitted 06/15/2024")

**Recommendation:** Option A (by year) - most intuitive for users

### Question 4: Old Assessment Access
**Should programs be able to view old assessments while completing new one?**
- A) Yes, via link/button (Client: "ability to open the old assessment")
- B) No, completely hidden until new assessment submitted
- C) Yes, but with warning about not copying ratings

**Recommendation:** Option A - allow access but make it separate/intentional

---

## Implementation Priority

**Phase 1 (Essential - Required for second assessment cycle):**
1. Add assessment lifecycle fields (status, is_current, etc.)
2. Add "Complete Assessment" functionality (NQMS staff)
3. Add "Start New Assessment" functionality (NQMS staff)
4. Ensure new assessments are blank (no rating carry-over)
5. Basic assessment history list

**Phase 2 (Enhanced usability):**
6. Assessment History with better UI/UX
7. Clear visual indicators (current vs historical)
8. Update all reports to handle multiple assessments
9. Add assessment year/cycle naming

**Phase 3 (Advanced features):**
10. Self-service "Start New Assessment" for programs (optional)
11. Assessment comparison view (Request 2)
12. Assessment timeline visualization
13. Automated assessment creation (e.g., start new assessment each January)

---

## Notes
- This issue is closely related to Reports Request 3 question about multiple assessments
- Client has not tested behavior with Assessment #2 in system yet
- This is a foundational feature that affects all assessment workflows
- Must coordinate with reports implementation to ensure consistency
