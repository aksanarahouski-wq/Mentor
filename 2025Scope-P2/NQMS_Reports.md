# NQMS Reporting Feature Requests

## Document Purpose
This document consolidates client requests for enhancements to NQMS reporting functionality. The goal is to conduct discovery to identify scope and requirements, which will inform the solution proposal and estimation.

---

## Discovery Session Summary

### Requests Overview: 3 Total Requests

**Request 1: Change Assessment Details Report Export Layout** - HIGH Priority
- Status: CLIENT CLARIFICATION NEEDED - Purpose of report discussed
- Current export: Questions as rows, programs as columns
- Proposed: Programs as rows, questions as columns (easier to read and analyze)
- Client note: "I think it is far easier to read if each program is a row and each question is a column"
- Purpose: For affiliates to export multiple programs' ratings over time for averaging/analysis
- Single program export handled separately (Assessment Requests Request 1B)

**Request 2: Change Goals Report Export Layout** - HIGH Priority
- Status: CLIENT CLARIFICATION NEEDED - Similar to Request 1
- Current export: Questions as rows with goal data
- Proposed: Programs as rows, questions/goals as columns (easier to read)
- Client note: Same layout change suggested as Assessment Details Report
- Single program goals: Should be accessible from program profile page (like Request 1)

**Request 3: Full Data Export** - CRITICAL Priority
- Status: Not yet discussed
- Comprehensive export for research and statistical analysis
- Captures historical ratings and improvements over time

