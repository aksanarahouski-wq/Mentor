# NQMS Enhancement Prototype Prompts — Lovable
**Base URL:** https://growth-buddy-platform.lovable.app/programs/1
**Purpose:** Iterative prompts to build on the existing Lovable prototype to demonstrate NQMS enhancement possibilities for the Mentor Connector platform.
**Created:** April 9, 2026

---

## How to Use

Each prompt below is designed to be pasted directly into Lovable. They are sequenced — later prompts build on earlier ones. Run them in order within a section, but sections can be done independently if needed.

Each prompt is tagged with the enhancement item number(s) it addresses.

---

## Section 1: Assessment History & Lifecycle (#11 — The #1 NQMS Priority)

### Prompt 1.1 — Add Assessment Tab to Program Detail Page

```
On the Program Detail page (/programs/:id), add a new tab called "NQMS Assessment" alongside the existing tabs. When clicked, this tab should show a panel with:

1. A header section showing:
   - "Current Assessment" label with a status badge showing "Active" (green badge)
   - The assessment cycle name (e.g., "Assessment Cycle 1 — 2023-2026")
   - Date range: start date and expected completion date
   - A "Complete Assessment" button (primary action, right-aligned) that we'll wire up later

2. Below the header, a summary card grid (2-3 cards per row) showing:
   - Overall Score: a numeric score like "3.2 / 5.0" with a small progress ring
   - Sections Completed: "8 of 12" with a progress bar
   - Last Updated: a date with "by [reviewer name]"

This is the landing view for the assessment tab. Use the existing design system/styling from the rest of the app.
```

### Prompt 1.2 — Assessment History List

```
Below the current assessment summary section on the NQMS Assessment tab, add a "Past Assessments" section with:

1. A section header: "Assessment History" with a small description: "Previous assessment cycles for this program"

2. A table/list showing past assessments with these columns:
   - Cycle name (e.g., "Assessment Cycle 1")
   - Date range (e.g., "Jan 2021 – Dec 2023")
   - Status badge — use three distinct states:
     - "Active" (green) — only one can be active
     - "Historical" (blue) — completed and accessible for reporting/comparison
     - "Archived" (gray) — closed, read-only
   - Final Score (e.g., "2.8 / 5.0")
   - A "View" button to open the historical assessment (read-only)

3. Add mock data for 2 past assessments:
   - Cycle 1 (2021-2023): Historical, score 2.8
   - Cycle 2 (2023-2026): Active, score 3.2

This demonstrates the three-state lifecycle model the client requested (Active → Historical → Archived).
```

### Prompt 1.3 — Complete Assessment Workflow

```
Wire up the "Complete Assessment" button on the NQMS Assessment tab. When clicked, it should open a confirmation modal/dialog with:

1. Title: "Complete Assessment Cycle"
2. Body text: "You are about to complete Assessment Cycle 2 (2023-2026). This will:"
   - Move this assessment to "Historical" status
   - Make all data read-only but still accessible for reporting and comparison
   - Allow you to start a new assessment cycle

3. A dropdown/select for "Final Status" with options:
   - "Historical — Available for reporting & comparison" (default)
   - "Archived — Read-only, hidden from default views"

4. An optional "Completion Notes" text area

5. Two buttons:
   - "Cancel" (secondary)
   - "Complete & Start New Cycle" (primary/destructive styling)

6. On confirm, simulate the transition:
   - Current assessment moves to "Historical" in the list
   - A new empty "Assessment Cycle 3" appears as "Active"
   - Show a success toast: "Assessment completed. New cycle started."

This demonstrates the close/open lifecycle workflow.
```

### Prompt 1.4 — Assessment Comparison View

```
Add a "Compare Assessments" button in the Assessment History section header (next to the title). When clicked, it should:

1. Let the user select 2 assessments from a checkbox list of all past + current assessments
2. Open a side-by-side comparison view showing:

   - Two columns, one per selected assessment, each with the cycle name and date range as header
   - A row for each assessment section/category (e.g., "Training & Support", "Program Management", "Mentoring Practices") showing:
     - The score for each assessment in that section
     - A visual indicator (up arrow green, down arrow red, dash gray) showing improvement/decline
     - The score difference (e.g., "+0.5" in green or "-0.3" in red)

   - At the bottom, an overall summary row with:
     - Total score comparison
     - Net improvement percentage
     - A small spark line or bar chart showing the trend

3. A "Close Comparison" button to return to the normal assessment tab view

This demonstrates the comparison tools and progress tracking across assessment cycles that Mike requested.
```

