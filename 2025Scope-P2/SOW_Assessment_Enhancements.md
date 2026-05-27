# Scope of Work: NQMS Assessment Enhancements

**Project:** NQMS Assessment System Improvements
**Prepared By:** Aksana Rahouski, Senior Product Manager
**Date:** 2024-10-28
**Status:** Ready for Developer Estimation

---

## Overview

This SOW covers **8 enhancement requests** to the NQMS Assessment system that address printing, exporting, data management, goal tracking, and visibility improvements.

**Requests Included:**
1. Print Assessment (Request 1A)
2. Export Assessment (Request 1B) - **PRIORITY**
3. Export Assessment Goals (Request 1C) - **NEW**
4. Archive Assessments (Request 2A)
5. Goal Date Tracking (Request 3)
6. Delete Goals (Request 4)
7. Remove Section Goals (Request 5)
8. Assessment Goals Tab (Request 6)

**Implementation Approach:** Each request can be estimated and implemented independently, though some dependencies exist (noted in each request).

---

## Request 1A: Print Assessment

### Problem Statement

**Current State:**
Programs and reviewers cannot print assessments directly from the assessment view page. Printing from the browser requires manually expanding all accordion sections, and the result includes navigation elements and buttons that clutter the printed output.

**Business Impact:**
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
2. Button triggers browser's native print dialog (`window.print()`)
3. CSS `@media print` styles automatically:
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

**Files to Modify:**
- `plugins/NQMS/templates/Admin/Assessments/view.twig` - Add print button
- `plugins/ThemeAdmin/webroot/assets/scss/partials/_print.scss` - Create print styles
- Minimal JavaScript for print trigger

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

### Test Cases

#### Test: Print button functionality
```
Given: User viewing assessment details page
When: User clicks "Print" button
Then: Browser print dialog opens
  And: Print preview displays formatted assessment
  And: User can choose printer or save as PDF
```

#### Test: All accordions expanded in print
```
Given: Assessment has 6 sections with accordions
  And: Some accordions are currently collapsed
When: User opens print preview
Then: All 6 sections are expanded
  And: All questions visible in preview
  And: No content hidden
```

#### Test: UI elements hidden in print
```
Given: User in print preview
Then: Navigation menu is NOT visible
  And: Action buttons are NOT visible
  And: Sidebar is NOT visible
  And: Footer navigation is NOT visible
  And: Only assessment content displays
```

#### Test: Branding and headers
```
Given: User in print preview
Then: MENTOR logo appears in header
  And: Program name displays on first page
  And: Assessment date displays
  And: Professional formatting applied
```

#### Test: Page breaks work correctly
```
Given: Assessment has multiple sections
When: User views print preview
Then: Each section starts on new page
  And: Questions not split across pages
  And: Page breaks between sections
```

#### Test: Cross-browser compatibility
```
Given: User opens assessment in [Chrome / Firefox / Safari / Edge]
When: User clicks Print button
Then: Print preview loads correctly
  And: All content visible
  And: Formatting consistent across browsers
```

#### Test: Print permissions
```
Given: User has view access to assessment
When: User views assessment page
Then: Print button is visible

Given: User does NOT have view access
When: User attempts to access assessment
Then: Access denied (cannot see print button)
```

#### Test: Goals not included
```
Given: Assessment has 3 goals set
When: User opens print preview
Then: Goals section is NOT visible in preview
  And: Only questions, ratings, comments appear
```

### Definition of Done

- [ ] Print button implemented and visible on assessment view page
- [ ] CSS print styles created in theme SCSS
- [ ] All acceptance criteria met
- [ ] All test cases pass
- [ ] Code review completed and approved
- [ ] Tested in Chrome, Firefox, Safari, Edge
- [ ] Works on staging environment
- [ ] PM/client UAT approved
- [ ] No critical or high bugs

---

## Request 1B: Export Assessment (PRIORITY)

### Problem Statement

**Current State:**
Programs and reviewers can export assessment data through the Assessment Details Report, but the process is cumbersome:
- Must navigate to separate report page (not from assessment view)
- Very difficult to filter down to a single program
- Can only search by date (no search by affiliate or program name)
- Export layout is difficult to use (questions as rows instead of columns)

**Business Impact:**
- Reviewers need to export assessments to share with programs
- Current 5+ step process to export one assessment
- Poor UX for a frequently-needed action
- Data format requires manual cleanup (copy/paste into template)

**User Need:**
Both programs and affiliate staff need quick, one-click export of a single program's assessment data for their records and to track progress offline.

---

## OPTION 1: Simple Export Button (Quick Win)

### Proposed Solution

**Approach:** Direct CSV export from assessment view page with single button

**How It Works:**
1. Add "Export Assessment" button to existing assessment details page (alongside Print, Delete, Review buttons)
2. Button triggers immediate CSV download (no navigation required)
3. CSV format matches existing Assessment Detail Report structure
4. File includes assessment data, questions, ratings, comments, and goals
5. Uses CakePHP's built-in CSV response functionality

**User Experience:**
- User clicks "Export Assessment" button → CSV downloads immediately
- No new pages, no navigation, minimal UI changes
- Simple, fast implementation

**CSV Format:** 16 columns (matches existing export format)
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

**File Naming:** `single_program_assessment_details__with_goals_{ISO8601_timestamp}.csv`

**Files to Modify:**
- `plugins/NQMS/src/Controller/Admin/AssessmentsController.php` - Add `exportCsv($id)` action
- `plugins/NQMS/templates/Admin/Assessments/view.twig` - Add export button

**Estimated Complexity:** Low (1-2 days)

### Acceptance Criteria

- [ ] "Export Assessment" button appears on assessment details page
- [ ] Button positioned with other action buttons (Print, Delete, Review)
- [ ] Button visible to all users who can view the assessment
- [ ] Clicking button downloads CSV file immediately
- [ ] No page refresh or navigation occurs
- [ ] User remains on assessment page after export
- [ ] CSV file named: `single_program_assessment_details__with_goals_{timestamp}.csv`
- [ ] Timestamp in ISO 8601 format with timezone
- [ ] CSV contains exactly 16 columns in specified order
- [ ] Column headers match specification
- [ ] One row per question in assessment
- [ ] Assessment metadata (columns 1-5) repeated on every row
- [ ] Section title and average repeated for all questions in section
- [ ] If question has multiple goals, each goal creates duplicate question row
- [ ] If question has no goals, goal columns (11-16) are empty/blank
- [ ] Dates formatted: "Month Day, Year, Time" (e.g., "April 1, 2025, 8:08 PM")
- [ ] Section averages calculated correctly
- [ ] CSV opens correctly in Excel, Google Sheets, Numbers
- [ ] Export respects existing view permissions
- [ ] CSV generation uses CakePHP native CSV response

### Test Cases

#### Test: Export button downloads CSV
```
Given: User viewing assessment details page
When: User clicks "Export Assessment" button
Then: CSV file downloads immediately to default download location
  And: Filename matches format: single_program_assessment_details__with_goals_2025-10-28T14_30_45.123Z.csv
  And: User remains on assessment page (no navigation)
  And: No page refresh occurs
```

#### Test: CSV has correct structure
```
Given: Assessment exported as CSV
When: User opens CSV file in spreadsheet software
Then: CSV has exactly 16 columns
  And: Column headers are: assessment_name, assessment_created_date, submitted_for_review_date, program_id, program_title, section_title, question_text, question_rating, question_notes, section_average_rating, goals_set, question_goal_name, question_goal_baseline_rating, question_goal_target_rating, question_goal_achieved_rating, question_goal_status
  And: Headers are in row 1
```

#### Test: One row per question
```
Given: Assessment has 50 questions total
When: CSV exported
Then: CSV has 51 rows (1 header + 50 data rows)
  And: Each question is one row
```

#### Test: Assessment metadata repeated
```
Given: Assessment has 50 questions
When: CSV exported
Then: All 50 rows have same values for columns 1-5
  And: assessment_name repeated on every row
  And: assessment_created_date repeated on every row
  And: submitted_for_review_date repeated on every row
  And: program_id repeated on every row
  And: program_title repeated on every row
```

