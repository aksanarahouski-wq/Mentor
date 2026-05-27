# NQMS Assessment Requests

## Overview

This SOW covers 7 enhancement requests to the NQMS Assessment system that address printing, exporting, data management, goal tracking, and visibility improvements.

**Requests Included:**

- Print Assessment (Request 1A)
- Export Assessment (Request 1B) - PRIORITY
- Export Assessment Goals (Request 1C)
- Archive Assessments (Request 2A)
- Goal Date Tracking (Request 3)
- Delete Goals (Request 4)
- Remove Section Goals (Request 5)

**Implementation Approach:** Each request can be estimated and implemented independently, though some dependencies exist (noted in each request).

---

## Request 1A: Print Assessment

### Problem Statement

**Current State:**
Programs and reviewers cannot print assessments directly from the assessment view page. Printing from the browser requires manually expanding all accordion sections, and the result includes navigation elements and buttons that clutter the printed output.

### Business Impact

- Programs need printed copies of their self-assessments for internal records
- Current manual process is time-consuming (expand each accordion individually)
- Print output includes unnecessary UI elements (navigation, buttons)
- No professional formatting or branding

**User Need:**
Programs want a "nice-looking copy" of their completed assessment to reference when filling out the assessment again 3 years later, or to share with their board/leadership.

### Proposed Solution

**Approach:** CSS-based print styling with browser print functionality

**How It Works:**

1. Add "Print" button to assessment view page
2. Button triggers browser's native print dialog (window.print())
3. CSS @media print styles automatically:
   - Expand all accordion sections
   - Hide navigation, buttons, and non-essential UI elements
   - Add MENTOR branding (logo, program name)
   - Control page breaks to avoid splitting questions
   - Format for professional appearance

**What's Included in Print:**

- Assessment sections (A, B, C, etc.) - each starting on new page
- Questions, ratings, and comments
- MENTOR logo and program branding
- Date and program name in header/footer

**What's NOT Included:**

- Goals (goals are set after assessment in most cases)
- Navigation and UI controls

### Acceptance Criteria

- [ ] "Print" button appears on assessment view page for all users who can view the assessment
- [ ] Clicking button triggers browser print dialog
- [ ] Print preview automatically expands all accordion sections
- [ ] Print view hides navigation, sidebar, buttons, and other UI controls
- [ ] Print view includes MENTOR logo in header
- [ ] Print view includes program name and date
- [ ] Each section (A, B, C, etc.) starts on a new page
- [ ] Questions, ratings, and comments are included
- [ ] Goals are NOT included in print view
- [ ] Page breaks controlled to prevent awkward splits
- [ ] Professional formatting with appropriate margins and spacing
- [ ] Print functionality works in Chrome, Firefox, Safari, and Edge
- [ ] Print respects existing view permissions (if can view, can print)

---

## Request 1B: Export Assessment (PRIORITY)

### Problem Statement

**Current State:**
Programs and reviewers can export assessment data through the Assessment Details Report, but the process is cumbersome:

- Must navigate to separate report page (not from assessment view)
- Very difficult to filter down to a single program
- Can only search by date (no search by affiliate or program name)
- Export layout is difficult to use (questions as rows instead of columns)

### Business Impact

- Reviewers need to export assessments to share with programs
- Current 5+ step process to export one assessment
- Poor UX for a frequently-needed action
- Data format requires manual cleanup (copy/paste into template)

**User Need:**
Both programs and affiliate staff need quick, one-click export of a single program's assessment data for their records and to track progress offline.

### Proposed Solution

**Approach:** Build dedicated "Assessment Preview" page with visual review before export

**How It Works:**

1. Add "Assessment Preview" button to existing assessment details page
2. Button navigates to new preview page
3. Preview page displays full assessment data in read-only table format
4. Table shows all 16 columns of data visually (scrollable)
5. "Export as CSV" button at top right downloads the data
6. "Back to Assessment" button returns to assessment details page

