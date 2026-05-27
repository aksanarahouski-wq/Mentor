# NQMS Assessment Feature Requests

## Document Purpose
This document consolidates client requests for enhancements to the NQMS Assessment system. The goal is to conduct discovery to identify scope and requirements, which will inform the solution proposal and estimation.

---

## Discovery Session 1 Summary (Date of Meeting)

### Requests Reviewed: 5 of 5
### Status Summary:
- ✅ **IN SCOPE (Approved):** 4 requests
  - Request 1A: Print Assessment
  - Request 1B: Export Assessment (Priority)
  - Request 2A: Delete/Archive Assessments
  - Request 3: Goal Start Date & Target Completion Date
  - Request 4: Delete Goals
- ❌ **OUT OF SCOPE:** 1 request
  - Request 2B: Delete Programs (handled in Mentoring Connector)
- ⏸️ **PAUSED/NEEDS MORE DISCOVERY:** 1 request
  - Request 5: Section Goals (first topic for Session 2)

### New Requests Identified: 1
- 🆕 **Request 6: Assessment Goals Tab** - Add dedicated tab for viewing all program goals (visibility issue identified)

### Key Decisions Made:
1. **Export over Print:** Team identified export functionality as higher priority than print; export may replace print need entirely
2. **Soft Delete for Assessments:** Archive/soft delete approach for assessments (not permanent deletion); no restore needed
3. **No Program Deletion:** Program deletion stays in Mentoring Connector, not NQMS
4. **Goal Dates Added:** Both start date and target completion date will be added (optional fields, no automated reminders)
5. **Permanent Delete for Goals:** Goals will be permanently deleted (not soft delete) since use case is correcting data entry errors
6. **Assessment Detail Report Issues Identified:** Current export process is cumbersome; needs improvements (see related requests)

### Open Questions Requiring Answers:
1. **Export format:** CSV, PDF, Excel, or multiple options? (Request 1B)
2. **Print vs Export decision:** If PDF export implemented, is print (1A) still needed?
3. **Goal permissions:** Confirm current access levels for goal add/edit to match for delete
4. **Date validation:** Should target date validation require it to be after start date?
5. **Visual indicators:** Should overdue goals have visual warnings on dashboard?
6. **Section Goals:** Need to determine if keeping, fixing, or removing (Session 2)

### Items Covered in Session 2:
1. ✅ **Section Goals (Request 5)** - DECISION MADE: Remove section goals entirely
2. ✅ **Export Assessment (Request 1B)** - DECISION MADE: Add export button to assessment details page with CSV format
3. 🆕 **Assessment Goals Tab (Request 6)** - IDENTIFIED: Need dedicated tab for goal visibility (discussed at line 243)

### Items Still Pending (Future Sessions):
1. **Request 6: Assessment Goals Tab** - Confirm requirements for new tab (data scope, filtering, layout)
2. **Assessment Detail Report Improvements** - Filtering, search, export layout
3. **Assessment Snapshot** - What metrics/data to display (may relate to Request 6)
4. **Documents Requests** - Not yet covered
5. **Reports Requests** - Not yet covered
6. **New NQMS Section** - Not yet covered

### Readiness for Sizing:
**Ready to Size:**
- Request 2B (Out of scope - no sizing needed)
- Request 4 (Delete Goals - clear requirements, can size)

**Need Minor Clarification Before Sizing:**
- Request 1A (Print) - Depends on whether still needed after export decision
- Request 1B (Export) - Need format decision (CSV/PDF/Excel)
- Request 2A (Archive Assessments) - Clear requirements, minor UI details
- Request 3 (Goal Dates) - Clear requirements, decision on optional visual enhancements

**Need Full Discovery Before Sizing:**
- Request 5 (Section Goals) - Major decision needed on keep/remove/fix
- Assessment Detail Report (not yet fully discussed)
- Documents, Reports, New NQMS Section (not yet discussed)

---

## Request 1A: Add "Print Assessment" Functionality

**Status:** IN SCOPE - APPROVED
**Priority:** TBD (to be prioritized with other requests)

### Description
Add a "Print Assessment" option at the top of individual assessments that allows users to print the assessment directly from their browser.

### Problem Statement
Programs need to be able to print off their self-assessment for their records. Currently, printing the assessment from the "view assessment" window doesn't work properly.

### Addresses
- Inability for a program to print off their self-assessment for their records
- Current print functionality doesn't work because all accordions do not open at the same time for printing
- Program staff need to print by accordion (manual, time-consuming process)

### Current Issues
- Printing from the "view assessment" window requires all accordions to be manually expanded
- No print-friendly view available
- Manual process is time-consuming and error-prone

### Meeting Decisions (Session 1)

**Key Decisions:**
1. **Format:** Browser print-to-PDF functionality (not direct PDF export)
2. **All sections/accordions:** Will be automatically expanded for printing
3. **Branding:** Include MENTOR logo and cover sheet with branding
4. **Page breaks:** Each section (A, B, etc.) should print to a new page
5. **Content included:** Questions, ratings, and comments
6. **Goals:** NOT included in print view (goals are set after assessment in most cases)
7. **Access/Permissions:** Follow existing access - whoever can view the assessment can print it

**Why Needed:**
- Tim requested print pricing to potentially provide a PDF copy to programs
- Mike mentioned programs sometimes want a "nice-looking copy" of their submission
- Sarah mentioned sending exports to programs currently, but print/PDF might be useful
- Use case: Programs want to see what they rated themselves before filling out assessment again 3 years later

**Open Questions:**
- Do we actually need print if we improve the export functionality? (Sarah expressed uncertainty about needing print)
- Would an improved assessment detail report export replace the need for print?

### Discovery Questions (Aligned with CSS Print Solution)

1. **Print Layout & Content:**
   - Should all sections/accordions be automatically expanded for printing? *(Recommended: Yes)*
   - What branding elements should appear? (MENTOR logo, program name, dates)
   - Should page breaks be controlled to avoid breaking questions across pages?
   - Should all assessment data be included (questions, ratings, comments, evidence)?
   - Should goals associated with the assessment be included?

2. **Styling & Presentation:**
   - What header/footer text should appear on each page?
   - Should different assessment sections have visual separators?
   - Are there specific print formatting requirements (margins, font sizes)?
   - Should color or grayscale be used for ratings/indicators?

3. **Access & Permissions:**
   - Confirm: Users who can view an assessment can also print it (using existing permissions)?
   - Should there be any restrictions on when printing is available (after submission only vs. anytime)?

4. **Button Placement:**
   - Where should the "Print" button be located in the assessment view?
   - What should the button text be? ("Print Assessment", "Print", "Print View"?)

### Recommended Solution (Budget-Friendly)

**Approach: CSS-based Print Styling with JavaScript Enhancement**

**Implementation:**
1. **Add print-specific CSS** using `@media print` queries in existing ThemeAdmin SCSS
   - Auto-expand all accordions for print
   - Hide navigation, buttons, and non-essential UI elements
   - Add page break controls to prevent awkward breaks
   - Include MENTOR branding in header/footer

2. **Add "Print" button** to assessment view template
   - Simple JavaScript that calls `window.print()`
   - No new controller action needed
   - Button placed in assessment header next to existing actions

3. **Leverage existing authorization**
   - Use current `RequestPolicy` rules from `config/request_policy_configs.php`
   - If user can view assessment, they can print it
   - No additional permission logic needed

**Benefits:**
- **Low cost**: Primarily CSS changes with minimal JavaScript
- **No server-side processing**: Uses browser's native print capability
- **No new dependencies**: Uses existing Twig templates and SCSS structure
- **Maintains existing code**: Works with current accordion component

**Files to Modify:**
- `plugins/NQMS/templates/Admin/Assessments/view.twig` - Add print button
- `plugins/ThemeAdmin/webroot/assets/scss/partials/_print.scss` - New print styles
- Minimal JavaScript in existing assessment view

**Technical Considerations:**
- Works with all modern browsers (Chrome, Firefox, Safari, Edge)
- No server load impact
- Maintains WCAG compliance
- Can be extended later for more control if needed

---

## Request 1B: Add "Export Assessment" Functionality

**Status:** IN SCOPE - APPROVED (Priority over Print)
**Priority:** High - More critical than print functionality

### Description
Add an "Export Assessment" button to the Assessment Details page that allows users to download a single program's assessment data in CSV format directly from the assessment view.