#### Test: Multiple goals per question
```
Given: Question #10 has 2 goals
  And: Assessment has 50 questions total
When: CSV exported
Then: CSV has 52 rows (1 header + 51 data rows)
  And: Question #10 appears on 2 rows
  And: First row has first goal data (columns 11-16)
  And: Second row has second goal data (columns 11-16)
  And: Question data (columns 1-10) duplicated on both rows
```

#### Test: Questions without goals
```
Given: Question #5 has no goals
When: CSV exported
Then: Row for question #5 exists
  And: Columns 1-10 populated with question data
  And: Columns 11-16 (goal columns) are empty/blank
```

#### Test: Date formatting
```
Given: Assessment created on 2025-04-01 at 20:08:00
When: CSV exported
Then: assessment_created_date shows "April 1, 2025, 8:08 PM"
  And: All date fields use same format
```

#### Test: Section averages calculated
```
Given: Section A has 5 questions with ratings: 3, 4, 3, 5, 4
When: CSV exported
Then: section_average_rating for Section A rows = 3.8
  And: Average calculated correctly for each section
```

#### Test: Export with no goals
```
Given: Assessment has 30 questions
  And: No goals set for any question
When: User exports assessment
Then: CSV has 31 rows (1 header + 30 questions)
  And: All goal columns (11-16) are empty
  And: Export succeeds without errors
```

#### Test: Export permissions
```
Given: User has view access to assessment
When: User views assessment page
Then: "Export Assessment" button is visible
  And: User can successfully download CSV

Given: User does NOT have view access
Then: User cannot access assessment page
  And: Cannot export
```

#### Test: CSV character encoding
```
Given: Assessment has special characters (é, ñ, 中)
When: CSV exported
Then: Special characters display correctly
  And: CSV uses UTF-8 encoding
  And: Opens correctly in Excel without encoding issues
```

### Definition of Done

- [ ] Export button implemented on assessment view page
- [ ] `exportCsv()` controller action created
- [ ] CSV generation logic implemented
- [ ] All 16 columns included in correct order
- [ ] All acceptance criteria met
- [ ] All test cases pass
- [ ] Code review completed and approved
- [ ] Tested with assessments of varying sizes (10, 50, 100 questions)
- [ ] Tested with goals (0 goals, multiple goals per question)
- [ ] Tested in Chrome, Firefox, Safari, Edge
- [ ] CSV opens correctly in Excel, Google Sheets, Numbers
- [ ] Works on staging environment
- [ ] Performance acceptable (<5 seconds for typical assessment)
- [ ] PM/client UAT approved
- [ ] No critical or high bugs

---

## OPTION 2: Assessment Preview Page with Export (Enhanced UX)

### Proposed Solution

**Approach:** Build dedicated "Assessment Preview" page with visual review before export

**How It Works:**
1. Add "Assessment Preview" button to existing assessment details page
2. Button navigates to new preview page at route: `/admin/assessments/{id}/preview`
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

**CSV Format:** Same 16 columns as Option 1

**File Naming:** `single_program_assessment_details__with_goals_{ISO8601_timestamp}.csv`

**Files to Create/Modify:**
- `plugins/NQMS/src/Controller/Admin/AssessmentsController.php` - Add `preview($id)` and `exportCsv($id)` actions
- `plugins/NQMS/templates/Admin/Assessments/preview.twig` - New preview page template (NEW)
- `plugins/NQMS/templates/Admin/Assessments/view.twig` - Add "Assessment Preview" button
- `config/routes.php` - Add preview route

**Estimated Complexity:** Medium (3-5 days)

### Acceptance Criteria

#### Preview Page Navigation
- [ ] "Assessment Preview" button appears on assessment details page
- [ ] Button positioned with other action buttons (Print, Delete, Review)
- [ ] Button visible to all users who can view the assessment
- [ ] Clicking button navigates to preview page
- [ ] Preview page URL: `/admin/assessments/{id}/preview`
- [ ] Breadcrumb navigation displays correctly
- [ ] "Back to Assessment" button returns to assessment details page

#### Preview Page Display
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

#### Export Functionality
- [ ] "Export as CSV" button appears at top right of preview page
- [ ] Button has download icon
- [ ] Button is styled as primary action button
- [ ] Clicking button downloads CSV file immediately
- [ ] No page refresh or navigation occurs after export
- [ ] User remains on preview page after export
- [ ] CSV file named: `single_program_assessment_details__with_goals_{timestamp}.csv`
- [ ] Timestamp in ISO 8601 format with timezone
- [ ] CSV contains exactly 16 columns in specified order
- [ ] CSV data matches what's displayed on preview page
- [ ] CSV generation uses CakePHP native CSV response

#### Data Integrity
- [ ] One row per question in assessment
- [ ] Assessment metadata (columns 1-5) repeated on every row
- [ ] Section title and average repeated for all questions in section
- [ ] If question has multiple goals, each goal creates duplicate question row (in CSV)
- [ ] If question has no goals, goal columns (11-16) are empty/blank
- [ ] Dates formatted: "Month Day, Year, Time" (e.g., "April 1, 2025, 8:08 PM")
- [ ] Section averages calculated correctly
- [ ] CSV opens correctly in Excel, Google Sheets, Numbers
- [ ] Export respects existing view permissions

### Test Cases

#### Test: Preview button navigates to preview page
```
Given: User viewing assessment details page
When: User clicks "Assessment Preview" button
Then: Browser navigates to /admin/assessments/{id}/preview
  And: Preview page loads successfully
  And: Page title shows "Assessment Preview"
  And: Breadcrumb shows: Home / Programs / Browse Programs / Program Details / Assessment / Preview
```

#### Test: Preview page displays assessment data
```
Given: Assessment has 50 questions across 5 sections
  And: 10 questions have goals
When: User navigates to preview page
Then: Data table displays all 50 questions
  And: Section titles grouped correctly
  And: Question ratings displayed
  And: Question notes displayed
  And: Section averages calculated and displayed
  And: "Goals Set" column shows Yes/No correctly
  And: Goal details populated for 10 questions
  And: Table is scrollable horizontally
```

#### Test: Back button returns to assessment
```
Given: User on preview page
When: User clicks "Back to Assessment" button
Then: Browser navigates back to assessment details page
  And: User sees full assessment view with sections
```

#### Test: Export from preview page
```
Given: User on preview page
When: User clicks "Export as CSV" button
Then: CSV file downloads immediately to default download location
  And: Filename matches format: single_program_assessment_details__with_goals_2025-10-28T14_30_45.123Z.csv
  And: User remains on preview page (no navigation)
  And: No page refresh occurs
```

#### Test: CSV matches preview data
```
Given: User viewing preview page with assessment data
When: User exports CSV
  And: User opens CSV in spreadsheet software
Then: CSV data exactly matches preview table data
  And: Row count matches (header + questions + duplicate rows for multi-goal questions)
  And: Column values match what was displayed on screen
```

#### Test: Preview page with no goals
```
Given: Assessment has 30 questions
  And: No goals set for any question
When: User navigates to preview page
Then: Table displays all 30 questions
  And: "Goals Set" column shows "No" for all questions
  And: Goal columns are empty
When: User exports CSV
Then: CSV has 31 rows (1 header + 30 questions)
  And: Goal columns (11-16) are empty
```

#### Test: Preview page with multiple goals per question
```
Given: Question #10 has 3 goals
When: User views preview page
Then: Question #10 displays in table
  And: "Goals Set" shows "Yes"
  And: First goal details visible in goal columns
When: User exports CSV
Then: Question #10 appears on 3 rows in CSV
  And: Each row has different goal data
  And: Question data duplicated on all 3 rows
```

#### Test: Preview permissions
```
Given: User has view access to assessment
When: User clicks "Assessment Preview" button
Then: Preview page loads successfully
  And: "Export as CSV" button is visible and functional

Given: User does NOT have view access to assessment
When: User attempts to navigate to preview URL directly
Then: Access denied (403 or redirect)
  And: User cannot view preview page
```

