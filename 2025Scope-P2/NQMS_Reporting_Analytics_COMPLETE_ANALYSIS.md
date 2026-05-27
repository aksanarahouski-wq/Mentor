# NQMS Reporting & Analytics - Complete Analysis
## What Was Discussed, What's Missing, What Metrics Client Wants

---

## EXECUTIVE SUMMARY

### 🔴 CRITICAL FINDING
**The client has NO comprehensive analytics or reporting dashboard for NQMS data**

> **Aksana (Meeting 2, Line 55):** "I do realize looking at your portal that you basically **have no access to NQMS data as a whole, right? No analytics to see how many assessments is out there** and et cetera."

This is THE biggest gap. The entire "NQMS Section" mentioned in the wishlist **does not exist** or is completely inaccessible.

---

## PART 1: WHAT WAS DISCUSSED IN MEETINGS

### Discussion Topic 1: Assessment Detail Report Issues
**Meeting:** Session 1 & 2
**Lines:** 67-89 (Meeting 2)
**Status:** Partially Discussed

**Current Problems Identified:**
1. **Export layout is unusable** - Questions as rows, programs as columns
2. **Cannot search by program name** - Only date filter available
3. **Cannot filter by affiliate** - No affiliate dropdown
4. **Very difficult to filter to single program** - Sarah's primary complaint
5. **Report results not clickable** - Can't click program name to go to assessment

**Client's Clarification (Post-Meeting):**
- Report is designed for **multi-program comparison** (NOT single program lookup)
- Affiliates use it to export multiple programs for averaging/analysis
- Single program export should use export button on program page (Request 1B)
- **Layout change suggested:** "I think it is far easier to read if each program is a row and each question is a column"

**What This Report Should Do:**
- Export multiple programs at once
- Allow comparison across programs
- Calculate averages across programs
- Analyze trends across program cohorts

---

### Discussion Topic 2: Goals Report Issues
**Meeting:** Session 2 (mentioned but not fully discussed)
**Status:** Client Clarification Received

**Current Problems Identified:**
1. **Similar layout issue** - Goals/questions as rows (difficult to compare across programs)
2. **Missing data:** Report doesn't show which programs set goals on given questions
3. **Missing data:** Report doesn't show "the text of those goals as written by programs"
4. **Results page doesn't identify** which programs have goals for specific questions

**Client's Requirements (Post-Meeting):**
> "In addition to the information that this CSV export already provides, it would be great to see **which programs had set goals on a given question and the text of those goals as written**. That would be helpful for future evaluation needs."

**Layout Change Suggested:**
- Same as Assessment Details: Programs as rows, goals/questions as columns
- Client: "as with the goals export, I think it is far easier to read if each program is a row"

**What This Report Should Do:**
- Multi-program goal comparison
- Show which programs have goals for each question
- Include actual goal text (not just goal names)
- Support evaluation needs
- Allow analysis of goal patterns across programs

---

### Discussion Topic 3: Full Data Export (Uber Report)
**Meeting:** Mentioned in wishlist, not discussed in meetings
**Status:** CRITICAL PRIORITY - Client Clarification Received
**Client Vision:** "Uber report-building tool"

**Client's Vision (Post-Meeting Email):**
> "I am wondering if some sort of **uber report-building tool** might solve all these export needs. The reason for this request is that **we often work with external evaluators** to analyze QMS data and it would be great if we could export lots of information out as CSV files."

> "That includes things like **assessment ratings and improved ratings and goal and goal completion information**. It would be nice to be able to export that at an **Affiliate level, as well as filter it by program type and other client details**."

> "I feel like that **kind of exporting tool would solve all the issues on this page**, honestly."

**Required Data:**
1. ✅ Assessment ratings (baseline)
2. ✅ Improved ratings (after goal completion - re-ratings)
3. ✅ Goal information
4. ✅ Goal completion data
5. ✅ Program/client details (from Mentor Connector)

**Required Filters:**
1. ✅ By affiliate
2. ✅ By program type
3. ✅ By other program/client details
4. ✅ Date ranges (implied)
5. ✅ Assessment status (implied)
6. ✅ Goal status (implied)