### Prompt 1.5 — Assessment Timeline View

```
Add a "Timeline" toggle/view option in the Assessment History section (alongside the list/table view). When toggled, show:

1. A horizontal or vertical timeline visualization showing all assessment cycles for this program:
   - Each node on the timeline represents an assessment cycle
   - Node color reflects status: green (Active), blue (Historical), gray (Archived)
   - Each node shows: cycle name, date range, and final score
   - The active assessment is highlighted/emphasized

2. Between nodes, show the improvement or decline in overall score with an arrow and percentage

3. If only 1-2 assessments exist, show a note: "More data points will appear as additional assessment cycles are completed"

Use mock data: 3 assessment cycles spanning 2021-2029 to show what a mature program timeline looks like.

This demonstrates the longitudinal view valuable for both individual program tracking and research purposes.
```

---

## Section 2: Reviewer Progress Tracking (#14)

### Prompt 2.1 — Visual Progress Indicators on Assessment Sections

```
Create a new page or view at /programs/:id/assessment that shows the full assessment form with collapsible sections. Each section should have:

1. A collapsible accordion-style section header showing:
   - Section name (e.g., "1. Training & Support", "2. Program Management")
   - A visual status indicator on the RIGHT side of the header:
     - Green checkmark icon — all questions in section are complete
     - Yellow/amber warning icon — section is partially complete (e.g., "3 of 5")
     - Red exclamation icon — section has not been started
     - Blue pencil icon — section has been edited but not yet reviewed/validated
   - A small text label showing completion count: "3/5 questions answered"

2. At the top of the page, add an overall progress bar showing total completion across all sections (e.g., "24 of 48 questions complete — 50%")

3. Show 4-5 mock sections with varying completion states to demonstrate the visual system

The key insight: reviewers currently have NO way to see progress without opening each section or trying to submit. This solves that by showing status at a glance on the landing page.
```

### Prompt 2.2 — Resume Where You Left Off

```
On the assessment detail page with the collapsible sections, add a "Resume Review" button at the top (next to the progress bar). When clicked, it should:

1. Automatically scroll to and expand the first incomplete section
2. Highlight the first unanswered question within that section with a subtle pulse or highlight animation
3. Show a small banner at the top: "Resuming from Section 3: Mentoring Practices — Question 2"

Also add a "Last edited" timestamp on each section header showing when that section was last modified, e.g., "Last edited: Mar 15, 2026 by Sandy M."

This shows how the system can help reviewers pick up where they left off without hunting through sections.
```

---

## Section 3: Assessment Workflow Cleanup (#12)

### Prompt 3.1 — Streamlined Navigation Flow

```
On the Program Detail page, in the main content area (not in the new Assessment tab, but in the existing program info area), make these changes:

1. If there is an "Edit Assessment" button visible, replace it with a "View Assessment" button that navigates to the read-only assessment view
2. Add a clear breadcrumb trail at the top: Programs > [Program Name] > Assessment
3. From the View Assessment page, show action buttons contextually:
   - "Edit" button (only if assessment is Active and user has permission)
   - "View Goals" button
   - "Export Goals" button (only show for approved assessments — this was questioned in the review)

4. Ensure the navigation follows this flow:
   Program Detail → View Assessment → (Edit / View Goals / Export)
   NOT: Program Detail → Edit Assessment directly

This cleans up the redundant button issue and establishes a consistent workflow pattern.
```

---

## Section 4: Assessment Question Management (#13)

### Prompt 4.1 — Clean Question Interface

```
In the assessment section detail view (inside an expanded accordion section), show a list of assessment questions. Each question should have:

1. The question text (clean, no outdated help text about file uploads)
2. A rating input (1-5 scale with radio buttons or star rating)
3. A "Notes" field with the updated label: "Notes (Why did you rate yourself at the above score or give yourself an NA?)"
4. For questions with an "Other" checkbox option, show a required text field that appears when "Other" is checked, labeled: "Please explain"

5. For admin users, show a small "Delete Question" icon (trash icon) on hover for each question, with a confirmation dialog: "Are you sure you want to delete this question? This cannot be undone."

Do NOT include any file upload instructions or help text on the questions — file uploads happen at the program profile level, not per-question.

This demonstrates the cleaned-up question interface with outdated text removed and the delete capability added.
```