### Problem Statement
Both programs and affiliate users need to be able to export assessments after they are submitted. Currently, exporting can be done through the assessment details report, but it is very difficult to do so.

### Addresses
- Inability for programs to export their self-assessment for their records
- Inability for affiliates to export a program's results from that program's assessment
- Current export process through assessment details report is cumbersome
- Need for offline access and archival of assessment data
- Need for direct export from assessment view page

### Current Issues
- Export functionality exists via assessment details report but is difficult to use
- No direct export option from the assessment view
- Must navigate to separate report page to export
- Assessment detail report is difficult to filter by program

### Meeting Decisions (Session 1)

**Key Decisions:**
1. **Export is the priority** - Team decided export functionality may be more valuable than print
2. **Current workflow:** Sarah currently exports from assessment detail report, then copies/pastes into a template
3. **Current format:** CSV export with questions, ratings, and comments
4. **Shared with programs:** Exports are currently shared with programs in existing workflow
5. **Assessment Detail Report issues:**
   - Very difficult to filter down to a single program
   - Can only search by date (no search by affiliate or program name)
   - Export layout is difficult to use (questions as rows instead of columns)

**Relationship to Print (1A):**
- Export may replace the need for print functionality entirely
- If export generates PDF or printable format, print feature becomes less necessary
- Sarah expressed she's "never tried to print" and uses export instead
- Mike acknowledged export might be "sufficient" and print might not be needed

### **Meeting Decisions (Session 2) - FINAL REQUIREMENTS**

**Key Decision: Add "Export Assessment" Button to Assessment Details Page**
- Button will be added directly to the assessment view page (where user views individual program assessment)
- One-click download of assessment data for that specific program
- CSV format (matches existing export format from assessment detail report)
- No need to navigate to separate report page

**Export Location & UI:**
1. **Button Placement:** Assessment Details page (same page where user views individual assessment)
2. **Button Label:** "Export Assessment" or "Download CSV"
3. **Action:** Downloads CSV file immediately when clicked
4. **No additional navigation required:** Export happens from current page

**CSV Export Format & Data Structure:**

Based on sample file: `single_program_assessment_details__with_goals_2025-10-22T20_37_22.155026625Z.csv`

**Required Columns (in this order):**
1. `assessment_name` - Name/title of the assessment (e.g., "2025 Self-Assessment")
2. `assessment_created_date` - Date assessment was created (e.g., "April 1, 2025, 8:08 PM")
3. `submitted_for_review_date` - Date assessment was submitted (e.g., "June 2, 2025")
4. `program_id` - Program ID number (e.g., "161,214")
5. `program_title` - Program name (e.g., "18 Degrees Mentoring")
6. `section_title` - Assessment section name (e.g., "A. Mentoring Program Design and Implementation")
7. `question_text` - Full text of the assessment question
8. `question_rating` - Rating value (1-5)
9. `question_notes` - Comments/notes entered for the question
10. `section_average_rating` - Calculated average rating for the section
11. `goals_set` - Whether goals are set for this question ("Yes - Question Goal" or "No")
12. `question_goal_name` - Name/title of the goal (if goal exists)
13. `question_goal_baseline_rating` - Baseline rating for the goal (if goal exists)
14. `question_goal_target_rating` - Target rating for the goal (if goal exists)
15. `question_goal_achieved_rating` - Achieved rating for the goal (if goal exists, may be empty)
16. `question_goal_status` - Status of the goal (e.g., "Goal Not Evaluated", "Goal Achieved", etc.)

**Data Rules:**
1. **One row per question** - Each assessment question is a separate row
2. **Assessment metadata repeated** - Columns 1-5 (assessment info) are repeated on every row
3. **Section info repeated** - Section title and average are repeated for all questions in that section
4. **Empty fields** - If no goal exists for a question, goal columns (11-16) should be empty/blank
5. **Multiple goals** - If a question has multiple goals, each goal should be a separate row (duplicate question row with different goal data)
6. **Date format** - "Month Day, Year, Time" format (e.g., "April 1, 2025, 8:08 PM")
7. **Section average** - Calculated across all questions in the section

**File Naming Convention:**
- Format: `single_program_assessment_details__with_goals_{timestamp}.csv`
- Timestamp: ISO 8601 format with timezone (e.g., `2025-10-22T20_37_22.155026625Z`)
- Ensures unique filename for each download
- Clear indication this is a single program export

**Access & Permissions:**
- **Who can export:** Anyone who can view the assessment can export it
- Same permission level as viewing the assessment (existing `RequestPolicy` rules)
- NQMS staff (reviewers/affiliates) can export any program assessment they can view
- Program end users can export their own assessment (if they have view access)

**Export Behavior:**
1. User clicks "Export Assessment" button on assessment details page
2. System generates CSV file with all data for that specific assessment
3. CSV file downloads immediately to user's browser default download location
4. No page refresh or navigation
5. User remains on assessment details page after export completes

**Integration with Existing Export:**
- This does NOT replace the assessment detail report export
- This supplements the existing report by providing quick single-program export
- Assessment detail report can still be used for multi-program exports
- Both export formats should match (same columns, same data structure)

**Benefits:**
- **Faster workflow:** No need to navigate to separate report page
- **Fewer clicks:** Direct export from assessment view
- **No filtering needed:** Export is already filtered to single program
- **Better UX:** Intuitive location for export button
- **Maintains existing format:** Uses proven CSV structure that Sarah already uses

### Recommended Solution (Budget-Friendly)

**Approach: CSV Export Using CakePHP Built-in Functionality**

**Implementation:**
1. **Add "Export Assessment" button** in assessment view page
   - New controller action: `AssessmentsController::exportCsv($id)`
   - Fetches assessment data with all questions, ratings, comments, and goals
   - Generates CSV using CakePHP's built-in CSV response type
   - Returns CSV as immediate download

2. **Reuse authorization layer**
   - Same permissions as viewing assessment
   - No new policy rules needed
   - Existing role-based access control applies

3. **CSV generation logic**
   - Query assessment with related questions, sections, and goals
   - Build rows following the 16-column structure (see CSV Export Format above)
   - Handle multiple goals per question (duplicate rows)
   - Calculate section averages
   - Format dates consistently

4. **Standard file naming**
   - Format: `single_program_assessment_details__with_goals_{timestamp}.csv`
   - ISO 8601 timestamp with timezone
   - Unique filename for each download

**Benefits:**
- **Very low cost**: Uses native CakePHP CSV response
- **No new dependencies**: No libraries or plugins needed
- **Proven format**: Matches existing export structure that users already use
- **Simple maintenance**: Standard query and CSV generation
- **Fast performance**: Lightweight CSV generation

**Files to Modify:**
- `plugins/NQMS/src/Controller/Admin/AssessmentsController.php` - Add `exportCsv()` action
- `plugins/NQMS/templates/Admin/Assessments/view.twig` - Add export button
- Minimal changes to existing code

**Technical Considerations:**
- CakePHP has built-in CSV response type (no external libraries needed)
- Query optimization for fetching related data (questions, goals)
- CSV escaping handled automatically by CakePHP
- Memory efficient for typical assessment sizes
- Can reuse existing query logic from assessment detail report

---

## Request 2A: Allow Global Admins to Delete Assessments

**Status:** IN SCOPE - APPROVED (Archive/Soft Delete)
**Priority:** Medium

### Description
Allow Global Admins and Affiliate Staff the ability to archive individual assessments from the system.

### Problem Statement
Need the ability to remove invalid, test, or duplicate assessment records. This is specifically about deleting **assessments** (the evaluation submissions), not the programs themselves.

### Addresses
- Test/invalid assessment data showing up in reports and dashboards
- Duplicate assessments created by error
- Old assessment versions that need to be removed after data cleanup
- Half-finished assessments when programs abandon the process mid-stream

### Current Issues
- No way to remove individual assessment records from the system
- Test assessment data pollutes reports and dashboards
- Cannot clean up duplicate or erroneous assessment submissions
- Nikki's original test assessments still show in reports

### Use Cases
- Delete test assessments created during system testing or training (e.g., "test one" assessments in system)
- Remove duplicate assessments created by user error
- Clean up invalid assessments from data migration issues
- Archive assessments when program abandons process mid-stream (person leaves, org decides not to complete)

### Notes
- This is about deleting assessment records, not programs
- Assessments can be submitted multiple times per program
- A confirmation pop-up should be added with clear warning about data removal

