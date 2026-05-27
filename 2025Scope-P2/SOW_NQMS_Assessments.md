# NQMS Assessments Feature - Scope of Work

## Document Purpose
This document defines the scope of work for the new NQMS Assessments section, which replaces the previous NQMS Reports concept. The feature provides a centralized view for searching and filtering assessments across programs, with the ability to generate custom downloadable reports for data analysis.

---

## Enhancement Requests Overview

This SOW includes **4 enhancement requests** organized by functionality:

1. **Request 1: View Assessments Page with Advanced Filtering**
2. **Request 2: Global Report - Comprehensive Assessment Data Export**
3. **Request 3: Aggregate Report - Question Summary Export**
4. **Request 4: Goals Report - Goals Summary by Question Export**

---

## Request 1: View Assessments Page with Advanced Filtering

### Problem Statement
Users currently lack a centralized view to search and filter assessments across multiple programs. Without this capability, users cannot easily identify assessments by affiliate, location, program characteristics, date ranges, or assessment status. This makes it difficult to:
- Find specific assessments for review
- Identify programs needing assessment completion
- Generate filtered reports for specific cohorts
- Track assessment progress across regions or program types

### Proposed Solution
Create a new "NQMS Assessments" section accessible from the main navigation menu. This page displays all assessments in a searchable, filterable table view with the following capabilities:

#### Page Layout
- **Header**: "NQMS Assessments" with subtitle "View and manage program assessments"
- **Action Buttons**: Three report generation buttons (Global Report, Aggregate Report, Goals Report)
- **Filter Panel**: Collapsible accordion with comprehensive filtering options
- **Results Table**: Paginated table showing filtered assessments

#### Filter Options
The filter panel includes the following fields:

1. **Affiliates** (Multi-select autocomplete)
   - Start typing affiliate name
   - Add/Remove buttons to build filter list
   - Applies to program's affiliate membership

2. **Cities** (Multi-select autocomplete)
   - Searches physical address city name
   - Add/Remove buttons to build filter list

3. **State** (Dropdown)
   - Single select from US states
   - Searches service area State

4. **Types of Mentoring Opportunities Offered** (Multi-checkbox)
   - 1:1 (One-to-One)
   - E-Mentoring / Virtual Mentoring
   - Group
   - Other
   - Peer
   - School-based 1:1
   - Team

5. **Grade(s) Program Serves** (Multi-checkbox)
   - 6-8
   - 9-12
   - College
   - K-5

6. **Mentee Categories / Youth Served** (Multi-checkbox)
   - Academically at-risk
   - Adjudicated / court involved
   - College / post-secondary student
   - Disabilities / special care needs
   - First-generation college
   - Foster, residential or kinship care
   - Gang at-risk
   - Gang involved
   - General youth population
   - Gifted / talented / academic achiever
   - Homeless / runaway
   - Incarcerated parent
   - LGBTQ youth
   - Low income
   - Mental health issues
   - Newcomer / Recent immigrant / refugee
   - Opportunity youth
   - Other
   - Parent involved in military
   - Pregnant / parenting
   - School drop-out
   - Single-parent household
   - Special education
   - Youth with disabilities

7. **Assessment Date (from)** (Date picker)
   - Filter assessments started on or after this date
   - Format: mm/dd/yyyy

8. **Assessment Date (to)** (Date picker)
   - Filter assessments started on or before this date
   - Format: mm/dd/yyyy

9. **Estimated Number Youths Served (from)** (Text input)
   - Lower limit for youth served range
   - Numeric input

10. **Estimated Number Youths Served (to)** (Text input)
    - Upper limit for youth served range
    - Numeric input

11. **Assessment Status** (Multi-checkbox)
    - In Progress
    - Completed
    - Goals Completed
    - Pending Review
    - Not Started

**Filter Actions:**
- **Reset Filter**: Clears all filter selections
- **Apply Filter**: Applies selected filters to table

#### Results Table Columns
| Column | Description | Data Source |
|--------|-------------|-------------|
| Program Name | Name of the program (clickable link to program details page) | `programs.name` |
| Assessment Title | Title of assessment (e.g., "2023 Self-Assessment") | `assessments.title` or derived from year |
| Assessment Status | Current status badge (uses same logic as main dashboard page) | `assessments.status` |
| Assessment Start Date | Date assessment was started | `assessments.start_date` |
| % Complete | Percentage of questions answered (calculated same way as main dashboard page) | Calculated from answered questions |
| Approved On | Date assessment was approved | `assessments.approved_date` |
| Actions | View/Edit button and Delete icon | Action buttons |

**Important Note:**
- **Assessment Status** and **% Complete** values are set and calculated using the exact same logic as the assessments table on the main dashboard page. This ensures consistency across the application.

**Table Features:**
- Sortable columns (Program Name, Assessment Title, Start Date, % Complete, Approved On)
- Pagination
- Row selection with checkboxes (for future bulk actions)
- **Program Name is a clickable link** that navigates to program details page (`/admin/programs/view/{id}`)
- "View/Edit" button navigates to assessment details page
- Delete icon (trash can) for assessment deletion (with confirmation)

#### Report Generation Buttons
Three buttons at the top generate reports based on currently applied filters:
- **View Global Report (X Assessments)**: Opens Global Report modal
- **View Aggregate Report (X Assessments)**: Opens Aggregate Report modal
- **View Goals Report (X Assessments)**: Opens Goals Report modal

The count (X) dynamically updates based on filtered results.

### Acceptance Criteria