**Export Format:**
- CSV files (for statistical software: SPSS, R, Stata, Excel)
- Analysis-ready structure
- One export contains all needed data

**Use Case:**
- Work with external evaluators
- Research and statistical analysis
- Answer complex evaluation questions
- Comprehensive data pull without running multiple reports

---

### Discussion Topic 4: Assessment Snapshot
**Meeting:** Session 2, Line 245
**Status:** MENTIONED BUT NOT DEFINED

**Aksana mentioned:**
> "We did guys ask something for like assessment snapshot. And that's where it's basically, what are the most critical metrics about my assessment goals is one of them, right?"

**What We Know:**
- Team intended to discuss it but ran out of time
- It's about "critical metrics" for assessments
- Goals are part of it
- Not clear if it's a dashboard widget, report, or section on program page

**What We DON'T Know:**
- What specific metrics to show?
- Where should it appear?
- Who is it for (reviewers, programs, both)?
- Is it separate from Assessment Goals Tab (Request 6)?

---

### Discussion Topic 5: Goal Reminders/Dashboard
**Meeting:** Session 1, Lines 747-751
**Status:** OPTIONAL ENHANCEMENT

**Discussed:**
- Dashboard reminder section for goal deadlines
- Show upcoming and overdue goals
- **Visual reminder only** (NOT automated emails - too expensive)
- May be included "if budget allows, but not core requirement"

**What It Would Show:**
- Goals due this week/month
- Overdue goals
- Which programs need follow-up
- Clickable to see program details

---

## PART 2: WHAT'S MISSING (NOT DISCUSSED OR DISCOVERED)

### Missing Topic 1: NQMS Overview/Analytics Dashboard 🔴 CRITICAL
**Status:** COMPLETELY MISSING - Never discussed
**Source:** Aksana's observation (Meeting 2, Line 55)

**The Problem:**
> "You basically have **no access to NQMS data as a whole, right? No analytics to see how many assessments is out there** and et cetera."

**What's Missing:**
- No NQMS overview page
- No system-wide analytics
- No aggregate statistics
- No ability to see total assessments
- No visualization of NQMS usage/adoption
- No high-level metrics dashboard

**This Should Include (Inferred from needs):**
1. **System-Wide Metrics**
2. **Affiliate-Level Breakdowns**
3. **Program-Level Statistics**
4. **Goal Tracking Metrics**
5. **Trend Analysis**
6. **Comparison Views**

---

### Missing Topic 2: Historical Comparison Reports
**Status:** NOT DISCUSSED

**What's Missing:**
- No way to compare same program's assessments over time
- Programs go through 3-year cycles with re-assessment
- No reports showing improvement from Assessment #1 to Assessment #2
- No "how have we improved over time" visualization

**Client Mentioned (but not explored):**
> "The one scenario I want to make sure is working well (and I'm not sure this has been tested in the system) is **what happens when we have the program's next assessment in the system**. Does it only include the new assessment in exports? Does it count assessment #2 as the 'current' ratings for the program and ignore the old ratings?"

**This Needs to Be Addressed:**
- How multiple assessments per program are handled
- Which assessment is "current"
- How historical assessments are accessed
- How to show improvement trends over time

---

### Missing Topic 3: Goal Achievement Analytics
**Status:** NOT DISCUSSED

**What's Missing:**
- No reports on goal completion rates
- No analysis of which goal types are most/least achieved
- No time-to-achievement metrics
- No identification of common goal patterns
- No goal success factors analysis

**Potential Metrics:**
- % of goals completed vs. in progress vs. abandoned
- Average time to achieve goals
- Most common goal areas (by section/question)
- Goal achievement rates by affiliate
- Goal achievement rates by program type
- Which programs are succeeding vs. struggling with goals

---

### Missing Topic 4: Benchmark/Comparison Reports
**Status:** NOT DISCUSSED

**What's Missing:**
- No national benchmarks (average ratings across all programs)
- No affiliate comparisons (how does Colorado compare to Texas?)
- No program type comparisons (site-based vs. e-mentoring)
- No year-over-year comparisons
- No cohort analysis

