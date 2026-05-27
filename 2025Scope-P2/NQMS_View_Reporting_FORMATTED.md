# NQMS View, Search & Dashboard Enhancements

## Document Purpose
This document consolidates client requests for enhancements to NQMS viewing, searching, filtering, and dashboard capabilities. The goal is to conduct discovery to identify scope and requirements, which will inform the solution proposal and estimation.

---

## Request Overview

### Category: Assessment Views & Dashboards
**Focus Areas:**
- Assessment Detail Report improvements (filtering, search, export layout)
- Assessment Snapshot dashboard widget
- Program-level goal visibility
- Dashboard enhancements for reviewers

### Related to Previous Requests:
- **Request 1B (Export Assessment):** Assessment Detail Report filtering improvements support better export workflow
- **Request 6 (Assessment Goals Tab):** Provides dedicated view for program goals, may replace/supplement current dashboard needs

---

## Request 7: Improve Assessment Detail Report - Search & Filter

**Status:** TO BE DISCUSSED
**Priority:** HIGH
**Related to:** Request 1B (Export Assessment)

### Description
Enhance the Assessment Detail Report with better search and filtering capabilities to make it easier to find and export specific program assessments.

### Problem Statement
The Assessment Detail Report is currently difficult to use for finding and exporting individual program assessments. Users need better search and filtering options to quickly locate specific programs or affiliates.

### Current Issues (From Meeting Discussion)
1. **Can only search by date** - No search by affiliate or program name
2. **Difficult to filter down to single program** - Sarah mentioned this is "very difficult"
3. **Export layout issues** - Questions as rows instead of columns makes data hard to use
4. **No program name search** - Must know exact date range to find assessment

### Meeting Context (Session 1, Lines 209-213)
**Sarah's feedback on Assessment Detail Report:**
- "Very difficult to filter down to a single program"
- "Can only search by date"
- "It would be lovely if we could search by even affiliate. But even better would be by program"
- "I'm trying to get creative to try and get... this one was submitted, but somebody else submitted too. So I'm trying to figure out which one is which"

**Mike's feedback:**
- "Right now, this assessment details report, it will export out... So right now you've got it filtered to showing like these 15 programs"
- Export currently shows all programs in date range, not filtered to single program

### Addresses
- Inability to quickly find a specific program's assessment
- Time wasted trying to filter by date to isolate single program
- Need to search by program name or affiliate name
- Difficulty identifying which assessment belongs to which program
- Cumbersome workflow for reviewers doing frequent exports

### Use Cases
1. **Reviewer needs to export single program assessment**
   - Currently: Must guess date range, may get multiple programs, then sort through results
   - Desired: Search by program name, select program, export immediately

2. **Affiliate reviewer wants to see all assessments for their affiliate**
   - Currently: No way to filter by affiliate
   - Desired: Filter by affiliate name to see only programs in their region

3. **Reviewer forgot exact submission date**
   - Currently: Must trial-and-error with different date ranges
   - Desired: Type program name to find assessment regardless of date

4. **Multiple programs submitted same day**
   - Currently: Sarah mentioned "trying to figure out which one is which"
   - Desired: Clear program identification in report results

### Proposed Enhancements

**1. Add Program Name Search**
- Search field to filter assessments by program name
- Type-ahead/autocomplete for quick selection
- Partial name matching (search "mentor" finds "Big Brothers Mentoring")

**2. Add Affiliate Filter**
- Dropdown or search field to filter by affiliate
- Shows only assessments for programs in selected affiliate
- Useful for affiliate staff to see only their programs

**3. Improve Results Display**
- Make program names more prominent in results
- Add program ID or additional identifiers
- Make results clickable (link directly to assessment view)

**4. Keep Date Filter**
- Date range still available as optional filter
- Can combine with program/affiliate search
- Useful for "assessments submitted in Q1" type queries

### Meeting Decision - Clickable Results (Session 1, Lines 86-88)
**Mike asked:** "I was wondering, can we make it so that if I filter down to just these 13 or 15 programs, are those clickable? Right. Could we make it so that I could just click on one of those and go to there?"