### Meeting Decisions (Session 2):
1. ✅ **Single program export**: Handled by export button on assessment details page (Assessment Requests Request 1B)
2. ✅ **Export over Print**: CSV export is preferred workflow (Sarah's current process)
3. ⏸️ **Request 1 - Layout Change**: Client clarification requested before proceeding

### Client Clarification (Post-Session 2):

**From Mike on Assessment Details Report Purpose:**
> "I believe this report was developed so that Affiliates could quickly generate an export on how programs in their state rated themselves over a period of time. That is why a name feature was not needed. If a reviewer wants to look at a single program's assessment ratings, they can do that from the program's profile page using the buttons we discussed the other day."

> "If the goal here is to create a CVS export of a range of programs' scores so that they can be averaged or otherwise reported on, then the current export does that. But, as with the goals export, **I think it is far easier to read if each program is a row and each question is a column in the CVS export.**"

> "So, let's really talk this through before simply adding a name feature, as I think that is actually a misuse of the purpose of this feature."

**Key Clarifications:**
- ✅ **Single program view**: Use export button on program profile page (NOT this report)
- ✅ **Multi-program purpose**: This report is for affiliates to export multiple programs for analysis
- ⏸️ **Layout question**: Client suggests programs-as-rows, questions-as-columns would be "far easier to read"
- ❌ **Program name filter NOT needed**: Would be misuse of report purpose

### Items Still Pending (Future Sessions):
1. **Request 1 (Assessment Details Layout)**: Discuss whether to change export layout (programs as rows vs. current)
2. **Request 2 (Goals Report)**: Confirm exact columns and layout for program names and goal names
3. **Request 3 (Full Data Export)**: CRITICAL priority, needs dedicated discovery session

---

## Request 1: Change Assessment Details Report Export Layout

### Description
Change the Assessment Details Report CSV export layout so that programs are rows and questions are columns, instead of the current layout where questions are rows and programs are columns. This makes the export easier to read and analyze for the report's intended purpose: allowing affiliates to export multiple programs' ratings over time for averaging and comparison.

### Priority
HIGH

### Problem Statement
The current Assessment Details Report export has questions as rows and programs as columns. When multiple programs are exported for analysis, the CSV is difficult to read and work with. Client feedback indicates that having programs as rows and questions as columns would be "far easier to read" for the report's intended use case of comparing and averaging multiple programs' scores.

### Addresses
- Difficult to read current export layout (questions as rows, programs as columns)
- Hard to calculate averages or compare programs across questions
- Unnatural data structure for analysis (programs should be primary entities)
- Need for easier multi-program comparison and reporting
- Better alignment with report purpose (affiliate analysis of multiple programs)

### Current Issues
- Current layout: Questions as rows, programs add columns
- Wide, unwieldy spreadsheet when exporting multiple programs
- Column headers repeat: Program1_Rating, Program1_Comment, Program2_Rating, Program2_Comment...
- Cannot easily sort by program or calculate column statistics
- Difficult to scan and compare programs

### Use Cases
1. **Affiliate admin exports 10 programs** to calculate average ratings per question
2. **National staff compares programs** across same assessment questions
3. **Researcher analyzes program performance** across multiple programs over time
4. **Reviewer exports programs in state** to identify trends and outliers

### Discovery Questions

#### 1. Report Purpose Confirmation
- **Primary use case:** Affiliates exporting multiple programs for comparison/analysis *(Client confirmed)*
- **NOT for single program export:** Use export button on program profile page instead *(Client confirmed)*
- **Key question:** Should we change layout to programs-as-rows? Client says "I think it is far easier to read if each program is a row and each question is a column"

#### 2. Layout Structure
- **Current layout:**
  ```
  Question | Section | Program1_Rating | Program1_Comment | Program2_Rating | Program2_Comment | ...
  ```

- **Proposed layout:**
  ```
  Program | Affiliate | Date | Q1_Rating | Q1_Comment | Q2_Rating | Q2_Comment | ...
  ```

- **Questions:**
  - Should we implement proposed layout? (Client suggests yes)
  - Column naming convention for questions?
  - Should comments be included? (makes file very wide)
  - Should goals be included in this export?
  - Should section averages be calculated?

#### 3. Export Scope
- **What data to include:**
  - Program metadata (name, affiliate, location)?
  - Assessment metadata (date, status)?
  - All questions and ratings? (40+ questions)
  - Comments? (can make export very wide)
  - Goals? (or keep separate in Goals Report?)

#### 4. Compatibility
- **Display vs. Export:**
  - Change only the export, or also the web view?
  - Current web view may work fine; export is the issue

- **Backwards compatibility:**
  - Replace current export entirely, or provide as option?
  - Any users who prefer current layout?

#### 5. Related to Goals Report
- **Client mentioned:** "as with the goals export, I think it is far easier to read if each program is a row and each question is a column"
- **Consistency:** Should Goals Report use same layout approach?
- **Bundle implementation:** Do both reports together for consistency?

### Client Clarification (Post-Session 2)

**Status:** NEEDS DISCUSSION - Client provided important clarification on report purpose

**Mike's Feedback on Report Purpose:**

> "I believe this report was developed so that Affiliates could quickly generate an export on how programs in their state rated themselves over a period of time. That is why a name feature was not needed."

> "If a reviewer wants to look at a single program's assessment ratings, they can do that from the program's profile page using the buttons we discussed the other day."

> "If the goal here is to create a CVS export of a range of programs' scores so that they can be averaged or otherwise reported on, then the current export does that. But, **as with the goals export, I think it is far easier to read if each program is a row and each question is a column in the CVS export.**"

> "So, let's really talk this through before simply adding a name feature, as I think that is actually a misuse of the purpose of this feature."

**Key Clarifications from Client:**

1. **Report Purpose Confirmed:**
   - Designed for affiliates to export MULTIPLE programs
   - Purpose: Compare and analyze programs over time
   - NOT for single program export (use program profile page export button instead)

2. **Program Name Filter NOT Needed:**
   - Would be "misuse of the purpose of this feature"
   - Report filters by date/affiliate to get range of programs
   - Individual program names not relevant for multi-program analysis

3. **Layout Change Suggested:**
   - Client states: "I think it is far easier to read if each program is a row and each question is a column"
   - Same suggestion for Goals Report
   - Current layout (questions as rows) is hard to work with for analysis

4. **Single vs. Multi-Program Exports:**
   - ✅ **Single program**: Use export button on program profile (Assessment Requests Request 1B)
   - ✅ **Multiple programs**: Use Assessment Details Report (this request)
   - Two different use cases, two different solutions

**Decision Needed:**
- Should we change the Assessment Details Report export layout to programs-as-rows?
- Client suggests this would be "far easier to read"
- Would align with report's purpose (multi-program comparison/averaging)
- Same question applies to Goals Report (Request 2)

### Recommended Solution (Based on Client Feedback)

**Approach: Change Export Layout (Programs as Rows, Questions as Columns)**

**Client Preference:** "I think it is far easier to read if each program is a row and each question is a column in the CVS export."

**Implementation:**

1. **Restructure CSV export logic**
   - Query programs as primary entities (not questions)
   - Pivot data so each program is one row
   - Questions become columns
   - Format: `Program | Affiliate | Date | Q1_Rating | Q1_Comment | Q2_Rating | Q2_Comment | ...`

2. **Column structure**
   - Program metadata: Program Name, Affiliate, Assessment Date, Status
   - Question columns: For each question, include Rating and Comment columns
   - Column naming: `SectionA_Q1_Rating`, `SectionA_Q1_Comment`, etc.
   - Total columns: ~80-100 (40+ questions × 2 fields each)

3. **Keep web view as-is** (optional)
   - Only change the CSV export
   - Web display can remain current layout
   - Export is where usability issue exists

4. **No filtering changes needed**
   - Keep existing filters (date range, affiliate, status)
   - Remove consideration of program name filter (not needed per client)
   - Report works for its intended purpose: multi-program comparison

**Benefits:**
- **Easier to read**: Programs as rows is more intuitive
- **Better for analysis**: Can calculate column averages (average rating per question)
- **Aligns with purpose**: Multi-program comparison is easier
- **Client requested**: Direct feedback that this would be "far easier to read"
- **Consistent with Goals Report**: Same layout approach suggested for both

**Why This Solution (Not Program Search):**
- **Client clarified**: Program search would be "misuse of the purpose of this feature"
- **Report purpose**: Export multiple programs for comparison, not find individual program
- **Single program export**: Handled separately via export button on program profile page
- **Better architecture**: Each report serves its distinct purpose

**Technical Approach:**
See the detailed implementation in the removed Request 4 section below (lines 599-871) for:
- Database query structure (pivot logic)
- Column generation approach
- Performance considerations
- Alternative implementation options

---

## Request 2: Change Goals Report Export Layout

### Description
Change the Goals Report CSV export layout so that programs are rows and goals are organized as columns, instead of having questions/goals as rows. This makes the export easier to read and analyze for multi-program goal comparison. Similar to Assessment Details Report (Request 1), this aligns with the report's intended purpose: comparing goals across multiple programs.

### Priority
HIGH

### Problem Statement
Similar to the Assessment Details Report, the Goals Report export layout makes it difficult to compare goals across multiple programs. The report is designed for multi-program analysis, not individual program lookup. Client feedback suggests that changing the layout (programs as rows) would make the export "far easier to read" and better serve the report's purpose.

### Addresses
- Difficult to read current export layout (similar to Assessment Details Report)
- Hard to compare goals across multiple programs
- Unnatural data structure for multi-program goal analysis
- Need for easier goal comparison and tracking across programs
- Better alignment with report purpose (multi-program goal analysis)

### Current Issues
- Current layout: Goals/questions as rows (similar issue to Assessment Details Report)
- Difficult to compare the same goal type across multiple programs
- Cannot easily calculate statistics across programs
- Export format not optimized for multi-program analysis
- Hard to identify patterns across programs
- **Results page doesn't show which programs set goals on a given question** (Client need)
- **Export lacks goal text as written by programs** (Client: "it would be great to see... the text of those goals as written")
- Cannot identify which programs have goals for specific questions
- Missing goal text makes evaluation and analysis difficult

### Use Cases
1. **National staff reviews goals** across 10 programs to identify common goal areas
2. **Affiliate admin compares goal progress** across programs in their state
3. **Researcher analyzes goal achievement rates** across multiple programs
4. **Staff exports goals for trend analysis** across program cohorts
5. **Evaluation team needs to see which programs set goals on specific questions** (Client: "future evaluation needs")
6. **Researcher exports goal text to analyze goal content** and themes across programs
7. **National staff reviews actual goal language** written by programs to identify patterns

### Discovery Questions

#### 1. Report Purpose Confirmation
- **Primary use case:** Multi-program goal comparison and analysis *(Similar to Request 1)*
- **NOT for single program goals:** Should be accessible from program profile page *(Client preference)*
- **Key question:** Should we change layout to programs-as-rows? Client suggested this for Assessment Details, likely same for Goals

#### 2. Layout Structure
- **Current layout:**
  ```
  Program | Question | Goal Name | Baseline | Target | Achieved | Status | ...
  (Goals as individual rows)
  ```

- **Proposed layout (Option A - Programs as Rows):**
  ```
  Program | Affiliate | Goal1_Question | Goal1_Baseline | Goal1_Target | Goal1_Status | Goal2_Question | ...
  ```

- **Proposed layout (Option B - Programs as Rows, Questions as Columns):**
  ```
  Program | Affiliate | Q1_Goal_Name | Q1_Baseline | Q1_Target | Q1_Status | Q2_Goal_Name | ...
  ```

- **Questions:**
  - Which layout works best for multi-program goal comparison?
  - How to handle programs with different numbers of goals?
  - Should goals be organized by question or in chronological order?
  - Column naming convention?

#### 3. Single Program Goals Access
- **Client feedback:** "I don't think this is needed if this info is easily accessible from the program's main profile page"
- **Questions:**
  - Should single program goals be viewable from program profile?
  - Is this the Assessment Goals Tab (Request 6 in Assessment Requests)?
  - Does this report ONLY need to serve multi-program analysis?
  - Remove any single-program-focused features?

#### 4. Export Scope & Goal Text
- **What data to include:**
  - Program metadata (name, affiliate)?
  - Goal details (name, question, baseline, target, achieved, status)?
  - **Goal text as written by programs** (Client requirement: "the text of those goals as written")
  - Assessment context (which assessment the goal is from)?
  - Date information (goal created, updated, target completion)?
  - All goals or only active goals?

- **Client's specific need:**
  - "See which programs had set goals on a given question"
  - "The text of those goals as written"
  - For "future evaluation needs"

- **Questions:**
  - Is goal text the same as goal name, or is there a separate description field?
  - If programs-as-rows layout: How to show goal text for each program's goal?
  - If multiple goals per question per program: How to handle in export?
  - Should goal text be full or truncated?
  - Is goal text different from goal name/title?

#### 5. Compatibility
- **Display vs. Export:**
  - Change only the export, or also the web view?
  - Current web view may work for browsing; export is for analysis

- **Backwards compatibility:**
  - Replace current export entirely, or provide as option?
  - Any users who prefer current layout?

#### 6. Consistency with Assessment Details Report
- **Bundle with Request 1:**
  - Both reports have same layout issue
  - Same transformation logic needed (pivot to programs-as-rows)
  - Implement together for consistency?
  - Share technical approach?

### Client Clarification (Post-Session 2)

**Status:** NEEDS DISCUSSION - Client clarification with additional requirements

**Mike's Feedback on Goals Report:**

> "As with the Assessment Details report above, I don't think this is needed if this info is easily accessible from the program's main profile page."

**Mike's Additional Requirements for Goals Report Export:**

> "I'm not quite sure how to format this, but in addition to the information that this CSV export already provides, it would be great to see **which programs had set goals on a given question and the text of those goals as written**. That would be helpful for future evaluation needs."

**Key Clarifications from Client:**

1. **Similar to Request 1:**
   - Goals Report is for MULTI-program analysis (not single program lookup)
   - Single program goals should be accessible from program profile page
   - Likely refers to Assessment Goals Tab (Request 6 in Assessment Requests)

2. **Layout Change Likely Needed:**
   - Client mentioned for Assessment Details: "as with the goals export, I think it is far easier to read if each program is a row and each question is a column"
   - Same layout transformation suggested for Goals Report
   - Current layout (goals as rows) is difficult for multi-program comparison

3. **Additional Data Requirements:**
   - **Show which programs set goals on a given question**
   - **Include the actual goal text as written by programs**
   - This is for "future evaluation needs"
   - More than just goal names - need full goal descriptions/text

4. **Two Distinct Solutions:**
   - ✅ **Single program goals**: View from program profile page (Assessment Goals Tab)
   - ✅ **Multiple program goals**: Goals Report (with layout change + goal text)
   - Each serves different use case

**Decisions Needed:**
1. Should we change the Goals Report export layout to programs-as-rows?
2. How to include goal text in the export (new column? multiple columns?)
3. Should export show which programs have/don't have goals for each question?
4. What format works best for evaluation needs?
5. Bundle with Request 1 for consistency?

### Recommended Solution (Based on Client Feedback)

**Approach: Change Export Layout (Programs as Rows, Goals as Columns)**

**Similar to Request 1, but for Goals data**

**Implementation:**

1. **Restructure CSV export logic**
   - Query programs as primary entities (not goals/questions)
   - Pivot data so each program is one row
   - Goals become columns grouped by question or chronologically
   - **Include goal text as written by programs** (client requirement)
   - Format options:
     - Option A: `Program | Affiliate | Q1_Goal_Name | Q1_Goal_Text | Q1_Baseline | Q1_Target | Q1_Status | Q2_Goal_Name | Q2_Goal_Text | ...`
     - Option B: `Program | Affiliate | Goal1_Name | Goal1_Text | Goal1_Question | Goal1_Status | Goal2_Name | Goal2_Text | ...`
     - Option C (Question-focused): `Question | Program1_HasGoal | Program1_GoalText | Program2_HasGoal | Program2_GoalText | ...`

2. **Column structure decisions needed**
   - How to organize goals (by question? by creation date? by section?)
   - What goal fields to include (name, **text/description**, baseline, target, achieved, status, dates?)
   - How to handle varying numbers of goals per program?
   - **How to show which programs have goals for each question?** (client need)
   - **How to display goal text in readable format?** (may be long)
   - Column naming convention

3. **Keep web view as-is** (optional)
   - Only change the CSV export
   - Web display can remain current layout
   - Export is where usability issue exists

4. **No filtering changes needed**
   - Keep existing filters (date range, affiliate, status, question)
   - Remove any single-program-focused features
   - Report serves multi-program analysis purpose

**Benefits:**
- **Easier to compare programs**: Can see all of Program A's goals in one row
- **Better for analysis**: Can compare goal achievement across programs
- **Aligns with purpose**: Multi-program goal tracking and comparison
- **Consistent with Request 1**: Same layout approach as Assessment Details Report
- **Client suggested**: Applies same reasoning as Assessment Details Report
- **Includes goal text**: Meets client need to see "the text of those goals as written"
- **Shows which programs have goals**: Can identify which programs set goals on each question
- **Supports evaluation**: Provides data structure for "future evaluation needs"

**Why This Solution (Not Adding Program Names/Goal Names to Current Layout):**
- **Client clarified**: Single program info should be on program profile page
- **Report purpose**: Multi-program comparison, not individual program lookup
- **Layout transformation needed**: Current structure doesn't support easy multi-program analysis
- **Bundle with Request 1**: Same technical approach for both reports

**Technical Approach:**
- See Request 4 section (lines 661+) for detailed implementation reference
- Same pivot logic as Assessment Details Report
- Adjust column structure for goal-specific data
- Handle variable number of goals per program

**Technical Considerations:**
- Query joins: Goals → Assessments → Programs (may need optimization for large datasets)
- Export format: Ensure goal names and **goal text** don't break CSV parsing (escape commas, quotes, newlines)
- **Goal text may be long**: Consider truncation, separate column, or allowing wide cells
- Performance: Add indexes on goal foreign keys if not present
- Multiple goals per question: Decide on display format (list in one column vs. separate rows)
- **Data model question**: Is "goal text" the same as goal name, or is there a separate description/notes field?
- **Showing presence**: How to indicate which programs have goals (Y/N column? or blank if no goal?)

**Alternative Layout (Question-Focused for Evaluation):**
If client's evaluation need is to see which programs set goals on specific questions:
```
Question | Section | Program1 | Program1_GoalText | Program2 | Program2_GoalText | ...
Q1       | A       | Yes      | "Improve..."      | No       |                   | ...
Q2       | A       | Yes      | "Develop..."      | Yes      | "Enhance..."      | ...
```

This shows presence/absence clearly and includes goal text. However, doesn't align with "programs as rows" suggestion. Needs client input on which format better serves evaluation needs.

**Database Query Example:**
```php
$query->contain([
    'Assessments' => [
        'Programs'
    ]
])
->where(['Programs.name LIKE' => '%' . $programFilter . '%']);
```

**CSV Export Enhancement:**
```php
// Add goal_name column to export
$csvHeaders = ['Question Number', 'Question Text', 'Goal Name', 'Goal Status', ...];
// Handle multiple goals per question
$goalNames = implode(', ', $goalsForQuestion->extract('name')->toArray());
```

---

## Request 3: Export All Data Option for Data Analysis

### Description
Create a comprehensive data export that includes all NQMS assessment data (and ideally all Mentor Connector data associated with programs) in a format suitable for statistical analysis and research evaluation.

### Priority
CRITICAL

### Problem Statement
The client needs to export comprehensive NQMS data in a format that works for researchers and statistical analysis tools. This is essential for planned evaluation work with external evaluators. The export must capture baseline ratings, improved ratings after goal completion, goal information, and goal completion data. The client envisions an "uber report-building tool" that allows flexible filtering by affiliate, program type, and other program details, and exports everything as CSV files.

### Addresses
- Need to export comprehensive data for external evaluators and researchers
- Need flexible filtering options (affiliate, program type, other program details)
- Current exports don't provide all needed data in one place
- Need to export assessment ratings, improved ratings, goals, and goal completion
- Data format must work with statistical analysis tools (SPSS, R, Stata, Excel)
- Critical for planned evaluation work with external evaluators
- Client wants "uber report-building tool" that solves all export needs on this page

### Current Issues
- No comprehensive export option with all NQMS data
- Cannot filter exports by affiliate, program type, or other program details
- Existing exports don't include all needed data (ratings, improved ratings, goals, completion)
- Need to use multiple reports to get all data (inefficient for evaluators)
- No single "uber report-building tool" for flexible data export
- Uncertainty about how multiple assessments are handled (Assessment #2 vs. Assessment #1 ratings)

### Use Cases
1. **External evaluators need comprehensive NQMS data** for analysis (Client: "we often work with external evaluators")
2. **National staff exports data filtered by affiliate** for regional analysis
3. **Researcher exports specific program types** (e.g., all school-based programs) with all their data
4. **Evaluator needs assessment ratings + improved ratings + goals** in single export for statistical analysis
5. **Funder requires comprehensive data** showing program improvements and goal completion over time
6. **National staff exports all data** to answer complex evaluation questions without running multiple reports

### Client Clarification (Post-Session 2)

**Status:** CRITICAL PRIORITY - Client envisions comprehensive "uber report-building tool"

**Mike's Vision for Request 3:**

> "In reading through the two reports above, I am wondering if some sort of **uber report-building tool** might solve all these export needs. The reason for this request is that we often work with external evaluators to analyze QMS data and it would be great if we could export lots of information out as CSV files."

> "That includes things like **assessment ratings and improved ratings and goal and goal completion information**. It would be nice to be able to export that at an **Affiliate level, as well as filter it by program type and other client details**."

> "I feel like that **kind of exporting tool would solve all the issues on this page**, honestly."

**Key Requirements from Client:**

1. **Comprehensive Data Export:**
   - Assessment ratings (baseline)
   - Improved ratings (after goal completion)
   - Goal information
   - Goal completion information
   - All in CSV format

2. **Flexible Filtering:**
   - Export at Affiliate level
   - Filter by program type
   - Filter by other program/client details
   - Similar to advanced filtering capabilities

3. **Purpose:**
   - Work with external evaluators
   - Statistical analysis
   - Answer evaluation questions
   - "Solve all the issues on this page" (Requests 1, 2, and 3)

4. **Vision:**
   - "Uber report-building tool" concept
   - One tool that handles all export needs
   - Replaces need for multiple separate reports/exports
   - Flexible enough to support various evaluation scenarios

**Client Clarification on Data Quality:**

**Question:** Are there known data quality issues?

**Mike's Answer:**
> "Not at this time, as it seems like the system is accurately capturing changed ratings and treating the updated rating as the 'current' number. Meaning, if I want to report on the average rating across all programs on Q1, it's counting any improved post-goal completion ratings as the program's current rating on that question."

> "The one scenario I want to make sure is working well (and I'm not sure this has been tested in the system) is **what happens when we have the program's next assessment in the system**. Does it only include the new assessment in exports? Does it count assessment #2 as the 'current' ratings for the program and ignore the old ratings? That is a scenario we have not tested yet, to my knowledge."

**Critical Data Question:**
- How does system handle multiple assessments for same program?
- Does Assessment #2 become "current" and Assessment #1 becomes historical?
- How are improved ratings tracked across multiple full assessments?
- This needs to be tested and clarified before building export tool

### Proposed Export Structure

**Row Structure:**
- Each row = one program
- Programs are unique (one row per program regardless of # of assessments)

**Column Structure:**
- Program identification fields (ID, name, organization, location, etc.)
- Mentor Connector data (program characteristics, demographics, etc.)
- For each assessment (1st assessment, 2nd assessment, etc.):
  - Assessment approval date
  - For each question:
    - Question number/ID
    - Initial rating (baseline)
    - Goal set? (Y/N)
    - Improved rating (if applicable / if program made improvements)

**Example Structure:**
```
Program ID | Program Name | ... | Assessment 1 Date | Q1 Rating | Q1 Goal | Q1 Improved | Q2 Rating | Q2 Goal | Q2 Improved | ... | Assessment 2 Date | Q1 Rating | Q1 Goal | Q1 Improved | ...
```

Future assessments for the same program are added in new columns (same row) to avoid data duplication and ensure format is friendly for statistical software.

### Discovery Questions

#### 1. Data Scope & Content
- **NQMS Data:**
  - All assessment questions and ratings? *(Assumed: Yes)*
  - Assessment metadata (submission date, approval date, assessor, status)?
  - Goals data (goal text, target dates, completion status)?
  - Documents metadata (count, types)?
  - Standard scores and badge levels?
  - Comments/notes fields?

- **Mentor Connector Data:**
  - Program characteristics (site-based, e-mentoring, focus area, etc.)?
  - Demographics (mentee ages, genders, populations served)?
  - Program metrics (youth served, youth waiting)?
  - Contact information?
  - Affiliate associations?
  - All MC data or just key fields? *(Discovery needed)*

#### 2. Historical Data & Improvements
- **Rating history:**
  - Confirm format: Initial rating, improved rating 1, improved rating 2, etc.?
  - How many improvement cycles should be captured? (unlimited or cap at X?)
  - Should assessment date accompany each rating cycle?
  - If a question has no improvement, leave improved rating columns blank?

- **Multiple assessments:**
  - Programs can submit multiple full assessments over time (e.g., annual re-assessment)
  - Confirm: Each full assessment gets its own set of columns (Assessment 1, Assessment 2, etc.)?
  - Should there be a limit on number of assessments exported? (most recent 5? all time?)

#### 3. Export Format & Structure
- **File format:**
  - CSV (current standard)? *(Recommended for statistical software)*
  - Excel with multiple sheets (summary + details)?
  - SPSS .sav format?
  - Multiple format options?

- **Column structure:**
  - Confirm wide format (programs as rows, all data in columns)? *(Recommended for statistical analysis)*
  - Alternative: Long format (multiple rows per program, one per assessment)?
  - Should there be separate files for different data types (one for ratings, one for goals, etc.)?

- **Column naming:**
  - Use question numbers (Q1, Q2, Q3...)? *(Recommended)*
  - Use question text (can be very long)?
  - Use standard codes (1.1, 1.2, 2.1, etc.)?
  - Consistent naming convention for repeated assessments? (Assess1_Q1_Rating, Assess1_Q1_Improved, Assess2_Q1_Rating...)

#### 4. Data Filtering & Selection
- **Filter options:**
  - Export all programs or filtered subset (by affiliate, date range, status)?
  - Global admins only, or should affiliate admins be able to export their data?
  - Date range filter (assessments submitted between X and Y dates)?

- **Program selection:**
  - All active programs?
  - Include inactive/deleted programs (if soft delete implemented)?
  - Filter by badge level, assessment status, or other criteria?

#### 5. Data Quality & Validation
- **Testing & validation:**
  - Client mentioned need to "do a full test of a mock program"
  - What specific data elements need validation?
  - Should export include data quality indicators (missing data flags)?
  - Should there be a data dictionary or codebook accompanying export?

- **Data integrity:**
  - How to handle missing data (blank, "N/A", -999)?
  - How to handle questions that change across assessment versions?
  - How to handle programs with incomplete assessments?

#### 6. Performance & Technical
- **Export size:**
  - Estimated number of programs?
  - Average assessments per program?
  - Total questions per assessment (40+ standards)?
  - Potential total columns (could be 1000+ if many assessments)?

- **Performance concerns:**
  - Should large exports run in background and email when ready?
  - Or generate on-demand (how long is acceptable wait time)?
  - Should there be export size limits or warnings?

- **Data privacy:**
  - Should personally identifiable information be excluded or anonymized?
  - Are there FERPA or other compliance considerations?
  - Should program contact info be included?

#### 7. Filtering & Selection (Client Requirement)
- **Filter options needed:**
  - By affiliate (Client: "export that at an Affiliate level")
  - By program type (Client: "filter it by program type")
  - By other program/client details (Client: "other client details")
  - By date range?
  - By assessment status?
  - By goal status?

- **Filter UI:**
  - Advanced filter builder (select multiple criteria)?
  - Simple dropdown filters?
  - Search/autocomplete for affiliates and program types?
  - Save filter configurations for reuse?

#### 8. "Uber Report-Building Tool" Concept
- **What does "uber" mean?**
  - One tool to replace all export needs (Requests 1, 2, 3)?
  - Configurable columns (select what data to include)?
  - Multiple export format options?
  - Template/preset configurations for common scenarios?

- **Tool capabilities:**
  - Select data types to include (assessments, goals, improved ratings, etc.)
  - Choose columns to export
  - Apply filters (affiliate, program type, dates, etc.)
  - Save configurations as "templates" for future use?
  - Preview data before exporting?

- **Scope question:**
  - Does this replace Requests 1 and 2, or supplement them?
  - Should simple exports (Requests 1 & 2) still exist for common use cases?
  - Is "uber tool" for advanced/complex exports only?

#### 9. UI & Access
- **Where should this export be accessible?**
  - New menu item under Reports? ("Data Export Builder", "Advanced Export Tool", "Uber Export Tool")
  - Global admin only, or also affiliate admins?
  - Separate from existing reports, or integrated?

- **Export configuration:**
  - Should users be able to select which data fields to include? (Recommended: YES for "uber tool")
  - Or is this a standardized "export everything" function?
  - Save export configurations for future use? (Recommended: YES - Client will reuse with evaluators)
  - Share saved configurations with team members?

#### 10. Multiple Assessments Handling (Critical Question from Client)
- **Client's untested scenario:**
  - What happens when program has Assessment #2 in system?
  - Does Assessment #2 become "current" and #1 becomes historical?
  - Do exports include only Assessment #2, or both?
  - How are improved ratings from Assessment #1 handled when Assessment #2 exists?

- **Questions to test/clarify:**
  - If program completes Assessment #1, sets goals, achieves improved ratings, then submits Assessment #2:
    - Which ratings are "current"? (Assessment #2 baseline or Assessment #1 improved?)
    - Are improved ratings from #1 preserved in reports?
    - Does "average rating across all programs on Q1" include both assessments or just latest?
  - **This impacts export structure significantly - must be tested/clarified first**

### Recommended Solution (Based on Client Feedback)

**Approach: "Uber Report-Building Tool" - Flexible Data Export with Filtering**

**Client Vision:** "I am wondering if some sort of uber report-building tool might solve all these export needs... I feel like that kind of exporting tool would solve all the issues on this page, honestly."

**Key Features Based on Client Requirements:**

1. **Comprehensive Data Options:**
   - Assessment ratings (baseline)
   - Improved ratings (after goal completion)
   - Goal information
   - Goal completion data
   - Program/client details

2. **Flexible Filtering:**
   - By affiliate
   - By program type
   - By other program/client details
   - Date ranges
   - Assessment status
   - Goal status

3. **Export Capabilities:**
   - CSV format (primary)
   - Select which data fields to include
   - Save export configurations as templates
   - Reuse saved templates for future exports

**Implementation:**

1. **Create new "Data Export Builder" tool**
   - New menu item under Reports: "Data Export Builder" or "Advanced Export"
   - Global admin access (possibly affiliate admins with filtered data)
   - Filter form for date range, affiliate, program selection (optional)

2. **Build filter interface**
   - Step 1: Select filters
     - Affiliate dropdown/multi-select (Client requirement)
     - Program type dropdown/multi-select (Client requirement)
     - Other program details (location, status, etc.)
     - Date range picker
     - Assessment status filter
     - Goal status filter
   - Step 2: Select data to include
     - Checkboxes for data categories:
       - ☐ Assessment ratings (baseline)
       - ☐ Improved ratings
       - ☐ Goals
       - ☐ Goal completion
       - ☐ Program details (from Mentoring Connector)
     - Optional: Select specific fields within each category
   - Step 3: Export configuration
     - Export name (for saved templates)
     - Export format (CSV initially, others later)
     - Save as template option

3. **Build export service class**
   - `DataExportBuilderService` to handle flexible data structure
   - Query programs based on selected filters
   - Include only selected data categories
   - Build dynamic column headers based on selections and max # of assessments
   - Generate CSV with proper column naming

4. **Data structure logic (based on selections)**
   - One row per program
   - Program metadata columns (ID, name, affiliate)
   - If "Assessment ratings" selected:
     - `Assess1_Date, Assess1_Q1_Rating, Assess1_Q2_Rating...`
     - `Assess2_Date, Assess2_Q1_Rating...` (if multiple assessments)
   - If "Improved ratings" selected:
     - `Assess1_Q1_Improved, Assess1_Q2_Improved...`
   - If "Goals" selected:
     - `Q1_Goal_Name, Q1_Goal_Baseline, Q1_Goal_Target...`
   - If "Goal completion" selected:
     - `Q1_Goal_Achieved, Q1_Goal_Status...`
   - If "Program details" selected:
     - MC fields: program type, demographics, focus areas, etc.
   - Blank/NULL values where data doesn't exist

5. **Handle multiple assessments** (CRITICAL - must test first)
   - **Client's untested scenario**: What happens when Assessment #2 exists?
   - Need to clarify how system treats multiple assessments before implementing
   - Options:
     - Include all assessments (Assess1, Assess2, Assess3...)
     - Include only "current" assessment
     - Let user choose in export builder
   - **Must resolve before building export tool**

6. **Save export templates**
   - Store export configurations in database
   - Fields: name, filters, selected data categories, created by, created date
   - Load saved templates to rerun exports
   - Share templates with team members (optional)
   - For external evaluators: Client can create template, run it regularly

7. **Performance optimization**
   - For large datasets (1000+ programs), run export in background
   - Use CakePHP job queue or simple background command
   - Email download link when ready
   - Store export file temporarily (auto-delete after 7 days)

8. **Data dictionary (optional but recommended)**
   - Generate accompanying data dictionary file
   - Lists all columns with descriptions
   - Includes data types, possible values, notes
   - Helps external evaluators understand export structure

**Benefits:**
- **Comprehensive**: Includes all requested data (assessments, improved ratings, goals, completion)
- **Flexible**: Client can filter by affiliate, program type, and other details (Client requirement)
- **Reusable**: Save export configurations as templates for external evaluators
- **Analysis-ready**: CSV format works with SPSS, R, Stata, Excel
- **One tool**: Client says this "would solve all the issues on this page" (Requests 1, 2, 3)
- **External evaluator friendly**: Can share saved templates with evaluators for consistent data pulls
- **Efficient**: No need to run multiple separate reports
- **Customizable**: Select only needed data to keep files manageable

**Why "Uber Tool" vs. Fixed Reports:**
- Client works with external evaluators who have varying needs
- Different evaluation questions require different data combinations
- Flexibility allows tool to adapt to future evaluation needs
- Saved templates provide consistency while maintaining flexibility
- May supplement (not replace) simple exports (Requests 1 & 2) for common use cases

**Files to Modify:**
- `plugins/Reports/src/Controller/Admin/ReportsController.php` - Add fullDataExport action
- `plugins/Reports/src/Service/FullDataExportService.php` - NEW service for export logic
- `plugins/Reports/templates/Admin/Reports/full_data_export.twig` - NEW form/page
- `plugins/Reports/src/Command/FullDataExportCommand.php` - NEW background command (optional)
- `config/navigation.php` - Add "Full Data Export" menu item
- `config/request_policy_configs.php` - Add global admin permission

**Technical Considerations:**
- **Memory usage**: Large exports may hit PHP memory limits
  - Stream data to file rather than building entire CSV in memory
  - Process in chunks (100 programs at a time)
- **Column count**: Could exceed Excel's 16,384 column limit for programs with many assessments
  - CSV doesn't have this limit
  - Consider alternative: Multiple assessments per program in separate files
- **Query complexity**: Joining multiple tables (programs, assessments, ratings, goals)
  - Use eager loading to prevent N+1 queries
  - Add indexes on foreign keys
  - Cache intermediate results
- **Data validation**: Test with mock program as client requested
  - Create test program with multiple assessments and improvements
  - Verify all data exports correctly
  - Check for data accuracy

**Database Query Approach:**
```php
$programs = $this->Programs->find()
    ->contain([
        'Assessments' => [
            'Ratings',
            'Goals'
        ]
    ])
    ->where($filterConditions)
    ->all();

// Build CSV dynamically
$headers = ['Program ID', 'Program Name', ...MC fields...];
$maxAssessments = $this->getMaxAssessmentsCount($programs);
for ($i = 1; $i <= $maxAssessments; $i++) {
    $headers[] = "Assess{$i}_Date";
    foreach ($questions as $q) {
        $headers[] = "Assess{$i}_Q{$q}_Rating";
        $headers[] = "Assess{$i}_Q{$q}_Goal";
        $headers[] = "Assess{$i}_Q{$q}_Improved";
    }
}
```

**Alternative Approach: Long Format**
If wide format becomes unwieldy:
- Each row = one question response for one assessment
- Columns: Program ID, Program Name, Assessment Date, Question Number, Rating, Goal (Y/N), Improved Rating
- Easier to query but requires data reshaping for analysis
- Not recommended unless wide format proves technically infeasible

**Testing & Validation Plan:**
1. Create mock program with 2-3 assessments
2. Add improvements/re-ratings on several questions
3. Run export and verify:
   - All assessments appear
   - Baseline and improved ratings captured correctly
   - Goal flags are accurate
   - Column naming is consistent
   - Data can be opened in Excel, SPSS, R
4. Client reviews and validates data accuracy
5. Iterate based on feedback

---

---

## Request 4: Detailed Implementation Reference for Layout Change

**NOTE:** This section provides detailed technical implementation details for changing report export layouts (programs as rows, questions as columns). This applies to both Request 1 (Assessment Details Report) and Request 2 (Goals Report) based on client feedback.

**Client Context:** Mike stated "I think it is far easier to read if each program is a row and each question is a column in the CVS export" for BOTH reports.

**Status:** FOR REFERENCE - Technical details for implementing layout change
**Original Priority:** HIGH (still relevant for Request 1 and Request 2)

### Description
Restructure the Assessment Details report so that programs are rows and questions are columns, instead of the current layout where questions are rows and programs add columns. This makes the export much more usable, especially when comparing multiple programs.

### Problem Statement
The current Assessment Details report layout has questions as rows and programs as columns. When exporting multiple programs, the CSV becomes very wide and difficult to use, with repeating column patterns (Rating1, Comment1, Rating2, Comment2...). Users cannot easily compare programs or calculate averages across programs.

### Addresses
- Unusable export format when multiple programs are included
- Difficulty comparing programs side-by-side
- Cannot easily calculate column averages (e.g., average rating across programs for Q1)
- Wide, unwieldy spreadsheet with many repeated column headers
- Poor data structure for analysis and reporting

### Current Issues
- Questions are rows, programs are columns
- Export shows: Question | Program1_Rating | Program1_Comment | Program2_Rating | Program2_Comment | ...
- Very difficult to scan and analyze
- Cannot sort by program or calculate program-level statistics
- Mike (line 67): "as you can see, it's running the question as the row... very hard to see an individual program's ratings"

### Use Cases
1. **Affiliate admin wants to compare** 5 programs' ratings on a specific assessment question
2. **National staff calculates average** rating across all programs for benchmark question
3. **Researcher analyzes** program performance trends across multiple programs
4. **Reviewer exports multiple programs** and wants to easily see each program's full assessment

### Meeting Decisions (Session 2)

**Status:** DISCUSSED AND APPROVED

**Key Discussion Points:**
- Mike (line 67-80): "Right now, this assessment details report, it will export out... it's running the question as the row, meaning I've got Big Brothers Alaska, their question one and then their comment... very hard to see an individual program's ratings. I'd much rather see the program be the row and the questions, the comments."
- Mike (line 83): "I think changing the layout would be helpful. You know, if each row was the program, so say I run this report and there's five programs on there, right? It makes it easier to average the column, you know, that type of thing."
- Aksana (line 85): "So are you thinking just really kind of swapping, like your programs become your rows and your assessment questions?"
- Mike (line 87): "Well, I think that would be helpful."

**Current Layout (Problems):**
```
Question | Section | Program1_Rating | Program1_Comment | Program2_Rating | Program2_Comment | ...
Q1       | A       | 4               | Good             | 3               | Needs work       | ...
Q2       | A       | 5               | Excellent        | 4               | Good             | ...
```
Issues:
- Very wide when multiple programs
- Cannot easily see all of Program1's ratings
- Cannot calculate program-level statistics
- Difficult to compare programs

**Desired Layout (Approved):**
```
Program         | Section_A_Q1_Rating | Section_A_Q1_Comment | Section_A_Q2_Rating | Section_A_Q2_Comment | ...
Big Brothers AK | 4                   | Good                 | 5                   | Excellent            | ...
Program 2       | 3                   | Needs work           | 4                   | Good                 | ...
```
Benefits:
- Each row = one program (easy to scan)
- Can sort/filter by program
- Can calculate column averages (average rating for Q1 across all programs)
- Easier to analyze program performance
- Better structure for statistical analysis

**Confirmed Requirements:**
1. **Swap rows and columns**: Programs become rows, questions become columns
2. **Column naming**: Section + Question Number + Field Type (e.g., "A_Q1_Rating", "A_Q1_Comment")
3. **Include all data**: All questions, ratings, comments, goals (if applicable)
4. **Maintain filters**: This works with Request 1 (program name filter, affiliate filter)
5. **Export format**: CSV (current format)
6. **Backwards compatibility**: Replace current export or provide as option?

**Requirements to Confirm:**
1. Should this completely replace the old layout, or be an option/toggle?
2. Exact column naming convention (use section letters? question numbers? both?)
3. Should goals be included in this export? (Mike mentioned earlier they may not be needed)
4. How to handle very long comment text in cells?
5. Maximum number of programs per export (performance consideration)?
6. Should section averages be calculated and included?

### Discovery Questions

1. **Column Structure:**
   - Should columns be grouped by section? (All Section A questions, then Section B, etc.)
   - Should there be section header/separator columns?
   - Column naming format: "SectionA_Q1_Rating" or "A.1_Rating" or "Q1_Rating"?
   - Should section average columns be included? (e.g., "SectionA_Avg")

2. **Data Included:**
   - Should goals associated with questions be included? (separate columns for goal name, target, status?)
   - Should comments be included? (can make columns very wide)
   - Should assessment metadata be included? (submission date, status, assessor)
   - Should program metadata be included? (location, affiliate, program type)

3. **Layout Options:**
   - Should there be a way to switch between layouts (old vs. new)?
   - Or completely replace old layout with new one?
   - Should there be a "transpose" option for users who want old layout?

4. **Performance:**
   - Maximum number of programs in one export?
   - Should large exports be processed in background?
   - How many total columns will this create? (40+ questions × 2 fields = 80+ columns minimum)

5. **Integration:**
   - Does this change affect the on-screen report display, or just the export?
   - Should the web view also show programs as rows?
   - How does this work with Request 1 filters (program name, affiliate)?

### Recommended Solution (Budget-Friendly)

**Approach: Restructure Query and Export Logic**

**Implementation:**

1. **Modify query structure**
   - Query programs table as primary (not questions)
   - Join with assessments, questions, ratings
   - Pivot/transform data so programs are primary entities
   - Use CakePHP's query builder or raw SQL if needed

2. **Build dynamic column headers**
   - Generate column names based on sections and questions
   - Format: `[Section]_Q[Number]_Rating` and `[Section]_Q[Number]_Comment`
   - Example: `A_Q1_Rating`, `A_Q1_Comment`, `A_Q2_Rating`, `A_Q2_Comment`, etc.
   - Consider adding section average columns

3. **Generate CSV rows**
   - Each row = one program
   - First columns: Program ID, Program Name, Assessment Date, etc.
   - Followed by: All question ratings and comments in column order
   - Handle missing data (blank cells if question not answered)

4. **Update controller action**
   - Modify `AssessmentDetailsController::export()` action
   - Change query logic to fetch by programs (not questions)
   - Build CSV structure with new layout
   - Maintain filter compatibility (date, affiliate, program name from Request 1)

5. **Consider display view**
   - Decide: Change web view to match new layout?
   - Or: Keep web view as-is, only change export?
   - If changing web view: Requires template and CSS updates

**Benefits:**
- **Much easier to use**: Programs as rows is intuitive
- **Better for analysis**: Can calculate column statistics
- **Easier comparison**: See all programs' Q1 ratings in one column
- **Standard format**: Matches common data analysis structure
- **Complements Request 1**: Works perfectly with program filters

**Files to Modify:**
- `plugins/Reports/src/Controller/Admin/AssessmentDetailsController.php` - Update export action
- `plugins/Reports/src/Model/Table/AssessmentsTable.php` - Add query method for new structure (optional)
- `plugins/Reports/templates/Admin/AssessmentDetails/index.twig` - Update view if changing display (optional)
- May need custom service class for complex pivot logic

**Technical Considerations:**
- **Pivot operation**: PHP/CakePHP doesn't have built-in pivot like SQL Server
  - Build pivot manually by iterating programs and questions
  - Or use raw SQL with CASE statements (more complex)
- **Column count**: 40+ questions × 2 fields = 80+ columns
  - Still within reasonable limits for CSV
  - Excel can handle this (16,384 column limit)
- **Performance**: May be slower than current query
  - Optimize with eager loading (contain() relationships)
  - Consider caching for frequently run exports
- **Memory**: Building large CSVs in memory
  - Stream to file for large datasets
  - Process in chunks if needed

**Pivot Query Example (Conceptual):**
```php
// Pseudo-code - actual implementation will vary
$programs = $this->Programs->find()
    ->contain(['Assessments' => ['Questions', 'Ratings']])
    ->where($filterConditions)
    ->all();

$csvData = [];
foreach ($programs as $program) {
    $row = [
        'id' => $program->id,
        'name' => $program->name,
        // ... other program fields
    ];

    foreach ($program->assessment->questions as $question) {
        $sectionPrefix = $question->section->letter;
        $questionNum = $question->number;
        $row["{$sectionPrefix}_Q{$questionNum}_Rating"] = $question->rating ?? '';
        $row["{$sectionPrefix}_Q{$questionNum}_Comment"] = $question->comment ?? '';
    }

    $csvData[] = $row;
}
```

**Alternative Approach: Provide Both Layouts**
- Keep existing layout as "Detailed View" (questions as rows)
- Add new layout as "Program Comparison View" (programs as rows)
- Toggle or separate export buttons
- Gives users flexibility based on use case
- More development effort but provides options

**Recommendation:**
- Implement new layout (programs as rows) as default
- Deprecate old layout unless strong use case emerges
- Simpler to maintain one export format
- Aligns with stated user needs (Mike's feedback)

---

## Overall Discovery Questions

### General Scope
1. **Priority Order (Updated with Client Clarification):**
   - Request 1 (Change Assessment Details Layout): HIGH - Client suggests programs-as-rows would be "far easier to read"
   - Request 2 (Change Goals Report Layout + Add Data): HIGH - Same layout change plus add program names/goal names
   - Request 3 (Full Data Export): CRITICAL - Comprehensive export for research
   - **Recommendation:** Consider bundling Requests 1 + 2 (same layout change pattern for both reports)

2. **Dependencies:**
   - Requests 1 and 2 have same layout change (can share implementation approach)
   - Request 3 is independent (needs dedicated discovery)
   - Single program export handled separately (Assessment Requests Request 1B)
   - Layout changes align with reports' intended purposes (multi-program analysis)

3. **Timeline & Budget:**
   - What is the timeline for evaluation work (Request 3)?
   - Are there grant deadlines or reporting cycles that drive urgency?
   - Should we prioritize Request 3 and deliver quickly?
   - Requests 1 + 2 can be bundled (same layout transformation logic)

### User Impact
1. **User Base:**
   - How many users actively run reports?
   - Which reports are run most frequently?
   - Who are the primary users of each report?

2. **Research & Evaluation:**
   - Who will be using the full data export (Request 3)?
   - What statistical software do they use?
   - Have they provided example desired format/structure?
   - Any sample mock programs we can use for testing?

3. **Training & Documentation:**
   - Will researchers need training on export format?
   - Should there be user guide for data export?
   - Documentation on report filtering?

### Technical Considerations
1. **Current System:**
   - How many programs currently in system?
   - Average number of assessments per program?
   - How many total questions per assessment?
   - Database performance with current data volume?

2. **Data Accuracy & Quality:**
   - Request 3 mentions need to verify "system is capturing what it is supposed to accurately over time"
   - Are there known data quality issues?
   - Should data validation be part of export?
   - How should missing/invalid data be handled?

3. **Assessment Ratings & Improvements:**
   - How are improvements/re-ratings currently stored in database?
   - Is there an `improvements` table or are they updates to existing ratings?
   - How many improvement cycles are typically recorded per question?
   - Are historical ratings preserved or overwritten?

---

## Next Steps

1. **Discuss layout change with client** (Requests 1 + 2)
   - Client stated: "I think it is far easier to read if each program is a row and each question is a column"
   - Confirm decision to proceed with layout change for both reports
   - Discuss exact column structure and naming conventions
   - Decide: Change only export or also web view?

2. **Bundle Requests 1 + 2 implementation** (if approved)
   - Change Assessment Details Report export layout (programs as rows)
   - Change Goals Report export layout (programs as rows)
   - Add program names and goal names to Goals Report
   - Same technical approach for both (pivot logic)
   - Implement together for consistency

3. **Schedule discovery session** focused on Request 3 (Full Data Export) given CRITICAL priority
   - Gather sample data requirements from research/evaluation team
   - Create mock program for testing data export accuracy (as client mentioned)
   - Analyze database schema for assessment ratings and improvements structure
   - Prototype export format with small dataset for client review
   - This is the highest priority report request

4. **Single program export** - Already covered in Assessment Requests
   - See NQMS_Assessment_Requests.md Request 1B
   - Export button on assessment details page
   - Separate from multi-program reports

5. **Create detailed technical specifications**
   - Requests 1 + 2: Combined spec for layout transformation (see Request 4 section for technical details)
   - Request 3: Comprehensive data export spec (needs extensive discovery)

6. **Develop effort estimates** with client-clarified scope
   - Phase 1: Requests 1 + 2 (bundled layout changes)
   - Phase 2: Request 3 (Full Data Export) - Complex, after dedicated discovery

7. **Plan testing strategy**
   - Test layout changes with real multi-program data
   - Verify averaging/analysis workflows work better with new layout
   - Research team validation for Request 3
   - Verify Request 3 export compatibility with statistical software (SPSS, R, Stata, Excel)

## Client Clarifications Summary

**Important Scope Clarifications from Mike:**

1. **Report Purposes Confirmed:**
   - **Assessment Details Report**: For affiliates to export MULTIPLE programs for comparison/averaging
   - **Goals Report**: For multi-program goal comparison and analysis
   - **NOT for single program data**: Use program profile page instead
   - Program name filter would be "misuse of the purpose of this feature"

2. **Layout Change Suggested for BOTH Reports:**
   - Client feedback: "I think it is far easier to read if each program is a row and each question is a column"
   - **Applies to BOTH Assessment Details Report AND Goals Report**
   - Current layout (questions/goals as rows) is difficult to work with for analysis
   - Proposed layout (programs as rows) better aligns with report purposes

3. **Single Program Data Access:**
   - **Request 1 (Assessment Details)**: "If a reviewer wants to look at a single program's assessment ratings, they can do that from the program's profile page using the buttons we discussed"
   - **Request 2 (Goals Report)**: "As with the Assessment Details report above, I don't think this is needed if this info is easily accessible from the program's main profile page"
   - **Solution**: Single program data should be on program profile page
     - Assessment export: Request 1B in Assessment Requests (Export button)
     - Goals view: Request 6 in Assessment Requests (Assessment Goals Tab)

4. **Two Distinct Solutions for Each Report:**
   - ✅ **Single program assessment**: Export button on assessment page (Assessment Requests Request 1B)
   - ✅ **Multiple program assessments**: Assessment Details Report with layout change (Request 1)
   - ✅ **Single program goals**: Assessment Goals Tab on program page (Assessment Requests Request 6)
   - ✅ **Multiple program goals**: Goals Report with layout change (Request 2)

5. **Updated Scope:**
   - **Request 1**: Change Assessment Details Report export layout (programs as rows, questions as columns)
   - **Request 2**: Change Goals Report export layout (programs as rows, goals as columns)
   - **Request 3**: Full Data Export (unchanged - CRITICAL priority)
   - All 3 requests remain active, refocused on multi-program analysis purposes