#### Test: Preview page performance
```
Given: Assessment has 100 questions
  And: 50 questions have goals
When: User navigates to preview page
Then: Page loads in < 3 seconds
  And: Table renders without lag
  And: Scrolling is smooth
```

#### Test: CSV character encoding from preview
```
Given: Assessment has special characters (é, ñ, 中)
  And: User on preview page
When: User exports CSV
  And: User opens CSV in spreadsheet software
Then: Special characters display correctly
  And: CSV uses UTF-8 encoding
  And: Opens correctly in Excel without encoding issues
```

#### Test: Responsive design
```
Given: User on preview page
When: User resizes browser window to tablet size (768px)
Then: Table remains usable
  And: Horizontal scroll works correctly
  And: Action buttons remain accessible

When: User resizes to mobile size (375px)
Then: Table adapts appropriately
  And: Core functionality remains accessible
```

### Definition of Done

- [ ] Preview page route created
- [ ] "Assessment Preview" button added to assessment view page
- [ ] Preview page template created with data table
- [ ] Preview page displays all assessment data correctly
- [ ] Table includes all 16 columns
- [ ] "Back to Assessment" navigation implemented
- [ ] "Export as CSV" button implemented on preview page
- [ ] `preview()` controller action created
- [ ] `exportCsv()` controller action created
- [ ] CSV generation logic implemented
- [ ] All 16 columns included in correct order
- [ ] All acceptance criteria met
- [ ] All test cases pass
- [ ] Code review completed and approved
- [ ] Tested with assessments of varying sizes (10, 50, 100 questions)
- [ ] Tested with goals (0 goals, multiple goals per question)
- [ ] Tested in Chrome, Firefox, Safari, Edge
- [ ] Responsive design tested on tablet and mobile
- [ ] CSV opens correctly in Excel, Google Sheets, Numbers
- [ ] Works on staging environment
- [ ] Performance acceptable (preview page loads <3s, export <5s)
- [ ] PM/client UAT approved
- [ ] No critical or high bugs

---

## Request 1C: Export Assessment Goals (NEW)

### Problem Statement

**Current State:**
Programs and reviewers can view assessment goals through the "Preview Assessment Goals" button on the assessment details page, but there is no way to export this data:
- Goals are displayed on screen but cannot be downloaded
- No offline access to goals data
- Cannot share goals data via file
- Must manually transcribe goals data for reporting or tracking

**Business Impact:**
- Programs need to track goal progress over time in their own systems
- Reviewers want to export goals data for follow-up and monitoring
- No easy way to share goals with stakeholders (board, leadership, funders)
- Manual data entry required if programs want to maintain offline goal tracking

**User Need:**
Programs and affiliate staff need to export assessment goals data (goal names, baseline/target ratings, dates, notes) to track progress offline, share with stakeholders, and maintain their own records.

---

## OPTION 1: Simple Export Goals Button (Quick Win)

### Proposed Solution

**Approach:** Direct CSV export from assessment view page with single button

**How It Works:**
1. Add "Export Assessment Goals" button to existing assessment details page (alongside existing action buttons)
2. Button triggers immediate CSV download (no navigation required)
3. CSV contains only goals data (no questions without goals)
4. File includes section, question, goal details, dates, and notes
5. Uses CakePHP's built-in CSV response functionality

**User Experience:**
- User clicks "Export Assessment Goals" button → CSV downloads immediately
- No new pages, no navigation, minimal UI changes
- Simple, fast implementation

**CSV Format:** 8 columns
1. section_title
2. question_text
3. goal_name
4. baseline_rating
5. target_rating
6. start_date
7. target_completion_date
8. notes

**File Naming:** `assessment_goals_{assessment_name}_{ISO8601_timestamp}.csv`

**Files to Modify:**
- `plugins/NQMS/src/Controller/Admin/AssessmentsController.php` - Add `exportGoalsCsv($id)` action
- `plugins/NQMS/templates/Admin/Assessments/view.twig` - Add export goals button

**Estimated Complexity:** Low (1-2 days)

### Acceptance Criteria

- [ ] "Export Assessment Goals" button appears on assessment details page
- [ ] Button positioned with other action buttons (Print, Assessment Preview, etc.)
- [ ] Button visible to all users who can view the assessment
- [ ] Clicking button downloads CSV file immediately
- [ ] No page refresh or navigation occurs
- [ ] User remains on assessment page after export
- [ ] CSV file named: `assessment_goals_{assessment_name}_{timestamp}.csv`
- [ ] Timestamp in ISO 8601 format with timezone
- [ ] CSV contains exactly 8 columns in specified order
- [ ] Column headers match specification
- [ ] One row per goal (not per question)
- [ ] Only questions WITH goals are included
- [ ] Questions without goals are excluded from export
- [ ] Dates formatted: "MM/DD/YYYY" (e.g., "01/15/2024")
- [ ] CSV opens correctly in Excel, Google Sheets, Numbers
- [ ] Export respects existing view permissions
- [ ] CSV generation uses CakePHP native CSV response
- [ ] If assessment has no goals, CSV downloads with headers only (no data rows)

### Test Cases

#### Test: Export goals button downloads CSV
```
Given: User viewing assessment details page
  And: Assessment has 5 goals across 3 questions
When: User clicks "Export Assessment Goals" button
Then: CSV file downloads immediately to default download location
  And: Filename matches format: assessment_goals_2023_Self-Assessment_2025-10-28T14_30_45.123Z.csv
  And: User remains on assessment page (no navigation)
  And: No page refresh occurs
```

#### Test: CSV has correct structure
```
Given: Assessment goals exported as CSV
When: User opens CSV file in spreadsheet software
Then: CSV has exactly 8 columns
  And: Column headers are: section_title, question_text, goal_name, baseline_rating, target_rating, start_date, target_completion_date, notes
  And: Headers are in row 1
```

#### Test: One row per goal
```
Given: Assessment has 50 questions total
  And: 10 questions have 1 goal each
  And: 2 questions have 2 goals each
  And: 38 questions have no goals
When: CSV exported
Then: CSV has 15 rows total (1 header + 14 data rows)
  And: Each goal is one row
  And: Questions without goals are NOT included
```

#### Test: Multiple goals per question
```
Given: Question #10 has 3 goals
When: CSV exported
Then: Question #10 appears on 3 rows in CSV
  And: Each row has different goal data (goal_name, baseline, target, dates, notes)
  And: Question data (section_title, question_text) duplicated on all 3 rows
```

#### Test: Date formatting
```
Given: Goal has start_date of 2024-01-15 and target_completion_date of 2024-06-30
When: CSV exported
Then: start_date shows "01/15/2024"
  And: target_completion_date shows "06/30/2024"
  And: All date fields use MM/DD/YYYY format
```

#### Test: Export with no goals
```
Given: Assessment has 30 questions
  And: No goals set for any question
When: User clicks "Export Assessment Goals" button
Then: CSV downloads successfully
  And: CSV has 1 row (headers only)
  And: No data rows present
  And: Export succeeds without errors
```

#### Test: Export permissions
```
Given: User has view access to assessment
When: User views assessment page
Then: "Export Assessment Goals" button is visible
  And: User can successfully download CSV

Given: User does NOT have view access to assessment
Then: User cannot access assessment page
  And: Cannot export goals
```

#### Test: CSV character encoding
```
Given: Assessment goals have special characters (é, ñ, 中) in goal_name or notes
When: CSV exported
Then: Special characters display correctly
  And: CSV uses UTF-8 encoding
  And: Opens correctly in Excel without encoding issues
```

#### Test: Empty notes field
```
Given: Goal has no notes (empty/null)
When: CSV exported
Then: notes column is empty/blank for that row
  And: Export succeeds without errors
```

#### Test: Missing dates
```
Given: Goal has start_date but no target_completion_date
When: CSV exported
Then: start_date populated correctly
  And: target_completion_date is empty/blank
  And: Export succeeds without errors
```

### Definition of Done