**User Experience:**

- User clicks "Assessment Preview" → Navigates to preview page
- User reviews data visually in table format
- User clicks "Export as CSV" → CSV downloads
- User clicks "Back to Assessment" → Returns to main assessment page

**Preview Page Layout:**

- **Breadcrumb:** Home / Programs / Browse Programs / Program Details / Assessment / Preview
- **Page Title:** "Assessment Preview"
- **Action Buttons (top right):**
  - "Back to Assessment" (secondary button)
  - "Export as CSV" (primary button with download icon)
- **Data Table:** Scrollable table with columns:
  - Section Title
  - Question Text
  - Question Rating
  - Question Notes
  - Section Average Rating
  - Goals Set
  - Goal Name
  - Goal Baseline Rating
  - Goal Target Rating
  - Goal Achieved Rating
  - Question Goal Status

**Benefits:**

- Visual confirmation of data before export
- Better UX for reviewing assessment completeness
- Easier to spot data issues before downloading
- Provides shareable preview URL for team collaboration
- More professional/polished user experience

**CSV Format:** 16 columns

1. assessment_name
2. assessment_created_date
3. submitted_for_review_date
4. program_id
5. program_title
6. section_title
7. question_text
8. question_rating
9. question_notes
10. section_average_rating
11. goals_set
12. question_goal_name
13. question_goal_baseline_rating
14. question_goal_target_rating
15. question_goal_achieved_rating
16. question_goal_status

**File Naming:** single_program_assessment_details__with_goals_{ISO8601_timestamp}.csv

**Estimated Complexity:** Medium (3-5 days)

### Acceptance Criteria

**Preview Page Navigation**

- [ ] "Assessment Preview" button appears on assessment details page
- [ ] Button positioned with other action buttons (Print, Delete, Review)
- [ ] Button visible to all users who can view the assessment
- [ ] Clicking button navigates to preview page
- [ ] Breadcrumb navigation displays correctly
- [ ] "Back to Assessment" button returns to assessment details page

**Preview Page Display**

- [ ] Page title shows "Assessment Preview"
- [ ] Assessment name/year displayed prominently
- [ ] Program name displayed
- [ ] Data table displays all assessment questions
- [ ] Table includes all 16 data columns
- [ ] Section titles displayed and grouped visually
- [ ] Question ratings displayed correctly
- [ ] Question notes displayed (truncated if long)
- [ ] Section average ratings calculated and displayed
- [ ] Goals displayed (Yes/No in "Goals Set" column)
- [ ] Goal details displayed in respective columns
- [ ] Table is horizontally scrollable if needed
- [ ] Table is responsive and usable on different screen sizes
- [ ] Data is read-only (no editing on preview page)

**Export Functionality**

- [ ] "Export as CSV" button appears at top right of preview page
- [ ] Button has download icon
- [ ] Button is styled as primary action button
- [ ] Clicking button downloads CSV file immediately
- [ ] No page refresh or navigation occurs after export
- [ ] User remains on preview page after export
- [ ] CSV file named: single_program_assessment_details__with_goals_{timestamp}.csv
- [ ] Timestamp in ISO 8601 format with timezone
- [ ] CSV contains exactly 16 columns in specified order
- [ ] CSV data matches what's displayed on preview page

**Data Integrity**

- [ ] One row per question in assessment
- [ ] Assessment metadata (columns 1-5) repeated on every row
- [ ] Section title and average repeated for all questions in section
- [ ] If question has multiple goals, each goal creates duplicate question row (in CSV)
- [ ] If question has no goals, goal columns (11-16) are empty/blank
- [ ] Dates formatted: "Month Day, Year, Time" (e.g., "April 1, 2025, 8:08 PM")
- [ ] Section averages calculated correctly
- [ ] CSV opens correctly in Excel, Google Sheets, Numbers
- [ ] Export respects existing view permissions

---

## Request 1C: Export Assessment Goals