#### Filter Functionality
- [ ] All filter fields correctly filter assessments in the results table
- [ ] Multiple filters combine with AND logic (all conditions must match)
- [ ] Multi-select filters use OR logic within each filter type
- [ ] Date range filters work correctly for "from" and "to" dates
- [ ] Numeric range filters work correctly for youth served counts
- [ ] "Reset Filter" button clears all selections and shows all assessments
- [ ] "Apply Filter" button applies current filter selections to table
- [ ] Filter panel is collapsible (accordion behavior)
- [ ] Filter selections persist when user navigates back to page

#### Results Table
- [ ] Table displays all assessments when no filters applied
- [ ] Table updates when filters are applied
- [ ] Sortable columns sort correctly (ascending/descending)
- [ ] Pagination works correctly
- [ ] Program Name is clickable link that navigates to program details page
- [ ] Program Name link navigates to correct program (by program_id)
- [ ] "View/Edit" button navigates to correct assessment
- [ ] Delete icon shows confirmation dialog
- [ ] Delete removes assessment (soft delete - archived status)
- [ ] Assessment status badges display correct colors and text
- [ ] % Complete calculates correctly based on answered questions
- [ ] Empty state message shows when no assessments match filters

#### Report Generation
- [ ] Report button counts update dynamically based on filtered results
- [ ] Clicking each report button opens correct modal with filtered data
- [ ] Reports only include assessments matching current filter criteria
- [ ] Reports show "0 assessments" message if no results match filters

#### Access Control
- [ ] Only authorized users can access NQMS Assessments section
- [ ] Users only see assessments for programs they have permission to view
- [ ] Users can only delete assessments if they have delete permissions
- [ ] Users can only edit assessments if they have edit permissions

### Technical Implementation Notes

#### Code Reuse
- **Assessment Status Logic**: Reuse the exact same status determination logic from the main dashboard assessments table
- **% Complete Calculation**: Reuse the exact same percentage calculation logic from the main dashboard assessments table
- This ensures consistency across the application and reduces duplicate code

#### Database Schema
- Filter queries will need to join multiple tables:
  - `assessments`
  - `programs`
  - `affiliates_programs` (for affiliate filtering)
  - `physical_addresses` (for city/state filtering)
  - `program_mentoring_types` (for mentoring types)
  - `program_grades` (for grade levels)
  - `program_youth_categories` (for mentee categories)

#### Performance Considerations
- Add database indexes for frequently filtered columns
- Consider caching filter options (affiliates list, cities list)
- Implement pagination server-side (limit 50 results per page)
- Use AJAX for filter application (no full page reload)

#### CakePHP Components
- **Controller**: `Admin/AssessmentsController::nqmsIndex()`
- **View Template**: `templates/Admin/Assessments/nqms_index.twig`
- **Routes**: `/admin/assessments/nqms`
- **Shared Methods**: Reference existing dashboard methods for status and completion calculations

### Test Cases

#### TC1: View All Assessments (No Filters)
**Given** user navigates to NQMS Assessments page
**When** no filters are applied
**Then** all assessments user has permission to view are displayed
**And** table shows all columns with correct data
**And** report buttons show total assessment count

#### TC2: Filter by Single Affiliate
**Given** user is on NQMS Assessments page
**When** user selects "Big Brothers Big Sisters of Colorado" in Affiliates filter
**And** clicks "Apply Filter"
**Then** only assessments for programs affiliated with BBBS Colorado are shown
**And** report button counts update to match filtered results

#### TC3: Filter by Multiple Criteria (Combined AND)
**Given** user is on NQMS Assessments page
**When** user selects:
- State: "Colorado"
- Grade(s) Program Serves: "6-8"
- Assessment Status: "Completed"
**And** clicks "Apply Filter"
**Then** only completed assessments for programs in Colorado serving grades 6-8 are shown

#### TC4: Filter by Date Range
**Given** user is on NQMS Assessments page
**When** user enters:
- Assessment Date (from): "01/01/2024"
- Assessment Date (to): "12/31/2024"
**And** clicks "Apply Filter"
**Then** only assessments started in 2024 are shown

#### TC5: Reset Filter
**Given** user has applied multiple filters
**And** table shows filtered results
**When** user clicks "Reset Filter"
**Then** all filter fields are cleared
**And** table shows all assessments again
**And** report button counts update to total assessments

#### TC6: Delete Assessment
**Given** user views assessment in results table
**When** user clicks delete (trash) icon
**Then** confirmation dialog appears
**When** user confirms deletion
**Then** assessment is soft-deleted (archived)
**And** assessment no longer appears in results table
**And** success message is displayed

#### TC7: Sort Table Columns
**Given** user views assessments in table
**When** user clicks "Program Name" column header
**Then** table sorts alphabetically by program name (ascending)
**When** user clicks "Program Name" header again
**Then** table sorts in descending order

#### TC8: Report Button Count Updates
**Given** user is on NQMS Assessments page
**And** 71 assessments are displayed
**When** user applies filter reducing results to 15 assessments
**Then** report buttons update to show "(15 Assessments)"

### Definition of Done
- [ ] Code implemented and tested in development environment
- [ ] All acceptance criteria met and verified
- [ ] All test cases pass
- [ ] Code reviewed and approved
- [ ] Database migrations created and tested
- [ ] Performance tested with large datasets (1000+ assessments)
- [ ] Responsive design works on mobile/tablet
- [ ] Accessibility standards met (WCAG 2.1 AA)
- [ ] User documentation updated
- [ ] Deployed to staging for client UAT

