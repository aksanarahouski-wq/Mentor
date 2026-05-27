# Estimates: NQMS Enhancements
**Category:** NQMS Enhancements
**Items:** #11, #12, #13, #14, #15 (reviewed) | #30 (new — excluded)
**Status:** Reviewed items only
**Last Updated:** April 2026

---

## #11 — Assessment History & Multi-Assessment Support

**Priority:** Critical | **Impact:** Medium | **Status:** Reviewed (Meeting 1) — **#1 NQMS priority**

### Refined Scope (Post-Meeting 1)
1. **Support multiple assessments per program** (1 active at a time)
2. **Close/complete workflow** — trigger to close assessment and open new cycle
3. **Three assessment states:** Active, Historical (accessible for reporting), Archived
4. **Historical visibility** — dashboard/list showing Active and Historical assessments
5. **Goal reference** — ability to reference past assessment data when setting new goals

> **Dependency:** Requires dedicated breakout/discovery session with Mike before finalizing solution. Too complex for T-shirt sizing alone.

### Preliminary Scope Breakdown

#### 11a. Assessment Status Model Enhancement
**What exists today:**
- Assessments already support one-to-many relationship with programs (`program_id` FK on `program_assessments`)
- Current statuses: `in-progress`, `pending-review`, `completed`, `goal_completed`
- Soft-delete/archive exists: `deleted` column (migration `20251124150000`), `beforeFind()` excludes archived unless `withArchived` option is true
- Archive button visible to Global Admins and Affiliate Staff

**Work required:**
- Add a `lifecycle_status` field (or repurpose existing status) to distinguish: **Active**, **Historical**, **Archived**
- Active = current assessment cycle (only 1 per program)
- Historical = completed and closed cycle, accessible for viewing/reporting
- Archived = hidden from standard views (existing soft-delete behavior)
- Migration to add new column or modify existing status enum
- Update all queries to respect lifecycle status

**Estimate:** ~16-20 hours

#### 11b. Close Assessment & Open New Cycle Workflow
**What exists today:**
- No workflow to "close" an assessment and start a new one
- Assessment statuses are: in-progress → pending-review → completed → goal_completed
- No "close/finalize" action that transitions a completed assessment to historical

**Work required:**
- Add "Close Assessment Cycle" action (button on completed/goal_completed assessment)
- Closing an assessment sets its lifecycle_status to "Historical"
- "Start New Assessment" action creates a fresh assessment for the program
- Validation: cannot start new assessment if one is still active/in-progress
- Carry forward context: link new assessment to prior cycle for reference
- UI: confirmation dialog explaining what closing means

**Estimate:** ~24-32 hours

#### 11c. Assessment Dashboard / List View
**What exists today:**
- Program detail page shows a single assessment view
- No list of all assessments for a program

**Work required:**
- New section on Program Detail page: "Assessment History" showing all assessments
- Table/list: Assessment cycle #, Date range, Status (Active/Historical/Archived), Actions (View)
- Default view: Active assessment expanded, Historical assessments listed below
- Click to view any historical assessment in read-only mode
- Filter/sort by date or status

**Estimate:** ~20-28 hours

#### 11d. Historical Assessment Viewer
**What exists today:**
- Assessment view page exists (`plugins/Programs/templates/Admin/Assessments/view.php`)
- Currently only shows the "active" assessment

**Work required:**
- Allow viewing any historical assessment (not just active)
- Read-only mode for historical assessments (no edit buttons)
- Display historical goals alongside assessment responses
- Navigation between assessment cycles (prev/next)

**Estimate:** ~12-16 hours

#### 11e. Goal Reference from Prior Cycles
**What exists today:**
- Goals are tied to a specific assessment via `program_assessment_id`
- No cross-assessment goal reference

**Work required:**
- When creating goals for a new assessment, show sidebar/panel with prior assessment goals
- Display: prior goal text, baseline score, target score, achieved score, status
- Allow "carry forward" action: copy a prior goal into the new cycle with updated baseline

**Estimate:** ~16-24 hours

### Item #11 Total Estimate