### Meeting Decisions (Session 1)

**Key Decisions:**
1. **Soft Delete (Archive) - NOT Permanent Delete:** Assessment will be marked as archived/inactive, NOT permanently deleted from database
2. **No Restore Needed:** Team agreed restore functionality is not necessary - archived assessments will stay archived
3. **No Visibility After Archive:** Archived assessments will NOT be visible anywhere (no "view archived" page needed)
4. **No Reporting on Archived:** Archived assessments will NOT be included in any reports or exports
5. **Data Preservation:** Archived assessment data will be kept in the database but hidden from all queries
6. **Permanent Purge:** If data truly needs to be permanently deleted, Oasis can run manual delete scripts upon request

**Access & Permissions:**
- **Who Can Archive:** Global Admins AND Affiliate Staff (NOT program end users)
- **Reasoning:** Affiliate reviewers (like Sarah in Colorado) should be able to archive assessments for programs they work with when program goes under or abandons process
- **Similar to:** Same permission level as "Launch Assessment" functionality

**UI Placement:**
- Archive button will be on the Assessment View page
- Confirmation modal with warning: "Are you sure?" with Yes/No options
- After archiving, user is redirected back to Program Detail page

**Use Case - Primary Scenario:**
- Program starts assessment process, begins filling it out
- Program abandons process (staff leaves, org changes direction, program closes)
- Half-done "dead assessment" sits in system
- Reviewer (Sarah/affiliate staff) archives it to clean up data
- Archived assessment no longer appears in reports or dashboards

**Use Case - Secondary Scenario:**
- Test assessments created during system testing/training
- Global admin archives test data to clean up reports

**Important Distinction:**
- **Inactive Program:** A program that has completed assessment(s) but is now closed/out of business should NOT have assessments archived - that's historical data to preserve
- **Dead Assessment:** An incomplete, abandoned assessment that was never finished - THIS is what gets archived

**Open Questions:**
- Should there be a reason field in the confirmation modal? (Team leaned toward NO to keep it simple)

### Discovery Questions (Aligned with Soft Delete Solution)

1. **Clarification:**
   - Confirm: This is about deleting assessment records, not program records? *(Need to clarify with client)*
   - Can a program have multiple assessments, and do you want to delete individual assessment submissions?
   - What happens to a program when its assessment(s) are deleted? (Program remains, just loses assessment data?)

2. **Permissions & Access:**
   - Confirm: Only Global Admins should have delete/restore access?
   - Should there be different permissions for delete vs. restore?

3. **Confirmation & Audit:**
   - What information should appear in the delete confirmation modal? (assessment details, program name, submission date)
   - Should a reason field be required, optional, or not included in the confirmation?
   - Should we track who deleted the assessment and when? *(Recommended: Yes)*

4. **Related Data:**
   - Confirm: Goals, documents, and other data linked to the assessment should be preserved (not deleted)?
   - Should soft-deleted assessments still be viewable by Global Admins?

5. **Recovery Process:**
   - Should there be a "Deleted Assessments" view for Global Admins to see what was deleted?
   - Should there be a "Restore" button to undelete assessments?
   - Should there be an automatic permanent deletion after a retention period (e.g., 90 days)?

6. **UI Placement:**
   - Where should the "Delete Assessment" button be located? (assessment view page only, or also in list view?)
   - What should the button text be? ("Delete Assessment", "Remove Assessment"?)

### Recommended Solution (Budget-Friendly)

**Approach: Soft Delete with Archive Status (Preferred)**

**Implementation:**
1. **Add `deleted` timestamp column** to assessments table
   - Migration to add `deleted` datetime field (nullable)
   - Use CakePHP's built-in soft delete behavior
   - Assessments with `deleted` value are hidden from queries by default

2. **Update authorization rules**
   - Add new route in `config/request_policy_configs.php`
   - Restrict delete action to `global` role only
   - Simple authorization check in controller

3. **Add delete functionality**
   - Add "Delete Assessment" button on assessment view (global admins only)
   - Confirmation modal with warning message and reason field
   - `AssessmentsController::delete($id)` action sets `deleted` timestamp
   - Log deletion in audit trail (user, reason, timestamp)

4. **Update queries throughout application**
   - Add global scope to exclude soft-deleted assessments
   - Use CakePHP's `find()` conditions or global query modifier
   - Reports, dashboards, lists automatically exclude deleted items

5. **Optional: Admin recovery interface**
   - Simple list view of deleted assessments (global admins only)
   - "Restore" button to undelete (sets `deleted` to null)
   - Permanent delete after 90 days (cron job)

**Benefits:**
- **Safe**: Data can be recovered if deleted by mistake
- **Low risk**: No actual data loss, just visibility change
- **Clean reports**: Deleted assessments automatically excluded
- **Audit trail**: All deletions logged with reason
- **Simple implementation**: Leverages CakePHP conventions
- **No cascading issues**: Related data preserved

**Files to Modify:**
- `config/Migrations/` - New migration for `deleted` column
- `plugins/NQMS/src/Model/Table/AssessmentsTable.php` - Add soft delete behavior
- `plugins/NQMS/src/Controller/Admin/AssessmentsController.php` - Add delete action
- `config/request_policy_configs.php` - Add delete permission for global role
- `plugins/NQMS/templates/Admin/Assessments/view.twig` - Add delete button
- Modal template for delete confirmation

**Database Changes:**
```sql
ALTER TABLE assessments ADD COLUMN deleted DATETIME NULL DEFAULT NULL;
ALTER TABLE assessments ADD INDEX idx_deleted (deleted);
```

**Technical Considerations:**
- Soft delete is industry best practice for data integrity
- Can add `deleted_by` and `delete_reason` fields for audit
- Restore functionality is trivial (set deleted = NULL)

**Alternative: Hard Delete (Not Recommended)**
- Permanently remove records from database
- Must handle cascade deletes for related data (goals, documents, etc.)
- Higher risk, cannot undo
- Same effort but more dangerous
- Only consider if storage cost is critical concern

**Hybrid Approach:**
- Soft delete + permanent cleanup after retention period (e.g., 90 days)
- Automated cron job: `bin/cake cleanup_deleted_assessments`
- Best of both worlds

---

## Request 2B: Allow Global Admins to Delete Programs

**Status:** OUT OF SCOPE - NOT NEEDED
**Priority:** N/A

### Description
Allow Global Admins the ability to delete program records from the system.

### Problem Statement
Test programs and programs no longer in operation show up in reports and dashboards, making it difficult to get accurate data for active programs. There is no way to remove these obsolete program records from the system.

### Meeting Decisions (Session 1)

**Key Decision: NOT DOING THIS**
- Tim confirmed: "I wouldn't do delete programs. That's a mentoring connector functionality. So we wouldn't do that in NQMS."
- Program deletion should be handled on the Mentoring Connector side, not NQMS side
- This request is being removed from scope

**Reasoning:**
- Programs exist in Mentoring Connector system
- Deleting programs has implications on the volunteer recruitment side
- Program status (active/inactive/paused) is managed in Connector
- NQMS should respect program status from Connector, not manage it independently

**Alternative Solution:**
- Programs that are inactive/closed will be marked as such in Mentoring Connector
- NQMS can respect that status when displaying programs in reports/dashboards
- Focus is on archiving assessments (Request 2A), not programs

### Addresses
- Test programs showing up in global and affiliate level dashboards and reports
- Programs that are no longer in operation being included in live data
- Programs that have merged with another organization creating duplicate records

### Current Issues
- No way to remove test or obsolete program records
- Test/inactive programs clutter reports and dashboards
- Cannot clean up programs that have merged or ceased operations

### Use Cases
- Delete test programs created during system testing or training
- Remove programs that are no longer in operation
- Clean up duplicate program records from mergers
- Remove invalid programs from data migration issues

### Notes
- This is about deleting **program** records (organizations), not assessments
- Programs may have multiple assessments and related data over time
- Need to preserve historical data while allowing cleanup

### Discovery Questions (Aligned with Soft Delete Solution)

1. **Clarification:**
   - Confirm: This is about deleting program records, not assessment records?
   - What happens to a program's assessments when the program is deleted? (Should they also be hidden?)
   - What happens to a program's associated data (users, documents, affiliates)?

2. **Permissions & Access:**
   - Confirm: Only Global Admins should have delete/restore access?
   - Should there be different permissions for delete vs. restore?