---

## Request 2: Global Report - Comprehensive Assessment Data Export

### Important Note
**This report is a combined/consolidated report that replaces 3 existing reports currently in the system:**
1. NQMS Aggregate Report
2. Assessment Details Report
3. Goals Report

The Global Report consolidates the functionality of all three reports into a single comprehensive view.

### Problem Statement
Users need a comprehensive view of all assessment data across multiple programs to:
- Analyze question performance across programs
- Calculate average ratings for each question
- Understand rating distributions (how many programs rated 0, 1, 2, 3, 4, 5, N/A)
- Identify questions with low or high ratings
- Export data for further analysis in Excel or statistical software

Without this report, users must manually compile data from individual assessments, which is time-consuming and error-prone.

### Proposed Solution
Create a "Global Report" that displays comprehensive assessment data with **questions as rows** (not programs as rows). This report shows aggregated statistics for each question across all filtered assessments.

**Two implementation options are provided for client estimation:**

---

## OPTION 1: View Page with Export Button (Enhanced UX)

**Estimated Complexity:** Medium (4-6 days)

This option provides a full report preview experience before exporting.

#### Report Layout
The Global Report opens in a modal dialog with the following structure:

**Modal Header:**
- Title: "NQMS Global Report"
- Subtitle: "Comprehensive data based on X filtered assessment(s)"
- Close button (X)

**Report Summary:**
- Display line: "Total # of programs in this report: XX"
- This count represents the unique number of programs included in the filtered assessment set

**Export Button:**
- "Export as CSV" button (top right)

**Data Table Columns:**

| Column | Description | Data Type | Calculation |
|--------|-------------|-----------|-------------|
| Number of Assessments | Total assessments in filtered set | Integer | Count of filtered assessments |
| Programs With Ratings | Number of programs that rated this question | Integer | Count of non-N/A responses |
| Section Title | Section name (e.g., "A. Mentoring Program Design and Planning") | Text | From assessment structure |
| Question | Full question text | Text | From assessment structure |
| Question Average Rating | Average of all numeric ratings | Decimal | AVG(ratings where rating != N/A) |
| Marked as N/A | Count of N/A responses | Integer | Count of N/A ratings |
| Marked as 0 | Count of 0 ratings | Integer | Count of rating = 0 |
| Marked as 1 | Count of 1 ratings | Integer | Count of rating = 1 |
| Marked as 2 | Count of 2 ratings | Integer | Count of rating = 2 |
| Marked as 3 | Count of 3 ratings | Integer | Count of rating = 3 |
| Marked as 4 | Count of 4 ratings | Integer | Count of rating = 4 |
| Marked as 5 | Count of 5 ratings | Integer | Count of rating = 5 |

**Table Features:**
- Fixed columns for "Number of Assessments" and "Programs With Ratings" (same value for all questions in filtered set)
- Questions grouped by section
- Scrollable table for large datasets
- All questions from assessment structure included (even if no ratings)

#### CSV Export Format
When "Export as CSV" is clicked, generate CSV file with:
- Filename: `NQMS_Global_Report_YYYYMMDD_HHMMSS.csv`
- All columns listed above
- One row per question
- UTF-8 encoding

#### Benefits of Option 1
- Users can preview data before exporting
- Easier to verify correct filters applied
- Better user experience for data validation
- Allows users to review without downloading

#### Technical Considerations
- Requires modal UI development
- Data table rendering for large datasets
- AJAX call to fetch report data
- CSV generation from displayed data

---

## OPTION 2: Direct Export (Quick Win)

**Estimated Complexity:** Low (2-3 days)

This option provides immediate CSV download without preview page.

#### User Experience
When user clicks "View Global Report (X Assessments)" button:
1. System immediately generates CSV file
2. CSV file downloads automatically
3. No preview modal displayed
4. Success message shown: "Global Report exported successfully"

#### CSV Export Format
CSV file generated with:
- Filename: `NQMS_Global_Report_YYYYMMDD_HHMMSS.csv`
- All columns: Number of Assessments, Programs With Ratings, Section Title, Question, Question Average Rating, Marked as N/A, Marked as 0-5
- One row per question
- UTF-8 encoding
- Header row includes: "Total # of programs in this report: XX" as first line before column headers

#### Benefits of Option 2
- Faster implementation (lower cost)
- Simpler user workflow (one click to download)
- No modal development required
- Reduced server load (no data table rendering)

#### Technical Considerations
- Direct CSV generation and download
- Include report metadata in CSV header
- Single controller action for export
- Progress indicator during generation

---

### CSV Format (Both Options)
Both options produce identical CSV output:

**CSV Header Section:**
```
Total # of programs in this report: XX
Comprehensive data based on X filtered assessment(s)

[Column Headers]
Number of Assessments,Programs With Ratings,Section Title,Question,Question Average Rating,Marked as N/A,Marked as 0,Marked as 1,Marked as 2,Marked as 3,Marked as 4,Marked as 5
[Data Rows...]
```

### Acceptance Criteria

#### OPTION 1: View Page with Export Button

**Report Display**
- [ ] Modal opens when "View Global Report" button clicked
- [ ] Report displays data for all filtered assessments
- [ ] "Total # of programs in this report: XX" displays correct unique program count
- [ ] Program count correctly counts unique programs (not duplicate assessments from same program)
- [ ] "Number of Assessments" column shows correct count
- [ ] "Programs With Ratings" shows count of programs that answered each question
- [ ] Questions grouped by section
- [ ] All questions from assessment structure included
- [ ] Questions with no ratings show 0 for all rating counts
- [ ] Average rating calculated correctly (excludes N/A responses)
- [ ] Rating distribution counts are accurate (N/A, 0, 1, 2, 3, 4, 5)
- [ ] Table is scrollable for long question lists