---

## Section 5: Cross-Cutting UX Patterns (Referenced in #4, #6, #9)

### Prompt 5.1 — Hyperlink Navigation Pattern

```
Throughout the NQMS Assessment tab and assessment views, ensure all entity names are clickable hyperlinks:

1. Program names link to the program detail page
2. Affiliate names link to the affiliate detail page
3. Assessment cycle names link to the assessment detail view
4. Reviewer names link to the user profile
5. Any referenced program in comparison views should link back to that program's detail page

Use a consistent link style: blue text with underline on hover. This matches the NQMS side's existing pattern that the client wants applied across the platform.
```

### Prompt 5.2 — Collapsible Filter Panel for Assessment Search

```
If there is an assessments list/search page, add a collapsible filter panel at the top (matching the NQMS assessment search pattern). The filter panel should include:

1. A "Filters" toggle button to expand/collapse the panel
2. Filter options:
   - Assessment Status (Active / Historical / Archived) — multi-select checkboxes
   - Date Range (from/to date pickers)
   - Score Range (min/max slider or inputs)
   - Program Name (search/autocomplete)
   - Affiliate (dropdown)
   - Reviewer (dropdown)
3. "Apply Filters" and "Clear All" buttons
4. Show active filter count on the collapsed toggle: "Filters (3 active)"

This follows the NQMS assessment search pattern that was repeatedly cited as the UX model to follow.
```

---

## Section 6: Goal Reference Across Cycles (#11 — Sub-feature)

### Prompt 6.1 — Goal Reference Panel

```
In the assessment edit/view mode, when a reviewer is working on a question, add a collapsible side panel or inline expandable section labeled "Previous Cycle Reference" that shows:

1. The same question from the previous assessment cycle
2. The previous rating given
3. The previous notes/justification
4. The previous goal set for this area
5. A visual indicator showing if the current rating improved, declined, or stayed the same compared to last cycle

This panel should be collapsed by default and expandable with a "View Previous Response" link under each question.

If no previous assessment exists, show: "No previous assessment data available — this is the first cycle."

This is critical for helping programs set informed goals and track genuine improvement over time.
```

---

## Prompt Execution Order (Recommended)

For the most impactful demo, run in this order:

1. **1.1** (Assessment tab) — establishes the foundation
2. **1.2** (History list with 3 states) — shows the lifecycle model
3. **1.3** (Complete workflow) — demonstrates state transitions
4. **2.1** (Progress indicators) — high visual impact, shows reviewer UX improvement
5. **1.4** (Comparison view) — the "wow" feature for Mike's research use case
6. **4.1** (Clean questions) — quick win, shows cleanup
7. **3.1** (Navigation flow) — workflow consistency
8. **1.5** (Timeline) — polished longitudinal view
9. **6.1** (Goal reference) — ties comparison back to practical use
10. **2.2** (Resume review) — quality of life feature
11. **5.1 & 5.2** (Cross-cutting UX) — polish and consistency

---

## Notes for Discovery Session with Mike

These prompts are designed to generate visual artifacts you can bring to the breakout/discovery session for #11. Key questions the prototype should help answer:

- Does the three-state model (Active/Historical/Archived) match Mike's mental model?
- Is the comparison view what he envisions for longitudinal analysis?
- Should "Historical" assessments be editable in any way, or strictly read-only?
- What data points matter most in the comparison view?
- Should the timeline be per-program only, or should there be an aggregate view across programs?
- How should the "Complete Assessment" workflow interact with reviewer permissions?

---
---

# NEW PROMPTS — April 9, 2026

> The prompts above (Sections 1–6) have already been built into the prototype.
> Everything below is **new work** to be applied on top of the existing state.

---

## Section 7: Viewing Past Assessments (#11 — Historical Access)

These prompts build on the Assessment History list (Prompt 1.2) by adding a full read-only view of completed assessments, so reviewers, admins, and Mike's team can actually open and browse historical data — not just see it in a table row.

### Prompt 7.1 — Historical Assessment Detail View (Read-Only)