**Potential Reports:**
- "How does my program compare to national average?"
- "How does my affiliate's programs compare to other affiliates?"
- "What are the highest/lowest rated questions across all programs?"
- "Which affiliates have highest assessment completion rates?"
- "Which program types perform best on specific standards?"

---

### Missing Topic 5: Assessment Progress/Status Reports
**Status:** NOT DISCUSSED

**What's Missing:**
- No report showing which programs have/haven't submitted assessments
- No report on assessment status (draft, submitted, under review, complete)
- No way to see "assessment pipeline" (how many in each status)
- No alert/report for overdue assessments
- No way to track reviewer workload (which assessments need review)

**Potential Reports:**
- "Programs with assessments in progress"
- "Assessments awaiting review"
- "Assessments submitted this quarter"
- "Programs without recent assessments" (need follow-up)
- "Reviewer workload by affiliate"

---

### Missing Topic 6: Document/Evidence Reports
**Status:** NOT DISCUSSED

**What's Missing:**
- No reports on document uploads (evidence for questions)
- No way to see which programs have uploaded evidence
- No analysis of document compliance by question
- No report on missing documentation

**Context:**
- Documents section exists in wishlist but not yet discussed in meetings
- Likely relates to evidence uploaded to support assessment answers

---

### Missing Topic 7: Trend & Longitudinal Analysis
**Status:** NOT DISCUSSED

**What's Missing:**
- No time-series analysis of ratings
- No trending over time (are programs improving year-over-year?)
- No cohort analysis (programs that started in 2020 vs. 2023)
- No seasonal patterns (assessment submission patterns)
- No adoption trends (NQMS usage over time)

**Potential Analysis:**
- "Are programs' assessment ratings improving over time?"
- "Which sections show most improvement across all programs?"
- "What's the typical time from assessment submission to goal completion?"
- "Assessment submission patterns by quarter/month"
- "NQMS adoption rate by affiliate over time"

---

### Missing Topic 8: Reviewer/Staff Performance Metrics
**Status:** NOT DISCUSSED

**What's Missing:**
- No reports on reviewer activity
- No metrics on how long reviews take
- No workload distribution reports
- No identification of bottlenecks

**Potential Metrics:**
- Number of programs per reviewer
- Average time from submission to review completion
- Reviewer response times
- Assessments per reviewer per month
- Reviewer workload by affiliate

---

## PART 3: WHAT METRICS CLIENT WANTS TO COLLECT

### Category 1: Assessment Metrics

#### 1.1 Assessment Ratings (Baseline)
**Source:** Full Data Export request
- Initial ratings on all assessment questions
- By program, by affiliate, by program type
- For statistical analysis
- **Format:** One row per program, columns for each question's rating

#### 1.2 Improved Ratings (Re-ratings after goal work)
**Source:** Full Data Export request
**Client explicitly stated:**
> "Assessment ratings and **improved ratings** and goal and goal completion information"

- Ratings after programs work on goals and improve
- Track improvement from baseline to achieved
- Historical improvement data
- Multiple improvement cycles if applicable

#### 1.3 Assessment Completion Data
**Source:** Inferred from Assessment Snapshot, Dashboard needs
- How many assessments submitted
- When assessments submitted
- Assessment status (draft, submitted, reviewed, complete)
- Time to complete assessment
- Completion rates by affiliate

#### 1.4 Section Average Ratings
**Source:** Assessment Detail Report, current data structure
- Average rating per section (A, B, C, etc.)
- Allows quick identification of strong/weak areas
- Useful for program-level and aggregate analysis

---

### Category 2: Goal Metrics

#### 2.1 Goal Information
**Source:** Full Data Export request, Goals Report
**Client explicitly stated:**
> "Goal and goal completion information"
>
> "Which programs had set goals on a given question and **the text of those goals as written**"

- Goal names/titles
- **Goal text as written by programs** (full descriptions)
- Which question the goal is attached to
- Baseline rating (starting point)
- Target rating (desired achievement)
- Achieved rating (actual result)
- Goal status (not evaluated, achieved, in progress, etc.)

