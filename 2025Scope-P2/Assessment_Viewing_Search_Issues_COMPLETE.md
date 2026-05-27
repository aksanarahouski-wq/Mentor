# Complete List: Assessment Viewing, Search, and Status Management Issues

## Document Purpose
This document consolidates ALL issues, questions, and requests related to viewing assessments, searching/filtering assessments, viewing assessment statuses, and managing assessment data across the NQMS system.

---

## CRITICAL FINDING: Major Gap Identified

### **"No Access to NQMS Data as a Whole"**
**Source:** Meeting 2, Line 55 - Aksana's Discovery Statement

> "I do realize looking at your portal that you basically **have no access to NQMS data as a whole, right? No analytics to see how many assessments is out there** and et cetera."

**This is the BIGGEST issue identified** - There's an entire NQMS analytics/overview section that doesn't exist or is completely inaccessible.

---

## Issue Category 1: Assessment List/Overview View

### Issue 1.1: No Comprehensive Assessment List View
**Status:** MAJOR GAP - Not explicitly requested but implied by workflows
**Priority:** HIGH

**Problem:**
- Users cannot see a list of ALL assessments across all programs
- No single page showing assessment overview/status
- Must navigate to individual programs to find assessments
- No way to see which programs have assessments vs. which don't

**Evidence from Meetings:**
- Sarah needs to search Assessment Detail Report to find assessments (Meeting 2, Line 77)
- Aksana mentioned "no access to NQMS data as a whole" (Meeting 2, Line 55)
- Users mentioned need for "assessment snapshot" (Meeting 2, Line 255)

**What's Missing:**
- Assessment index/list page (like a "Programs" list but for Assessments)
- Ability to see all assessments at a glance
- Filter/sort options for assessment list
- Bulk actions on assessments

**Questions:**
1. Should there be an "Assessments" main navigation item?
2. What would an assessment list page show?
   - Program name
   - Assessment name/title
   - Assessment status (draft, submitted, under review, completed)
   - Submission date
   - Last updated date
   - Reviewer assigned
   - Number of goals set
   - Average rating
3. Who should have access to view all assessments?
   - Global admins: All assessments
   - Affiliate staff: Only their affiliate's assessments
   - Programs: Only their own assessments
4. Should there be different views for different statuses?
   - "Active Assessments"
   - "Submitted for Review"
   - "Archived Assessments"

---

### Issue 1.2: No Assessment Status Visibility
**Status:** CONFIRMED GAP
**Priority:** HIGH

**Problem:**
- No clear way to see assessment status at a glance
- Users cannot tell which assessments are:
  - In progress (draft)
  - Submitted for review
  - Under review by staff
  - Completed
  - Archived/inactive
- Section goals incorrectly show as "complete" on assessment status dashboard (from Request 5)

**Evidence:**
- Assessment Detail Report doesn't show status clearly
- Section goals "show as complete on the assessment status dashboard when they shouldn't" (Request 5 problem statement)
- No mention of status filters in current system

**Questions:**
1. What assessment statuses should exist?
   - Draft (program still working on it)
   - Submitted (ready for review)
   - Under Review (reviewer is working on it)
   - Review Complete (reviewer finished, goals set)
   - Archived (dead/abandoned assessment)
2. Should status be automatically calculated or manually set?
3. Should there be workflow transitions? (Draft → Submit → Review → Complete)
4. Should email notifications be sent on status changes?
5. Where should status be visible?
   - Assessment list view
   - Program detail page
   - Assessment view page
   - Dashboard widgets
   - Reports

---

### Issue 1.3: No Dashboard Widget for Assessment Overview
**Status:** PARTIALLY REQUESTED (Assessment Snapshot - Request 8)
**Priority:** MEDIUM-HIGH

**Problem:**
- Reviewers have no dashboard view of assessments across their programs
- No quick way to see:
  - How many assessments are awaiting review
  - Which assessments are overdue for follow-up
  - Assessment completion rates
  - Programs without assessments
  - Recent assessment submissions

**Related Requests:**
- Request 8: Assessment Snapshot (mentioned but not fully defined)
- Request 9: Dashboard Reminders for Goal Deadlines

**Questions:**
1. Should there be an "Assessments" dashboard widget?
2. What metrics should it show?
   - Total assessments in system
   - Assessments by status (draft, submitted, under review, complete)
   - Recent submissions (last 30 days)
   - Assessments awaiting action
   - Average assessment rating across programs