| Sub-Item | Hours (Low) | Hours (High) |
|----------|-------------|--------------|
| 11a. Status model enhancement | 16 | 20 |
| 11b. Close/open cycle workflow | 24 | 32 |
| 11c. Assessment dashboard | 20 | 28 |
| 11d. Historical viewer | 12 | 16 |
| 11e. Goal reference | 16 | 24 |
| **QA & Testing** | **16** | **24** |
| **Total** | **104** | **144** |

> **IMPORTANT:** This is the most complex item on the list. The breakout session with Mike may refine scope significantly. These estimates assume full scope — a phased approach is recommended:
> - **Phase 1:** 11a + 11b + 11c (~60-80h) — core lifecycle support
> - **Phase 2:** 11d + 11e (~28-40h) — historical viewing and goal reference

---

## #12 — NQMS Assessment Workflow Improvements

**Priority:** Medium | **Impact:** Medium | **Status:** Reviewed (Meeting 1)

### Refined Scope (Post-Meeting 1)
1. **Remove "Edit Assessment" button from Program Details** — display "View Assessment" only
2. **Reevaluate "Export Assessment Goals" button** for approved assessments
3. **Update "Notes" field label** to: "Notes (Why did you rate yourself at the above score or give yourself an NA?)"

> Minor cleanup — good candidate for bundling with other quick wins

### Preliminary Scope Breakdown

#### 12a. Remove/Replace "Edit Assessment" Button
**What exists today:**
- Assessment view page (`plugins/Programs/templates/Admin/Assessments/view.php`) shows buttons based on status:
  - If `in-progress`: "Edit Assessment" (btn-info)
  - If `pending-review` + can approve: "Review Assessment" (btn-success)
- Program Details page likely has a direct "Edit Assessment" link

**Work required:**
- On Program Details page: change "Edit Assessment" to "View Assessment" link
- View Assessment page then provides the appropriate action buttons based on status
- Ensures consistent flow: Program → View Assessment → Edit/Review/Delete

**Estimate:** ~3-4 hours

#### 12b. Review "Export Assessment Goals" Button
**What exists today:**
- Goals export exists in `GoalsController::export()` — generates CSV
- Button appears for approved assessments

**Work required:**
- Evaluate if button should be hidden for certain assessment statuses
- Hide or relocate if deemed unnecessary (conditional display)

**Estimate:** ~2-3 hours

#### 12c. Update Notes Field Label
**What exists today:**
- Notes field in assessment response form with generic "Notes" label

**Work required:**
- Update label text in assessment edit template
- Ensure label wraps properly on different screen sizes

**Estimate:** ~1-2 hours

### Item #12 Total Estimate

| Sub-Item | Hours (Low) | Hours (High) |
|----------|-------------|--------------|
| 12a. Button changes | 3 | 4 |
| 12b. Export button review | 2 | 3 |
| 12c. Notes label update | 1 | 2 |
| **QA & Testing** | **2** | **3** |
| **Total** | **8** | **12** |

---

## #13 — NQMS Assessment Question Management

**Priority:** Medium | **Impact:** High | **Status:** Reviewed (Meeting 1)

### Refined Scope (Post-Meeting 1)
1. **Scrub outdated file upload help text from NQMS assessments** — old instructional text referencing per-question uploads still exists; uploads were moved to program profile

> Mike said he should have rated this higher — confusing instructions is a real problem. Aksana: "super minor, just text change."

### Preliminary Scope Breakdown

#### 13a. Remove Outdated File Upload Help Text
**What exists today:**
- Assessment edit template includes help text about file uploads
- Goals section uses Dropzone for file uploads with help text: "Batch mode: Document names will be derived from filenames..."
- Old instructional text references per-question file uploads that no longer apply

**Work required:**
- Identify all instances of file upload help text in NQMS assessment templates
- Remove or update outdated references
- Keep relevant help text for goal file uploads (Dropzone is still used there)
- Test that no actual upload functionality is broken

**Estimate:** ~2-4 hours

### Item #13 Total Estimate

| Sub-Item | Hours (Low) | Hours (High) |
|----------|-------------|--------------|
| 13a. Remove outdated help text | 2 | 4 |
| **QA & Testing** | **1** | **2** |
| **Total** | **3** | **6** |