- [ ] "Export Assessment Goals" button implemented on assessment view page
- [ ] `exportGoalsCsv()` controller action created
- [ ] CSV generation logic implemented (goals only, no questions without goals)
- [ ] All 8 columns included in correct order
- [ ] All acceptance criteria met
- [ ] All test cases pass
- [ ] Code review completed and approved
- [ ] Tested with assessments of varying goals (0 goals, 1 goal, multiple goals per question)
- [ ] Tested with missing/empty data (no notes, no dates)
- [ ] Tested in Chrome, Firefox, Safari, Edge
- [ ] CSV opens correctly in Excel, Google Sheets, Numbers
- [ ] Works on staging environment
- [ ] Performance acceptable (<3 seconds for typical assessment)
- [ ] PM/client UAT approved
- [ ] No critical or high bugs

---

## OPTION 2: Assessment Goals Preview Page with Export (Enhanced UX)

### Proposed Solution

**Approach:** Build dedicated "Assessment Goals Preview" page with visual review before export

**How It Works:**
1. "Preview Assessment Goals" button already exists on assessment details page
2. Button navigates to preview page at route: `/admin/assessments/{id}/preview-goals`
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

**CSV Format:** Same 8 columns as Option 1

**File Naming:** `assessment_goals_{assessment_name}_{ISO8601_timestamp}.csv`

**Files to Create/Modify:**
- `plugins/NQMS/src/Controller/Admin/AssessmentsController.php` - Add `exportGoalsCsv($id)` action
- `plugins/NQMS/templates/Admin/Assessments/preview_goals.twig` - Add "Export as CSV" button to existing template
- Note: Preview page already exists, just need to add export button

**Estimated Complexity:** Low-Medium (2-3 days)

### Acceptance Criteria

#### Preview Page Navigation
- [ ] "Preview Assessment Goals" button already exists on assessment details page
- [ ] Clicking button navigates to goals preview page
- [ ] Preview page URL: `/admin/assessments/{id}/preview-goals`
- [ ] Breadcrumb navigation displays correctly
- [ ] "Back to Assessment" button returns to assessment details page

#### Preview Page Display
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

#### Export Functionality
- [ ] "Export as CSV" button appears at top right of preview page
- [ ] Button has download icon
- [ ] Button is styled as primary action button
- [ ] Clicking button downloads CSV file immediately
- [ ] No page refresh or navigation occurs after export
- [ ] User remains on preview page after export
- [ ] CSV file named: `assessment_goals_{assessment_name}_{timestamp}.csv`
- [ ] Timestamp in ISO 8601 format with timezone
- [ ] CSV contains exactly 8 columns in specified order
- [ ] CSV data matches what's displayed on preview page
- [ ] CSV generation uses CakePHP native CSV response

#### Data Integrity
- [ ] One row per goal (not per question)
- [ ] Only questions WITH goals are included in table and CSV
- [ ] Questions without goals are excluded
- [ ] Multiple goals per question each get their own row
- [ ] Dates formatted: MM/DD/YYYY in CSV
- [ ] CSV opens correctly in Excel, Google Sheets, Numbers
- [ ] Export respects existing view permissions
- [ ] If assessment has no goals, preview shows "No goals set" message
- [ ] If assessment has no goals, CSV downloads with headers only

### Test Cases

#### Test: Preview page displays goals data
```
Given: Assessment has 50 questions total
  And: 10 questions have 1 goal each
  And: 2 questions have 2 goals each
When: User navigates to preview goals page
Then: Data table displays 14 rows (10 + 4 goals)
  And: Section titles displayed correctly
  And: Question text displayed
  And: Goal names displayed
  And: Baseline and target ratings displayed
  And: Start dates formatted as MM/DD/YYYY
  And: Target completion dates formatted as MM/DD/YYYY
  And: Notes displayed
  And: Table is scrollable horizontally if needed
```

#### Test: Back button returns to assessment
```
Given: User on goals preview page
When: User clicks "Back to Assessment" button
Then: Browser navigates back to assessment details page
  And: User sees full assessment view with sections
```

#### Test: Export from preview page
```
Given: User on goals preview page
  And: Assessment has 10 goals
When: User clicks "Export as CSV" button
Then: CSV file downloads immediately to default download location
  And: Filename matches format: assessment_goals_2023_Self-Assessment_2025-10-28T14_30_45.123Z.csv
  And: User remains on preview page (no navigation)
  And: No page refresh occurs
```

#### Test: CSV matches preview data
```
Given: User viewing goals preview page with 10 goals displayed
When: User exports CSV
  And: User opens CSV in spreadsheet software
Then: CSV has 11 rows (1 header + 10 data rows)
  And: CSV data exactly matches preview table data
  And: Goal names match
  And: Ratings match
  And: Dates match
  And: Notes match
```

#### Test: Preview page with no goals
```
Given: Assessment has 30 questions
  And: No goals set for any question
When: User navigates to preview goals page
Then: Page displays "No goals set for this assessment" message
  And: Empty table shown (headers only, no data rows)
When: User clicks "Export as CSV" button
Then: CSV downloads with headers only (no data rows)
  And: Export succeeds without errors
```

#### Test: Preview page with multiple goals per question
```
Given: Question #10 has 3 goals
  And: Question #15 has 2 goals
When: User views preview page
Then: Question #10 appears in 3 rows
  And: Question #15 appears in 2 rows
  And: Each row shows different goal data
  And: Question text duplicated on rows for same question
When: User exports CSV
Then: CSV structure matches preview table
  And: Same number of rows as displayed on screen
```

#### Test: Preview permissions
```
Given: User has view access to assessment
When: User clicks "Preview Assessment Goals" button
Then: Preview page loads successfully
  And: "Export as CSV" button is visible and functional

Given: User does NOT have view access to assessment
When: User attempts to navigate to preview goals URL directly
Then: Access denied (403 or redirect)
  And: User cannot view preview page
```

#### Test: Preview page performance
```
Given: Assessment has 50 goals
When: User navigates to preview goals page
Then: Page loads in < 2 seconds
  And: Table renders without lag
  And: Scrolling is smooth
```

#### Test: CSV character encoding from preview
```
Given: Assessment goals have special characters (é, ñ, 中) in goal names or notes
  And: User on preview goals page
When: User exports CSV
  And: User opens CSV in spreadsheet software
Then: Special characters display correctly
  And: CSV uses UTF-8 encoding
  And: Opens correctly in Excel without encoding issues
```

#### Test: Empty data fields on preview
```
Given: Goal #5 has no notes (empty)
  And: Goal #8 has no target_completion_date (empty)
When: User views preview page
Then: Notes column for goal #5 is blank
  And: Target Completion Date column for goal #8 is blank
  And: Empty cells display cleanly (no "null" or "undefined")
When: User exports CSV
Then: Empty fields are blank in CSV
  And: Export succeeds without errors
```

#### Test: Responsive design
```
Given: User on preview goals page
When: User resizes browser window to tablet size (768px)
Then: Table remains usable
  And: Horizontal scroll works correctly
  And: Action buttons remain accessible

When: User resizes to mobile size (375px)
Then: Table adapts appropriately
  And: Core functionality remains accessible
```

### Definition of Done

- [ ] "Export as CSV" button added to existing goals preview page
- [ ] `exportGoalsCsv()` controller action created
- [ ] CSV generation logic implemented (goals only, no questions without goals)
- [ ] All 8 columns included in correct order
- [ ] All acceptance criteria met
- [ ] All test cases pass
- [ ] Code review completed and approved
- [ ] Tested with assessments of varying goals (0 goals, multiple goals per question)
- [ ] Tested with missing/empty data (no notes, no dates)
- [ ] Tested in Chrome, Firefox, Safari, Edge
- [ ] Responsive design tested on tablet and mobile
- [ ] CSV opens correctly in Excel, Google Sheets, Numbers
- [ ] CSV data matches preview page display exactly
- [ ] Works on staging environment
- [ ] Performance acceptable (preview page loads <2s, export <3s)
- [ ] PM/client UAT approved
- [ ] No critical or high bugs

---

## Request 2A: Archive Assessments

### Problem Statement