```
When a user clicks "View" on a past assessment from the Assessment History list on the NQMS Assessment tab, navigate to a new view at /programs/:id/assessment/:cycleId that shows the full historical assessment in read-only mode.

This page should have:

1. A prominent banner at the top with a blue "Historical" badge and text: "You are viewing a completed assessment. This data is read-only."
   - Include the cycle name, date range, and final overall score in this banner
   - A "Back to Assessment History" link to return to the program's NQMS Assessment tab

2. The same accordion/collapsible section layout as the active assessment, but:
   - All fields are read-only (no edit buttons, no input fields — display values only)
   - Ratings shown as filled stars or colored number badges (not editable radio buttons)
   - Notes shown as plain text blocks
   - Goals shown as plain text with their status (Met / Not Met / In Progress)

3. A right-side or top summary panel showing:
   - Overall score with a donut/ring chart
   - Score breakdown by section as a horizontal bar chart
   - Completion date and reviewer name

4. Use the same mock assessment sections and data structure from the active assessment, but with different scores to show this is a different cycle.

This is the core "historical access" feature Mike identified — being able to actually open and read past assessments, not just know they exist.
```

### Prompt 7.2 — Historical Assessment with Goal Outcomes

```
On the historical assessment detail view (/programs/:id/assessment/:cycleId), add a "Goals & Outcomes" section at the bottom of each assessment section (after the questions). For each section, show:

1. A sub-section titled "Goals Set During This Cycle" with a table:
   - Goal description (e.g., "Increase frequency of mentor-mentee check-ins to biweekly")
   - Target rating (e.g., "Move from 2 to 3 in Monitoring & Support")
   - Outcome status badge:
     - "Achieved" (green checkmark) — rating met or exceeded target
     - "Partially Met" (yellow) — improved but did not reach target
     - "Not Met" (red) — no improvement or declined
     - "Deferred" (gray) — carried forward to next cycle
   - Actual rating achieved

2. At the very bottom of the page, add an "Assessment Summary" card with:
   - Total goals set: X
   - Goals achieved: X (with percentage)
   - Goals partially met: X
   - Goals not met: X
   - Goals deferred to next cycle: X

Use this mock data for a completed Cycle 1 assessment:
- Section "Recruitment": Goal to improve from 2 to 3 → Achieved (rated 3)
- Section "Screening": Goal to improve from 1 to 3 → Partially Met (rated 2)
- Section "Training": Goal to maintain 4 → Achieved (rated 4)
- Section "Matching & Initiation": Goal to improve from 2 to 4 → Not Met (rated 2)
- Section "Monitoring & Support": Goal to improve from 3 to 4 → Achieved (rated 4)
- Section "Closure": No goal set → N/A

This demonstrates how historical assessments aren't just snapshots — they tell the story of what the program committed to and whether they followed through.
```

### Prompt 7.3 — Print / Export Historical Assessment

```
On the historical assessment detail view, add a top-right action bar with:

1. A "Print Assessment" button that opens the browser print dialog with a print-friendly layout (hide nav, expand all sections, clean formatting)

2. A "Download PDF" button that generates a simulated download (just show a toast: "Assessment Cycle 1 report downloaded as PDF") — this is for demonstrating the concept, not actual PDF generation

3. A "Share with Program" button that opens a small modal:
   - Text: "Share this historical assessment with the program's admin contacts"
   - A preview of who will receive it (mock names: "Jane Smith, Program Director" and "Tom Lee, Program Coordinator")
   - "Send" and "Cancel" buttons
   - On send, show toast: "Assessment shared with 2 program contacts"

This addresses the need Mike described for sharing historical assessment data with programs and making it accessible for reporting purposes.
```

---

## Section 8: Rich Assessment Detail with Progress Tracking (#14 — Deep Dive)

These prompts create a full, data-rich assessment view with realistic NQMS content so the prototype demonstrates real assessment structure, not just placeholder sections. This builds on Prompt 2.1 but with substantially more depth.

### Prompt 8.1 — Full Assessment Page with Realistic NQMS Sections