**Aksana confirmed:** "Yes, that's actually it. Yeah. And that is like things like that are very easy to do."

**Decision:** Make program names in report results clickable - clicking navigates directly to that program's assessment view

### Discovery Questions

1. **Search Functionality:**
   - Should program search be full-text search or dropdown select?
   - Should it support partial name matching (fuzzy search)?
   - Should there be type-ahead/autocomplete suggestions?
   - Should program ID also be searchable?

2. **Affiliate Filter:**
   - Should affiliate filter be a dropdown or search field?
   - Should it support multi-select (filter by multiple affiliates)?
   - What should affiliate staff see by default (all or only their affiliate)?
   - Should global admins see all affiliates in dropdown?

3. **Combined Filters:**
   - Can users combine program + affiliate + date filters?
   - What happens if filters return no results?
   - Should there be a "Clear Filters" button?
   - Should filter state persist across page refreshes?

4. **Results Display:**
   - Should clicking program name navigate to assessment view or program detail page?
   - Should there be option to "Open in New Tab"?
   - Should assessment submission date be displayed in results?
   - Should there be visual indicator for completed vs. in-progress assessments?

5. **Export from Report:**
   - When filters are applied, should export only include filtered results?
   - Should there be "Export Selected" option to export specific programs?
   - How does this relate to Request 1B (Export Assessment button on assessment view)?

6. **Performance:**
   - How many total assessments are in the system?
   - Will search need to handle large datasets (pagination, limits)?
   - Should there be a max number of results displayed?

### Recommended Solution (Budget-Friendly)

**Approach: Add Search/Filter Fields to Existing Report Page**

**Implementation:**
1. **Add Program Name Search Field**
   - CakePHP form input with search condition
   - Query: `WHERE programs.name LIKE '%search_term%'`
   - Clear/reset button to remove search filter

2. **Add Affiliate Filter Dropdown**
   - Dropdown populated from affiliates table
   - Query: `WHERE programs.affiliate_id = selected_affiliate`
   - "All Affiliates" default option for global admins
   - Auto-filtered to logged-in user's affiliate for affiliate staff

3. **Make Program Names Clickable**
   - Add link to assessment view for each program in results
   - Link format: `/assessments/view/{assessment_id}`
   - Opens in same tab (users can right-click for new tab)

4. **Keep Existing Date Filter**
   - Date range filter remains available
   - Can be used alone or combined with program/affiliate filters
   - All filters are additive (AND logic)

5. **Update Query Logic**
   - Modify existing report query to accept additional filter parameters
   - Use CakePHP query builder conditions
   - Maintain existing export functionality (exports filtered results)

**Benefits:**
- **Low effort:** Uses existing report page, just adds filters
- **Familiar UX:** Users already know this report page
- **Flexible:** Filters can be used individually or combined
- **Fast:** Simple database queries with indexed columns
- **Backwards compatible:** Existing functionality preserved

**Files to Modify:**
- `plugins/Reports/src/Controller/Admin/AssessmentReportsController.php` - Add filter parameters to query
- `plugins/Reports/templates/Admin/AssessmentReports/detail.twig` - Add search/filter form fields
- `plugins/Reports/src/Model/Table/AssessmentReportsTable.php` - Update query conditions (if needed)

**Database Considerations:**
- Index on `programs.name` for faster search
- Index on `programs.affiliate_id` for faster affiliate filtering
- Likely already indexed, but verify

**Technical Considerations:**
- Sanitize search input to prevent SQL injection (CakePHP handles this)
- Consider search performance with large program lists
- May need pagination if many results returned
- Filter state should be preserved in URL query params (allows bookmarking, sharing)

---

## Request 8: Assessment Snapshot Dashboard Widget

**Status:** TO BE DISCUSSED (Mentioned but not fully defined)
**Priority:** MEDIUM
**Related to:** Request 6 (Assessment Goals Tab)