**Current State:**
There is no way to remove assessments from the system. This creates issues:
- Test assessments created during training pollute reports and dashboards
- Duplicate assessments created by error cannot be removed
- Half-finished assessments when programs abandon process mid-stream remain visible
- Invalid assessments from data migration cannot be cleaned up

**Business Impact:**
- Reports include test and invalid data, reducing accuracy
- Dashboards show incomplete/dead assessments
- No way to clean up data quality issues
- Affiliate reviewers cannot archive assessments for programs that go under or abandon NQMS

**User Need:**
Reviewers need ability to archive "dead assessments" - incomplete submissions that were never finished and never will be. This is different from inactive programs (which retain historical data).

### Proposed Solution

**Approach:** Soft delete (archive) with no restore UI

**How It Works:**
1. Add `deleted` timestamp column to assessments table
2. Add "Archive Assessment" button on assessment view page (authorized users only)
3. Confirmation modal warns about action
4. Setting `deleted` timestamp hides assessment from all queries
5. Archived assessments excluded from reports, dashboards, and lists
6. Data preserved in database but not visible anywhere
7. If permanent deletion needed, Oasis support can run manual scripts

**Who Can Archive:**
- Global Admins
- Affiliate Staff (reviewers like Sarah)
- NOT program end users

**Rationale for Soft Delete:**
- Safe: can be recovered if archived by mistake
- Data preserved for audit purposes
- Can add permanent cleanup later (e.g., 90-day retention)

**Files to Modify:**
- `config/Migrations/[TIMESTAMP]_AddDeletedToAssessments.php` - Add deleted column
- `plugins/NQMS/src/Model/Table/AssessmentsTable.php` - Add soft delete behavior
- `plugins/NQMS/src/Controller/Admin/AssessmentsController.php` - Add archive action
- `plugins/NQMS/templates/Admin/Assessments/view.twig` - Add archive button
- `config/request_policy_configs.php` - Add archive permission

### Acceptance Criteria

- [ ] Migration adds `deleted` column (DATETIME, nullable) to assessments table
- [ ] Migration adds index on `deleted` column
- [ ] `AssessmentsTable` uses soft delete behavior (excludes deleted by default)
- [ ] "Archive Assessment" button appears on assessment view page
- [ ] Button only visible to Global Admins and Affiliate Staff
- [ ] Button NOT visible to program end users
- [ ] Clicking button opens confirmation modal
- [ ] Modal displays warning: "Are you sure you want to archive this assessment?"
- [ ] Modal shows assessment name and program name
- [ ] Modal has "Yes" and "No" buttons
- [ ] Clicking "Yes" sets `deleted` timestamp to current datetime
- [ ] After archiving, user redirected to Program Details page
- [ ] Archived assessment removed from assessment lists
- [ ] Archived assessment excluded from all reports
- [ ] Archived assessment excluded from dashboard widgets
- [ ] Archived assessment data preserved in database (soft delete, not hard delete)
- [ ] Related data (goals, documents) preserved when assessment archived
- [ ] User cache cleared after archiving
- [ ] All assessment queries updated to exclude `deleted IS NOT NULL`
- [ ] Permission check enforces: global admins OR affiliate staff only

### Test Cases

#### Test: Archive button visibility - authorized users
```
Given: User is Global Admin
When: User views assessment page
Then: "Archive Assessment" button is visible

Given: User is Affiliate Staff
When: User views assessment page for program in their affiliate
Then: "Archive Assessment" button is visible
```

#### Test: Archive button hidden - unauthorized users
```
Given: User is Program end user
When: User views their own assessment
Then: "Archive Assessment" button is NOT visible
  And: Archive action is not accessible via URL manipulation
```

#### Test: Confirmation modal appears
```
Given: Authorized user clicks "Archive Assessment"
Then: Confirmation modal appears
  And: Modal shows warning: "Are you sure you want to archive this assessment?"
  And: Modal displays assessment name: "2025 Self-Assessment"
  And: Modal displays program name: "Youth Mentoring Program"
  And: Modal has "Yes" button
  And: Modal has "No" button
```

#### Test: Cancel archiving
```
Given: User clicks "Archive Assessment"
  And: Confirmation modal appears
When: User clicks "No" or closes modal
Then: Modal closes
  And: Assessment remains active (not archived)
  And: User stays on assessment page
```

#### Test: Archive assessment - soft delete
```
Given: User confirms archive action
When: Archive completes
Then: Assessment record still exists in database
  And: `deleted` column set to current timestamp
  And: User redirected to Program Details page
  And: Success message displayed
```

#### Test: Archived assessment hidden from lists
```
Given: Program has 3 assessments
When: User archives 1 assessment
  And: User views program's assessment list
Then: Only 2 assessments displayed
  And: Archived assessment NOT in list
```

#### Test: Archived assessment excluded from reports
```
Given: System has 100 active assessments
  And: 5 assessments archived
When: User runs assessment report
Then: Report shows 100 assessments
  And: Archived assessments NOT included
  And: Report counts exclude archived
```

#### Test: Archived assessment excluded from dashboards
```
Given: Dashboard widget shows "Total Assessments: 100"
When: User archives 1 assessment
  And: Dashboard refreshes
Then: Widget shows "Total Assessments: 99"
  And: Archived assessment NOT counted
```

#### Test: Related data preserved
```
Given: Assessment has 5 goals
  And: Assessment has 3 documents
When: Assessment is archived
Then: Assessment.deleted timestamp is set
  And: 5 goals still exist in database
  And: 3 documents still exist in database
  And: Related data preserved but hidden (via queries filtering deleted assessments)
```

#### Test: User cache cleared
```
Given: User has assessment cached in session
When: Assessment is archived
Then: User cache cleared
  And: Next page load shows updated data (assessment gone)
```

#### Test: Cannot archive via API without permission
```
Given: Program user attempts POST to /assessments/archive/{id} via API
When: Request submitted
Then: 403 Forbidden response
  And: Assessment NOT archived
```

### Definition of Done

- [ ] Migration created and tested
- [ ] Soft delete behavior added to AssessmentsTable
- [ ] Archive action implemented in controller
- [ ] Archive button added to view with permission check
- [ ] Confirmation modal implemented
- [ ] All assessment queries updated to exclude deleted
- [ ] All acceptance criteria met
- [ ] All test cases pass
- [ ] Code review completed and approved
- [ ] Tested with various user roles
- [ ] Works on staging environment with production-like data
- [ ] Performance impact assessed (index on deleted column)
- [ ] PM/client UAT approved
- [ ] No critical or high bugs

---

## Request 3: Goal Date Tracking

### Problem Statement

**Current State:**
Goals in the system lack date tracking. There is no way to capture:
- When a goal was started (start date)
- When a goal should be completed (target date)
- Timeline for goal achievement

**Business Impact:**
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
1. Add `start_date` (DATE, nullable) column to goals table
2. Add `target_completion_date` (DATE, nullable) column to goals table
3. Both fields are optional (can be left blank)
4. `start_date` auto-populates with current date on goal creation (editable)
5. Both dates editable in goal add/edit forms
6. HTML5 date pickers for user input
7. Validation: target date must be after start date (if both provided)
8. Backfill existing goals: set `start_date` from goal's `created` timestamp

**NOT Included:**
- Automated email reminders (adds significant cost)
- Visual indicators could be added later (red text for overdue goals)

**Files to Modify:**
- `config/Migrations/[TIMESTAMP]_AddDateFieldsToGoals.php` - Add columns + backfill
- `plugins/Programs/src/Model/Table/GoalsTable.php` - Add validation
- `plugins/Programs/templates/Admin/Goals/add.twig` - Add date fields
- `plugins/Programs/templates/Admin/Goals/edit.twig` - Add date fields
- `plugins/Programs/templates/Admin/Goals/view.twig` - Display dates
- `plugins/Programs/templates/Admin/Goals/index.twig` - Add date columns
- `plugins/Reports/` - Update goal reports to include dates

### Acceptance Criteria