#### 2.2 Goal Completion Data
**Source:** Full Data Export request
- Whether goal was completed (Y/N)
- When goal was completed
- Time to achieve goal
- Goal success/failure reasons

#### 2.3 Goal Dates (New - Request 3 adds this)
**Source:** Request 3 in Assessment Requests
- Goal start date
- Target completion date
- Actual completion date
- Days overdue (if applicable)

#### 2.4 Goal Presence by Question
**Source:** Goals Report requirements
**Client explicitly stated:**
> "Which programs had set goals on a given question"

- Identify which programs set goals for Question 1, Question 2, etc.
- Useful for evaluation: "Which questions do programs most commonly target for improvement?"
- Presence/absence matrix

---

### Category 3: Program/Client Details (from Mentor Connector)

#### 3.1 Program Identifiers
**Source:** Full Data Export request
- Program ID
- Program name
- Organization name
- Affiliate association
- Location (city, state)

#### 3.2 Program Type
**Source:** Full Data Export request
**Client explicitly stated:**
> "Filter it by **program type** and other client details"

- Site-based vs. e-mentoring
- School-based, community-based, workplace, etc.
- Focus area (academic, social-emotional, etc.)
- Other program classification fields

#### 3.3 Program Characteristics
**Source:** Full Data Export request - "other client details"
- Demographics served (age, gender, population)
- Youth served (count)
- Youth on waitlist (count)
- Program size indicators
- Program maturity/age
- Any other relevant program metadata from Connector

#### 3.4 Program Contact Information
**Source:** Inferred from export needs
- Program administrator name
- Contact email
- Contact phone
- Primary contact info

---

### Category 4: Affiliate-Level Metrics

#### 4.1 Affiliate Identification
**Source:** Full Data Export request, Assessment Detail Report
**Client explicitly stated:**
> "Export that at an **Affiliate level**"

- Affiliate name/ID
- Affiliate region
- Affiliate contact information

#### 4.2 Affiliate Aggregate Data (Inferred)
**Source:** Need to compare affiliates, benchmark performance
- Number of programs per affiliate
- Assessment submission rates by affiliate
- Average assessment ratings by affiliate
- Goal completion rates by affiliate
- Affiliate-level comparisons

---

### Category 5: Time-Based Metrics

#### 5.1 Assessment Dates
**Source:** Full Data Export, Assessment Detail Report
- Assessment created date
- Assessment submitted date
- Assessment review date
- Assessment approval date
- Time from creation to submission
- Time from submission to review

#### 5.2 Goal Dates
**Source:** Request 3 (Goal Dates)
- Goal created date
- Goal start date
- Goal target completion date
- Goal actual completion date
- Goal last updated date

#### 5.3 Historical Data
**Source:** Full Data Export request
**Client stated:**
> "Export lots of information... assessment ratings and improved ratings"

- Multiple assessments per program over time
- Assessment #1 data, Assessment #2 data, etc.
- Track improvement from Assessment #1 to Assessment #2
- Longitudinal data over 3-year cycles

---

### Category 6: Data for Statistical Analysis

#### 6.1 Export Format Requirements
**Source:** Full Data Export request
**Client stated:**
> "We often work with external evaluators to analyze QMS data... export lots of information out as **CSV files**"

- CSV format (for SPSS, R, Stata, Excel)
- Wide format preferred (programs as rows, metrics as columns)
- One comprehensive export file
- Analysis-ready structure

#### 6.2 Data Structure Requirements
**Source:** Inferred from statistical analysis needs
- One row per program (not per question or per goal)
- All program data in columns
- Columns for all questions, ratings, goals
- Handle missing data appropriately (blank cells)
- Consistent column naming for statistical software

---

## PART 4: WHAT CLIENT WANTS (Specific Requests)

### 1. Uber Report-Building Tool 🔴 CRITICAL
**Priority:** CRITICAL
**Client Vision:** One tool to solve all export needs

**Features Client Wants:**
1. **Select data to export:**
   - Assessment ratings
   - Improved ratings
   - Goals
   - Goal completion
   - Program details
   - All of the above (comprehensive export)