**CSV Export**
- [ ] "Export as CSV" button generates CSV file
- [ ] CSV filename includes timestamp
- [ ] CSV includes all columns in correct order
- [ ] CSV data matches displayed report data
- [ ] CSV header includes report metadata (program count, assessment count)
- [ ] UTF-8 encoding preserves special characters
- [ ] CSV opens correctly in Excel

**Filter Integration**
- [ ] Report reflects currently applied filters from View Assessments page
- [ ] Changing filters and regenerating report updates data
- [ ] Report shows "0 assessments" message if no results match filters

---

#### OPTION 2: Direct Export

**Export Functionality**
- [ ] Clicking "View Global Report (X Assessments)" immediately triggers CSV download
- [ ] No modal or preview page displayed
- [ ] Success message shown after export starts
- [ ] CSV filename includes timestamp
- [ ] CSV includes all columns in correct order
- [ ] CSV header includes report metadata: "Total # of programs in this report: XX"
- [ ] CSV header includes: "Comprehensive data based on X filtered assessment(s)"
- [ ] Program count correctly counts unique programs (not duplicate assessments)
- [ ] All questions from assessment structure included
- [ ] Average rating calculated correctly (excludes N/A responses)
- [ ] Rating distribution counts are accurate (N/A, 0, 1, 2, 3, 4, 5)
- [ ] UTF-8 encoding preserves special characters
- [ ] CSV opens correctly in Excel

**Filter Integration**
- [ ] Export reflects currently applied filters from View Assessments page
- [ ] Export includes only filtered assessments
- [ ] If no assessments match filters, show error message and prevent export

---

#### Common Acceptance Criteria (Both Options)
- [ ] CSV format is identical for both options
- [ ] Data calculations are identical for both options
- [ ] Report respects user permissions (only includes assessments user can view)

### Missing Requirements to Define
1. **Question Order**: Should questions be ordered by section/question number, or by another criteria?
2. **Unanswered Questions**: If a program hasn't answered a question yet (in-progress assessment), should it count as N/A or be excluded?
3. **Archived Assessments**: Should archived/deleted assessments be included or excluded?
4. **Comments**: The current design doesn't show comments. Should there be a separate column for comments or should comments be excluded?
5. **Multiple Assessment Versions**: If assessment structure changes over time, how should we handle different question versions?
6. **Empty Sections**: Should sections with no ratings be displayed or hidden?

### Test Cases

#### OPTION 1: View Page with Export Button

**TC1-Opt1: Generate Global Report with All Assessments**
**Given** user is on NQMS Assessments page with no filters applied
**When** user clicks "View Global Report (71 Assessments)"
**Then** modal opens showing global report
**And** "Total # of programs in this report: XX" displays unique program count
**And** "Number of Assessments" shows 71
**And** all questions are displayed with correct aggregated data

**TC2-Opt1: Generate Global Report with Filtered Assessments**
**Given** user has filtered assessments to 15 results
**When** user clicks "View Global Report (15 Assessments)"
**Then** modal opens showing report based on 15 assessments only
**And** subtitle shows "Comprehensive data based on 15 filtered assessment(s)"
**And** "Total # of programs in this report: XX" shows correct unique program count for filtered set

**TC2a-Opt1: Verify Unique Program Count**
**Given** user has filtered assessments showing:
- Program A: 2 assessments (2023, 2024)
- Program B: 1 assessment (2024)
- Program C: 1 assessment (2023)
**When** user clicks "View Global Report (4 Assessments)"
**Then** report shows "Total # of programs in this report: 3"
**And** program count is 3 (not 4, because Program A counted once despite having 2 assessments)

---

#### OPTION 2: Direct Export

**TC1-Opt2: Direct Export Global Report with All Assessments**
**Given** user is on NQMS Assessments page with no filters applied
**When** user clicks "View Global Report (71 Assessments)"
**Then** CSV file downloads immediately
**And** No modal is displayed
**And** Success message shown: "Global Report exported successfully"
**And** CSV opens in Excel showing correct data

**TC2-Opt2: Direct Export with Filtered Assessments**
**Given** user has filtered assessments to 15 results
**When** user clicks "View Global Report (15 Assessments)"
**Then** CSV file downloads immediately
**And** CSV header shows "Comprehensive data based on 15 filtered assessment(s)"
**And** CSV includes only data from 15 filtered assessments

**TC2a-Opt2: Verify Unique Program Count in CSV**
**Given** user has filtered assessments showing:
- Program A: 2 assessments (2023, 2024)
- Program B: 1 assessment (2024)
- Program C: 1 assessment (2023)
**When** user clicks "View Global Report (4 Assessments)"
**Then** CSV downloads with header line "Total # of programs in this report: 3"
**And** program count is 3 (not 4, because Program A counted once despite having 2 assessments)

---

#### Common Test Cases (Both Options)

#### TC3: Verify Average Rating Calculation
**Given** global report is displayed
**And** question "Does your program have a mission statement?" has ratings: [4, 5, 5, 4, 5, N/A, 5]
**Then** "Programs With Ratings" shows 6 (excludes N/A)
**And** "Question Average Rating" shows 4.67 (average of 4,5,5,4,5,5)
**And** "Marked as N/A" shows 1