- [ ] Migration adds `start_date` column (DATE, nullable) to goals table
- [ ] Migration adds `target_completion_date` column (DATE, nullable) to goals table
- [ ] Migration backfills `start_date` for existing goals from `created` timestamp
- [ ] Both date fields are optional (nullable)
- [ ] Goal add form includes `start_date` field (HTML5 date picker)
- [ ] Goal add form includes `target_completion_date` field (HTML5 date picker)
- [ ] `start_date` auto-populates with current date when creating new goal
- [ ] Both dates are editable by user
- [ ] Goal edit form includes both date fields (pre-populated if set)
- [ ] Validation: if both dates provided, target must be after start
- [ ] Validation error message: "Target completion date must be after start date"
- [ ] Invalid dates prevent goal save
- [ ] Goal view page displays both dates (if set)
- [ ] Goals list/index includes "Start Date" column
- [ ] Goals list/index includes "Target Date" column
- [ ] Dates formatted consistently: MM/DD/YYYY
- [ ] Goals list sortable by target_completion_date
- [ ] Goal reports include start_date and target_completion_date columns
- [ ] Goal exports include date fields
- [ ] Existing goals (created before migration) have start_date backfilled
- [ ] Goals without dates display blank/empty (not error)

### Test Cases

#### Test: Migration adds columns
```
Given: Database before migration
When: Migration runs
Then: goals table has `start_date` column (DATE, nullable)
  And: goals table has `target_completion_date` column (DATE, nullable)
  And: Migration completes successfully
```

#### Test: Existing goals backfilled
```
Given: Goal created on 2024-01-15
  And: Goal exists before migration
When: Migration runs
Then: Goal's start_date set to 2024-01-15
  And: Goal's target_completion_date remains null
```

#### Test: Create goal - start date auto-populates
```
Given: User creating new goal today (2025-10-28)
When: Goal add form loads
Then: start_date field pre-filled with "10/28/2025"
  And: Field is editable
  And: target_completion_date field is blank
```

#### Test: Save goal with dates
```
Given: User sets start_date = 10/28/2025
  And: User sets target_completion_date = 12/31/2025
When: User saves goal
Then: Goal saves successfully
  And: start_date stored as 2025-10-28
  And: target_completion_date stored as 2025-12-31
```

#### Test: Save goal without dates (optional)
```
Given: User leaves start_date blank
  And: User leaves target_completion_date blank
When: User saves goal
Then: Goal saves successfully
  And: Both date fields null in database
  And: No validation errors
```

#### Test: Date validation - target after start
```
Given: User sets start_date = 12/31/2025
  And: User sets target_completion_date = 01/01/2025
When: User saves goal
Then: Validation error appears
  And: Error message: "Target completion date must be after start date"
  And: Goal does NOT save
  And: User remains on form to correct
```

#### Test: Edit goal - dates preserved
```
Given: Goal has start_date = 10/28/2025
  And: Goal has target_completion_date = 12/31/2025
When: User opens goal edit form
Then: start_date field shows "10/28/2025"
  And: target_completion_date field shows "12/31/2025"
  And: Both fields editable
```

#### Test: Goal view displays dates
```
Given: Goal has start_date and target_completion_date
When: User views goal details page
Then: Start date displays as "10/28/2025"
  And: Target date displays as "12/31/2025"
  And: Dates clearly labeled
```

#### Test: Goals list includes date columns
```
Given: User viewing goals list/index
Then: Table has "Start Date" column
  And: Table has "Target Date" column
  And: Dates displayed in MM/DD/YYYY format
  And: Blank if date not set
```

#### Test: Sort goals by target date
```
Given: Goals list with 5 goals
When: User clicks "Target Date" column header
Then: Goals sort by target_completion_date ascending
  And: Goals without target date appear at end
When: User clicks again
Then: Goals sort descending
  And: Goals without target date appear at end
```

#### Test: Goal report includes dates
```
Given: User runs goal report
When: Report generates
Then: Report includes "Start Date" column
  And: Report includes "Target Completion Date" column
  And: Dates formatted consistently
  And: Export includes date columns
```

#### Test: HTML5 date picker works
```
Given: User on goal add form
When: User clicks start_date field
Then: Browser date picker opens
  And: User can select date from calendar
  And: Selected date populates field
```

### Definition of Done

- [ ] Migration created with column additions and backfill logic
- [ ] Migration tested on staging database
- [ ] Validation added to GoalsTable
- [ ] Date fields added to add/edit forms
- [ ] HTML5 date pickers implemented
- [ ] Dates displayed on goal view page
- [ ] Date columns added to goals list
- [ ] Sorting by date implemented
- [ ] Reports updated to include dates
- [ ] All acceptance criteria met
- [ ] All test cases pass
- [ ] Code review completed and approved
- [ ] Tested with various date scenarios (valid, invalid, null)
- [ ] Works on staging environment
- [ ] Backfill tested with production-like data
- [ ] PM/client UAT approved
- [ ] No critical or high bugs

---

## Request 4: Delete Goals

### Problem Statement

**Current State:**
There is no way to delete goals in the system. This creates issues when:
- Goals created on wrong question (data entry error)
- Duplicate goals created by mistake
- Section goals need to be converted to question goals (old goal cannot be removed)
- Goals created with incorrect information

**Business Impact:**
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

**Files to Modify:**
- `plugins/Programs/src/Controller/Admin/GoalsController.php` - Add delete action
- `plugins/Programs/templates/Admin/Goals/view.twig` - Add delete button
- `config/request_policy_configs.php` - Add delete permission (if needed)

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
- [ ] Related records handled appropriately (cascade or cleanup)
- [ ] User cache cleared after deletion
- [ ] Permission check enforces: only users with edit permissions can delete
- [ ] Cannot delete via API without proper permissions

### Test Cases

#### Test: Delete button visibility - authorized users
```
Given: User is NQMS staff (reviewer/affiliate)
When: User views goal page
Then: "Delete Goal" button is visible
  And: Button is enabled
```

#### Test: Delete button hidden - unauthorized users
```
Given: User is Program end user
When: User views goal page
Then: "Delete Goal" button is NOT visible
  And: Delete action not accessible via URL
```

#### Test: Confirmation modal appears
```
Given: Authorized user clicks "Delete Goal"
Then: Confirmation modal appears
  And: Modal shows warning: "This action cannot be undone"
  And: Modal displays goal name: "Improve mentor training attendance"
  And: Modal displays question context
  And: Modal has "Yes, Delete" button
  And: Modal has "Cancel" button
```

#### Test: Cancel deletion
```
Given: User clicks "Delete Goal"
  And: Confirmation modal appears
When: User clicks "Cancel"
Then: Modal closes
  And: Goal remains in system (not deleted)
  And: User stays on goal page
```

#### Test: Delete goal - permanent removal
```
Given: User confirms delete action
When: Delete completes
Then: Goal record permanently removed from database
  And: User redirected to program or assessment page
  And: Success message: "Goal deleted successfully"
```

#### Test: Deleted goal removed from lists
```
Given: Assessment has 5 goals
When: User deletes 1 goal
  And: User views goals list
Then: Only 4 goals displayed
  And: Deleted goal NOT in list
```

#### Test: Deleted goal removed from reports
```
Given: System has 100 goals
When: User deletes 1 goal
  And: User runs goal report
Then: Report shows 99 goals
  And: Deleted goal NOT included
```

#### Test: Deleted goal removed from assessment export
```
Given: Assessment has 3 goals
When: User deletes 1 goal
  And: User exports assessment (Request 1B)
Then: CSV shows only 2 goals
  And: Deleted goal NOT in export
```

#### Test: Related records cleaned up
```
Given: Goal has related records (goal updates, history)
When: Goal is deleted
Then: Related records handled via cascade delete
  And: No orphaned data remains
  And: No foreign key constraint errors
```

#### Test: User cache cleared
```
Given: User has goals cached in session
When: Goal is deleted
Then: User cache cleared
  And: Next page load shows updated goal list
```

#### Test: Permission check enforced
```
Given: Program user attempts DELETE /goals/{id} via API
When: Request submitted
Then: 403 Forbidden response
  And: Goal NOT deleted
```

### Definition of Done