```
Replace or significantly enhance the assessment detail page at /programs/:id/assessment with a full, realistic NQMS assessment. Use the following structure based on MENTOR's Elements of Effective Practice for Mentoring (EEPM):

**Assessment header:**
- Program name, assessment cycle name, status badge (Active), date range
- Assigned reviewer name and role
- Overall progress bar: "28 of 42 questions complete — 67%"

**Assessment sections (accordion/collapsible, numbered):**

1. **Recruitment** (6 questions)
   - Status: COMPLETE (6/6) — green checkmark
   - Section score: 3.5 / 5.0
   - All questions answered with ratings and notes

2. **Screening** (5 questions)
   - Status: COMPLETE (5/5) — green checkmark
   - Section score: 2.8 / 5.0
   - All questions answered

3. **Training** (7 questions)
   - Status: IN PROGRESS (5/7) — yellow warning, "5 of 7"
   - Section score: pending (not all rated)
   - 5 questions answered, 2 remaining blank

4. **Matching & Initiation** (6 questions)
   - Status: IN PROGRESS (3/6) — yellow warning, "3 of 6"
   - Section score: pending
   - 3 answered, 3 blank

5. **Monitoring & Support** (8 questions)
   - Status: NOT STARTED (0/8) — red exclamation
   - No questions answered yet

6. **Closure** (5 questions)
   - Status: NOT STARTED (0/5) — red exclamation
   - No questions answered yet

7. **Program Management & Operations** (5 questions)
   - Status: IN PROGRESS (4/5) — yellow warning, "4 of 5"
   - 4 answered, 1 blank

Each collapsed section header should show: section number, section name, status icon, completion count (e.g., "5/7"), and section score (if fully complete) or "In Progress" label.

This gives the prototype realistic volume and lets us demonstrate progress tracking with real variation across sections.
```

### Prompt 8.2 — Expanded Section with Question Detail

```
For the assessment page created in prompt 8.1, make Section 3 (Training) expanded by default to show the full question detail. Display these 7 questions inside the expanded accordion:

**Question 3.1:** "Does the program provide initial training for mentors before they are matched?"
- Rating: 4 / 5 (shown as filled circles or stars)
- Notes: "All mentors complete a 6-hour orientation before matching. Includes program policies, communication skills, and boundary setting."
- Goal: "Maintain current training quality; add cultural competency module by Year 2"

**Question 3.2:** "Does the training cover the mentoring relationship lifecycle?"
- Rating: 3 / 5
- Notes: "Covered at high level during orientation but lacks depth on closure phase."
- Goal: "Develop dedicated closure training module"

**Question 3.3:** "Are mentors trained on recognizing and responding to safety concerns?"
- Rating: 5 / 5
- Notes: "Comprehensive mandatory reporter training included. Refresher required annually."
- Goal: (none set — already at highest rating)

**Question 3.4:** "Does the program provide ongoing training beyond the initial orientation?"
- Rating: 3 / 5
- Notes: "Quarterly webinars offered but attendance is low (~30%)."
- Goal: "Increase ongoing training participation to 60% by adding in-person options"

**Question 3.5:** "Are training materials regularly reviewed and updated?"
- Rating: 2 / 5
- Notes: "Materials last updated 2022. Need refresh."
- Goal: "Complete full materials review and update by Dec 2026"

**Question 3.6:** (UNANSWERED)
- "Does the program train mentors on cultural responsiveness and equity?"
- Rating: blank (show as empty circles/stars with a light gray "Not yet rated" label)
- Notes: empty (show placeholder: "Add notes...")
- Goal: empty

**Question 3.7:** (UNANSWERED)
- "Are training outcomes assessed or evaluated?"
- Rating: blank
- Notes: empty
- Goal: empty

For each answered question, display the rating as a visual element (filled vs empty indicators), the notes in a light gray text block, and the goal in an indented block with a small target icon.

For unanswered questions, use a subtle different background (very light yellow or light gray) to visually distinguish them from completed ones. Show "Not yet rated" where the score would be.

This demonstrates exactly what a reviewer sees when working through an assessment and makes the answered vs. unanswered distinction immediately clear.
```

### Prompt 8.3 — Section-Level Progress Summary Bar

```
At the top of the assessment page (below the header, above the accordion sections), add a visual section-level progress summary. This is a horizontal row of 7 small cards or segments — one per assessment section — showing at-a-glance status:

Layout: a horizontal strip of connected/adjacent blocks, like a segmented progress bar:

| Recruitment | Screening | Training | Matching | Monitoring | Closure | Program Mgmt |
|   6/6 ✓     |   5/5 ✓   |  5/7 ◐   |  3/6 ◐   |   0/8 ✗    |  0/5 ✗  |    4/5 ◐     |

Each block should:
- Show the section name (abbreviated if needed)
- Show the completion fraction (e.g., "5/7")
- Be color-coded:
  - Green background — fully complete
  - Amber/yellow background — in progress
  - Light red/pink background — not started
- Be clickable — clicking a block scrolls to and expands that section in the accordion below

Below this strip, show a single-line summary: "4 of 7 sections in progress · 2 sections complete · 2 not started"

This gives reviewers an instant visual map of where the assessment stands without scrolling. It's the #1 UX improvement the client described — "show me what's done and what's not without making me click into everything."
```