#### TC4: Export Global Report as CSV
**Given** global report modal is open
**When** user clicks "Export as CSV"
**Then** CSV file downloads with correct filename format
**And** CSV contains all columns and rows
**And** CSV data matches displayed report data

#### TC5: Rating Distribution Accuracy
**Given** global report shows question "Does your program have a Theory of Change?"
**And** ratings are: [N/A, N/A, N/A, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5]
**Then** distribution shows:
- Marked as N/A: 3
- Marked as 0: 15
- Marked as 1: 6
- Marked as 2: 9
- Marked as 3: 9
- Marked as 4: 12
- Marked as 5: 22

### Definition of Done
- [ ] Code implemented and tested in development environment
- [ ] All acceptance criteria met and verified
- [ ] All test cases pass
- [ ] Missing requirements clarified with client
- [ ] Code reviewed and approved
- [ ] CSV export tested with large datasets
- [ ] Performance tested (report generation < 3 seconds for 100 assessments)
- [ ] Deployed to staging for client UAT

---

## Request 3: Aggregate Report - Question Summary Export

### Problem Statement
Users need a simplified summary view of assessment questions showing:
- Average rating across all programs
- Distribution of ratings (counts for each rating level)
- Question performance analysis without section grouping

This differs from the Global Report by focusing on question-level summaries without the "Number of Assessments" and "Programs With Ratings" columns repeated for each row. It provides a cleaner view for analyzing individual question performance.

### Proposed Solution
Create an "Aggregate Report" that displays question-level summary data with ratings distribution.

**Two implementation options are provided for client estimation:**

---

## OPTION 1: View Page with Export Button (Enhanced UX)

**Estimated Complexity:** Medium (3-5 days)

This option provides a full report preview experience before exporting.

#### Report Layout
The Aggregate Report opens in a modal dialog:

**Modal Header:**
- Title: "NQMS Aggregate Report"
- Subtitle: "Summary data based on X filtered assessment(s)"
- Close button (X)

**Export Button:**
- "Export as CSV" button (top right)

**Data Table Columns:**

| Column | Description | Data Type |
|--------|-------------|-----------|
| Question Text | Full question text | Text |
| Average Rating | Average of all numeric ratings | Decimal (2 decimals) |
| N/A | Count of N/A responses | Integer |
| 0 | Count of 0 ratings | Integer |
| 1 | Count of 1 ratings | Integer |
| 2 | Count of 2 ratings | Integer |
| 3 | Count of 3 ratings | Integer |
| 4 | Count of 4 ratings | Integer |
| 5 | Count of 5 ratings | Integer |

**Table Features:**
- Questions listed in assessment order (sections not displayed as grouping)
- Scrollable table
- Clean, simplified view focused on question performance

#### CSV Export Format
When "Export as CSV" is clicked:
- Filename: `NQMS_Aggregate_Report_YYYYMMDD_HHMMSS.csv`
- All columns listed above
- One row per question
- UTF-8 encoding

#### Benefits of Option 1
- Users can preview data before exporting
- Easier to verify correct filters applied
- Better user experience for data validation
- Allows users to review question performance without downloading

#### Technical Considerations
- Requires modal UI development
- Data table rendering for large question lists
- AJAX call to fetch report data
- CSV generation from displayed data

---

## OPTION 2: Direct Export (Quick Win)

**Estimated Complexity:** Low (1-2 days)

This option provides immediate CSV download without preview page.

#### User Experience
When user clicks "View Aggregate Report (X Assessments)" button:
1. System immediately generates CSV file
2. CSV file downloads automatically
3. No preview modal displayed
4. Success message shown: "Aggregate Report exported successfully"

#### CSV Export Format
CSV file generated with:
- Filename: `NQMS_Aggregate_Report_YYYYMMDD_HHMMSS.csv`
- All columns: Question Text, Average Rating, N/A, 0, 1, 2, 3, 4, 5
- One row per question
- UTF-8 encoding
- Header row includes: "Summary data based on X filtered assessment(s)" as first line before column headers

#### Benefits of Option 2
- Faster implementation (lower cost)
- Simpler user workflow (one click to download)
- No modal development required
- Reduced server load (no data table rendering)

#### Technical Considerations
- Direct CSV generation and download
- Include report metadata in CSV header
- Single controller action for export
- Progress indicator during generation

---

### CSV Format (Both Options)
Both options produce identical CSV output:

**CSV Header Section:**
```
Summary data based on X filtered assessment(s)

[Column Headers]
Question Text,Average Rating,N/A,0,1,2,3,4,5
[Data Rows...]
```

### Acceptance Criteria

#### OPTION 1: View Page with Export Button

**Report Display**
- [ ] Modal opens when "View Aggregate Report" button clicked
- [ ] Report displays summary data for all filtered assessments
- [ ] All questions from assessment structure included in order
- [ ] Average rating calculated correctly (excludes N/A)
- [ ] Rating counts accurate for each level (N/A, 0-5)
- [ ] Average rating displays with 2 decimal places
- [ ] Table scrolls for long question lists

**CSV Export**
- [ ] "Export as CSV" button generates CSV file
- [ ] CSV filename includes timestamp
- [ ] CSV includes all columns
- [ ] CSV data matches displayed report
- [ ] CSV header includes report metadata
- [ ] UTF-8 encoding preserves special characters
- [ ] CSV opens correctly in Excel

**Filter Integration**
- [ ] Report reflects currently applied filters
- [ ] Report updates when filters change
- [ ] Report shows "0 assessments" message if no results match filters