---

## #14 — NQMS Reviewer Progress Tracking

**Priority:** Medium | **Impact:** High | **Status:** Reviewed (Meeting 1)

### Refined Scope (Post-Meeting 1)
1. **Visual indicators on collapsed assessment sections** showing completion status on landing page
2. **Red/yellow/green or icon-based indicators** (e.g., red exclamation points) without requiring user to open each section or attempt submission

> Priority decision depends on effort estimate — if small, worth including; if medium/large, may defer.

### Preliminary Scope Breakdown

#### 14a. Section Completion Indicators
**What exists today:**
- API endpoint tracks question completion: `questions_total_count`, `questions_answered_count` (counter cache on `ProgramAssessments`)
- Progress calculated as: `percentComplete = ceil(answered / total * 100)`
- Counter cache behavior in `ProgramAssessmentResponsesTable.initialize()`
- Validation errors only appear when you try to submit — no pre-submission visual feedback
- Assessment uses accordion sections (collapsible)

**Work required:**
- Calculate per-section completion status (answered vs total questions per section)
- Add visual indicator (icon + color) next to each section header in the accordion:
  - Green checkmark: all questions in section answered
  - Yellow warning: some questions answered
  - Red exclamation: no questions answered
- This requires section-level question counts (currently only overall counts exist)
- Add AJAX endpoint or precompute section-level stats on page load
- Update assessment edit and view templates to display indicators
- For reviewer mode: indicate which sections have been reviewed vs pending

**Estimate:** ~20-28 hours

### Item #14 Total Estimate

| Sub-Item | Hours (Low) | Hours (High) |
|----------|-------------|--------------|
| 14a. Section completion indicators | 20 | 28 |
| **QA & Testing** | **4** | **6** |
| **Total** | **24** | **34** |

---

## #15 — Full Data Export for Research

**Priority:** High | **Impact:** — | **Status:** Reviewed (Meeting 1)

### Refined Scope (Post-Meeting 1)
**Deprioritized — no immediate development needed.**
- Interim approach: Orases provides ad-hoc CSV data exports via SQL query on request
- Revisit in ~3-4 months (June/July 2026) when evaluation plan is defined

### Preliminary Scope Breakdown

**No development work at this time.**

**What exists today for ad-hoc support:**
- NQMS Report export exists: `plugins/Reports/src/Controller/Admin/NqmsReportController.php` — comprehensive export with question averages, goal statistics, rating distributions
- Assessment export: `AssessmentsController::export()` — CSV with responses
- Goals export: `GoalsController::export()` — CSV with goal data
- `Export::export()` utility supports CSV and XLSX formats

**When revisited (~June/July 2026), scope would include:**
- Wide-format CSV with one row per program
- All assessment cycles side by side
- Baseline and improved ratings per question
- Goal tracking across assessments
- Data dictionary/codebook

**Future estimate (when scoped):** ~40-60 hours

### Item #15 Total Estimate

| Sub-Item | Hours (Low) | Hours (High) |
|----------|-------------|--------------|
| **Current:** Ad-hoc SQL support | 0 | 0 |
| **Future (est.):** Full export builder | 40 | 60 |
| **Total (current)** | **0** | **0** |

---

## Category Summary

| Item | Description | Hours (Low) | Hours (High) | Notes |
|------|-------------|-------------|--------------|-------|
| #11 | Assessment History & Multi-Assessment | 104 | 144 | Needs breakout session; phased approach recommended |
| #12 | Assessment Workflow Improvements | 8 | 12 | Quick win — bundle with other small items |
| #13 | Assessment Question Mgmt | 3 | 6 | Quick fix — text changes |
| #14 | Reviewer Progress Tracking | 24 | 34 | Priority depends on effort |
| #15 | Full Data Export for Research | 0 | 0 | Deferred — ad-hoc SQL for now |
| | **Category Total (current)** | **139** | **196** | |
| | **Quick wins (#12 + #13)** | **11** | **18** | Can start immediately |
| | **Phase 1 of #11** | **60** | **80** | Core lifecycle support |