### Description
Add an "Assessment Snapshot" widget or section that displays key assessment metrics and goal summary at a glance.

### Problem Statement
There's no quick way to see high-level assessment status and progress without diving into full assessment details or running reports.

### Meeting Context (Session 2, Line 255-256)
**Aksana mentioned:** "We did guys ask something for like assessment snapshot. And that's where it's basically, what are the most critical metrics about my assessment goals is one of them, right?"

**Status:** Not yet fully discussed - team plans to cover this in future session

### Addresses
- Need for quick assessment overview
- Visibility of key metrics without full assessment review
- Goal progress summary at a glance
- Dashboard visibility for reviewers

### Potential Metrics to Display (To Be Confirmed)
1. **Assessment Status**
   - Completion percentage
   - Submission date
   - Last updated date
   - Overall average rating

2. **Goal Summary**
   - Total goals set
   - Goals completed vs. in progress
   - Goals overdue (based on target completion dates from Request 3)
   - Percentage of goals achieved

3. **Section Breakdown**
   - Section-level average ratings
   - Sections with lowest ratings (needs attention)
   - Sections with highest improvement

4. **Timeline Information**
   - Days since assessment submission
   - Next assessment due date (for 3-year cycle)
   - Goal deadline summary

### Location Options (To Be Determined)
**Option A: Program Details Page**
- Widget on main program overview
- Shows snapshot above or alongside existing details
- Always visible when viewing program

**Option B: Assessment View Page**
- Summary at top of assessment
- Shows before diving into detailed questions
- Context for assessment review

**Option C: Dashboard Widget**
- Reviewer dashboard showing multiple programs
- Comparative view across programs
- Prioritization tool for reviewers

**Option D: Integration with Request 6**
- Part of Assessment Goals tab
- Summary at top of goals table
- Goal-focused snapshot

### Discovery Questions

1. **Scope & Metrics:**
   - What specific metrics should be included in snapshot?
   - Should it focus on goals only, or include assessment ratings too?
   - Should it show historical data (comparison to previous assessments)?
   - Should it calculate trends or improvements over time?

2. **Location & Display:**
   - Where should the snapshot appear? (program page, assessment page, dashboard, goals tab?)
   - Should it be a collapsible widget or always-visible section?
   - Should it update in real-time or require page refresh?
   - Mobile responsive design requirements?

3. **Calculations:**
   - How is assessment "completion" calculated?
   - How are goal status indicators determined? (Request 3 adds dates, affects this)
   - What defines "overdue" for goals?
   - Should section averages exclude certain question types?

4. **Interactions:**
   - Should snapshot metrics be clickable (drill down to details)?
   - Should there be "Quick Actions" buttons? (e.g., "Add Goal", "Export Assessment")
   - Should there be filters or date range selectors?

5. **Access & Permissions:**
   - Should program users see their own snapshot?
   - Should affiliate staff see snapshots for all their programs?
   - Should global admins have different/additional metrics?

6. **Relationship to Request 6:**
   - Is this the same as the Assessment Goals Tab, or separate?
   - Should goals tab include snapshot at top?
   - Or should snapshot be separate from goals tab?

### Recommended Solution (To Be Defined After Discovery)

**Note:** Full solution will be defined once client confirms requirements.

**Preliminary Approach Ideas:**

**Option 1: Lightweight Goals Summary (MVP)**
- Add summary section at top of Assessment Goals Tab (Request 6)
- Display: Total goals, completed count, overdue count, percentage complete
- No complex calculations, just counts and percentages
- Low effort, high value

**Option 2: Dashboard Widget**
- Separate widget on program details page
- Shows assessment + goals summary together
- Includes visual indicators (progress bars, status badges)
- Medium effort, comprehensive view

**Option 3: Dedicated Snapshot Page**
- New page with full assessment analytics
- Charts, graphs, trend analysis
- Historical comparison across assessments
- High effort, advanced analytics

**Recommendation Pending:** Wait for client input on priority and desired metrics before recommending specific approach.