---

#### OPTION 2: Direct Export

**Export Functionality**
- [ ] Clicking "View Aggregate Report (X Assessments)" immediately triggers CSV download
- [ ] No modal or preview page displayed
- [ ] Success message shown after export starts
- [ ] CSV filename includes timestamp
- [ ] CSV includes all columns in correct order
- [ ] CSV header includes: "Summary data based on X filtered assessment(s)"
- [ ] All questions from assessment structure included
- [ ] Average rating calculated correctly (excludes N/A)
- [ ] Rating counts accurate for each level (N/A, 0-5)
- [ ] Average rating displays with 2 decimal places
- [ ] UTF-8 encoding preserves special characters
- [ ] CSV opens correctly in Excel

**Filter Integration**
- [ ] Export reflects currently applied filters from View Assessments page
- [ ] Export includes only filtered assessments
- [ ] If no assessments match filters, show error message and prevent export

---

#### Common Acceptance Criteria (Both Options)
- [ ] CSV format is identical for both options
- [ ] Data calculations are identical for both options
- [ ] Report respects user permissions (only includes assessments user can view)

### Missing Requirements to Define
1. **Section Context**: Should section titles be included in question text or as a separate column for context?
2. **Question Numbering**: Should questions include their numbering (e.g., "1.", "2.") or just text?
3. **Long Questions**: How should very long question text be handled in the table display?
4. **Sort Options**: Should users be able to sort by average rating or rating counts?

### Test Cases

#### OPTION 1: View Page with Export Button

**TC1-Opt1: Generate Aggregate Report**
**Given** user is on NQMS Assessments page with 71 assessments
**When** user clicks "View Aggregate Report (71 Assessments)"
**Then** modal opens showing aggregate report
**And** all questions are displayed with correct summary data

**TC2-Opt1: Verify Average Rating Format**
**Given** aggregate report is displayed
**And** question has average rating of 4.65432
**Then** "Average Rating" column displays "4.65"

**TC3-Opt1: Export Aggregate Report as CSV**
**Given** aggregate report modal is open
**When** user clicks "Export as CSV"
**Then** CSV file downloads successfully
**And** CSV contains all questions with correct data

---

#### OPTION 2: Direct Export

**TC1-Opt2: Direct Export Aggregate Report**
**Given** user is on NQMS Assessments page with 71 assessments
**When** user clicks "View Aggregate Report (71 Assessments)"
**Then** CSV file downloads immediately
**And** No modal is displayed
**And** Success message shown: "Aggregate Report exported successfully"

**TC2-Opt2: Verify Average Rating Format in CSV**
**Given** user has exported aggregate report
**And** question has average rating of 4.65432
**When** CSV is opened in Excel
**Then** "Average Rating" column displays "4.65"

**TC3-Opt2: Direct Export with Metadata**
**Given** user clicks "View Aggregate Report (71 Assessments)"
**Then** CSV downloads with header line "Summary data based on 71 filtered assessment(s)"
**And** CSV contains all questions with correct data

---

#### Common Test Cases (Both Options)

### Definition of Done
- [ ] Code implemented and tested in development environment
- [ ] All acceptance criteria met
- [ ] All test cases pass
- [ ] Missing requirements clarified with client
- [ ] Code reviewed and approved
- [ ] Deployed to staging for client UAT

---

## Request 4: Goals Report - Goals Summary by Question Export

### Problem Statement
Users need to analyze goals set across programs to:
- Identify which questions have goals set
- Track goal completion rates
- View baseline vs. target ratings
- See which programs have set goals for each question
- Export goals data for progress tracking and reporting

Currently, there is no centralized view of goals across multiple programs.

### Proposed Solution
Create a "Goals Report" that displays goals grouped by section and question, showing aggregated goal statistics and listing programs that have set goals.

**Two implementation options are provided for client estimation:**

---

## OPTION 1: View Page with Export Button (Enhanced UX)

**Estimated Complexity:** Medium (4-6 days)

This option provides a full report preview experience before exporting.

#### Report Layout
The Goals Report opens in a modal dialog:

**Modal Header:**
- Title: "NQMS Goals Report"
- Subtitle: "Goals summary based on X filtered assessment(s)"
- Close button (X)

**Export Button:**
- "Export as CSV" button (top right)

**Data Table Columns:**

| Column | Description | Data Type |
|--------|-------------|-----------|
| Section | Section title | Text |
| Question | Full question text | Text |
| Avg. Rating | Average rating for this question across filtered assessments | Decimal (2 decimals) |
| Total Goals | Total number of goals set for this question | Integer |
| Completed Goals | Number of completed goals for this question | Integer |
| Avg. Baseline | Average baseline rating of goals | Decimal (2 decimals) |
| Avg. Achieved | Average achieved rating of completed goals | Decimal (2 decimals) |
| Programs | Comma-separated list of program names with goals | Text |

**Table Features:**
- Questions grouped by section
- Only shows questions that have at least one goal set
- Programs listed in alphabetical order
- Scrollable table

#### CSV Export Format
When "Export as CSV" is clicked:
- Filename: `NQMS_Goals_Report_YYYYMMDD_HHMMSS.csv`
- All columns listed above
- One row per question with goals
- UTF-8 encoding

#### Benefits of Option 1
- Users can preview goals data before exporting
- Easier to identify which questions have goals
- Better user experience for data validation
- Allows users to review goal completion rates without downloading