- [ ] Delete action implemented in GoalsController
- [ ] Delete button added to goal view page
- [ ] Permission check enforces authorized users only
- [ ] Confirmation modal implemented
- [ ] Hard delete removes goal from database
- [ ] Related records cleaned up (cascade)
- [ ] All acceptance criteria met
- [ ] All test cases pass
- [ ] Code review completed and approved
- [ ] Tested with various user roles
- [ ] Works on staging environment
- [ ] PM/client UAT approved
- [ ] No critical or high bugs

---

## Request 5: Remove Section Goals

### Problem Statement

**Current State:**
Section goals feature exists in the system but causes multiple problems:
- No way to identify if section goals are completed
- Section goals show as "complete" even when they are not
- Section goals don't appear in goal reports
- Section goals show as complete on dashboard when they shouldn't
- Confusion about when to use section goals vs question goals
- Cannot delete section goals to convert them to question goals

**Business Impact:**
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

**Files to Modify:**
- `config/Migrations/[TIMESTAMP]_RemoveSectionGoals.php` - Delete section goals
- `plugins/Programs/templates/Admin/Goals/add.twig` - Remove section option
- `plugins/Programs/src/Controller/Admin/GoalsController.php` - Remove section logic
- `plugins/Programs/src/Model/Table/GoalsTable.php` - Update validation
- `plugins/Reports/` - Remove section goal queries
- Dashboard widgets - Remove section goal logic

### Acceptance Criteria

- [ ] Migration script counts existing section goals before deletion
- [ ] Migration output logs: "Deleting X section goals..."
- [ ] Migration permanently deletes all section goals (hard delete)
- [ ] Migration completes successfully with or without section goals
- [ ] "Add Section Goal" option removed from goal creation form
- [ ] Only "Question Goal" option available in UI
- [ ] Form validation prevents section goal creation
- [ ] Validation error if user attempts to create section goal
- [ ] Section goal logic removed from GoalsController
- [ ] Section goal conditionals removed from views
- [ ] Reports exclude section goal queries
- [ ] Dashboard widgets exclude section goal logic
- [ ] Help text updated to clarify only question goals supported
- [ ] No errors when viewing old assessments that had section goals
- [ ] System handles references to deleted section goals gracefully

### Test Cases

#### Test: Migration counts section goals
```
Given: Database has 12 section goals
When: Migration runs
Then: Migration output shows: "Found 12 section goals to delete"
  And: Count logged before deletion
```

#### Test: Migration deletes all section goals
```
Given: Database has 12 section goals
  And: Database has 100 question goals
When: Migration runs
Then: All 12 section goals permanently deleted
  And: 100 question goals remain unchanged
  And: Migration completes successfully
```

#### Test: Migration handles zero section goals
```
Given: Database has 0 section goals
When: Migration runs
Then: Migration completes successfully
  And: Output shows: "No section goals found"
  And: No errors thrown
```

#### Test: Section goal option removed from UI
```
Given: User creating new goal
When: User views goal creation form
Then: Only "Question Goal" option appears
  And: Goal type dropdown/radio shows single option
  And: "Section Goal" option NOT visible
```

#### Test: Form validation prevents section goals
```
Given: User manipulates form to set goal_type = 'section'
When: User submits form
Then: Validation error appears
  And: Error message: "Section goals are not supported"
  And: Goal NOT saved
```

#### Test: Cannot create section goal via API
```
Given: User attempts POST /goals with goal_type = 'section'
When: Request submitted
Then: 422 Unprocessable Entity response
  And: Validation error in response
  And: Goal NOT created
```

#### Test: Reports exclude section goals
```
Given: Goal report query executed
When: Report generates
Then: Query does NOT check for goal_type = 'section'
  And: Report displays only question goals
  And: No errors related to section goals
```

#### Test: Dashboard excludes section goals
```
Given: Dashboard widget shows goal statistics
When: Widget loads
Then: Calculations exclude section goals
  And: Only question goals counted
  And: No errors in widget
```

#### Test: Code cleanup - no section goal conditionals
```
Given: Developer reviews codebase
Then: No "if goal_type == 'section'" conditionals remain
  And: No section goal-specific view logic
  And: Code simplified to single goal type
```

#### Test: Help text updated
```
Given: User views goal creation form
Then: Help text indicates "Create goals for specific assessment questions"
  And: No mention of section goals
  And: Clear guidance on question goals only
```

#### Test: Old assessments with deleted section goals
```
Given: Assessment previously had 2 section goals (now deleted)
When: User views old assessment
Then: No errors displayed
  And: Assessment displays normally
  And: Question goals still visible
  And: No broken links or references
```

### Definition of Done

- [ ] Migration created with section goal deletion logic
- [ ] Migration tested on staging with production-like data
- [ ] Section goal option removed from UI
- [ ] Form validation updated
- [ ] Controller logic cleaned up
- [ ] View conditionals removed
- [ ] Reports updated
- [ ] Dashboard widgets updated
- [ ] All acceptance criteria met
- [ ] All test cases pass
- [ ] Code review completed and approved
- [ ] No references to section goals remain in code
- [ ] Works on staging environment
- [ ] Data analysis confirms all section goals removed
- [ ] PM/client UAT approved
- [ ] No critical or high bugs

---

## Request 6: Assessment Goals Tab

### Problem Statement

**Current State:**
Once all goals are completed, the "goals button" at the top of the assessment page disappears, making it impossible to view goals without running a report. There is no centralized, always-visible location to see all assessment goals for a program.

**Business Impact:**
- Reviewers lose visibility into completed goals
- Must navigate to separate Goals Report to view goals
- No quick reference for goal status during program check-ins
- Poor UX for frequently-needed information
- Cannot see all program goals in one place

**User Need:**
Reviewers need permanent, easily accessible view of all program assessment goals (both completed and incomplete) without running reports or hunting for hidden UI elements.

### Proposed Solution

**Approach:** New tab on Program Details page with goals table

**How It Works:**
1. Add "Assessment Goals" tab to Program Details page navigation
2. Tab appears between "NQMS" and "Documents" tabs
3. Tab displays table with all assessment goals for the program
4. Table shows 10 columns: Section, Question, Question Rating, Goal, Baseline, Target, Achieved, Created, Updated, Actions
5. Table includes both completed and incomplete goals
6. "Edit Goal" button in Actions column (authorized users only)
7. Empty state message if no goals exist
8. Goals from all assessments displayed (not just most recent)
9. Section goals excluded (after Request 5 implementation)

**Table Columns:**
1. Section - Assessment section name
2. Question - Question text (truncated with tooltip)
3. Question Rating - Current rating (1-5)
4. Goal - Goal name/title
5. Baseline Rating - Starting rating
6. Target Rating - Desired rating
7. Achieved Rating - Actual rating achieved
8. Goal Created - Date/time created
9. Goal Updated - Date/time last modified
10. Actions - Edit button (if authorized)

**Files to Modify:**
- `plugins/Programs/src/Controller/Admin/ProgramsController.php` - Add `assessmentGoals($id)` action
- `plugins/Programs/templates/Admin/Programs/view.twig` - Add tab to navigation
- `plugins/Programs/templates/Admin/Programs/assessment_goals.twig` - Create goals table view
- `config/request_policy_configs.php` - Add permission (if needed)

### Acceptance Criteria

- [ ] "Assessment Goals" tab added to Program Details page navigation
- [ ] Tab appears between "NQMS" and "Documents" tabs
- [ ] Tab visible to users with program view permissions
- [ ] Clicking tab loads goals table view
- [ ] Table displays 10 columns in specified order
- [ ] All goals for program displayed in table
- [ ] Goals from all assessments included (not just most recent)
- [ ] Goals ordered by section, then question order
- [ ] Long question text truncated with ellipsis (...) after ~50 characters
- [ ] Full question text appears on hover (tooltip)
- [ ] Empty state message if no goals: "No goals set for this program"
- [ ] Both completed and incomplete goals displayed
- [ ] Archived assessments' goals excluded
- [ ] Section goals excluded (after Request 5)
- [ ] "Edit Goal" button in Actions column
- [ ] Edit button only visible to users with goal edit permissions
- [ ] Edit button opens goal edit page or modal
- [ ] Table responsive: horizontal scroll on mobile if needed
- [ ] Tab accessible to NQMS staff (reviewers/affiliates)
- [ ] Tab accessible to program users (if they have view access)
- [ ] Query optimized to avoid N+1 problems
- [ ] Page loads in <3 seconds