---

## Request 9: Dashboard Reminder Section for Goal Deadlines

**Status:** OPTIONAL ENHANCEMENT (Discussed but not core requirement)
**Priority:** LOW-MEDIUM
**Related to:** Request 3 (Goal Start Date & Target Completion Date)

### Description
Add a reminder section to the reviewer dashboard that shows upcoming goal deadlines and overdue goals across all programs.

### Problem Statement
Reviewers have no centralized way to see which programs have goals approaching their target completion dates or which goals are overdue. They must manually check each program or export goals to track deadlines.

### Meeting Context (Session 1, Lines 747-751)
**Optional Enhancement Discussed:**
- "Dashboard Reminder Section: On reviewer dashboard, show upcoming goal deadlines or overdue goals"
- Example: "Goal deadline approaching" or "Goal overdue by X days"
- "This is visual reminder, not automated email"
- "May be included if budget allows, but not core requirement"

**Key Decision:** This is a visual reminder only, NOT automated email reminders (which would add significant cost)

### Addresses
- No visibility into upcoming goal deadlines across programs
- Reviewers must manually track goal timelines
- No prioritization tool for which programs need attention
- Sarah mentioned she manually exports goals quarterly to check on progress

### Use Cases
1. **Reviewer wants to see which programs need follow-up**
   - Dashboard shows "5 goals due this week" across all their programs
   - Clickable to see which programs/goals

2. **Affiliate staff prioritizing outreach**
   - See programs with overdue goals first
   - Focus on programs falling behind on goals

3. **Proactive check-ins**
   - Reviewer sees goal deadline approaching in 7 days
   - Reach out to program before deadline hits

### Proposed Dashboard Section

**Location:** Reviewer Dashboard (Main page when affiliate/global admin logs in)

**Display:**
- Widget or section showing goal deadline summary
- List of upcoming deadlines (next 30 days)
- List of overdue goals
- Program name, goal name, deadline date, days remaining/overdue

**Example Display:**
```
GOAL REMINDERS
━━━━━━━━━━━━━━━━━━━━━━━━━━━

⚠️ Overdue Goals (3)
• Big Brothers Mentoring - "Improve mentor training" - 5 days overdue
• Youth Mentoring Program - "Increase volunteer retention" - 12 days overdue
• Community Mentors - "Update safety protocols" - 45 days overdue

⏰ Upcoming Deadlines (7 days)
• Mentor Match Program - "Enhance background checks" - Due in 3 days
• Friends for Youth - "Implement new curriculum" - Due in 6 days

📅 Due This Month (15)
[See all upcoming goals →]
```

**Features:**
- **Color coding:** Red for overdue, yellow/orange for approaching deadline
- **Clickable:** Each goal links to program's assessment or goals tab
- **Collapsible:** Can minimize section to save dashboard space
- **Filterable:** Option to filter by affiliate (for global admins)

### Meeting Decisions

**Key Decisions:**
1. **Visual indicator only** - No automated email reminders
2. **Dashboard display** - On reviewer landing page, not separate report
3. **Optional enhancement** - Not core requirement, if budget allows
4. **Depends on Request 3** - Requires goal start/target dates to be implemented first

**Why No Automated Emails:**
- Would add significant development cost (cron jobs, email templates, notification system)
- Mike and Sarah emphasized visual reminders are sufficient
- Reviewers already doing manual quarterly check-ins (this improves that workflow)

### Discovery Questions

1. **Dashboard Scope:**
   - Should this be on main dashboard page or separate "Reminders" tab?
   - Should it show all programs or only programs assigned to reviewer?
   - Should affiliate staff see only their affiliate's programs?
   - Should global admins see all programs or have option to filter by affiliate?

2. **Goal Selection & Display:**
   - How many goals should be displayed before "Show All" link?
   - Should there be separate sections for "Overdue" vs "Upcoming"?
   - What time ranges: "Due This Week", "Due This Month", custom?
   - Should completed goals be hidden from reminders?