### Problem Statement

**Current State:**
Programs and reviewers can view assessment goals through the "Preview Assessment Goals" button on the assessment details page, but there is no way to export this data:

- Goals are displayed on screen but cannot be downloaded
- No offline access to goals data
- Cannot share goals data via file
- Must manually transcribe goals data for reporting or tracking

### Business Impact

- Programs need to track goal progress over time in their own systems
- Reviewers want to export goals data for follow-up and monitoring
- No easy way to share goals with stakeholders (board, leadership, funders)
- Manual data entry required if programs want to maintain offline goal tracking

**User Need:**
Programs and affiliate staff need to export assessment goals data (goal names, baseline/target ratings, dates, notes) to track progress offline, share with stakeholders, and maintain their own records.

### Proposed Solution

**Approach:** Build dedicated "Assessment Goals Preview" page with visual review before export

**How It Works:**

1. "Preview Assessment Goals" button already exists on assessment details page
2. Button navigates to preview page
3. Preview page displays goals data in read-only table format
4. Table shows all 8 columns of goals data visually (scrollable)
5. Add "Export as CSV" button at top right to download the data
6. "Back to Assessment" button returns to assessment details page

**User Experience:**

- User clicks "Preview Assessment Goals" → Navigates to preview page
- User reviews goals data visually in table format
- User clicks "Export as CSV" → CSV downloads
- User clicks "Back to Assessment" → Returns to main assessment page

**Preview Page Layout:**

- **Breadcrumb:** Home / Programs / Browse Programs / Program Details / Assessment / Assessment Goals Preview
- **Page Title:** "Assessment Goals Preview"
- **Assessment Subtitle:** "{Assessment Name} - {Program Name}"
- **Action Buttons (top right):**
  - "Back to Assessment" (secondary button)
  - "Export as CSV" (primary button with download icon)
- **Data Table:** Scrollable table with columns:
  - Section Title
  - Question Text
  - Goal Name
  - Baseline Rating
  - Target Rating
  - Start Date
  - Target Completion Date
  - Notes

**Benefits:**

- Visual confirmation of goals data before export
- Better UX for reviewing goal completeness
- Easier to spot missing data (empty dates, missing notes)
- Provides shareable preview URL for team collaboration
- More professional/polished user experience
- Leverages existing "Preview Assessment Goals" button (just add export functionality)

**CSV Format:** 8 columns

1. section_title
2. question_text
3. goal_name
4. baseline_rating
5. target_rating
6. start_date
7. target_completion_date
8. notes

**File Naming:** assessment_goals_{assessment_name}_{ISO8601_timestamp}.csv

**Estimated Complexity:** Low-Medium (2-3 days)

### Acceptance Criteria

**Preview Page Navigation**

- [ ] "Preview Assessment Goals" button already exists on assessment details page
- [ ] Clicking button navigates to goals preview page
- [ ] Breadcrumb navigation displays correctly
- [ ] "Back to Assessment" button returns to assessment details page

**Preview Page Display**

- [ ] Page title shows "Assessment Goals Preview"
- [ ] Assessment name and program name displayed as subtitle
- [ ] Data table displays all goals
- [ ] Table includes all 8 data columns
- [ ] Section titles displayed
- [ ] Question text displayed
- [ ] Goal details displayed (name, baseline, target, dates, notes)
- [ ] Start dates formatted as MM/DD/YYYY
- [ ] Target completion dates formatted as MM/DD/YYYY
- [ ] Notes displayed (full text visible or truncated with expand)
- [ ] Table is horizontally scrollable if needed
- [ ] Table is responsive and usable on different screen sizes
- [ ] Data is read-only (no editing on preview page)
- [ ] Empty/missing data shows as blank (not error)

**Export Functionality**