#### Technical Considerations
- Requires modal UI development
- Data table rendering with section grouping
- Complex goal aggregation calculations
- AJAX call to fetch report data
- CSV generation from displayed data

---

## OPTION 2: Direct Export (Quick Win)

**Estimated Complexity:** Low (2-3 days)

This option provides immediate CSV download without preview page.

#### User Experience
When user clicks "View Goals Report (X Assessments)" button:
1. System immediately generates CSV file
2. CSV file downloads automatically
3. No preview modal displayed
4. Success message shown: "Goals Report exported successfully"

#### CSV Export Format
CSV file generated with:
- Filename: `NQMS_Goals_Report_YYYYMMDD_HHMMSS.csv`
- All columns: Section, Question, Avg. Rating, Total Goals, Completed Goals, Avg. Baseline, Avg. Achieved, Programs
- One row per question with goals
- UTF-8 encoding
- Header row includes: "Goals summary based on X filtered assessment(s)" as first line before column headers

#### Benefits of Option 2
- Faster implementation (lower cost)
- Simpler user workflow (one click to download)
- No modal development required
- Reduced server load (no data table rendering)

#### Technical Considerations
- Direct CSV generation and download
- Complex goal aggregation calculations
- Include report metadata in CSV header
- Single controller action for export
- Progress indicator during generation

---

### CSV Format (Both Options)
Both options produce identical CSV output:

**CSV Header Section:**
```
Goals summary based on X filtered assessment(s)

[Column Headers]
Section,Question,Avg. Rating,Total Goals,Completed Goals,Avg. Baseline,Avg. Achieved,Programs
[Data Rows...]
```

### Acceptance Criteria

#### OPTION 1: View Page with Export Button

**Report Display**
- [ ] Modal opens when "View Goals Report" button clicked
- [ ] Report displays goals data for all filtered assessments
- [ ] Only questions with goals are displayed
- [ ] "Total Goals" counts all goals for question across filtered assessments
- [ ] "Completed Goals" counts only goals with completed status
- [ ] "Avg. Rating" shows average current rating for question
- [ ] "Avg. Baseline" calculates average of baseline ratings from goals
- [ ] "Avg. Achieved" calculates average of achieved ratings (completed goals only)
- [ ] "Avg. Achieved" shows "-" if no goals completed
- [ ] "Programs" lists program names alphabetically
- [ ] Sections displayed as grouping headers
- [ ] Table is scrollable for long question lists

**CSV Export**
- [ ] "Export as CSV" button generates CSV file
- [ ] CSV filename includes timestamp
- [ ] CSV includes all columns
- [ ] CSV data matches displayed report
- [ ] CSV header includes report metadata
- [ ] Program names in CSV are comma-separated
- [ ] UTF-8 encoding preserves special characters
- [ ] CSV opens correctly in Excel

**Filter Integration**
- [ ] Report reflects currently applied filters
- [ ] Only shows goals from filtered assessments
- [ ] Report shows "No goals found" message if no goals match filters

---

#### OPTION 2: Direct Export

**Export Functionality**
- [ ] Clicking "View Goals Report (X Assessments)" immediately triggers CSV download
- [ ] No modal or preview page displayed
- [ ] Success message shown after export starts
- [ ] CSV filename includes timestamp
- [ ] CSV includes all columns in correct order
- [ ] CSV header includes: "Goals summary based on X filtered assessment(s)"
- [ ] Only questions with goals are included
- [ ] "Total Goals" counts all goals for question across filtered assessments
- [ ] "Completed Goals" counts only goals with completed status
- [ ] "Avg. Rating" shows average current rating for question
- [ ] "Avg. Baseline" calculates average of baseline ratings from goals
- [ ] "Avg. Achieved" calculates average of achieved ratings (completed goals only)
- [ ] "Avg. Achieved" shows "-" if no goals completed
- [ ] "Programs" lists program names alphabetically in CSV
- [ ] Program names in CSV are comma-separated
- [ ] UTF-8 encoding preserves special characters
- [ ] CSV opens correctly in Excel

**Filter Integration**
- [ ] Export reflects currently applied filters from View Assessments page
- [ ] Export includes only goals from filtered assessments
- [ ] If no goals match filters, show error message and prevent export

---

#### Common Acceptance Criteria (Both Options)
- [ ] CSV format is identical for both options
- [ ] Data calculations are identical for both options
- [ ] Report respects user permissions (only includes goals from assessments user can view)

### Missing Requirements to Define
1. **Goal Dates**: Should the report include goal start date and target completion date columns?
2. **Goal Names**: Should individual goal names/descriptions be included?
3. **Multiple Goals per Question**: If a program has multiple goals for the same question, how should this be handled?
4. **In-Progress Goals**: Should in-progress goals be counted separately from completed/not started?
5. **Target Rating**: Should target rating be displayed in addition to baseline and achieved?
6. **Goal Sections**: The current screenshot shows goals data but doesn't clearly show if section grouping is needed
7. **Sorting**: Should goals be sortable by completion rate or other metrics?

### Test Cases

#### OPTION 1: View Page with Export Button

**TC1-Opt1: Generate Goals Report**
**Given** user is on NQMS Assessments page with 71 assessments
**When** user clicks "View Goals Report (71 Assessments)"
**Then** modal opens showing goals report
**And** only questions with goals are displayed
**And** all goal statistics are correct

**TC2-Opt1: Verify Completed Goals Calculation**
**Given** goals report displays question "Does your program have a logic model?"
**And** question has 19 total goals across filtered programs
**And** 3 goals are marked as completed
**Then** "Total Goals" shows 19
**And** "Completed Goals" shows 3

