# NQMS Assessments Feature - Scope of Work

## Overview

This SOW defines the scope of work for the new NQMS Assessments section, which provides a centralized view for searching and filtering assessments across programs, with the ability to generate custom downloadable reports for data analysis.

**This SOW includes 4 enhancement requests:**

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

Create a new "NQMS Assessments" section accessible from the main navigation menu. This page displays all assessments in a searchable, filterable table view.

#### Page Layout

- **Header**: "NQMS Assessments" with subtitle "View and manage program assessments"
- **Action Buttons**: Three report generation buttons at the top:
  - "Preview Global Report (118 Assessments)"
  - "Preview Aggregate Report (118 Assessments)"
  - "Preview Goals Report (118 Assessments)"
- **Filter Panel**: Collapsible accordion with comprehensive filtering options
- **Results Table**: Paginated table showing filtered assessments

#### Filter Options

The filter panel includes the following fields:

1. **Affiliates** (Multi-select autocomplete)
2. **Cities** (Multi-select autocomplete)
3. **State** (Dropdown)
4. **Types of Mentoring Opportunities Offered** (Multi-checkbox)
   - 1:1 (One-to-One), E-Mentoring / Virtual Mentoring, Group, Other, Peer, School-based 1:1, Team
5. **Grade(s) Program Serves** (Multi-checkbox)
   - 6-8, 9-12, College, K-5
6. **Mentee Categories / Youth Served** (Multi-checkbox)
   - Academically at-risk, Adjudicated / court involved, College / post-secondary student, Disabilities / special care needs, First-generation college, Foster/residential/kinship care, Gang at-risk, Gang involved, General youth population, Gifted / talented / academic achiever, Homeless / runaway, Incarcerated parent, LGBTQ youth, Low income, Mental health issues, Newcomer / Recent immigrant / refugee, Opportunity youth, Other, Parent involved in military, Pregnant / parenting, School drop-out, Single-parent household, Special education, Youth with disabilities
7. **Assessment Date (from)** (Date picker) - Format: mm/dd/yyyy
8. **Assessment Date (to)** (Date picker) - Format: mm/dd/yyyy
9. **Estimated Number Youths Served (from)** (Numeric input)
10. **Estimated Number Youths Served (to)** (Numeric input)
11. **Assessment Status** (Multi-checkbox)
    - In Progress, Completed, Goals Completed, Pending Review, Not Started

**Filter Actions:**
- **Reset Filter**: Clears all filter selections
- **Apply Filter**: Applies selected filters to table

#### Results Table

| Column | Description |
|--------|-------------|
| Program Name | Name of the program (clickable link to program details page) |
| Assessment Title | Title of assessment (e.g., "2025 Self-Assessment") |
| Assessment Status | Current status badge (e.g., "Completed", "Not Started", "Pending Review") |
| Assessment Start Date | Date assessment was started |
| % Complete | Percentage of questions answered |
| Approved On | Date assessment was approved |
| Actions | View/Edit button and Delete icon |

**Table Features:**
- Sortable columns
- Pagination
- Row selection with checkboxes
- **Program Name is clickable link** that navigates to program details page
- "View/Edit" button navigates to assessment details page
- Delete icon (trash can) for assessment deletion (with confirmation)

#### Report Generation Buttons

Three buttons at the top generate reports based on currently applied filters:
- **Preview Global Report (X Assessments)**: Navigates to Global Report page
- **Preview Aggregate Report (X Assessments)**: Navigates to Aggregate Report page
- **Preview Goals Report (X Assessments)**: Navigates to Goals Report page

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
- [ ] Program Name link navigates to correct program
- [ ] "View/Edit" button navigates to correct assessment
- [ ] Delete icon shows confirmation dialog
- [ ] Delete removes assessment (archived status)
- [ ] Assessment status badges display correct colors and text
- [ ] % Complete calculates correctly based on answered questions
- [ ] Empty state message shows when no assessments match filters

#### Report Generation

- [ ] Report button counts update dynamically based on filtered results
- [ ] Clicking each report button navigates to corresponding report page
- [ ] Reports only include assessments matching current filter criteria
- [ ] Reports show appropriate message if no results match filters
- [ ] User can return to NQMS Assessments page from any report

#### Access Control

- [ ] Only authorized users can access NQMS Assessments section
- [ ] Users only see assessments for programs they have permission to view
- [ ] Users can only delete assessments if they have delete permissions
- [ ] Users can only edit assessments if they have edit permissions

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
- View goal statistics for each question
- Export data for further analysis in Excel or statistical software

Without this report, users must manually compile data from individual assessments, which is time-consuming and error-prone.

### Proposed Solution