- [ ] "Export as CSV" button appears at top right of preview page
- [ ] Button has download icon
- [ ] Button is styled as primary action button
- [ ] Clicking button downloads CSV file immediately
- [ ] No page refresh or navigation occurs after export
- [ ] User remains on preview page after export
- [ ] CSV file named: assessment_goals_{assessment_name}_{timestamp}.csv
- [ ] Timestamp in ISO 8601 format with timezone
- [ ] CSV contains exactly 8 columns in specified order
- [ ] CSV data matches what's displayed on preview page

**Data Integrity**

- [ ] One row per goal (not per question)
- [ ] Only questions WITH goals are included in table and CSV
- [ ] Questions without goals are excluded
- [ ] Multiple goals per question each get their own row
- [ ] Dates formatted: MM/DD/YYYY in CSV
- [ ] CSV opens correctly in Excel, Google Sheets, Numbers
- [ ] Export respects existing view permissions
- [ ] If assessment has no goals, preview shows "No goals set" message
- [ ] If assessment has no goals, CSV downloads with headers only

---

## Request 2A: Archive Assessments

**Estimate:** 3 hours

### Problem Statement

**Current State:**
There is no way to remove assessments from the system. This creates issues:

- Test assessments created during training pollute reports and dashboards
- Duplicate assessments created by error cannot be removed
- Half-finished assessments when programs abandon process mid-stream remain visible
- Invalid assessments from data migration cannot be cleaned up

### Business Impact

- Reports include test and invalid data, reducing accuracy
- Dashboards show incomplete/dead assessments
- No way to clean up data quality issues
- Affiliate reviewers cannot archive assessments for programs that go under or abandon NQMS

**User Need:**
Reviewers need ability to archive "dead assessments" - incomplete submissions that were never finished and never will be. This is different from inactive programs (which retain historical data).

### Proposed Solution

**Approach:** Soft delete (archive) with no restore UI

**How It Works:**

1. Add deleted timestamp column to assessments table
2. Add "Archive Assessment" button on assessment view page (authorized users only)
3. Confirmation modal warns about action
4. Setting deleted timestamp hides assessment from all queries
5. Archived assessments excluded from reports, dashboards, and lists
6. Data preserved in database but not visible anywhere

**Who Can Archive:**

- Global Admins
- Affiliate Staff
- NOT program end users

**Rationale for Soft Delete:**

- Safe: can be recovered if archived by mistake
- Data preserved for audit purposes
- Can add permanent cleanup later (e.g., 90-day retention)

### Acceptance Criteria

- [ ] Migration adds deleted column (DATETIME, nullable) to assessments table
- [ ] Migration adds index on deleted column
- [ ] "Archive Assessment" button appears on assessment view page
- [ ] Button only visible to Global Admins and Affiliate Staff
- [ ] Button NOT visible to program end users
- [ ] Clicking button opens confirmation modal
- [ ] Modal displays warning: "Are you sure you want to archive this assessment?"
- [ ] Modal shows assessment name and program name
- [ ] Modal has "Yes" and "No" buttons
- [ ] Clicking "Yes" sets deleted timestamp to current datetime
- [ ] After archiving, user redirected to Program Details page
- [ ] Archived assessment removed from assessment lists
- [ ] Archived assessment excluded from all reports
- [ ] Archived assessment excluded from dashboard widgets
- [ ] Archived assessment data preserved in database (soft delete, not hard delete)
- [ ] Related data (goals, documents) preserved when assessment archived
- [ ] User cache cleared after archiving
- [ ] Permission check enforces: global admins OR affiliate staff only

---

## Request 3: Goal Date Tracking

**Estimate:** 1 hour

### Problem Statement

**Current State:**
Goals in the system lack date tracking. There is no way to capture:

- When a goal was started (start date)
- When a goal should be completed (target date)
- Timeline for goal achievement

### Business Impact

- Cannot track goal deadlines or timelines
- No visibility into when goals are overdue
- Difficult for programs to plan goal work by quarter or timeframe
- Reviewers cannot see upcoming goal deadlines
- No way to track 3-year goal cycle (Year 1, Year 2, Year 3)