2. **Flexible filtering:**
   - By affiliate
   - By program type
   - By other program characteristics
   - By date range
   - By assessment status
   - By goal status

3. **Export capabilities:**
   - CSV format
   - Save configurations as templates
   - Reuse saved templates (for external evaluators)
   - Export preview before download

4. **Solve all export needs:**
   - Client: "I feel like that kind of exporting tool would solve all the issues on this page, honestly"
   - Replace need for multiple separate reports
   - One tool for all research/evaluation needs

---

### 2. Programs-as-Rows Layout (Multiple Reports)
**Priority:** HIGH
**Reports Affected:** Assessment Details Report, Goals Report

**Client explicitly stated:**
> "I think it is **far easier to read if each program is a row and each question is a column** in the CVS export"
>
> "As with the **goals export**, I think it is far easier to read if each program is a row..."

**What Client Wants:**
- Change export layout for both reports
- Programs as rows (instead of questions/goals as rows)
- Questions/goals as columns
- Easier to compare programs side-by-side
- Easier to calculate averages across programs
- Better for multi-program analysis

---

### 3. Goal Text in Exports
**Priority:** HIGH
**Report:** Goals Report

**Client explicitly stated:**
> "It would be great to see which programs had set goals on a given question and **the text of those goals as written**. That would be helpful for **future evaluation needs**."

**What Client Wants:**
- Include actual goal text/descriptions (not just goal names)
- Show which programs have goals for each question
- For evaluation analysis and research
- Understand what programs are actually working on

---

### 4. Improved Ratings Tracking
**Priority:** CRITICAL
**Report:** Full Data Export

**Client explicitly stated:**
> "Assessment ratings and **improved ratings** and goal and goal completion information"

**What Client Wants:**
- Track re-ratings after goal work
- Show progression from baseline → improved
- Multiple improvement cycles if applicable
- Historical improvement data
- **Critical question:** How are multiple assessments handled?

---

### 5. Multi-Assessment Handling (Needs Testing)
**Priority:** CRITICAL
**Status:** UNTESTED - Client flagged this

**Client explicitly stated:**
> "The one scenario I want to make sure is working well (and I'm not sure this has been tested in the system) is **what happens when we have the program's next assessment in the system**. Does it only include the new assessment in exports? Does it count assessment #2 as the 'current' ratings for the program and ignore the old ratings? That is a scenario we have not tested yet, to my knowledge."

**What Needs to Be Tested:**
- When program submits Assessment #2:
  - Does Assessment #2 become "current"?
  - Is Assessment #1 data preserved or overwritten?
  - How are improved ratings from Assessment #1 handled?
  - Do exports include both assessments or just latest?
  - How are averages calculated (include both or just latest)?

**Why This Matters:**
- Affects export structure significantly
- Determines how to show historical data
- Impacts evaluation analysis
- **Must be clarified before building Full Data Export tool**

---

## PART 5: RECOMMENDED METRICS DASHBOARD (Inferred from Needs)

### Dashboard 1: NQMS Overview (System-Wide)
**Audience:** Global Admins
**Purpose:** High-level system health and usage

**Metrics to Include:**
1. **Total Programs in NQMS:** Count of programs with at least one assessment
2. **Total Assessments Submitted:** All-time count
3. **Assessments by Status:**
   - Draft
   - Submitted
   - Under Review
   - Complete
4. **Active Goals:** Currently in-progress goals across all programs
5. **Goals Completed:** All-time count
6. **Goal Completion Rate:** % of goals completed vs. set
7. **Average Assessment Rating:** System-wide average across all programs
8. **Assessments This Month/Quarter/Year:** Trend chart
9. **Top Rated Sections:** Which sections score highest on average
10. **Lowest Rated Sections:** Which sections need most improvement
11. **NQMS Adoption Rate:** % of total programs that have submitted assessments
12. **Recent Activity:** List of recent assessment submissions

---

### Dashboard 2: Affiliate Dashboard
**Audience:** Affiliate Staff
**Purpose:** Monitor programs in their affiliate