Create a "Global Report" landing page that displays comprehensive assessment data with **questions as rows** (not programs as rows). This report shows aggregated statistics for each question across all filtered assessments.

#### Page Layout

The Global Report is a dedicated page (not a modal):

**Breadcrumb Navigation:**
- Dashboard / NQMS Assessments / Global Report

**Page Header:**
- Title: "NQMS Global Report"
- Subtitle: "Comprehensive data based on 118 filtered assessment(s)"

**Action Buttons (top right):**
- "Export as CSV" button (primary button with download icon)
- "Back to NQMS Assessments" button (secondary button with back arrow)

**Data Table:**

The table displays comprehensive data with the following columns:

| Column | Description |
|--------|-------------|
| Number of Assessments | Total assessments in filtered set (same value for all rows) |
| Programs With Ratings | Number of programs that rated this question (clickable to show program list) |
| Section Title | Section name (e.g., "A. Mentoring Program Design and Planning") |
| Question | Full question text with question number |
| Question Average Rating | Average of all numeric ratings (2 decimal places) |
| Marked as N/A | Count of N/A responses |
| Marked as 0 | Count of 0 ratings |
| Marked as 1 | Count of 1 ratings |
| Marked as 2 | Count of 2 ratings |
| Marked as 3 | Count of 3 ratings |
| Marked as 4 | Count of 4 ratings |
| Marked as 5 | Count of 5 ratings |
| Total Goals | Total number of goals set for this question |
| Completed Goals | Number of completed goals for this question |
| Average Goal Target Rating | Average target rating from goals |
| Average Goal Achieved Rating | Average achieved rating from completed goals (shows "-" if none completed) |
| Programs with Goals | Count of unique programs that have set goals for this question (clickable to show program list) |

**Table Features:**
- Questions grouped by section
- All questions from assessment structure included
- Scrollable table for large datasets
- Columns scroll horizontally if needed
- "Programs With Ratings" is clickable - opens modal showing list of program names
- "Programs with Goals" is clickable - opens modal showing list of programs with goals

#### Programs Popup Modal

When user clicks on "Programs With Ratings" or "Programs with Goals" cell:
- Modal opens with title "Programs With Ratings for Question [X]" or "Programs with Goals for Question [X]"
- Subtitle: "Click on any program to view its details"
- Lists program names
- Each program name is clickable link to program details page
- Close button (X) in top right

#### CSV Export Format

When "Export as CSV" is clicked:
- Filename: `NQMS_Global_Report_YYYYMMDD_HHMMSS.csv`
- All columns included in order shown above
- One row per question
- UTF-8 encoding
- Opens correctly in Excel

#### Benefits

- Users can review full report data before exporting
- Easier to verify correct filters were applied
- Better user experience for data validation
- Clickable programs allows drill-down to specific programs
- Allows users to explore data without downloading
- Comprehensive view combines ratings and goals data

### Acceptance Criteria

#### Page Navigation

- [ ] Clicking "Preview Global Report" button navigates to Global Report page
- [ ] Breadcrumb navigation displays correctly
- [ ] "Back to NQMS Assessments" button returns to main assessments page
- [ ] Filters from NQMS Assessments page are maintained when viewing report
- [ ] User can navigate back and forth between report and assessments page

#### Report Display

- [ ] Page displays title "NQMS Global Report"
- [ ] Subtitle shows "Comprehensive data based on X filtered assessment(s)"
- [ ] Report displays data for all filtered assessments
- [ ] "Number of Assessments" column shows correct count (same for all rows)
- [ ] "Programs With Ratings" shows count of programs that answered each question
- [ ] Questions grouped by section
- [ ] All questions from assessment structure included
- [ ] Questions with no ratings show 0 for all rating counts
- [ ] Average rating calculated correctly (excludes N/A responses)
- [ ] Rating distribution counts are accurate (N/A, 0, 1, 2, 3, 4, 5)
- [ ] Total Goals counts all goals for each question
- [ ] Completed Goals counts only goals with completed status
- [ ] Average Goal Target Rating displays correctly (2 decimals)
- [ ] Average Goal Achieved Rating displays correctly or "-" if no completed goals
- [ ] Programs with Goals shows count of unique programs with goals for question
- [ ] Table is scrollable horizontally for all columns
- [ ] Table displays cleanly with proper column widths

#### Programs Popup Modal

- [ ] Clicking "Programs With Ratings" cell opens modal
- [ ] Modal displays title "Programs With Ratings for Question [X]"
- [ ] Modal shows subtitle "Click on any program to view its details"
- [ ] Modal lists all program names that rated the question
- [ ] Each program name is clickable link
- [ ] Clicking program name navigates to program details page
- [ ] Modal has close button (X) in top right
- [ ] Clicking close button or outside modal closes it
- [ ] Clicking "Programs with Goals" cell opens similar modal
- [ ] Programs with Goals modal lists programs that have goals for that question