**User Need:**
Programs need to see goals in a timeline versus one long list. Reviewers need to track when goals are approaching deadlines. Goals are set annually (not for full 3-year period), so date tracking helps with yearly planning and quarterly check-ins.

### Proposed Solution

**Approach:** Add date fields to goals table

**How It Works:**

1. Add start_date (DATE, nullable) column to goals table
2. Add target_completion_date (DATE, nullable) column to goals table
3. Both fields are optional (can be left blank)
4. start_date auto-populates with current date on goal creation (editable)
5. Both dates editable in goal add/edit forms
6. HTML5 date pickers for user input
7. Validation: target date must be after start date (if both provided)
8. Backfill existing goals: set start_date from goal's created timestamp

**NOT Included:**

- Automated email reminders (adds significant cost)
- Visual indicators could be added later (red text for overdue goals)

### Acceptance Criteria

- [ ] Migration adds start_date column (DATE, nullable) to goals table
- [ ] Migration adds target_completion_date column (DATE, nullable) to goals table
- [ ] Migration backfills start_date for existing goals from created timestamp
- [ ] Both date fields are optional (nullable)
- [ ] Goal add form includes start_date field (HTML5 date picker)
- [ ] Goal add form includes target_completion_date field (HTML5 date picker)
- [ ] start_date auto-populates with current date when creating new goal
- [ ] Both dates are editable by user
- [ ] Goal edit form includes both date fields (pre-populated if set)
- [ ] Validation: if both dates provided, target must be after start
- [ ] Validation error message: "Target completion date must be after start date"
- [ ] Invalid dates prevent goal save
- [ ] Goal view page displays both dates (if set)
- [ ] Goals list/index includes "Start Date" column
- [ ] Goals list/index includes "Target Date" column
- [ ] Dates formatted consistently: MM/DD/YYYY
- [ ] Goal exports include date fields
- [ ] Existing goals (created before migration) have start_date backfilled
- [ ] Goals without dates display blank/empty (not error)

---

## Request 4: Delete Goals

**Estimate:** 1 hour

### Problem Statement

**Current State:**
There is no way to delete goals in the system. This creates issues when:

- Goals created on wrong question (data entry error)
- Duplicate goals created by mistake
- Section goals need to be converted to question goals (old goal cannot be removed)
- Goals created with incorrect information

### Business Impact

- Cannot correct data entry mistakes
- Incorrect goals pollute reports and exports
- Cannot clean up duplicate or erroneous goals
- Section goal migration blocked (cannot delete old section goals)

**User Need:**
Reviewers need ability to permanently delete goals that were created in error. This is NOT about programs deleting goals they can't complete (to game completion rates). This is about correcting mistakes.

### Proposed Solution

**Approach:** Permanent deletion (hard delete, not soft delete)

**How It Works:**

1. Add "Delete Goal" button on goal view/edit page
2. Button only visible to users with goal edit permissions (NQMS staff, NOT program users)
3. Confirmation modal warns action cannot be undone
4. Clicking "Yes" permanently deletes goal from database
5. Related records cleaned up (cascading delete)
6. User redirected to assessment or program page

**Rationale for Hard Delete:**

- Use case is correcting data entry errors, not preserving history
- Goals are small data objects (not complex like assessments)
- Simpler implementation than soft delete
- Less confusion than having "inactive" goals

**Who Can Delete:**

- Whoever can add/edit goals (currently: NQMS staff/reviewers/affiliates)
- NOT program end users

### Acceptance Criteria