3. **Confirmation & Audit:**
   - What information should appear in the delete confirmation modal? (program name, number of assessments, associated users, warning)
   - Should a reason field be required, optional, or not included in the confirmation?
   - Should we track who deleted the program and when? *(Recommended: Yes)*

4. **Related Data:**
   - Should soft-deleted programs' assessments also be hidden?
   - Should soft-deleted programs' users still be able to log in?
   - Should affiliate relationships be preserved or removed?

5. **Recovery Process:**
   - Should there be a "Deleted Programs" view for Global Admins to see what was deleted?
   - Should there be a "Restore" button to undelete programs?
   - Should there be an automatic permanent deletion after a retention period (e.g., 90 days)?

6. **Reports & Dashboards:**
   - Confirm: Deleted programs should be excluded from all reports and dashboards by default?
   - Should Global Admins have an option to include deleted programs in reports if needed?

7. **UI Placement:**
   - Where should the "Delete Program" button be located? (program view page only, or also in list view?)
   - What should the button text be? ("Delete Program", "Remove Program"?)

### Recommended Solution (Budget-Friendly)

**Approach: Soft Delete for Programs**

**Implementation:**
1. **Add `deleted` timestamp column** to programs table
   - Migration to add `deleted` datetime field (nullable)
   - Use CakePHP's built-in soft delete behavior
   - Programs with `deleted` value are hidden from queries by default

2. **Update authorization rules**
   - Add new route in `config/request_policy_configs.php`
   - Restrict delete action to `global` role only
   - Simple authorization check in controller