#### CSV Export

- [ ] "Export as CSV" button is visible and clickable
- [ ] Button has download icon
- [ ] Clicking button generates CSV file
- [ ] CSV filename includes timestamp in format: NQMS_Global_Report_YYYYMMDD_HHMMSS.csv
- [ ] CSV includes all columns in correct order
- [ ] CSV contains one row per question
- [ ] CSV data matches displayed report data
- [ ] UTF-8 encoding preserves special characters
- [ ] CSV opens correctly in Excel
- [ ] CSV opens correctly in Google Sheets

#### Filter Integration

- [ ] Report reflects currently applied filters from View Assessments page
- [ ] Report updates when user changes filters and regenerates report
- [ ] Report shows appropriate message if no assessments match filters

#### Access Control

- [ ] Report respects user permissions (only includes assessments user can view)
- [ ] Users can only see programs they have permission to view in popup modals

---

## Request 3: Aggregate Report - Question Summary Export

### Problem Statement

Users need a simplified summary view of assessment questions showing:
- Average rating across all programs
- Distribution of ratings (counts for each rating level)
- Question performance analysis without section grouping

This differs from the Global Report by focusing on question-level summaries without the goals data and program counts. It provides a cleaner, more focused view for analyzing individual question performance.

### Proposed Solution

Create an "Aggregate Report" landing page that displays question-level summary data with ratings distribution.

#### Page Layout

The Aggregate Report is a dedicated page (not a modal):

**Breadcrumb Navigation:**
- Dashboard / NQMS Assessments / Aggregate Report

**Page Header:**
- Title: "NQMS Aggregate Report"
- Subtitle: "Summary data based on 118 filtered assessment(s)"

**Action Buttons (top right):**
- "Export as CSV" button (primary button with download icon)
- "Back to NQMS Assessments" button (secondary button with back arrow)

**Data Table:**

The table displays question-level summary data with the following columns:

| Column | Description |
|--------|-------------|
| Question Text | Full question text with question number |
| Average Rating | Average of all numeric ratings (2 decimal places) |
| N/A | Count of N/A responses |
| 0 | Count of 0 ratings |
| 1 | Count of 1 ratings |
| 2 | Count of 2 ratings |
| 3 | Count of 3 ratings |
| 4 | Count of 4 ratings |
| 5 | Count of 5 ratings |

**Table Features:**
- Questions listed in assessment order
- Scrollable table
- Clean, simplified view focused on question performance
- Full question text displayed

#### CSV Export Format

When "Export as CSV" is clicked:
- Filename: `NQMS_Aggregate_Report_YYYYMMDD_HHMMSS.csv`
- All columns listed above
- One row per question
- UTF-8 encoding
- Opens correctly in Excel

#### Benefits

- Simplified view focused only on ratings distribution
- Easier to analyze question performance without extra data
- Cleaner export for statistical analysis
- Users can review data before exporting

### Acceptance Criteria

#### Page Navigation

- [ ] Clicking "Preview Aggregate Report" button navigates to Aggregate Report page
- [ ] Breadcrumb navigation displays correctly
- [ ] "Back to NQMS Assessments" button returns to main assessments page
- [ ] Filters from NQMS Assessments page are maintained when viewing report
- [ ] User can navigate back and forth between report and assessments page

#### Report Display

- [ ] Page displays title "NQMS Aggregate Report"
- [ ] Subtitle shows "Summary data based on X filtered assessment(s)"
- [ ] Report displays summary data for all filtered assessments
- [ ] All questions from assessment structure included in order
- [ ] Full question text displayed with question numbers
- [ ] Average rating calculated correctly (excludes N/A)
- [ ] Rating counts accurate for each level (N/A, 0-5)
- [ ] Average rating displays with 2 decimal places
- [ ] Table scrolls vertically for long question lists
- [ ] Table displays cleanly with proper formatting

#### CSV Export

- [ ] "Export as CSV" button is visible and clickable
- [ ] Button has download icon
- [ ] Clicking button generates CSV file
- [ ] CSV filename includes timestamp
- [ ] CSV includes all columns in correct order
- [ ] CSV contains one row per question
- [ ] CSV data matches displayed report
- [ ] UTF-8 encoding preserves special characters
- [ ] CSV opens correctly in Excel
- [ ] CSV opens correctly in Google Sheets

#### Filter Integration

- [ ] Report reflects currently applied filters
- [ ] Report updates when filters change
- [ ] Report shows appropriate message if no results match filters

#### Access Control

- [ ] Report respects user permissions (only includes assessments user can view)

---

## Request 4: Goals Report - Goals Summary by Question Export