3. Should it show different data for different user roles?
   - Global admin: All assessments system-wide
   - Affiliate staff: Only their affiliate's assessments
   - Programs: Only their own assessment(s)
4. Should it be clickable? (drill down to filtered assessment list)

---

## Issue Category 2: Assessment Search & Filtering (Assessment Detail Report)

### Issue 2.1: Cannot Search by Program Name
**Status:** CONFIRMED - Request 7
**Priority:** HIGH
**Source:** Meeting 2, Lines 77-78 (Sarah's feedback)

**Problem:**
> "It would be lovely if we could search by even affiliate. But even better would be by program, because sometimes I'm trying to get creative to try and get. Oh, this one was submitted, but somebody else is submitted too. So I'm trying to figure out which one is which."

**Current State:**
- Can ONLY search by date range
- No program name search
- No program ID search
- Must guess date ranges to find specific program

**Impact:**
- Sarah wastes time "trying to get creative" with date filters
- Cannot identify which assessment belongs to which program when multiple submitted same day
- Difficult workflow for frequent task (reviewers export assessments regularly)

**Requirements:**
- Add program name search field
- Support partial name matching
- Type-ahead/autocomplete suggestions
- Search by program ID as alternative

---

### Issue 2.2: Cannot Filter by Affiliate
**Status:** CONFIRMED - Request 7
**Priority:** HIGH
**Source:** Meeting 2, Line 77 (Sarah's feedback)

**Problem:**
> "It would be lovely if we could search by even affiliate."

**Current State:**
- No affiliate filter option
- Affiliate reviewers see all programs' assessments (not filtered to their affiliate)
- Must manually scan through results to find their programs

**Impact:**
- Affiliate staff (like Sarah in Colorado) must wade through assessments from other affiliates
- Inefficient for reviewers who only care about their affiliate's programs
- No way to run affiliate-specific reports

**Requirements:**
- Add affiliate dropdown/filter
- Auto-filter for affiliate staff (show only their affiliate by default)
- Global admins can select "All Affiliates" or specific affiliate
- Multi-select capability? (select multiple affiliates at once)

---

### Issue 2.3: Export Layout is Unusable (Questions as Rows)
**Status:** CONFIRMED - Request 7, Related to Request 1B
**Priority:** HIGH
**Source:** Meeting 2, Lines 79-80 (Mike's feedback)

**Problem:**
> "Right now, this assessment details report... it's running the question as the row, meaning I've got Big Brothers Alaska, their question one and then their comment. And then another very hard to see an individual program's ratings. **I'd much rather see the program be the row and the questions, the comments.**"

**Current State:**
- Export shows questions as rows
- Multiple programs appear as columns (Rating, Comment, Rating, Comment, Rating, Comment...)
- Very difficult to see individual program's full assessment
- Cannot easily average or analyze single program's data

**Impact:**
- Sarah currently exports, then copies/pastes into separate template to make usable
- Extra manual work for every export
- Prone to errors
- Time-consuming

**Requirements:**
- Swap rows/columns: Programs as rows, questions as columns
- Each program should be a single row (or set of rows)
- Questions should be columns across
- Makes it easier to: average columns, see one program's full data, filter/sort by program

**Related:**
- Request 1B adds "Export Assessment" button to assessment view page for single-program export
- Both export formats should be consistent

---

### Issue 2.4: Report Results Not Clickable
**Status:** CONFIRMED EASY FIX - Request 7
**Priority:** MEDIUM (High value, low effort)
**Source:** Meeting 2, Lines 87-88 (Mike's request, Aksana confirmed)

**Problem:**
> Mike: "I was wondering, can we make it so that if I filter down to just these 13 or 15 programs, are those clickable? Right. Could we make it so that I could just click on one of those and go to there?"
>
> Aksana: "Yes, that's actually it. Yeah. **And that is like things like that are very easy to do.**"

**Current State:**
- Report shows program names as plain text
- Must copy program name, navigate elsewhere, search for program
- Extra clicks and navigation

**Requirements:**
- Make program names clickable links
- Click navigates to: Assessment View page (or Program Detail page?)
- Should open in same tab (users can right-click for new tab)
- Visual indicator that it's clickable (underline, color, hover state)

**Effort:** Very low - Aksana confirmed "very easy to do"

---

### Issue 2.5: Difficult to Filter to Single Program
**Status:** CONFIRMED - Request 7 Core Issue
**Priority:** HIGH
**Source:** Meeting 2, Lines 68, 209 (Mike and Sarah's feedback)

**Problem:**
> Mike: "You can run an assessment report, but **it's very hard to filter it down to a single program** that you're working with."
>
> Sarah (later): "it is **very difficult**. You can only search here by date..."

**Current State:**
- Only date range filter available
- Returns multiple programs if they submitted in same date range
- Must manually scan through results
- No way to isolate single program's assessment

**Impact:**
- Sarah's primary workflow is to export single program assessment, but it's "very difficult"
- Must export multiple programs, then manually extract the one she needs
- Time-consuming and error-prone

**This is THE core use case that needs to be solved**

---

## Issue Category 3: Assessment Status & Workflow Management

### Issue 3.1: No Clear Assessment Workflow States
**Status:** NEEDS DEFINITION
**Priority:** MEDIUM-HIGH

**Problem:**
- Unclear what lifecycle states an assessment goes through
- No indication of assessment progress
- Users cannot tell if assessment is:
  - Just started
  - In progress
  - Awaiting submission
  - Submitted and awaiting review
  - Under review
  - Review complete
  - Goals set
  - Goals achieved
  - Closed/complete
  - Archived

**Questions:**
1. Should there be formal assessment statuses?
2. What are the states in the assessment lifecycle?
3. Who can change status? (automatic vs. manual)
4. Should there be workflow rules? (e.g., can't set goals until submitted)
5. Should there be email notifications on status changes?
6. Where should status be displayed prominently?

---

### Issue 3.2: Section Goals Show Wrong Status
**Status:** CONFIRMED BUG - Request 5
**Priority:** MEDIUM
**Source:** Request 5 Problem Statement

**Problem:**
- "Section goals can show up as 'complete' even when they are not"
- "Section goals show as complete on the assessment status dashboard when they shouldn't"
- Inaccurate completion indicators mislead users

**Impact:**
- Dashboard shows incorrect assessment completion status
- Reviewers think programs have completed goals when they haven't
- Data integrity issue affects reporting

**Solution:**
- Remove section goals entirely (Request 5 decision)
- This will fix the status bug

---

### Issue 3.3: No Way to Track Assessment Progress (Percentage Complete)
**Status:** NOT REQUESTED (Potential Enhancement)
**Priority:** LOW-MEDIUM

**Problem:**
- No indicator of how much of assessment is completed
- Programs don't know if they've answered all required questions
- Reviewers can't see progress at a glance

**Questions:**
1. Should there be percentage complete indicator?
2. What counts toward completion?
   - All questions answered?
   - All required questions answered?
   - Comments added?
   - Evidence uploaded?
3. Where should progress be shown?
   - Assessment view page (progress bar)
   - Program detail page
   - Assessment list view

---

## Issue Category 4: Assessment Data & Analytics

### Issue 4.1: No Access to NQMS Data/Analytics Overview
**Status:** CRITICAL GAP - MAJOR ISSUE
**Priority:** HIGHEST
**Source:** Meeting 2, Line 55 (Aksana's discovery finding)

**Problem:**
> Aksana: "I do realize looking at your portal that you basically **have no access to NQMS data as a whole, right? No analytics to see how many assessments is out there** and et cetera."

**This is mentioned as a major category in wishlist:** "an entire NQMS section"

**Current State:**
- NO overview of NQMS data
- Cannot see total number of assessments
- No system-wide analytics
- No aggregate reporting
- No visibility into NQMS usage/adoption

**What's Missing (Potential NQMS Analytics Section):**

**System-Wide Metrics:**
- Total programs in system
- Total assessments submitted
- Assessments by status
- Average assessment rating
- Assessment completion rate
- Programs with vs. without assessments
- Assessment submission trends over time

**By Affiliate:**
- Assessments per affiliate
- Affiliate comparison metrics
- Adoption rates by affiliate

**By Time Period:**
- Assessments submitted this month/quarter/year
- Year-over-year trends
- Submission timeline view

**Goal Metrics:**
- Total goals set
- Goal completion rates
- Average time to achieve goals
- Goals by category/section
- Goal trends over time

**Questions:**
1. Should there be a dedicated "NQMS Analytics" or "NQMS Dashboard" page?
2. Who should have access?
   - Global admins: Full system analytics
   - Affiliate staff: Their affiliate's analytics only
   - Programs: Their own metrics only (or no access?)
3. What are the priority metrics?
4. Should there be:
   - Charts/graphs?
   - Downloadable reports?
   - Scheduled email reports?
   - Data export capability?
5. How does this relate to existing Reports section?

---

### Issue 4.2: No Assessment Comparison View
**Status:** NOT REQUESTED (Potential Enhancement)
**Priority:** LOW

**Problem:**
- Cannot compare assessments side-by-side
- No way to see program improvement over time (3-year cycle)
- Cannot easily compare multiple programs

**Use Cases:**
- Program wants to see their progress: 2022 assessment vs. 2025 assessment
- Affiliate staff wants to compare programs in their region
- Global admin wants to benchmark across affiliates

**Questions:**
1. Should there be assessment comparison feature?
2. Compare what?
   - Same program over time (historical assessments)
   - Multiple programs at same time
   - Program vs. affiliate average
   - Program vs. national average
3. How should comparison be displayed? (side-by-side, overlays, charts?)

---

### Issue 4.3: No Assessment History/Audit Trail
**Status:** NOT REQUESTED
**Priority:** LOW

**Problem:**
- No record of assessment changes over time
- Cannot see who made changes and when
- No way to revert changes

**Questions:**
1. Should assessment edits be tracked?
2. Should there be version history?
3. Who should see edit history?
4. What actions should be logged?
   - Question answers changed
   - Status changes
   - Goals added/modified
   - Documents uploaded

---

## Issue Category 5: Access & Permissions Related to Viewing

### Issue 5.1: Unclear Assessment Viewing Permissions
**Status:** NEEDS CLARIFICATION
**Priority:** MEDIUM

**Questions:**
1. Who can view which assessments?
   - Global admins: All assessments
   - Affiliate staff: Only their affiliate's program assessments
   - Program users: Only their own assessment
   - Reviewers: Assessments assigned to them?
2. Can programs see other programs' assessments? (likely NO)
3. Can affiliate staff see assessments from other affiliates? (likely NO)
4. Should there be reviewer assignment? (This program's assessment is assigned to Sarah)

---

### Issue 5.2: No Indication of Who Can See What
**Status:** UX ISSUE
**Priority:** LOW

**Problem:**
- No visual indication of viewing permissions
- Users may not know if their assessment is visible to reviewers
- No transparency around data access

---

## Issue Category 6: Assessment Detail Report Specific Issues

### Issue 6.1: Report Only Accessible from Reports Menu
**Status:** USABILITY ISSUE
**Priority:** LOW-MEDIUM

**Problem:**
- Assessment Detail Report buried in Reports section
- Not easily discoverable
- Users must know report exists and navigate to it

**Questions:**
1. Should there be quick access to report from other locations?
2. Should there be "Export" button on program page that triggers report?
3. Should report be integrated into assessment list view?

---

### Issue 6.2: Report Shows Multiple Programs by Default
**Status:** CONFIRMED
**Priority:** MEDIUM
**Source:** Meeting discussion - current behavior

**Problem:**
- Report returns multiple programs in date range
- Sarah's use case is single program export
- Must filter through multi-program results

**Solution:**
- Request 7 addresses with program search
- Request 1B addresses with export button on assessment view

---

### Issue 6.3: No Saved Report Configurations
**Status:** NOT REQUESTED (Enhancement)
**Priority:** LOW

**Problem:**
- Must re-enter filter criteria every time
- Frequent users (like Sarah) repeat same searches
- No way to save commonly used filters

**Questions:**
1. Should users be able to save report configurations?
2. Should there be "Recent Searches" or "Favorite Filters"?
3. Who can save configurations? (per user or shared?)

---

## Issue Category 7: Assessment View Page Issues

### Issue 7.1: Goals Button Disappears When All Goals Complete
**Status:** CONFIRMED - Related to Request 6
**Priority:** MEDIUM
**Source:** Meeting 2, Line 243 (Sarah's feedback)

**Problem:**
> Sarah: "right now when you, once all those goals are completed, we don't have the little button at the top anymore, that lets us look at the goals, unless we go to report"

**Current State:**
- "Goals" button visible only when there are incomplete goals
- Button disappears when all goals marked complete
- No way to view completed goals from assessment page
- Must go to Goals Report to see completed goals

**Impact:**
- Loss of visibility into completed goals
- Inconsistent UX (button appears/disappears)
- Extra navigation to reports

**Solution:**
- Request 6: Add "Assessment Goals Tab" to Program Detail page
- Provides permanent, always-visible location for goals
- Alternative: Keep goals button always visible on assessment page

---

### Issue 7.2: No Quick Actions on Assessment View
**Status:** NOT REQUESTED (Enhancement)
**Priority:** LOW

**Problem:**
- Limited actions available on assessment view page
- Cannot quickly:
  - Change status
  - Assign reviewer
  - Add note/comment
  - Share with program
  - Archive assessment

**Questions:**
1. What quick actions would be valuable?
2. Should there be action menu or dropdown?
3. Who should have access to which actions?

---

### Issue 7.3: Assessment View Shows All Sections Expanded (or Collapsed?)
**Status:** NEEDS CLARIFICATION
**Priority:** LOW

**Context:**
- Print discussion mentioned sections are in accordions (collapsed)
- Must manually expand all accordions to print
- Not clear what default view is

**Questions:**
1. Are assessment sections collapsed or expanded by default?
2. Should there be "Expand All" / "Collapse All" button?
3. Should user preference be saved? (always show expanded/collapsed)
4. Does this affect viewing performance on large assessments?

---

## Issue Category 8: Program Detail Page - Assessment Section

### Issue 8.1: No Assessment Summary on Program Page
**Status:** POTENTIAL GAP
**Priority:** MEDIUM

**Problem:**
- Program detail page may not show assessment overview
- Users must click into assessment to see any details
- No at-a-glance assessment status

**Questions:**
1. What assessment info should show on program detail page?
   - Assessment status
   - Submission date
   - Average rating
   - Number of goals set/completed
   - Last updated date
   - Reviewer assigned
2. Should there be "Assessment Snapshot" widget on program page? (Request 8)
3. How much detail is appropriate before it becomes cluttered?

---

### Issue 8.2: Programs with Multiple Assessments (Historical)
**Status:** NEEDS CLARIFICATION
**Priority:** MEDIUM

**Problem:**
- Programs go through 3-year assessment cycles
- May have multiple historical assessments
- Not clear how multiple assessments are displayed/accessed

**Questions:**
1. Can a program have multiple assessments in the system?
2. How are historical assessments accessed?
3. Should there be assessment history list on program page?
4. Which assessment is "current" vs. "historical"?
5. Can programs see their historical assessments?
6. Should comparison view be available? (2022 vs. 2025 assessment)

---

## Issue Category 9: Assessment Snapshot (Request 8 - Needs Definition)

### Issue 9.1: Assessment Snapshot Not Defined
**Status:** MENTIONED BUT NOT DISCUSSED
**Priority:** MEDIUM
**Source:** Meeting 2, Line 255 (Aksana mentioned, team ran out of time)

**What We Know:**
- Aksana mentioned: "you guys asked about assessment snapshot, like what comes into here"
- Team did not discuss details
- Deferred to future session

**Questions Needing Answers:**
1. **What is Assessment Snapshot?**
   - Dashboard widget?
   - Section on program page?
   - Separate page/view?
   - Report?

2. **What should it show?**
   - Assessment metadata? (status, dates, reviewer)
   - Summary statistics? (average rating, completion %)
   - Goal summary? (total goals, completed, in progress)
   - Recent activity? (last updated, recent changes)
   - Progress indicators?

3. **Where should it appear?**
   - Program detail page
   - Assessment view page
   - Dashboard (reviewer landing page)
   - Assessment list page
   - Multiple locations?

4. **Who is it for?**
   - Reviewers (to quickly assess program status)
   - Programs (to see their own progress)
   - Both?

5. **How detailed should it be?**
   - High-level summary only
   - Detailed breakdown
   - Expandable (summary with drill-down option)

6. **Relationship to other requests:**
   - Is this part of Request 6 (Assessment Goals Tab)?
   - Is this part of Issue 4.1 (NQMS Analytics)?
   - Or separate feature?

---

## Issue Category 10: Cross-Cutting Concerns

### Issue 10.1: No Assessment Notifications/Alerts
**Status:** NOT REQUESTED
**Priority:** LOW-MEDIUM

**Problem:**
- No notifications when:
  - Assessment submitted by program
  - Assessment reviewed by staff
  - Goals approaching deadline
  - Assessment feedback provided

**Questions:**
1. Should there be email notifications?
2. In-app notifications? (notification bell icon)
3. What events should trigger notifications?
4. Who receives what notifications?

---

### Issue 10.2: No Assessment Activity Feed
**Status:** NOT REQUESTED
**Priority:** LOW

**Problem:**
- No record of recent assessment-related activity
- Cannot see timeline of events (submitted, reviewed, goals set, etc.)

**Questions:**
1. Should there be activity feed on program page?
2. Should there be activity feed on assessment page?
3. What activities should be logged?

---

### Issue 10.3: Assessment Data May Be Stale
**Status:** POTENTIAL ISSUE
**Priority:** LOW

**Problem:**
- Not clear how often assessment data refreshes
- If dashboards/reports are cached, data may be outdated
- No indication of when data was last updated

**Questions:**
1. How often does assessment data refresh?
2. Should there be "Last updated: [timestamp]" indicator?
3. Should there be manual "Refresh" button?
4. Are reports/dashboards cached or real-time?

---

## SUMMARY: Priority Matrix

### CRITICAL PRIORITIES (Must Address)
1. **Issue 4.1:** No Access to NQMS Data/Analytics Overview - BIGGEST GAP
2. **Issue 2.5:** Difficult to filter to single program (Request 7)
3. **Issue 2.1:** Cannot search by program name (Request 7)
4. **Issue 2.2:** Cannot filter by affiliate (Request 7)
5. **Issue 1.2:** No assessment status visibility
6. **Issue 2.3:** Export layout unusable (questions as rows)

### HIGH PRIORITIES (Should Address)
7. **Issue 1.1:** No comprehensive assessment list view
8. **Issue 1.3:** No dashboard widget for assessment overview
9. **Issue 9.1:** Define Assessment Snapshot requirements (Request 8)
10. **Issue 2.4:** Report results not clickable (EASY FIX)
11. **Issue 7.1:** Goals button disappears (Request 6 solves this)

### MEDIUM PRIORITIES (Nice to Have)
12. **Issue 3.1:** No clear assessment workflow states
13. **Issue 8.1:** No assessment summary on program page
14. **Issue 8.2:** Unclear how multiple assessments handled
15. **Issue 5.1:** Unclear assessment viewing permissions
16. **Issue 6.2:** Report shows multiple programs by default

### LOW PRIORITIES (Future Enhancements)
17. **Issue 3.3:** No assessment progress percentage
18. **Issue 4.2:** No assessment comparison view
19. **Issue 4.3:** No assessment history/audit trail
20. **Issue 6.3:** No saved report configurations
21. **Issue 7.2:** No quick actions on assessment view
22. **Issue 10.1:** No assessment notifications
23. **Issue 10.2:** No assessment activity feed

---

## RECOMMENDED IMMEDIATE ACTIONS

### 1. Define the NQMS Analytics/Overview Section (Issue 4.1)
**Why:** Aksana identified this as completely missing. This is the foundation for seeing "all assessments" and system-wide data.

**Discovery Questions:**
- What should NQMS Analytics page include?
- Who has access?
- What are the must-have metrics?
- How does this relate to Assessment Snapshot?

### 2. Improve Assessment Detail Report (Issues 2.1-2.5 - Request 7)
**Why:** Sarah and Mike both confirmed this is painful and used frequently. High value, relatively straightforward.

**Quick Wins:**
- Add program name search
- Add affiliate filter
- Make results clickable
- Fix export layout (programs as rows)

### 3. Create Assessment List/Index Page (Issue 1.1)
**Why:** Without this, users have no way to see assessments except through reports. Fundamental navigation issue.

**Requirements:**
- List all assessments with key metadata
- Status indicators
- Search/filter/sort capabilities
- Link to assessment view

### 4. Define Assessment Status Model (Issue 1.2, 3.1)
**Why:** Status is referenced throughout but never clearly defined. Affects multiple features.

**Define:**
- What statuses exist
- Status lifecycle/workflow
- Who can change status
- Where status is displayed
- How status affects behavior

### 5. Schedule Dedicated Session for Assessment Snapshot (Issue 9.1, Request 8)
**Why:** This was mentioned but never discussed. Likely important but needs requirements gathered.

---

## Questions for Client (Prioritized)

### CRITICAL QUESTIONS (Must Answer First)

1. **NQMS Analytics Section:**
   - What should the NQMS overview/analytics section include?
   - What metrics are most important to see system-wide?
   - Should this be on a dashboard or separate analytics page?

2. **Assessment Status:**
   - What statuses should assessments have?
   - What is the assessment workflow/lifecycle?
   - How is status currently managed (if at all)?

3. **Assessment List View:**
   - Should there be a main "Assessments" page listing all assessments?
   - What information is most important to see in the list?
   - How should it be filtered/sorted?

4. **Assessment Snapshot:**
   - What is "assessment snapshot" - what should it show?
   - Where should it appear?
   - Is it part of goals tab or separate?

### HIGH PRIORITY QUESTIONS

5. **Multiple Assessments per Program:**
   - Can programs have multiple assessments over time?
   - How are historical assessments accessed/displayed?
   - Should there be comparison capability?

6. **Assessment Viewing Permissions:**
   - Who can view which assessments?
   - Should there be reviewer assignment?
   - Can programs see each other's assessments?

7. **Dashboard Needs:**
   - What assessment information do reviewers need on landing page?
   - Should there be assessment-focused dashboard widget?
   - What actions should be quickly accessible?

---

## APPENDIX: All Issues Quick Reference

| ID | Issue | Category | Priority | Status |
|---|---|---|---|---|
| 1.1 | No assessment list view | Assessment Overview | HIGH | GAP |
| 1.2 | No assessment status visibility | Assessment Status | HIGH | GAP |
| 1.3 | No dashboard widget | Dashboard | MED-HIGH | Partial (Req 8) |
| 2.1 | Cannot search by program | Search/Filter | HIGH | Req 7 |
| 2.2 | Cannot filter by affiliate | Search/Filter | HIGH | Req 7 |
| 2.3 | Export layout unusable | Export | HIGH | Req 7 |
| 2.4 | Results not clickable | Search/Filter | MEDIUM | Req 7 - Easy |
| 2.5 | Hard to filter to single program | Search/Filter | HIGH | Req 7 |
| 3.1 | No workflow states | Assessment Status | MED-HIGH | Needs def |
| 3.2 | Section goals wrong status | Assessment Status | MEDIUM | Req 5 fixes |
| 3.3 | No progress percentage | Assessment Progress | LOW-MED | Not requested |
| 4.1 | **No NQMS analytics** | **Analytics** | **CRITICAL** | **MAJOR GAP** |
| 4.2 | No comparison view | Analytics | LOW | Not requested |
| 4.3 | No audit trail | Analytics | LOW | Not requested |
| 5.1 | Unclear permissions | Access | MEDIUM | Needs clarif |
| 5.2 | No permission indicators | Access | LOW | UX issue |
| 6.1 | Report not discoverable | Report UX | LOW-MED | Usability |
| 6.2 | Report shows multiple programs | Report | MEDIUM | Design issue |
| 6.3 | No saved configurations | Report | LOW | Enhancement |
| 7.1 | Goals button disappears | Assessment View | MEDIUM | Req 6 solves |
| 7.2 | No quick actions | Assessment View | LOW | Enhancement |
| 7.3 | Accordion default unclear | Assessment View | LOW | Needs clarif |
| 8.1 | No assessment summary on program page | Program Page | MEDIUM | Potential gap |
| 8.2 | Multiple assessments unclear | Program Page | MEDIUM | Needs clarif |
| 9.1 | Assessment Snapshot undefined | Snapshot | MEDIUM | Req 8 - Discuss |
| 10.1 | No notifications | Notifications | LOW-MED | Not requested |
| 10.2 | No activity feed | Activity | LOW | Not requested |
| 10.3 | Data may be stale | Data | LOW | Potential |

---

## END OF DOCUMENT
**Total Issues Identified:** 23 distinct issues across 10 categories
**Requests Related:** Primarily Request 7, Request 8, Request 6
**Critical Gap:** No NQMS data overview/analytics (Issue 4.1)