**Metrics to Include:**
1. **Programs in My Affiliate:** Total count
2. **Programs with Assessments:** Count and %
3. **Assessments Awaiting Review:** Count needing attention
4. **My Affiliate's Average Rating:** Compared to national average
5. **Assessments Submitted This Quarter:** By my affiliate's programs
6. **Active Goals in My Affiliate:** Count
7. **Goals Completed This Quarter:** By my affiliate's programs
8. **Programs Needing Follow-Up:** Haven't submitted assessment recently
9. **Section Performance:** My affiliate's ratings by section vs. national avg
10. **Recent Activity:** Recent submissions from my affiliate's programs

---

### Dashboard 3: Program Dashboard (For Program Users)
**Audience:** Program End Users
**Purpose:** See their own progress

**Metrics to Include:**
1. **My Assessment Status:** Current status (draft, submitted, reviewed)
2. **My Overall Rating:** Average across all questions
3. **My Section Ratings:** Breakdown by section with visual indicators
4. **My Goals:** Count of active goals
5. **Goals Completed:** Count and % complete
6. **Goals Overdue:** Count of overdue goals (if dates added)
7. **Next Steps:** What program should do next
8. **My Progress Over Time:** If multiple assessments, show improvement
9. **Comparison to National Average:** How my ratings compare (optional)
10. **Documents Uploaded:** Count of evidence uploaded

---

### Dashboard 4: Reviewer Dashboard
**Audience:** NQMS Staff, Reviewers
**Purpose:** Manage review workload

**Metrics to Include:**
1. **Assessments Awaiting My Review:** Count
2. **My Programs:** List of programs I'm reviewing
3. **Goal Deadlines This Week:** Upcoming goal target dates
4. **Overdue Goals:** Goals past target date
5. **Recent Submissions:** Programs that just submitted
6. **Programs with Completed Goals:** Need validation/recognition
7. **Average Review Time:** How long I typically take to review
8. **Workload:** Number of programs I'm currently managing
9. **Quick Actions:** Links to common tasks (review assessment, update goal status, etc.)
10. **Reminders:** Visual reminders for follow-ups

---

## PART 6: DATA QUALITY & TESTING REQUIREMENTS

### Testing Needed (Client Flagged)
**Source:** Client's post-meeting clarification

**Client stated:**
> "Not at this time, as it seems like the system is accurately capturing changed ratings and treating the updated rating as the 'current' number. Meaning, if I want to report on the average rating across all programs on Q1, it's counting any improved post-goal completion ratings as the program's current rating on that question."

**But also flagged:**
> "The one scenario I want to make sure is working well (and I'm not sure this has been tested in the system) is what happens when we have the program's next assessment in the system."

**Testing Required:**
1. **Test Scenario 1:** Single Assessment with Improvements
   - Program submits Assessment #1
   - Sets goals
   - Improves ratings on some questions
   - Verify: Improved ratings count as "current"
   - Verify: Exports include improved ratings