### Problem Statement

Users need to analyze goals set across programs to:
- Identify which questions have goals set
- Track goal completion rates
- View baseline vs. achieved ratings
- See which programs have set goals for each question
- Export goals data for progress tracking and reporting

Currently, there is no centralized view of goals across multiple programs.

### Proposed Solution

Create a "Goals Report" landing page that displays goals grouped by section and question, showing aggregated goal statistics and listing programs that have set goals.

#### Page Layout

The Goals Report is a dedicated page (not a modal):

**Breadcrumb Navigation:**
- Dashboard / NQMS Assessments / Goals Report

**Page Header:**
- Title: "NQMS Goals Report"
- Subtitle: "Goals summary based on 118 filtered assessment(s)"

**Action Buttons (top right):**
- "Export as CSV" button (primary button with download icon)
- "Back to NQMS Assessments" button (secondary button with back arrow)

**Data Table:**

The table displays goals data with the following columns:

| Column | Description |
|--------|-------------|
| Section | Section title (e.g., "A. Mentoring Program Design and Planning") |
| Question | Full question text with question number |
| Avg. Rating | Average current rating for this question across filtered assessments (2 decimals) |
| Total Goals | Total number of goals set for this question |
| Completed | Number of completed goals for this question |
| Avg. Baseline | Average baseline rating of goals (2 decimals) |
| Avg. Achieved | Average achieved rating of completed goals (2 decimals, shows "-" if none completed) |
| Programs with goals | Count of unique programs that have set goals (clickable to show program list) |

**Table Features:**
- Questions grouped by section
- Only shows questions that have at least one goal set
- Sections displayed with clear visual grouping
- Scrollable table
- "Programs with goals" is clickable - opens modal showing program names

#### Programs Popup Modal

When user clicks on "Programs with goals" cell:
- Modal opens with title showing which question
- Lists program names that have goals for that question
- Each program name is clickable link to program details page
- Close button (X) in top right

#### CSV Export Format

When "Export as CSV" is clicked:
- Filename: `NQMS_Goals_Report_YYYYMMDD_HHMMSS.csv`
- All columns listed above
- One row per question with goals
- UTF-8 encoding
- Opens correctly in Excel

#### Benefits

- Focused view on goals data only
- Easy to identify which questions have goals
- Track goal completion rates at a glance
- Drill down to specific programs with goals
- Export for progress tracking and reporting

### Acceptance Criteria

#### Page Navigation

- [ ] Clicking "Preview Goals Report" button navigates to Goals Report page
- [ ] Breadcrumb navigation displays correctly
- [ ] "Back to NQMS Assessments" button returns to main assessments page
- [ ] Filters from NQMS Assessments page are maintained when viewing report
- [ ] User can navigate back and forth between report and assessments page

#### Report Display

- [ ] Page displays title "NQMS Goals Report"
- [ ] Subtitle shows "Goals summary based on X filtered assessment(s)"
- [ ] Report displays goals data for all filtered assessments
- [ ] Only questions with goals are displayed
- [ ] "Total Goals" counts all goals for question across filtered assessments
- [ ] "Completed" counts only goals with completed status
- [ ] "Avg. Rating" shows average current rating for question
- [ ] "Avg. Baseline" calculates average of baseline ratings from goals
- [ ] "Avg. Achieved" calculates average of achieved ratings (completed goals only)
- [ ] "Avg. Achieved" shows "-" if no goals completed
- [ ] "Programs with goals" shows count of unique programs
- [ ] Sections displayed as clear grouping headers
- [ ] Table is scrollable for long question lists

#### Programs Popup Modal

- [ ] Clicking "Programs with goals" cell opens modal
- [ ] Modal displays appropriate title
- [ ] Modal lists all programs that have goals for that question
- [ ] Each program name is clickable link
- [ ] Clicking program name navigates to program details page
- [ ] Modal has close button (X) in top right
- [ ] Clicking close button or outside modal closes it

#### CSV Export

- [ ] "Export as CSV" button is visible and clickable
- [ ] Button has download icon
- [ ] Clicking button generates CSV file
- [ ] CSV filename includes timestamp
- [ ] CSV includes all columns in correct order
- [ ] CSV contains only questions with goals
- [ ] CSV data matches displayed report
- [ ] UTF-8 encoding preserves special characters
- [ ] CSV opens correctly in Excel
- [ ] CSV opens correctly in Google Sheets

#### Filter Integration

- [ ] Report reflects currently applied filters
- [ ] Only shows goals from filtered assessments
- [ ] Report shows appropriate message if no goals match filters

#### Access Control

- [ ] Report respects user permissions (only includes goals from assessments user can view)
- [ ] Users can only see programs they have permission to view in popup modals