3. **Add delete functionality**
   - Add "Delete Program" button on program view (global admins only)
   - Confirmation modal with warning message showing impact (# of assessments, users, etc.)
   - Reason field (optional) for audit trail
   - `ProgramsController::delete($id)` action sets `deleted` timestamp
   - Log deletion in audit trail (user, reason, timestamp)

4. **Update queries throughout application**
   - Add global scope to exclude soft-deleted programs
   - Programs plugin: Update all finders to exclude deleted programs
   - Reports plugin: Exclude deleted programs from all reports
   - Dashboard widgets: Exclude deleted programs
   - Assessments should also be hidden when their program is deleted

5. **Optional: Admin recovery interface**
   - Simple list view of deleted programs (global admins only)
   - Show program name, deletion date, deleted by, reason
   - "Restore" button to undelete (sets `deleted` to null)
   - Permanent delete after retention period (e.g., 90 days via cron job)

**Benefits:**
- **Safe**: Data can be recovered if deleted by mistake
- **Low risk**: No actual data loss, just visibility change
- **Clean reports**: Deleted programs automatically excluded
- **Audit trail**: All deletions logged with reason
- **Simple implementation**: Leverages CakePHP conventions
- **Cascading effect**: Program assessments automatically hidden

**Files to Modify:**
- `config/Migrations/` - New migration for `deleted` column
- `plugins/Programs/src/Model/Table/ProgramsTable.php` - Add soft delete behavior
- `plugins/Programs/src/Controller/Admin/ProgramsController.php` - Add delete action
- `config/request_policy_configs.php` - Add delete permission for global role
- `plugins/Programs/templates/Admin/Programs/view.twig` - Add delete button
- `plugins/NQMS/src/Model/Table/AssessmentsTable.php` - Update to respect program deletion
- `plugins/Reports/` - Update all queries to exclude deleted programs
- Dashboard widgets - Update queries to exclude deleted programs
- Modal template for delete confirmation

**Database Changes:**
```sql
ALTER TABLE programs ADD COLUMN deleted DATETIME NULL DEFAULT NULL;
ALTER TABLE programs ADD INDEX idx_deleted (deleted);

-- Optional audit fields
ALTER TABLE programs ADD COLUMN deleted_by INT NULL;
ALTER TABLE programs ADD COLUMN delete_reason TEXT NULL;
ALTER TABLE programs ADD FOREIGN KEY (deleted_by) REFERENCES users(id);
```

**Technical Considerations:**
- Soft delete is industry best practice for data integrity
- Program deletion should cascade to hide assessments (via query scope)
- Users associated with deleted programs may need special handling
- Restore functionality includes restoring visibility of all related data
- Consider impact on affiliate relationships

**Cascading Behavior:**
When a program is soft deleted:
- Program record is hidden
- All program assessments are hidden (query joins on non-deleted programs)
- Program users can still log in but may see "no programs" message
- Historical data is preserved but not visible in reports

**Alternative: Hard Delete (Not Recommended)**
- Permanently remove program and all related data
- Must handle cascade deletes for assessments, users, goals, documents, etc.
- Higher risk, cannot undo
- More complex and dangerous
- Only consider if storage cost is critical concern

---

## Request 3: Add Goal Start Date and Target Completion Date

**Status:** IN SCOPE - APPROVED
**Priority:** Medium-High

### Description
Add goal date tracking features including goal start date and target completion date.

### Problem Statement
Deadlines and targets for programs to work towards their goals identified in their Improvement & Innovation Plans are not currently captured in the system.

### Proposed Solution
- **Goal Start Date:** Auto-populated with the date the goal is added (date of goal creation), but editable by users
- **Target Completion Date:** Editable calendar field for user input
- **Target Rating:** Could be moved to align with Baseline Rating
- **Date Feature:** Added under the ratings section

### Addresses
- Deadlines and targets for programs not captured in the system
- Helps programs see their goals in a timeline versus one long list
- Helps spur the creation of additional reminders for affiliates to use with programs
- Supports the goal snapshot feature requested elsewhere

### Meeting Decisions (Session 1)

**Key Decisions:**
1. **Both Dates Included:** Start Date AND Target Completion Date will be added
2. **User-Editable:** Both dates are editable by users (not auto-locked to system date)
3. **Not Required Fields:** Dates are optional - can be left blank if program doesn't want to set specific dates
4. **No Automated Reminders:** System will NOT send automated email reminders based on dates (would add significant cost)
5. **Visual Indicator Only:** Dashboard could show visual indicators (e.g., red text for overdue goals), but no automated emails

**Use Case Discussion:**
- **Three-Year Process Clarification:** Goals are set annually, not for the full three-year period
  - Year 1: Set 3-5 goals, work on them for a year
  - End of Year 1: Review/update I&I plan, set new goals for Year 2
  - Year 2: Work on Year 2 goals
  - Year 3: Work on Year 3 goals, then redo full assessment
- **Quarterly Check-ins:** Sarah manually exports goals quarterly and emails programs to ask for updates
- **Timeline Visibility:** Some programs (Tim mentioned) might plan goals by quarter: "Goal 1 in Q1, Goal 2 in Q2," etc.
- **Reality Check:** Sarah noted most programs don't stick to specific timelines, so dates are helpful but not strictly enforced

**Goals vs. I&I Plan:**
- **I&I Plan (Improvement & Innovation Plan):** Broader document with potential goals for all 3 years
- **System Goals:** Narrowed down to 3-5 actionable goals for the current year
- **Strategy:** Don't put all I&I plan goals into system to avoid overwhelming programs with 20+ goals
- **Annual Review:** Update I&I plan annually, adjust system goals accordingly

**Access & Permissions:**
- **Current State:** Unclear if programs can currently edit their own goals
- **Mike's Preference:** Only reviewer staff should enter/edit goal data (not program end users)
  - Reasoning: Prevents programs from deleting goals they can't complete
  - Reviewer validates goal completion, not program self-reports
- **Tim's Perspective:** From build perspective, both reviewer AND program should have access (policy decision to restrict later if needed)
- **Decision:** Keep current access level as-is, just add date fields to existing add/edit goal forms

**Optional Enhancement Discussed:**
- **Dashboard Reminder Section:** On reviewer dashboard, show upcoming goal deadlines or overdue goals
  - Example: "Goal deadline approaching" or "Goal overdue by X days"
  - This is visual reminder, not automated email
  - May be included if budget allows, but not core requirement

**Open Questions:**
- Should there be validation that target date is after start date?
- Should overdue goals have visual indicators (red text, warning icon)?
- Should goal reports include these date columns?
- For existing goals, should we backfill start date with goal creation date?

### Discovery Questions (Aligned with Date Fields Solution)

1. **Date Field Behavior:**
   - Confirm: `start_date` should auto-populate with current date when goal is created (editable by users)?
   - Should `target_completion_date` be required or optional when creating/editing a goal?
   - Confirm validation: Target completion date must be after start date?
   - Can users edit both start date and target completion date after goal creation?

2. **Existing Goals Backfill:**
   - For existing goals without a start date, should we backfill with the goal's `created` timestamp?
   - Should existing goals require a target completion date to be added, or can it remain null?

3. **Display & Sorting:**
   - Should the goals list/table include date columns (start date, target date, days remaining)?
   - Should goals be sortable/filterable by target date?
   - Should overdue goals have a visual indicator (red text, icon, badge)?

4. **Reminders (Optional Feature):**
   - Should reminder emails be sent when goals are approaching target date?
   - If yes, how many days before target date? *(Recommended: 7 days)*
   - Who should receive reminders? (program user, affiliate, or both?)
   - Should reminders use the existing `Programs.reminder_notifications` cron system?

5. **Reports:**
   - Should goal reports include start date and target completion date columns?
   - Should reports show calculated fields like "days until target" or "overdue by X days"?
   - Any other date-related metrics needed in reports?

6. **Date Format & Display:**
   - What date format should be used in the UI? (MM/DD/YYYY, YYYY-MM-DD, or other?)
   - Should dates display as absolute dates or relative ("5 days ago", "in 10 days")?

### Recommended Solution (Budget-Friendly)

**Approach: Add Date Fields to Goals Table with Minimal UI Changes**

**Implementation:**
1. **Database changes**
   - Add `start_date` (date, nullable) to goals table
   - Add `target_completion_date` (date, nullable) to goals table
   - Create migration with backfill logic for existing goals
   - Backfill `start_date` from goal's `created` timestamp for existing goals

2. **Update goal creation/edit form**
   - Add `start_date` field (HTML5 date picker, auto-populated with current date, editable)
   - Add `target_completion_date` field (HTML5 date picker)
   - Auto-populate `start_date` with current date on goal creation
   - Both fields editable and display in goal details section
   - Simple date validation (target must be after start)

3. **Enhance goal display**
   - Add date columns to goals list/table
   - Show days until target date (calculated field)
   - Visual indicator for overdue goals (simple CSS class)
   - Filter/sort by target date

4. **Update reports**
   - Include dates in existing goal reports
   - Add date columns to goal exports
   - No new reports needed initially

5. **Optional: Basic reminders**
   - Leverage existing reminder system (`Programs.reminder_notifications` command)
   - Add goal deadline checks to existing cron
   - Email when goals approaching target date (7 days before)

**Benefits:**
- **Simple implementation**: Basic CRUD field additions
- **Reuses existing infrastructure**: Forms, validation, date pickers
- **Backwards compatible**: Nullable fields don't break existing data
- **Low risk**: No complex business logic
- **Timeline visibility**: Users can sort/filter by dates
- **Foundation for future**: Can add timeline view later

**Files to Modify:**
- `config/Migrations/` - Add date columns to goals table
- `plugins/Programs/src/Model/Table/GoalsTable.php` - Add validation for date fields
- `plugins/Programs/src/Controller/Admin/GoalsController.php` - Handle date fields in add/edit
- `plugins/Programs/templates/Admin/Goals/add.twig` - Add date input fields
- `plugins/Programs/templates/Admin/Goals/edit.twig` - Add date input fields
- `plugins/Programs/templates/Admin/Goals/index.twig` - Add date columns to table
- `plugins/Programs/templates/Admin/Goals/view.twig` - Display dates
- `plugins/Reports/` - Update goal reports to include dates

**Database Changes:**
```sql
ALTER TABLE goals ADD COLUMN start_date DATE NULL;
ALTER TABLE goals ADD COLUMN target_completion_date DATE NULL;

-- Backfill start dates from goal creation date
UPDATE goals
SET start_date = DATE(created)
WHERE created IS NOT NULL;
```

**Technical Considerations:**
- Use HTML5 `<input type="date">` for browser-native date picker
- Server-side validation to ensure target > start
- Can add `completed_date` later to track actual completion
- Consider timezone handling (store as date, not datetime)

**Future Enhancements (Phase 2, if budget allows):**
- **Timeline/calendar view**: Visual representation of goals
- **Advanced reminders**: Configurable reminder schedules
- **Progress tracking**: Percentage complete, on-track indicators
- **Dashboard widget**: Upcoming deadlines, overdue goals

**MVP Approach (Even More Budget-Friendly):**
- Only add `target_completion_date` field initially
- Skip `start_date` (can derive from goal `created` timestamp when needed)
- No reminders initially

---

## Request 4: Allow Global Admins to Delete or Mark Goals as Inactive

**Status:** IN SCOPE - APPROVED (Delete, Not Soft Delete)
**Priority:** Medium

### Description
Allow Global Admins and Affiliate Staff the ability to delete goals from the system.

### Problem Statement
There is currently no way to delete goals in the system. This creates issues when:
- Goals are created incorrectly (e.g., section goal created when it should be a question goal)
- Goals are moved/consolidated and duplicates need to be removed
- Goals are no longer relevant but cannot be removed from the system

### Use Case Example
An affiliate created a section goal for a program that was later tied to a specific question in the assessment. The goal was moved to the question level, but the original section goal cannot be deleted and continues to appear in the system.

### Addresses
- Inability to remove incorrect or duplicate goals
- Goals showing in reports and exports that should not be included
- Data cleanup and accuracy

### Meeting Decisions (Session 1)

**Key Decisions:**
1. **Permanent Delete (NOT Soft Delete/Archive):** Goals will be permanently deleted from the database when removed
2. **Reasoning:** Use cases are data entry errors (wrong question, duplicate goal, etc.) - no need to preserve erroneous data
3. **Confirmation Modal:** "Are you sure?" confirmation before deletion to prevent accidental deletions
4. **No Restore:** Once deleted, goal cannot be restored (unless Oasis runs manual database restore)

**Access & Permissions:**
- **Who Can Delete:** Whoever can add/edit goals can delete them
- **Current Access:** Unclear if programs can edit goals, but Mike indicated only NQMS staff (reviewers/affiliates) should have this access
- **Action Item:** Confirm current permission level and maintain it for delete functionality

**Use Cases:**
1. **Wrong Question:** Goal created for question A but should have been for question B → Delete and recreate
2. **Section Goal Migration:** Section goal needs to be converted to question goal → Delete section goal, create new question goal
3. **Duplicate Entry:** Accidentally created same goal twice → Delete duplicate
4. **Data Entry Error:** Goal created with wrong information → Delete and start over

**Important Notes:**
- This is NOT about programs changing their mind about goals they can't complete
- This is about correcting data entry mistakes and system errors
- Mike and Sarah emphasized this is for reviewer/affiliate use, not program end users
- Programs should NOT be deleting their own goals to game completion rates

**Why NOT Soft Delete:**
- Goals are relatively small data objects
- Use case is correcting mistakes, not preserving history of abandoned goals
- Simpler implementation than soft delete
- Less confusion than having "inactive" goals floating around

**UI Placement:**
- Delete button on goal view/edit page (same access level as add/edit)
- Confirmation modal with clear warning about permanent deletion

**Open Questions:**
- Confirm exact current permission level for goal add/edit (to match for delete)
- Should there be a reason field? (Team leaning NO to keep simple)

### Discovery Questions (Aligned with Status Field Solution)

1. **Status Field Behavior:**
   - Confirm: Use `status` field with values 'active', 'inactive', 'completed'?
   - Should inactive goals be completely hidden from normal views, or shown but grayed out?
   - Should Global Admins see inactive goals with a special indicator?

2. **Permissions:**
   - Confirm: Only Global Admins can mark goals as inactive/reactivate them?
   - Should there be different permissions for inactivate vs. reactivate?

3. **Inactivation Process:**
   - Should there be a confirmation modal when marking a goal as inactive?
   - Should a reason field be included (required, optional, or not at all)?
   - Should we track who inactivated the goal and when? *(Recommended: Yes, via `modified` timestamp)*

4. **Viewing Inactive Goals:**
   - Should there be a separate "Inactive Goals" view for Global Admins?
   - Or should there be a filter/dropdown on the main goals page (Show: Active | Inactive | All)?
   - Should inactive goals still be viewable in goal detail view if accessed directly?

5. **Impact on Reports & Dashboards:**
   - Confirm: Inactive goals should be excluded from all reports and dashboard calculations?
   - Should reports have an option to include inactive goals if needed?

6. **Reactivation:**
   - How should goals be reactivated? (Change status back to 'active' via edit form, or dedicated "Reactivate" button?)
   - Should reactivation require a confirmation?

7. **Integration with Section Goals Fix (Request 5):**
   - Can this status feature help clean up problematic section goals?
   - Should section goals that are incorrectly marked complete be bulk-inactivated?

### Recommended Solution (Budget-Friendly)

**Approach: Add "Inactive" Status (Soft Delete for Goals)**

**Implementation:**
1. **Add `status` field** to goals table
   - Migration to add `status` enum field (default: 'active')
   - Values: 'active', 'inactive', 'completed'
   - Existing goals default to 'active'
   - 'completed' status already may exist; if not, add it

2. **Update goal queries**
   - Add scope to filter out inactive goals by default
   - Use `$query->where(['status' => 'active'])` in table finder methods
   - Reports and exports exclude inactive goals
   - Dashboard calculations skip inactive goals

3. **Add inactivate functionality**
   - Add "Mark as Inactive" button on goal view (global admins only)
   - Confirmation modal with reason field (optional, for audit)
   - `GoalsController::inactivate($id)` action updates status
   - Can be reactivated by changing status back to 'active'

4. **Update authorization**
   - Add route to `config/request_policy_configs.php` for inactivate action
   - Restrict to `global` role
   - Simple permission check in controller

5. **Optional: Inactive goals view**
   - Separate view for global admins to see inactive goals
   - Filter on goals index page: "Show: Active | Inactive | All"
   - "Reactivate" button to restore goals

**Benefits:**
- **Safe**: Goals can be restored easily
- **Simple**: Just a status field change
- **Clean**: Inactive goals hidden from all views/reports
- **Audit-friendly**: Can see what was inactivated and when
- **Minimal changes**: Leverages existing CakePHP query patterns
- **No data loss**: All information preserved

**Files to Modify:**
- `config/Migrations/` - Add `status` column to goals table
- `plugins/Programs/src/Model/Table/GoalsTable.php` - Add default scope to exclude inactive
- `plugins/Programs/src/Controller/Admin/GoalsController.php` - Add inactivate/reactivate actions
- `config/request_policy_configs.php` - Add permission for global role
- `plugins/Programs/templates/Admin/Goals/view.twig` - Add inactivate button
- `plugins/Programs/templates/Admin/Goals/index.twig` - Add status filter dropdown

**Database Changes:**
```sql
ALTER TABLE goals
ADD COLUMN status ENUM('active', 'inactive', 'completed')
DEFAULT 'active' NOT NULL;

-- Optional: Add index for better query performance
ALTER TABLE goals ADD INDEX idx_status (status);
```

**Technical Considerations:**
- Use enum or varchar for status field
- Consider adding `inactivated_at` timestamp and `inactivated_by` user_id for audit
- Can add `inactive_reason` text field if detailed tracking needed
- Reactivation is simple status update (no special logic)

**Alternative Approach: Hard Delete**
- Add true delete functionality
- Must handle cascade (what happens to goal updates, history?)
- Cannot undo
- Same effort but riskier
- Not recommended unless storage is critical concern

**Why Status Over Soft Delete:**
- Goals are smaller data objects than assessments
- Status allows for multiple states beyond just active/inactive
- 'completed' status may already exist in the system
- More semantically clear than `deleted` timestamp
- Easier to filter and report on

**Integration with Request 5 (Section Goals Fix):**
- This solution works for both question goals and section goals
- Fixes incomplete section goals by allowing them to be inactivated
- Can bulk-inactivate problematic section goals during fix implementation

---

## Request 5: Address Section Goals - Remove or Fix

**Status:** IN SCOPE - APPROVED (Delete Section Goals)
**Priority:** Medium

### Description
Remove section goals capability entirely. Section goals are causing issues in the system and are not needed. Existing section goals should be deleted (permanently) and the ability to create new section goals should be removed from the UI.

### Problem Statement
Section goals are causing issues in the system and are not necessary. Problems include:
- No way to identify if section goals are completed or not
- Section goals can show up as "complete" even when they are not
- Section goals don't show up in the goals report
- Section goals show as complete on the assessment status dashboard when they shouldn't
- Users may be confused about when to use section goals vs. question goals
- Affiliates want to convert section goals to question goals but can't delete the original section goal

### Addresses
- Removal of section goals feature (not needed)
- Inconsistent goal tracking between section and question goals
- Inaccurate completion status on dashboards
- Missing data in goal reports
- Data cleanup for existing section goals
- Inability to delete problematic section goals

### Meeting Decisions (Session 1)

**Status:** NOT DISCUSSED IN SESSION 1 - Ran out of time
- Team ran out of time at 1:19:57 (meeting end)
- Oksana noted: "Let's pause here and resume on Wednesday starting with section goals"
- This is the first item for Session 2 (Wednesday)

**Pre-Discussion Context from Session 1:**
- Mike mentioned section goals briefly during goal deletion discussion (around 1:18:08)
- **Key quote from Mike:** "I think this originally came up because we wanted to get rid of the section goals and couldn't delete them."
- Example use case: Affiliate created section goal, later wanted to convert to question goal, couldn't delete the section goal
- This indicates section goals ARE being used but causing confusion and need to be removed

### **Meeting Decisions (Session 2) - DECISION MADE**

**Key Decision: REMOVE SECTION GOALS ENTIRELY**
- Client confirmed they want to remove section goals feature
- Section goals are not needed and cause more problems than they solve
- Existing section goals should be permanently deleted from the system
- UI option to create section goals should be removed

**Data Cleanup:**
1. **Permanent Delete:** All existing section goals will be permanently deleted (hard delete, not soft delete)
2. **Reasoning:** Section goals are problematic data that shouldn't have been created in the first place; no value in preserving
3. **Migration:** Data migration script will remove all section goals from database
4. **No Conversion:** Section goals will NOT be converted to question goals (too complex, not worth effort)

**UI Changes:**
1. **Remove "Add Section Goal" option** from goal creation interface
2. **Prevent future section goals:** Update code to prevent section goals from being created
3. **Simplify goal logic:** System will only support question goals going forward

**Access & Permissions:**
- No permission changes needed (feature removed entirely)
- All users will only be able to create question goals

**Implementation Approach:**
1. Count existing section goals (data analysis query)
2. Notify affected users before deletion (if any exist)
3. Run migration to permanently delete section goals
4. Remove section goal UI options
5. Clean up codebase (remove section goal logic from controllers, views, reports)
6. Update documentation to reflect question goals only

**Benefits of Removal:**
- **Simplifies system:** One goal type instead of two
- **Fixes completion status bugs:** No more incorrect "complete" markers
- **Cleaner reports:** All goals follow same structure
- **Less user confusion:** Clear choice (question goals only)
- **Easier maintenance:** Less code to maintain

**Related to Request 4 (Delete Goals):**
- Request 4 allows manual deletion of individual goals
- Request 5 is bulk removal of section goal feature entirely
- Both work together: Request 5 cleans up existing section goals, Request 4 handles future goal deletions (for question goals only)

### Discovery Questions (Decision-Based Approach)

**Critical Decision Questions (Must Answer First)**

1. **Feature Decision:**
   - **Does the client want to keep section goals functionality, or remove it entirely?**
   - Are section goals being used actively by programs and affiliates?
   - Is there a valid use case for section goals vs. question goals?
   - If removed, what should happen to existing section goals?

2. **Current State Analysis:**
   - How many section goals currently exist in the system?
   - How many are actively being used vs. abandoned/problematic?
   - Which programs/affiliates are using section goals?
   - How many are incorrectly showing as "complete"?

**If Decision: Remove Section Goals Entirely**

3. **Removal Approach:**
   - Should existing section goals be deleted (soft delete with status='inactive')?
   - Should existing section goals be converted to question goals?
   - Should users be notified before section goals are removed/converted?
   - Should the UI option to create section goals be removed?

4. **Data Migration:**
   - If converting to question goals, which question should each section goal be associated with?
   - Should conversion be automatic or require manual review?
   - What happens to section goals that cannot be easily converted?

**If Decision: Keep Section Goals and Fix Issues**

5. **Root Cause Discovery:**
   - What is the technical difference between how section goals and question goals are processed?
   - Which specific queries/methods are causing section goals to show as complete incorrectly?
   - Are section goals missing from reports due to a query filter or different logic?

6. **Fix Approach:**
   - Should section goals function identically to question goals?
   - Should section goals have the same completion criteria as question goals?
   - Should section goals be included in all the same reports as question goals?
   - How should completion status be calculated for section goals?

7. **User Guidance:**
   - Should there be UI guidance on when to create section goals vs. question goals?
   - Should there be restrictions or warnings when creating section goals?
   - Should existing problematic section goals be marked inactive (using Request 4 solution)?

### Recommended Solutions (Budget-Friendly Options)

**Solution A: Remove Section Goals Feature (Recommended if not needed)**

**Approach: Deprecate section goals and migrate existing data**

**Implementation:**
1. **Data analysis**
   - Query database to count section goals
   - Identify which programs/affiliates are using them
   - Assess impact of removal

2. **Disable section goal creation**
   - Remove "Add Section Goal" option from UI
   - Prevent new section goals from being created
   - Keep existing section goals visible (for now)

3. **Existing section goals - Choose one:**
   - **Option 3A:** Mark all section goals as inactive (using Request 4 status solution)
   - **Option 3B:** Convert section goals to question goals (requires manual or semi-automated mapping)
   - **Option 3C:** Soft delete all section goals (hide from all views but preserve data)

4. **Clean up codebase**
   - Remove section goal-specific code from controllers/views
   - Update reports to exclude section goals
   - Simplify goal logic to only handle question goals

5. **User communication**
   - Notify affected users before removal
   - Provide documentation on using question goals instead

**Benefits:**
- **Simplifies system**: One goal type instead of two
- **Prevents future issues**: No more section goal bugs
- **Clean codebase**: Less maintenance, fewer edge cases
- **Clear for users**: No confusion about which goal type to use

**Files to Modify:**
- `plugins/Programs/templates/Admin/Goals/add.twig` - Remove section goal option
- `plugins/Programs/src/Controller/Admin/GoalsController.php` - Remove section goal logic
- `plugins/Programs/src/Model/Table/GoalsTable.php` - Update queries (if needed for Option 3A/3B/3C)
- `plugins/Reports/` - Update to exclude section goals
- Dashboard widgets - Update to exclude section goals
- Migration script for data cleanup

**Database Changes (if using Option 3A - mark inactive):**
```sql
-- Mark all section goals as inactive using status from Request 4
UPDATE goals SET status = 'inactive' WHERE goal_type = 'section';
```

**Database Changes (if using Option 3C - soft delete):**
```sql
-- Soft delete all section goals
UPDATE goals SET deleted = NOW() WHERE goal_type = 'section';
```

---

**Solution B: Fix Section Goals to Work Properly (If keeping feature)**

**Approach: Standardize section goal behavior to match question goals**

**Implementation:**
1. **Investigation**
   - Analyze root cause of completion status issues
   - Identify all places where section goals diverge from question goals
   - Document technical findings

2. **Fix completion logic**
   - Update goal completion calculation for section goals
   - Ensure section goals appear in all reports
   - Fix dashboard widget calculations
   - Add visual indicators to distinguish goal types

3. **Data cleanup**
   - Reset incorrectly marked section goal completion status
   - Add `goal_type` field if not present

**Benefits:**
- **Preserves feature**: Users can continue using section goals
- **Fixes issues**: Section goals work properly
- **Consistency**: Both goal types behave the same

**Note:** This approach requires more effort than removal and ongoing maintenance of two goal types.

---

**Recommendation:**
**Choose Solution A (Remove Section Goals)** if:
- Client confirms section goals are rarely used or not needed
- Existing section goals can be converted or inactivated
- Simplification is preferred over feature preservation

**Choose Solution B (Fix Section Goals)** if:
- Section goals are actively used and valued by users
- There's a strong use case for section-level goals
- Client wants to preserve the feature despite issues

**Data Analysis Queries for Discovery:**
```sql
-- Count goals by type
SELECT goal_type, COUNT(*) as count, SUM(CASE WHEN completed = 1 THEN 1 ELSE 0 END) as completed_count
FROM goals
GROUP BY goal_type;

-- Find section goals marked complete
SELECT g.*, a.program_id
FROM goals g
JOIN assessments a ON g.assessment_id = a.id
WHERE g.goal_type = 'section' AND g.completed = 1;

-- Goals not in reports (potential issue)
SELECT g.*
FROM goals g
LEFT JOIN report_goal_entries r ON g.id = r.goal_id
WHERE r.id IS NULL;
```

---

## Request 6: Add "Assessment Goals" Tab to Program Details Page

**Status:** NEW - Requirements to be confirmed
**Priority:** MEDIUM-HIGH

### Description
Add a new "Assessment Goals" tab to the Program Details page that displays all assessment goals for that program in a table format. This provides reviewers and staff with easy visibility into program goals without having to navigate to reports or click through the assessment view.

### Problem Statement
Currently, once all goals are completed, the "goals button" at the top of the assessment page disappears, making it difficult to view goals. Users must navigate to the Goals Report to see assessment goals, which is cumbersome. There is no centralized, always-accessible location to view all assessment goals for a specific program.

### Addresses
- Loss of goals visibility when all goals are completed
- Difficulty accessing goals without running reports
- Need for quick goal overview for reviewers
- Centralized location to view all program assessment goals
- Better UX for goal tracking and monitoring

### Current Issues
- "Goals button" disappears from assessment view when all goals are completed (Sarah's quote: "right now when you, once all those goals are completed, we don't have the little button at the top anymore, that lets us look at the goals")
- Must go to Goals Report to view completed goals
- No single page showing all goals for a program
- Goals are scattered across different assessment questions
- Difficult to get overview of program's goal progress

### Use Cases
- Reviewer wants to see all goals for a program at a glance
- Staff needs to check goal status without running reports
- Viewing completed goals after they've been marked as complete
- Monitoring goal progress across multiple assessment sections
- Quick reference for goal tracking during program check-ins

### Screenshot Reference
Based on screenshot: `/Users/aksana/Desktop/Screenshot 2025-10-22 at 4.12.40 PM.png`

**Tab Structure:**
- Tab appears in Program Details navigation alongside: Details | Program Administrators | NQMS | **Assessment Goals** | Documents

**Table Columns (from screenshot):**
1. **Section** - Assessment section name (e.g., "F. Mentee Preparation and Training")
2. **Question** - Question text (truncated if long)
3. **Question Rating** - Current rating for the question (1-5)
4. **Goal** - Goal name/title
5. **Baseline Rating** - Starting rating when goal was set
6. **Target Rating** - Desired rating to achieve
7. **Achieved Rating** - Actual rating achieved (may be empty if not evaluated)
8. **Goal Created** - Date and time goal was created
9. **Goal Updated** - Date and time goal was last updated
10. **Actions** - "Edit Goal" button with pencil icon

### Meeting Decisions (Session 2)

**Status:** DISCUSSED - Visibility issue confirmed

**Key Discussion Points:**
- Sarah confirmed at line 243: "having the goals being visible, incomplete or complete, because right now when you, once all those goals are completed, we don't have the little button at the top anymore, that lets us look at the goals, unless we go to report and we're, and we're looking at it."
- Aksana acknowledged: "yeah, definitely, like I said, keep that in mind, because we will be going through that. But we did guys ask something for like assessment snapshot."
- Team identified this as part of overall goal visibility improvements

**Confirmed Requirements (from screenshot):**
1. New "Assessment Goals" tab in Program Details page
2. Table display showing all assessment goals for the program
3. Display both active and completed goals
4. Include question context (section, question text, current rating)
5. Show all goal details (baseline, target, achieved ratings)
6. Display created and updated timestamps
7. Include "Edit Goal" action button for each goal
8. Goals grouped/sorted by section

**Requirements to Confirm:**
1. Should this show goals from all assessments or only the most recent assessment?
2. Should there be filtering options (by section, by status, by date)?
3. Should there be sorting options for columns?
4. Should there be an "Add Goal" button on this page?
5. What happens if program has no goals? (show empty state message?)
6. Should completed/incomplete goals be visually distinguished (color coding)?
7. Should this replace or supplement the current "goals button" in assessment view?
8. Pagination needed if many goals?

### Discovery Questions

1. **Data Scope:**
   - Should this show goals from current assessment only or all historical assessments?
   - If multiple assessments exist, how are goals filtered/organized?
   - Should archived assessment goals be included or excluded?
   - Should section goals be included (or only question goals after Request 5)?

2. **Display & Layout:**
   - Should table columns be sortable? (click column header to sort)
   - Should there be search/filter functionality? (filter by section, status, date range)
   - Should there be pagination or show all goals at once?
   - Should goals be grouped by assessment section (collapsible sections)?
   - How should long question text be handled? (truncate with "..." and tooltip?)

3. **Goal Status Indicators:**
   - Should completed goals be visually distinguished? (green highlight, checkmark icon?)
   - Should overdue goals (past target completion date) be flagged? (red/yellow indicator?)
   - Should goal status be calculated and displayed? (Achieved, In Progress, Not Started, Overdue)
   - Should there be a goal progress summary at top? (e.g., "3 of 5 goals completed")

4. **Actions & Interactions:**
   - Should there be "Add Goal" button on this tab?
   - Should "Edit Goal" open modal or navigate to separate page?
   - Should there be bulk actions? (delete multiple goals, export selected goals)
   - Should table rows be clickable to expand/show more details?
   - Should there be an "Export Goals" button to download this program's goals?

5. **Access & Permissions:**
   - Who should have access to this tab? (NQMS staff only, or also program users?)
   - Should program end users see their own goals on this tab?
   - Should permissions match existing goal view permissions?
   - Should "Edit Goal" button only appear for authorized users?

6. **Empty States:**
   - What should display if program has no goals? ("No goals set for this program" message?)
   - Should there be a call-to-action to add first goal?
   - What if program has no completed assessment yet?

7. **Integration:**
   - Should this sync with Goals Report data?
   - Should clicking goal link to related assessment question?
   - Should clicking section name navigate to that assessment section?
   - How does this relate to "Assessment Snapshot" feature?

### Recommended Solution (Budget-Friendly)

**Approach: New Program Tab with Goals Table**

**Implementation:**
1. **Add new tab to Program Details page**
   - Modify program view navigation to include "Assessment Goals" tab
   - New controller action: `ProgramsController::assessmentGoals($programId)`
   - New view template: `programs/assessment_goals.twig`

2. **Query assessment goals for program**
   - Join goals table with assessments table filtered by program_id
   - Include related data: assessment questions, sections, ratings
   - Calculate goal status (completed, in progress, overdue based on dates)
   - Order by section, then question number

3. **Build table display**
   - HTML table with 10 columns matching screenshot
   - Responsive design for smaller screens (stack columns or horizontal scroll)
   - Show all goals (no pagination initially, add later if needed)
   - Include "Edit Goal" button for authorized users only

4. **Handle empty states**
   - Display friendly message if no goals exist
   - Optional: Add "Set Your First Goal" button/link

5. **Authorization**
   - Check program view permissions (existing RequestPolicy)
   - NQMS staff can view all program goals
   - Program users can view their own goals (if enabled)
   - "Edit Goal" button only for authorized users (NQMS staff)

**Benefits:**
- **Always visible**: Goals never disappear, unlike current "goals button"
- **Centralized view**: All program goals in one place
- **Better UX**: No need to run reports to see goals
- **Quick reference**: Reviewers can easily check goal status
- **Contextual**: Shows question and section context for each goal

**Files to Modify:**
- `plugins/Programs/templates/Admin/Programs/view.twig` - Add "Assessment Goals" tab to navigation
- `plugins/Programs/src/Controller/Admin/ProgramsController.php` - Add `assessmentGoals()` action
- `plugins/Programs/templates/Admin/Programs/assessment_goals.twig` - New goals table view
- `config/request_policy_configs.php` - Add permission check (if needed, or reuse existing)

**Database Queries:**
```sql
-- Get all assessment goals for a program
SELECT
    g.id as goal_id,
    g.name as goal_name,
    g.baseline_rating,
    g.target_rating,
    g.achieved_rating,
    g.start_date,
    g.target_completion_date,
    g.created,
    g.modified,
    s.title as section_title,
    q.text as question_text,
    q.rating as current_question_rating,
    a.id as assessment_id,
    a.name as assessment_name
FROM goals g
JOIN assessment_questions aq ON g.assessment_question_id = aq.id
JOIN questions q ON aq.question_id = q.id
JOIN sections s ON q.section_id = s.id
JOIN assessments a ON aq.assessment_id = a.id
WHERE a.program_id = ?
  AND g.deleted IS NULL  -- Exclude deleted goals
  AND g.goal_type = 'question'  -- Exclude section goals (after Request 5)
ORDER BY s.order_num, q.order_num;
```

**Technical Considerations:**
- Query optimization: Index on `program_id` in assessments table
- May need to eager load related data to avoid N+1 queries
- Calculate goal status in query or in view (completed = achieved_rating >= target_rating)
- Handle null `achieved_rating` (goal not yet evaluated)
- Date formatting for created/modified timestamps
- Truncate long question text with CSS (`text-overflow: ellipsis`)

**UI/UX Features:**

**Phase 1 (MVP):**
- Simple table with all columns
- Static display (no sorting/filtering)
- "Edit Goal" button for authorized users
- Show all goals for program's most recent assessment
- Empty state message if no goals

**Phase 2 (Enhancements):**
- Column sorting (click header to sort)
- Search/filter by section or goal name
- Visual indicators for completed/overdue goals
- Goal progress summary at top (e.g., "3 of 5 complete")
- "Add Goal" button
- Export goals to CSV

**Phase 3 (Advanced):**
- Include goals from all historical assessments (with filter)
- Collapsible sections (group goals by assessment section)
- Inline editing (click to edit without modal)
- Goal timeline view (alternative visualization)

**Visual Design Notes:**
- Use standard table styling from existing system
- Align with Program Details page design
- Responsive: stack columns or horizontal scroll on mobile
- Truncate long text with ellipsis and show full text on hover
- Use icons for actions (pencil for edit)
- Color coding for status (green for complete, red for overdue - optional)

**Integration with Other Requests:**
- **Request 3 (Goal Dates)**: Table displays start_date and target_completion_date columns
- **Request 4 (Delete Goals)**: May add "Delete" action button in Actions column
- **Request 5 (Section Goals)**: Only show question goals (exclude section goals)
- **Request 1B (Export Assessment)**: Goals data included in assessment export
- **Assessment Snapshot**: Goals summary may feed into snapshot widget

**Alternative Approaches:**

**Option A: Tab with Table (Recommended)**
- Separate tab in Program Details page
- Full table display with all goal details
- Best for detailed goal tracking

**Option B: Assessment Snapshot Widget**
- Compact widget on main program page
- Shows goal summary with link to full list
- Lighter weight, less detail

**Option C: Expand Existing NQMS Tab**
- Add goals section to existing NQMS tab
- Avoids adding another tab
- May crowd existing NQMS content

**Recommendation:** Choose Option A (separate tab) for better organization and visibility, matching the screenshot provided.

---

## Overall Discovery Questions

### General Scope
1. **Priority Order:**
   - What is the priority order for these requests?
   - Which requests are "must-have" vs. "nice-to-have"?
   - Are any requests dependent on others?

2. **Timeline & Budget:**
   - What is the desired timeline for implementation?
   - Are there budget constraints that should inform phasing?
   - Should these be delivered as separate releases or bundled together?

3. **Delivery Approach:**
   - Should we implement all requests, or start with highest priority items?
   - Is there a preference for quick wins vs. comprehensive solutions?

### User Impact
1. **User Base:**
   - How many programs, affiliates, and global admins are in the system?
   - Which user roles will be most affected by these changes?

2. **Training & Communication:**
   - What training or documentation will be needed?
   - How should users be notified of new features?
   - Are there any seasonal considerations (busy periods to avoid implementation)?

### Technical Considerations
1. **Current System:**
   - Any known technical limitations or performance concerns?
   - Current database size and growth rate?
   - Are there plans to upgrade PHP, CakePHP, or other dependencies?

2. **Testing & Deployment:**
   - What testing environments are available (dev, review, staging)?
   - What is the standard deployment process and frequency?
   - Are there any compliance or regulatory requirements (WCAG, data privacy)?

---

## Next Steps

1. **Schedule discovery sessions** with key stakeholders for each request
2. **Document current system behavior** with screenshots and technical analysis
3. **Identify technical dependencies** and potential risks
4. **Create detailed solution proposals** with multiple implementation options
5. **Develop effort estimates** for each request and phase
6. **Present findings and recommendations** to client for prioritization