2. **Test Scenario 2:** Multiple Assessments
   - Program completes Assessment #1 with improvements
   - Program submits Assessment #2 (3 years later)
   - Verify: Which ratings are "current"? (#1 improved or #2 baseline?)
   - Verify: Are #1 ratings preserved in database?
   - Verify: Do reports include both assessments or just #2?
   - Verify: How are averages calculated?

3. **Test Scenario 3:** Full Data Export
   - Create mock program with multiple assessments and improvements
   - Run Full Data Export
   - Verify: All data exports correctly
   - Verify: Data structure works in Excel/SPSS
   - Verify: Historical data is preserved
   - Client validates accuracy

---

## PART 7: IMMEDIATE ACTION ITEMS

### 1. Define NQMS Analytics/Overview Section 🔴 CRITICAL
**Why:** This is completely missing, biggest gap identified
**Actions:**
- Schedule dedicated discovery session for NQMS Analytics
- Determine what metrics are priority
- Define who sees what (global admin vs. affiliate vs. program)
- Decide on dashboard vs. reports vs. both
- Prototype mockups for client review

### 2. Build "Uber Report-Building Tool" (Full Data Export) 🔴 CRITICAL
**Why:** Client explicitly stated this would "solve all the issues on this page"
**Actions:**
- Prioritize as highest report request
- Schedule dedicated discovery session
- Define data structure with client input
- Test multiple assessment handling (critical blocker)
- Create mock program for testing
- Build flexible filter interface
- Implement save/reuse template functionality

### 3. Test Multiple Assessment Handling 🔴 CRITICAL BLOCKER
**Why:** Client flagged as untested, impacts export structure
**Actions:**
- Create test program with Assessment #2
- Document current system behavior
- Present findings to client
- Get client decision on desired behavior
- Implement changes if needed before building exports

### 4. Implement Layout Changes (Assessment Details & Goals Reports)
**Why:** Client explicitly requested, relatively straightforward
**Actions:**
- Bundle both reports (same transformation logic)
- Change export layout: programs as rows, questions/goals as columns
- Add goal text to Goals Report
- Show which programs have goals for each question
- Test with real multi-program data
- Validate that layout improves usability as expected

### 5. Define Assessment Snapshot
**Why:** Mentioned but never discussed, unclear requirements
**Actions:**
- Schedule time in next discovery session
- Clarify what it should show
- Decide where it appears
- Determine relationship to Assessment Goals Tab
- Prototype options for client feedback

---

## PART 8: SUMMARY OF METRICS CLIENT WANTS

### Explicitly Stated by Client:
1. ✅ Assessment ratings (baseline)
2. ✅ Improved ratings (after goal work)
3. ✅ Goal information (including goal text as written)
4. ✅ Goal completion data
5. ✅ Which programs set goals on which questions
6. ✅ Program type
7. ✅ Affiliate-level data
8. ✅ Other program/client details (demographics, characteristics)

### Implied by Client Needs:
9. ✅ Assessment dates (submitted, reviewed, approved)
10. ✅ Goal dates (start, target, completion)
11. ✅ Section average ratings
12. ✅ Assessment status
13. ✅ Goal status
14. ✅ Program identifiers (ID, name, organization)
15. ✅ Multiple assessments over time (historical data)
16. ✅ Time series data (longitudinal analysis)

### Needed but Not Explicitly Requested:
17. ⚠️ Total assessment count (system-wide)
18. ⚠️ NQMS adoption rate
19. ⚠️ Trend analysis (improvement over time)
20. ⚠️ Benchmark comparisons (affiliate vs. national)
21. ⚠️ Goal achievement rates
22. ⚠️ Common goal patterns
23. ⚠️ Reviewer workload metrics
24. ⚠️ Assessment pipeline status
25. ⚠️ Document/evidence tracking

---

## PART 9: PRIORITY MATRIX

### 🔴 CRITICAL & URGENT
1. **NQMS Analytics/Overview Section** - Completely missing, fundamental gap
2. **Uber Report-Building Tool (Full Data Export)** - Client says it "solves all the issues"
3. **Test Multiple Assessment Handling** - Blocker for export tool, untested scenario

### 🟠 HIGH PRIORITY
4. **Layout Change: Assessment Details Report** - Client explicitly requested
5. **Layout Change: Goals Report + Add Goal Text** - Client explicitly requested
6. **Define Assessment Snapshot** - Mentioned but undefined

### 🟡 MEDIUM PRIORITY
7. **Goal Reminders Dashboard Widget** - Optional but useful
8. **Affiliate-Level Analytics Dashboard** - Supports affiliate staff needs
9. **Historical Comparison Reports** - Programs over time analysis
10. **Goal Achievement Analytics** - Track success rates

### 🟢 LOW PRIORITY (Future Enhancements)
11. **Benchmark/Comparison Reports** - Nice to have
12. **Trend & Longitudinal Analysis** - Research enhancement
13. **Reviewer Performance Metrics** - Internal operations
14. **Document/Evidence Reports** - After documents discovery

---

## END OF DOCUMENT

**Key Takeaway:** The client needs comprehensive reporting and analytics that **don't currently exist**. The "Uber Report-Building Tool" could solve many export needs, but the foundational NQMS Analytics/Overview section is the biggest missing piece that should be prioritized alongside the comprehensive data export capability.