3. **Threshold Settings:**
   - How many days before target date should goal appear in "Upcoming"? (7 days? 14 days?)
   - Should reviewers be able to customize their reminder threshold?
   - Should there be different thresholds for different urgency levels?

4. **Sorting & Filtering:**
   - How should goals be sorted? (By deadline date, by days overdue, by program name?)
   - Should there be filters? (By affiliate, by section, by goal status)
   - Should there be search functionality?

5. **Interactions:**
   - What happens when clicking a goal? (Navigate to program goals tab, assessment view, or goal edit page?)
   - Should there be quick actions? (Mark as complete, extend deadline, delete goal?)
   - Should there be "Dismiss" option to hide reminders for specific goals?

6. **Visual Design:**
   - What visual indicators for urgency? (Icons, colors, badges?)
   - Should there be progress bars or percentage indicators?
   - Responsive design for mobile viewing?
   - How much dashboard real estate should this take up?

7. **Performance:**
   - How many total goals will need to be checked for deadlines?
   - Should this use cached data or real-time queries?
   - Will this impact dashboard load time?

### Recommended Solution (Budget-Friendly)

**Approach: Simple Dashboard Widget with Goal Deadline Summary**

**Implementation:**
1. **Add dashboard widget**
   - New widget on reviewer dashboard page
   - Queries goals with `target_completion_date` (from Request 3)
   - Shows upcoming and overdue goals for reviewer's programs

2. **Calculate deadline status**
   - Overdue: `target_completion_date` < today AND achieved_rating < target_rating
   - Upcoming: `target_completion_date` BETWEEN today AND today + 7 days
   - Completed goals excluded (achieved_rating >= target_rating)

3. **Display logic**
   - Show max 5 overdue goals (most overdue first)
   - Show max 5 upcoming deadlines (soonest first)
   - "See All Goals" link to full report or program goals pages

4. **Make goals clickable**
   - Link to Assessment Goals Tab (Request 6) for that program
   - Anchor link to specific goal row if possible

5. **Access control**
   - Affiliate staff see only their programs' goals
   - Global admins see all programs (or filter by affiliate)
   - Program users do not see this dashboard (NQMS staff only)

**Benefits:**
- **Low effort:** Simple query and widget display
- **High value:** Helps reviewers prioritize follow-ups
- **No email infrastructure:** Just visual display, no cron jobs or emails
- **Leverages existing data:** Uses dates from Request 3
- **Integrates with Request 6:** Links to Assessment Goals Tab

**Files to Modify:**
- `plugins/Dashboard/src/Controller/Admin/DashboardController.php` - Add widget data
- `plugins/Dashboard/templates/Admin/Dashboard/index.twig` - Add widget HTML
- `plugins/Dashboard/webroot/css/dashboard.css` - Widget styling
- Create new dashboard widget component (if using component pattern)

**Database Query (Simplified):**
```sql
-- Get overdue goals for reviewer's programs
SELECT g.*, p.name as program_name, p.id as program_id
FROM goals g
JOIN assessments a ON g.assessment_id = a.id
JOIN programs p ON a.program_id = p.id
WHERE g.target_completion_date < CURDATE()
  AND (g.achieved_rating IS NULL OR g.achieved_rating < g.target_rating)
  AND g.deleted IS NULL
  AND g.status = 'active'
  AND p.affiliate_id = [reviewer_affiliate_id]  -- or all for global admin
ORDER BY g.target_completion_date ASC
LIMIT 5;
```

**Technical Considerations:**
- Ensure `target_completion_date` column exists (added in Request 3)
- Index on `target_completion_date` for faster queries
- Cache widget data (refresh every 24 hours) if performance concern
- Widget should be collapsible/dismissible to save dashboard space
- Color coding with CSS classes (e.g., `.goal-overdue`, `.goal-upcoming`)