- [ ] "Delete Goal" button appears on goal view page
- [ ] Button only visible to users with goal edit permissions
- [ ] Button NOT visible to program end users
- [ ] Clicking button opens confirmation modal
- [ ] Modal displays warning: "This action cannot be undone"
- [ ] Modal shows goal name
- [ ] Modal shows associated question/section
- [ ] Modal has "Yes" and "No" buttons
- [ ] Clicking "Yes" permanently deletes goal from database
- [ ] After deletion, user redirected to assessment or program page
- [ ] Success message displayed: "Goal deleted successfully"
- [ ] Deleted goal removed from all lists
- [ ] Deleted goal removed from all reports
- [ ] Deleted goal removed from exports
- [ ] User cache cleared after deletion
- [ ] Permission check enforces: only users with edit permissions can delete
- [ ] Cannot delete via API without proper permissions

---

## Request 5: Remove Section Goals

**Estimate:** 2 hours

### Problem Statement

**Current State:**
Section goals feature exists in the system but causes multiple problems:

- No way to identify if section goals are completed
- Section goals show as "complete" even when they are not
- Section goals don't appear in goal reports
- Section goals show as complete on dashboard when they shouldn't
- Confusion about when to use section goals vs question goals
- Cannot delete section goals to convert them to question goals

### Business Impact

- Data integrity issues (incorrect completion status)
- Missing data in reports
- User confusion about goal types
- Technical debt maintaining two goal types
- Cannot clean up problematic section goals (Request 4 needed for cleanup)

**User Need:**
Client confirmed section goals are not needed and should be removed entirely. They cause more problems than they solve. System should only support question goals going forward.

### Proposed Solution

**Approach:** Complete removal of section goals feature

**How It Works:**

1. Count existing section goals (data analysis query)
2. Migration permanently deletes all section goals (hard delete)
3. Remove "Add Section Goal" option from UI
4. Update form validation to prevent section goal creation
5. Remove section goal logic from controllers, views, reports
6. Simplify codebase to only handle question goals

**Data Cleanup:**

- All existing section goals permanently deleted (no conversion)
- Migration logs count of section goals removed
- No value in preserving problematic data

**Code Cleanup:**

- Remove section goal conditionals from views
- Remove section goal queries from reports
- Simplify goal creation to single path

### Acceptance Criteria

- [ ] Migration script counts existing section goals before deletion
- [ ] Migration output logs: "Deleting X section goals..."
- [ ] Migration permanently deletes all section goals (hard delete)
- [ ] Migration completes successfully with or without section goals
- [ ] "Add Section Goal" option removed from goal creation form
- [ ] Only "Question Goal" option available in UI
- [ ] Form validation prevents section goal creation
- [ ] Validation error if user attempts to create section goal
- [ ] Help text updated to clarify only question goals supported
- [ ] No errors when viewing old assessments that had section goals
- [ ] System handles references to deleted section goals gracefully

---

## Implementation Dependencies

### Request Dependencies

**Can be implemented independently:**

- Request 1A (Print Assessment)
- Request 1B (Export Assessment)
- Request 2A (Archive Assessments)
- Request 4 (Delete Goals)

**Request 5 (Remove Section Goals) should be implemented first, as it's foundational cleanup**

**Request 3 (Goal Dates) should be implemented before Request 1C (Export Assessment Goals) - so that exported goals can include date columns**

### Suggested Implementation Order

1. Request 1B (Export) - High priority, independent
2. Request 2A (Archive) - Independent, enables cleanup
3. Request 3 (Goal Dates) - Foundation for timeline features
4. Request 5 (Section Goals) - Cleanup technical debt
5. Request 4 (Delete Goals) - Administrative capability
6. Request 1C (Export Goals) - Depends on Request 3
7. Request 1A (Print) - Nice-to-have, may not be needed

---

## Out of Scope (All Requests)

❌ Request 2B: Delete Programs (handled in Mentoring Connector)
❌ PDF export (only CSV for Request 1B)
❌ Automated email reminders for goal deadlines
❌ Assessment restore after archiving
❌ Goal restore after deletion
❌ Bulk archive/delete operations
❌ Section goal conversion to question goals (delete only)
❌ Goal timeline/calendar view (Phase 2)
❌ Goal progress dashboard widgets (Phase 2)