### Test Cases

#### Test: Tab appears in navigation
```
Given: User viewing Program Details page
Then: Navigation shows tabs: Details | Program Administrators | NQMS | Assessment Goals | Documents
  And: "Assessment Goals" tab is visible
  And: Tab is clickable
```

#### Test: Tab loads goals table
```
Given: Program has 5 assessment goals
When: User clicks "Assessment Goals" tab
Then: Page loads goals table
  And: Table displays 10 columns
  And: Table shows all 5 goals
  And: Goals ordered by section, then question
```

#### Test: Table column structure
```
Given: User viewing Assessment Goals tab
Then: Table header shows: Section | Question | Question Rating | Goal | Baseline Rating | Target Rating | Achieved Rating | Goal Created | Goal Updated | Actions
  And: All headers clearly labeled
  And: Columns aligned properly
```

#### Test: Long question text truncated
```
Given: Question text is 150 characters long
When: Displayed in table
Then: Text truncated to ~50 characters
  And: Ellipsis (...) appears at truncation point
When: User hovers over text
Then: Tooltip appears with full question text
```

#### Test: Edit button for authorized users
```
Given: User is NQMS staff with goal edit permissions
When: User views Assessment Goals tab
Then: "Edit Goal" button appears in Actions column for each goal
  And: Button is clickable

Given: User is Program end user without edit permissions
Then: Actions column is empty OR shows "View" only
  And: "Edit Goal" button does NOT appear
```

#### Test: Empty state - no goals
```
Given: Program has no assessment goals
When: User views Assessment Goals tab
Then: Message displays: "No goals set for this program"
  And: Table does not display
  And: No errors shown
```

#### Test: Shows goals from all assessments
```
Given: Program has 2 completed assessments
  And: First assessment (2023) has 3 goals
  And: Second assessment (2024) has 4 goals
When: User views Assessment Goals tab
Then: Table shows all 7 goals
  And: Goals from both assessments visible
  And: Assessment year/name may be indicated
```

#### Test: Excludes archived assessment goals
```
Given: Program has 1 active assessment with 3 goals
  And: Program has 1 archived assessment with 2 goals (Request 2A)
When: User views Assessment Goals tab
Then: Table shows only 3 goals from active assessment
  And: Archived assessment goals NOT displayed
```

#### Test: Excludes section goals
```
Given: Program has 4 question goals
  And: Program has 1 section goal (legacy data before Request 5)
When: User views Assessment Goals tab
Then: Table shows only 4 question goals
  And: Section goal NOT displayed
```

#### Test: Tab permissions - authorized access
```
Given: User has view access to program
When: User navigates to Program Details page
Then: Assessment Goals tab is visible
  And: User can click tab and view goals
```

#### Test: Tab permissions - unauthorized access
```
Given: User does NOT have view access to program
When: User attempts to access Assessment Goals tab via URL
Then: 403 Forbidden OR redirect to login
  And: Goals not displayed
```

#### Test: Goals ordered correctly
```
Given: Program has goals from Section A (3 goals) and Section B (2 goals)
When: User views Assessment Goals tab
Then: Section A goals appear first (in question order)
  And: Section B goals appear next (in question order)
  And: Goals sorted by section, then question
```

#### Test: Date formatting
```
Given: Goal created on 2025-04-01 at 14:30:00
When: Displayed in table
Then: Goal Created shows "04/01/2025 2:30 PM"
  And: Date format consistent across all goals
```

#### Test: Responsive design - mobile
```
Given: User viewing tab on mobile device (width < 768px)
When: Table loads
Then: Table displays with horizontal scroll
  Or: Most important columns visible, others accessible via scroll
  And: All data remains accessible
```

#### Test: Edit goal action
```
Given: User clicks "Edit Goal" button
When: Button clicked
Then: User navigated to goal edit page
  Or: Modal opens with goal edit form
  And: User can modify goal details
```

#### Test: Performance with many goals
```
Given: Program has 50 goals
When: User clicks Assessment Goals tab
Then: Page loads in < 3 seconds
  And: All 50 goals displayed
  And: No performance degradation
```

### Definition of Done

- [ ] New tab added to Program Details navigation
- [ ] `assessmentGoals()` controller action implemented
- [ ] Goals table view template created
- [ ] Query optimized for performance (includes, joins)
- [ ] All 10 columns displayed correctly
- [ ] Empty state handled
- [ ] Edit button shown to authorized users only
- [ ] Responsive design implemented
- [ ] All acceptance criteria met
- [ ] All test cases pass
- [ ] Code review completed and approved
- [ ] Tested with programs having 0, 5, 50 goals
- [ ] Tested with multiple assessments per program
- [ ] Works on staging environment
- [ ] Performance acceptable (loads in <3 seconds)
- [ ] PM/client UAT approved
- [ ] No critical or high bugs

---

## Implementation Dependencies

### Request Dependencies

**Can be implemented independently:**
- Request 1A (Print Assessment)
- Request 1B (Export Assessment)
- Request 2A (Archive Assessments)
- Request 4 (Delete Goals)

**Request 5 (Remove Section Goals) should be implemented before:**
- Request 6 (Assessment Goals Tab) - ensures tab only shows question goals

**Request 3 (Goal Dates) should be implemented before:**
- Request 6 (Assessment Goals Tab) - tab can display date columns

**Suggested implementation order:**
1. Request 1B (Export) - High priority, independent
2. Request 2A (Archive) - Independent, enables cleanup
3. Request 3 (Goal Dates) - Foundation for timeline features
4. Request 5 (Section Goals) - Cleanup technical debt
5. Request 4 (Delete Goals) - Administrative capability
6. Request 6 (Goals Tab) - Enhanced visibility (depends on 3, 5)
7. Request 1A (Print) - Nice-to-have, may not be needed

---

## Out of Scope (All Requests)

- ❌ Request 2B: Delete Programs (handled in Mentoring Connector)
- ❌ PDF export (only CSV for Request 1B)
- ❌ Automated email reminders for goal deadlines
- ❌ Assessment restore after archiving
- ❌ Goal restore after deletion
- ❌ Bulk archive/delete operations
- ❌ Section goal conversion to question goals (delete only)
- ❌ Column sorting on Assessment Goals tab (Phase 2)
- ❌ Filtering/search on Assessment Goals tab (Phase 2)
- ❌ Goal timeline/calendar view (Phase 2)
- ❌ Goal progress dashboard widgets (Phase 2)

---

## Overall Success Metrics

**Functional Success (30 days post-launch):**
- Zero critical bugs
- All test cases pass
- Client UAT sign-off for all requests

**User Adoption (30 days post-launch):**
- 10+ assessment exports performed
- 5+ assessments archived
- 20+ goals created with target dates
- 50%+ of NQMS users access Assessment Goals tab

**Performance:**
- Export CSV completes in <5 seconds
- Archive action completes in <2 seconds
- Assessment Goals tab loads in <3 seconds
- Print preview loads in <2 seconds

---

## Related Documents

- [NQMS Assessment Requests (Source)](/Users/aksana/Documents/Projects/Mentor/NewScope/NQMS_Assessment_Requests.md)
- [Meeting 3 Notes](/Users/aksana/Documents/Projects/Mentor/Meetings/Meeting3.md)
- CSV Sample File: `single_program_assessment_details__with_goals_2025-10-22T20_37_22.155026625Z.csv`
- Screenshot: Assessment Goals Tab UI (`/Users/aksana/Desktop/Screenshot 2025-10-22 at 4.12.40 PM.png`)

---

**Status:** ✅ Ready for Developer Estimation

**Next Steps:**
1. Review each request with development team
2. Estimate effort per request
3. Prioritize implementation order
4. Schedule sprints/releases