**Phase 2 Enhancements (If Budget Allows):**
- Customizable reminder thresholds (user preferences)
- Email digest option (weekly summary of goal deadlines)
- "Snooze" or "Dismiss" functionality for reminders
- More detailed metrics (goal progress percentage, trend indicators)

---

## Overall Discovery Questions

### General Scope
1. **Priority Order:**
   - What is the priority among these view/reporting enhancements?
   - Which provides most immediate value to reviewers?
   - Should any be bundled together in implementation?

2. **Timeline & Budget:**
   - Are these separate from assessment requests (Requests 1-6)?
   - What is the budget allocation for reporting/view enhancements?
   - Should these be implemented as Phase 2 after core assessment features?

3. **Relationships:**
   - How do these requests relate to Request 1B (Export Assessment)?
   - How do these relate to Request 6 (Assessment Goals Tab)?
   - Should Assessment Snapshot be part of Goals Tab or separate?

### User Impact
1. **User Workflows:**
   - How often do reviewers use Assessment Detail Report currently?
   - How many programs does a typical affiliate reviewer manage?
   - What are the most common tasks reviewers need to accomplish quickly?

2. **Dashboard Usage:**
   - How often do reviewers log in and check dashboard?
   - What information is most critical to see first?
   - Are there seasonal variations in usage (busy assessment periods)?

### Technical Considerations
1. **Current Dashboard:**
   - What widgets/sections are currently on reviewer dashboard?
   - How much additional content can dashboard handle without clutter?
   - Are there performance concerns with current dashboard load times?

2. **Data Volume:**
   - How many total programs in system?
   - How many assessments per year?
   - Average number of goals per program?
   - Will queries need pagination or limits?

---

## Next Steps

1. **Prioritize requests** with client
   - Determine which view/reporting enhancements are highest priority
   - Clarify relationship to assessment requests (1-6)
   - Understand budget allocation

2. **Define Assessment Snapshot** requirements
   - Schedule focused discussion on what metrics to include
   - Determine where snapshot should appear
   - Clarify relationship to Request 6 (Assessment Goals Tab)

3. **Gather user feedback** on current pain points
   - Interview Sarah and other frequent report users
   - Understand typical workflows and bottlenecks
   - Identify quick wins vs. comprehensive solutions

4. **Technical analysis**
   - Review current Assessment Detail Report code
   - Assess dashboard architecture and capacity
   - Identify performance optimization opportunities

5. **Develop solutions and estimates**
   - Create detailed implementation plans
   - Provide effort estimates for each request
   - Propose phasing approach (MVP vs. enhancements)

6. **Present recommendations** to client
   - Show mockups or wireframes for visual features
   - Provide cost-benefit analysis
   - Get approval before implementation

---

## Dependencies & Integration

### Depends On:
- **Request 3 (Goal Dates):** Dashboard reminders require start_date and target_completion_date
- **Request 6 (Assessment Goals Tab):** Assessment Snapshot may be integrated with goals tab

### Supports:
- **Request 1B (Export Assessment):** Improved Assessment Detail Report filtering makes export workflow better
- **Request 6 (Assessment Goals Tab):** Dashboard reminders link to goals tab for detailed view

### Related:
- **Overall Assessment Strategy:** These enhancements improve the assessment review workflow end-to-end
- **Reviewer Efficiency:** Focus on reducing clicks and time for common tasks
- **Data Visibility:** Making critical information accessible without running reports

---

## Readiness for Sizing

**Ready to Size:**
- Request 7 (Assessment Detail Report) - Requirements fairly clear from meeting discussion
- Request 9 (Dashboard Reminders) - Optional enhancement, clear scope if approved

**Need More Discovery:**
- Request 8 (Assessment Snapshot) - Not fully defined yet, needs focused discussion

**Quick Win Candidates:**
- Request 7 (Program/Affiliate Search) - High value, relatively simple implementation
- Making report results clickable - Very easy, immediate benefit

**Optional/Budget Dependent:**
- Request 9 (Dashboard Reminders) - Nice to have but not critical
- Assessment Snapshot advanced features - Can start with MVP, enhance later