### Prompt 8.4 — Validation Preview (Pre-Submit Check)

```
Add a "Review Before Submitting" button at the bottom of the assessment page. When clicked, instead of immediately submitting, it opens a validation summary panel that shows:

1. **Title:** "Assessment Readiness Check"

2. **Section-by-section checklist:**
   For each of the 7 sections, show:
   - Section name
   - Status icon (checkmark / warning / X)
   - If incomplete: list the specific unanswered question numbers
     (e.g., "Training: Questions 3.6 and 3.7 are not yet rated")
   - If complete: "All questions answered" in green

3. **Summary counts:**
   - Total questions answered: 28 / 42
   - Total questions remaining: 14
   - Sections ready for submission: 2 / 7

4. **Action buttons:**
   - "Go to First Incomplete Question" — navigates to and highlights it (like the Resume feature)
   - "Submit Anyway" — grayed out / disabled with tooltip: "All questions must be answered before submission"
   - "Close" — returns to the assessment

5. If ALL questions are answered (simulate by description), the panel instead shows:
   - A green success state: "Assessment is complete and ready for submission"
   - "Submit Assessment" button (primary, active)
   - "Review One More Time" button (secondary)

This replaces the current experience where validation errors only appear AFTER you try to submit — a key pain point the client identified. Now reviewers can proactively check readiness.
```

### Prompt 8.5 — Per-Question Review Status Indicators

```
Inside each expanded assessment section, add a small review status indicator to each question. This is separate from whether the question is answered — it tracks the reviewer's evaluation:

For each question, add a small dropdown or toggle in the top-right corner with these states:
- "Needs Review" (default, gray dot) — reviewer hasn't looked at this yet
- "Reviewed" (blue checkmark) — reviewer has evaluated the program's response
- "Flagged" (orange flag) — reviewer wants to discuss or revisit this question
- "Approved" (green checkmark) — reviewer is satisfied with the rating and notes

When a question is flagged, show a small text input that appears below: "Flag note (optional):" where the reviewer can add a brief comment like "Rating seems high — request supporting documentation"

At the section header level, show a count: "3 reviewed · 1 flagged · 3 needs review"

This supports the reviewer workflow where answering a question (the program's job) and reviewing a question (the NQMS reviewer's job) are two different actions. Progress tracking needs to work for both roles.
```

---

## Section 9: Active vs. Historical Visual Differentiation (#11 + #14)

### Prompt 9.1 — Visual Mode Switching Between Active and Historical

```
When navigating between the active assessment and a historical assessment, make the visual difference immediately obvious:

1. **Active assessment** (current behavior):
   - Standard white/light background
   - All fields are editable (inputs, radio buttons, text areas)
   - Action buttons visible: "Save Draft", "Submit", "Review Before Submitting"
   - Progress indicators are interactive (clickable to navigate)
   - Header badge: "Active" in green

2. **Historical assessment** (when viewing a past cycle):
   - Subtle blue-tinted background or a thin blue left border on the entire page
   - All fields rendered as static text (no input affordances)
   - NO edit/save/submit buttons — replaced with: "Print", "Download PDF", "Share"
   - Progress indicators still visible but non-interactive (just informational)
   - Header badge: "Historical" in blue with lock icon
   - A persistent top bar: "Viewing Assessment Cycle 1 (2021–2023) · Completed Dec 15, 2023 · [Return to Current Assessment →]"

3. **Archived assessment** (if opened from history):
   - Gray-tinted background
   - Same read-only rendering as historical
   - Header badge: "Archived" in gray with archive icon
   - Top bar: "Viewing Archived Assessment · This assessment is no longer included in reports · [Return to Current Assessment →]"

The point: a reviewer should NEVER be confused about whether they're looking at live data they can edit or historical data. The visual treatment must make it instantly obvious.
```