**TC3-Opt1: Verify Average Baseline Calculation**
**Given** goals report displays question with 5 goals
**And** baseline ratings are: [4, 3, 4, 4, 3]
**Then** "Avg. Baseline" shows "3.60"

**TC4-Opt1: Verify Programs List**
**Given** goals report displays question
**And** programs "Big Brothers Big Sisters of Colorado Southwest" and "Big Brothers Big Sisters of the Bay Area" have goals
**Then** "Programs" column shows: "Big Brothers Big Sisters of Colorado Southwest, Big Brothers Big Sisters of the Bay Area"

**TC5-Opt1: Export Goals Report as CSV**
**Given** goals report modal is open
**When** user clicks "Export as CSV"
**Then** CSV file downloads successfully
**And** CSV contains all questions with goals
**And** CSV programs column is properly formatted

**TC6-Opt1: Questions Without Goals Not Displayed**
**Given** filtered assessments include questions with no goals set
**When** goals report is generated
**Then** only questions with at least one goal are displayed
**And** questions without goals are excluded from report

---

#### OPTION 2: Direct Export

**TC1-Opt2: Direct Export Goals Report**
**Given** user is on NQMS Assessments page with 71 assessments
**When** user clicks "View Goals Report (71 Assessments)"
**Then** CSV file downloads immediately
**And** No modal is displayed
**And** Success message shown: "Goals Report exported successfully"

**TC2-Opt2: Verify Completed Goals in CSV**
**Given** user has exported goals report
**And** question "Does your program have a logic model?" has 19 total goals with 3 completed
**When** CSV is opened in Excel
**Then** question row shows "Total Goals" = 19
**And** "Completed Goals" = 3

**TC3-Opt2: Verify Average Baseline in CSV**
**Given** user has exported goals report
**And** question has 5 goals with baseline ratings: [4, 3, 4, 4, 3]
**When** CSV is opened in Excel
**Then** "Avg. Baseline" column shows "3.60"

**TC4-Opt2: Verify Programs List in CSV**
**Given** user exports goals report
**And** programs "Big Brothers Big Sisters of Colorado Southwest" and "Big Brothers Big Sisters of the Bay Area" have goals for a question
**When** CSV is opened
**Then** "Programs" column shows comma-separated list: "Big Brothers Big Sisters of Colorado Southwest, Big Brothers Big Sisters of the Bay Area"

**TC5-Opt2: Direct Export with Metadata**
**Given** user clicks "View Goals Report (71 Assessments)"
**Then** CSV downloads with header line "Goals summary based on 71 filtered assessment(s)"
**And** CSV contains only questions with goals

**TC6-Opt2: Questions Without Goals Not in CSV**
**Given** filtered assessments include questions with no goals set
**When** user exports goals report
**Then** CSV contains only questions with at least one goal
**And** questions without goals are excluded

---

#### Common Test Cases (Both Options)

### Definition of Done
- [ ] Code implemented and tested in development environment
- [ ] All acceptance criteria met
- [ ] All test cases pass
- [ ] Missing requirements clarified with client
- [ ] Code reviewed and approved
- [ ] Performance tested with large goal datasets
- [ ] Deployed to staging for client UAT

---

## Implementation Notes

### Database Schema Considerations
All reports will need to query:
- `assessments` table (assessment data)
- `assessment_responses` table (question ratings)
- `assessment_goals` table (goals data)
- `programs` table (program details)
- Various filter-related tables

### Performance Optimization
- Add database indexes for frequently queried columns
- Implement report caching for large datasets
- Consider background job processing for large reports
- Limit concurrent report generations per user

### CakePHP Components
- **Controller**: `Admin/AssessmentsController`
  - `nqmsIndex()` - View Assessments page
  - `globalReport()` - Generate Global Report
  - `aggregateReport()` - Generate Aggregate Report
  - `goalsReport()` - Generate Goals Report
- **View Templates**:
  - `nqms_index.twig` - View Assessments page
  - Modals rendered via AJAX

### User Permissions
- All features restricted to authenticated users with NQMS access
- Filter results based on user's program/affiliate permissions
- Role-based access control for assessment deletion

---

## Overall Missing Requirements Summary

### Request 1: View Assessments Page
✅ Well-defined based on screenshots

### Request 2: Global Report
Missing clarifications:
1. Question ordering methodology
2. Treatment of unanswered questions in in-progress assessments
3. Handling of archived/deleted assessments
4. Whether comments should be included
5. Handling of different assessment structure versions
6. Display of empty sections

### Request 3: Aggregate Report
Missing clarifications:
1. Section context in question text
2. Question numbering inclusion
3. Long question text handling
4. Sort options for users

### Request 4: Goals Report
Missing clarifications:
1. Goal date columns (start date, target completion date)
2. Individual goal names/descriptions
3. Handling of multiple goals per question per program
4. In-progress goals tracking
5. Target rating display
6. Section grouping requirements
7. Sorting capabilities

### Cross-Cutting Concerns
1. **Performance targets**: What are acceptable report generation times for different dataset sizes?
2. **Concurrent usage**: How many users will generate reports simultaneously?
3. **Data refresh**: Should reports reflect real-time data or use cached data?
4. **Export limits**: Maximum number of assessments/programs for report generation?
5. **Mobile responsiveness**: Should reports work on mobile devices or desktop only?
6. **Accessibility**: WCAG compliance requirements for modals and tables?
7. **Error handling**: What should happen if report generation fails?
