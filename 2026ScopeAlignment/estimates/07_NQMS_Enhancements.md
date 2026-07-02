# Group 7: NQMS Assessment Enhancements
**Items:** #11, #12, #13, #14, #30
**Estimated Effort:** 73-121 hours
**Confidence Level:** HIGH (#12, #13, #14), MEDIUM (#11, #30 -- discovery session with Mike still needed)
**Prototype Reference:** https://growth-buddy-platform.lovable.app/programs/5/assessment
**Last Updated:** July 2026

---

## Scope Summary

These items cover the full NQMS assessment experience: workflow cleanup, help text fixes, progress tracking, assessment lifecycle/history, and goal status enhancements. Estimates are informed by the interactive prototype shared with the client and grounded in the actual codebase (CakePHP server-rendered assessment UI in the Programs plugin).

---

## Prototype vs. Current System

| Prototype Feature | Current System | Gap |
|---|---|---|
| Progress overview panel ("23 of 42 complete -- 55%") with per-section breakdown | Basic counter cache only. Not on view/landing page. | Large |
| Per-section completion indicators (checkmark/partial/empty) on collapsed headers | Error icons only appear after failed submit validation. No proactive status. | Large |
| Assessment cycle header ("Cycle 2", dates, reviewer) | No cycle concept. One assessment per program. | New feature |
| "View Previous Response" link per question | No historical comparison capability | New feature |
| Inline goal cards under each question (baseline, target, achieved, dates) | Goals on separate preview page, not inline | Medium |
| Streamlined action bar (Edit, View Goals, Print, Delete) | Redundant buttons scattered across program header and assessment view | Small |

---

## Item #12 -- NQMS Assessment Workflow Cleanup

### Problem

The assessment navigation flow has redundant buttons that create confusion. The Program Details page shows an "Edit Assessment" button that lets users jump directly into editing, bypassing the intended flow of Program -> View Assessment -> Edit/Delete/Goals. An "Export Assessment Goals" button also appears on the program header for approved assessments, but its usefulness is unclear. Breadcrumb navigation is inconsistent within the assessment flow.

### Solution

- Remove "Edit Assessment" button from the Program Details page header (keep only "View Assessment")
- Ensure the View Assessment page provides clear access to edit, delete, and goal actions
- Evaluate "Export Assessment Goals" button -- confirm with client if still needed on program header
- Fix breadcrumb inconsistencies in assessment navigation
- Update "Notes" field label to clarify purpose

### Technical Context

- Program header element (`program-header.php`): "Edit Assessment" button (lines 100-116), "View Assessment" button (lines 84-98), "Export Assessment Goals" button (lines 66-81)
- Template-only changes -- no database or business logic impact

### Estimate: 3-4 hours

| Component | Low | High |
|---|---|---|
| Button removal and flow adjustment | 1h | 1h |
| Breadcrumb fixes | 1h | 1h |
| QA/testing of assessment workflow | 1h | 2h |

---

## Item #13 -- NQMS Assessment Help Text Cleanup

### Problem

Outdated file upload help text still appears in NQMS assessments, referencing per-question file uploads that were moved to the program profile during a prior redesign. Mike noted this is a real problem -- confusing instructions in the assessment undermine the user experience. He said he should have rated this higher than medium.

### Solution

- Scrub all outdated file upload help text from NQMS assessment templates
- Remove any remaining references to per-question uploads (documents are now uploaded at the program profile level, not per assessment question)

### Technical Context

- Assessment edit form (`Assessments/edit.php`): `MimeTypes` variable still available (line 8) but file upload help text may have been partially cleaned up already
- Quick text change -- no structural changes needed
- Search all NQMS assessment templates for remaining file upload references and remove

### Estimate: 1-2 hours

| Component | Low | High |
|---|---|---|
| Search and cleanup | 0.5h | 1h |
| QA/verification | 0.5h | 1h |

---

## Item #14 -- NQMS Reviewer Progress Tracking

### Problem

Reviewers have no way to visually track their progress within an assessment. They can't tell which sections are complete, in progress, or not started without opening each accordion section individually. Validation errors only surface when the user attempts to submit, meaning reviewers can work through 42 questions and only discover at the end that they missed something. There's no way to resume a review where you left off.

Mike considered bumping this to high priority, saying the cost/effort would be the real decision factor.

### Solution

Add a progress overview dashboard and per-section completion indicators to the assessment view and edit pages:

- **Top-level progress bar** showing overall completion (e.g., "23 of 42 questions complete -- 55%")
- **Per-section breakdown** with status indicators (complete/in progress/not started) visible on collapsed accordion headers
- **Summary line** (e.g., "2 sections complete, 3 in progress, 2 not started")
- **Real-time updates** on the edit page as the user changes ratings or N/A toggles
- **"Review Before Submitting"** guided prompt at page footer

**Prototype Reference:** https://growth-buddy-platform.lovable.app/programs/5/assessment -- shows the full progress panel with per-section breakdowns and color-coded status badges.

### Technical Context

- `AssessmentsController::getSectionsFromResponses()` already groups questions by section -- extend to return per-section completion counts
- Counter cache exists: `questions_total_count` / `questions_answered_count` on `program_assessments`
- AJAX endpoint `Api/AssessmentsController::edit()` already returns `percent_complete` -- can extend to per-section
- Current JS handles show/hide of checkboxes -- extend with indicator update logic

### Estimate: 18-30 hours

| Component | Low | High |
|---|---|---|
| Backend section-level completion logic | 4h | 6h |
| Progress overview panel (view + edit templates) | 6h | 10h |
| Dynamic JS indicator updates (edit page) | 4h | 8h |
| QA/testing | 4h | 6h |

**Note:** Previous estimate was 16-24h for simpler traffic-light icons. The prototype shows a richer progress dashboard, adding 2-6h. Low end assumes simpler indicators; high end matches the prototype's full overview panel.

---

## Item #11 -- Assessment History & Multi-Assessment Support

### Problem

The system currently doesn't support multiple assessments per program in any meaningful way. Programs approaching the 3-year reassessment mark need to complete a second assessment, but there's no way to close the current assessment cycle and start a new one while maintaining access to historical data. Reviewers can't view past assessments, compare ratings across cycles, or reference previous goals when setting new ones. There's no distinction between an active and closed assessment -- just statuses that don't convey lifecycle state.

Mike confirmed this as the **#1 NQMS priority** (Meeting 1). He requested a third assessment state beyond "active" and "archived" -- something like "historical" that remains accessible for reporting and longitudinal research.

### Solution

Support multiple assessment cycles per program with lifecycle management and historical access:

- **Close/complete workflow** -- dedicated action to mark the current assessment as "historical" and prevent further edits
- **Start new cycle** -- creates a new assessment with auto-incremented cycle number, sets it as the program's active assessment
- **Third assessment state ("historical")** -- completed assessments that are read-only but remain visible and reportable
- **Assessment history view** -- list of all assessment cycles for a program showing cycle number, date range, status, and score summary
- **"View Previous Response"** per question -- link on current assessment showing what was answered in the prior cycle
- **Report updates** -- default to active assessment, with option to include historical data

**Prototype Reference:** https://growth-buddy-platform.lovable.app/programs/5/assessment -- shows "2024 NQMS Assessment -- Cycle 2" with Active badge, cycle date range, and "View Previous Response" links per question.

Out of scope (deferred): side-by-side comparison tools, progress charts, timeline view, automated cycle opening.

### What Exists Today

The database already supports multiple assessments per program, but the UI and workflow do not.

| What Exists | What's Missing |
|---|---|
| `program_assessments` table (1:many with programs) | No "close cycle" action -- no deliberate close workflow |
| `programs.latest_assessment_id` FK tracks current | No "start new cycle" action -- creating new doesn't formally close previous |
| Soft-delete via `deleted` column | No history UI -- only latest assessment accessible in admin |
| Status workflow: in-progress -> pending-review -> completed -> goal_completed | No cycle concept -- no `cycle_number`, no date range metadata |
| 3-year renewal reminder on approval | No third state -- Mike requested "historical" |
| Assessment creation is event-driven (`AssessmentListener`) | No previous response comparison |

### Estimate: 40-64 hours

| Component | Low | High |
|---|---|---|
| DB migrations + model changes | 4h | 6h |
| Close/complete lifecycle workflow (controller + UI) | 10h | 16h |
| Assessment list/history view | 6h | 10h |
| "View Previous Response" per question | 8h | 14h |
| Report filter updates | 4h | 6h |
| QA/testing | 8h | 12h |

**Scope Sensitivity:**
- **If "View Previous Response" is cut** (just lifecycle + list view): drops to ~24-38h
- **If side-by-side comparison is added later** (not in prototype): would add 16-24h on top
- Discovery session with Mike will determine which features are essential for v1

### Discovery Questions for Mike

- Exact close-cycle workflow: Does assessment need to be `completed` first, or can an `in-progress` assessment be abandoned/closed?
- Who can close a cycle? Same permissions as approve, or elevated?
- What happens to `goal_completed` status on close? Auto-transition to `historical`?
- How much previous-cycle data should be visible during a new assessment? (Rating only vs. full response with notes and goals)
- Should cycle date ranges be manually set or auto-derived from created/approved dates?
- Reporting: Is "filter by cycle" sufficient, or do they need a dedicated cross-cycle trend report?

---

## Item #30 -- NQMS Goal Status Enhancements + Inline Display

### Problem

Goals currently only have two statuses: "In Progress" and "Complete." There's no way to mark a goal that will never be completed without deleting it entirely. During NQMS data cleanup, Mike and Rachel found many stale goals (1+ year old, no progress) that are effectively abandoned but can't be appropriately categorized. These abandoned goals inflate active goal counts in reports, making it appear programs have more pending work than they actually do.

Mike: "We need some way of marking them as 'you can stop asking the program about it 'cause they ain't gonna do it' status."

Deleting abandoned goals is not acceptable -- they have evaluation value (showing where programs set goals but didn't follow through reveals barriers to change and informs process improvement).

Additionally, goals are currently displayed on a separate preview page as a flat table rather than inline with their associated assessment questions, making it harder to see the connection between a question's rating and its related goal.

### Solution

- **Add new goal statuses:** "Not Pursued" and "Deferred" alongside existing "In Progress" and "Complete"
- **Require a reason** when marking a goal as Not Pursued or Deferred (free text -- valuable for evaluation)
- **Update reporting** -- exclude Not Pursued / Deferred goals from active counts by default, but keep them visible in historical reports
- **Inline goal display** -- render goal cards directly under each assessment question (as shown in prototype) instead of on a separate page
- **Goal status interaction with #11** -- when closing an assessment cycle, prompt reviewer to update status on any In Progress goals before closing

**Prototype Reference:** https://growth-buddy-platform.lovable.app/programs/5/assessment -- shows goal cards nested under each question with baseline/target scores, dates, and action links (Edit/Delete/Add Goal).

### Technical Context

- `ProgramAssessmentGoalsTable`: fields include name, score, target_score, achieved_score, dates, notes
- `ProgramAssessmentResponse hasOne ProgramAssessmentGoal` association exists -- enables inline display
- Goals currently on separate preview page (`preview.php`) as flat table
- Reports count active goals -- queries need updating to exclude not_pursued/deferred

### Estimate: 15-25 hours

| Component | Low | High |
|---|---|---|
| Inline goal cards in view/edit templates | 6h | 10h |
| New goal statuses + reason field (migration, model, form) | 4h | 6h |
| Report query updates | 2h | 4h |
| QA/testing | 3h | 5h |

---

## Group Total

| Item | Hours (Low) | Hours (High) |
|------|-------------|--------------|
| #14 -- Reviewer Progress Tracking (Enhanced) | 18 | 30 |
| #11 -- Assessment History & Multi-Assessment | 40 | 64 |
| #30 -- Goal Status Enhancements + Inline Display | 15 | 25 |
| #12 -- Assessment Workflow Cleanup | 3 | 4 |
| #13 -- Help Text Cleanup | 1 | 2 |
| Bundling savings (shared assessment templates, shared QA) | -4 | -4 |
| **Group Total** | **73** | **121** |

---

## Scope Tiers

The wide range (73-121h) reflects pending decisions. Here's how scope choices affect the total:

### Tier 1: Quick Wins Only (4-6h)
Items #12 + #13. Ship independently, no dependencies.

### Tier 2: Quick Wins + Progress Tracking (22-36h)
Items #12 + #13 + #14. Matches the original Group 7 scope with enhanced progress dashboard from prototype.

### Tier 3: Full Prototype (73-121h)
All 5 items. Delivers the complete assessment experience shown in the prototype. Requires discovery session with Mike for #11 and #30.

### Tier 3a: Full Prototype Without "View Previous Response" (57-97h)
Same as Tier 3 but cuts the most complex #11 sub-feature. Still delivers lifecycle management, history list, goal statuses, and progress tracking. Saves 8-14h.

---

## Implementation Order

1. **#12 + #13** -- Quick wins, ship anytime, no dependencies
2. **#14** -- Progress tracking, visible impact, no hard dependencies (but if #11 is planned, build with cycle awareness from the start)
3. **#11 + #30 together** -- After discovery session with Mike. #30 pairs naturally with #11 (goal cleanup on cycle close)

---

## Dependencies & Sequencing

```
#12, #13 (Quick wins) ---- No dependencies, ship anytime

#14 (Progress tracking) -- No hard dependencies, but if #11 is planned,
                           consider building progress panel with cycle
                           awareness from the start

#11 (Assessment lifecycle) -- Requires discovery session with Mike
                              Blocks "View Previous Response" in #14
                              Companion to #30

#30 (Goal statuses) -------- Requires discovery session with Mike
                              Pairs naturally with #11 (goal cleanup on cycle close)
                              Can be built independently but better together
```

---

## Risks

- **Medium risk overall.**
- #12 and #13 are template-only changes with no business logic impact (low risk)
- #14: Defining "completion" per section requires clear rules (what counts as complete when N/A is checked? Are notes required?)
- #14: Real-time indicator updates add frontend JavaScript complexity
- #11: Assessment lifecycle is the most complex piece -- state transitions, data integrity across cycles, report compatibility. Needs discovery session with Mike before committing to scope.
- #11: "View Previous Response" requires loading historical data inline -- performance consideration for programs with many cycles
- #30: Goal status changes must not break existing report queries or aggregate counts
- #30: Integration with #11 (prompt to update goal statuses when closing a cycle) adds coupling between items

---

## Item #15 -- Full Data Export for Research

**Status:** Deferred. Revisit June/July 2026 when Mike's evaluation plan is defined. Interim approach: Orases provides ad-hoc CSV exports via SQL on request. Not included in this estimate.

---

## Related NQMS Work in Other Groups

- **Item #8 (Badge Management)** in Group 6 touches `plugins/NQMS/src/Model/Table/BadgesTable.php` but is scoped as a general admin feature, not an assessment workflow item
- **Item #21 (National Affiliate)** in Group 4 includes 6-10 hours for NQMS assessment/reporting compatibility -- this is a dependency of the affiliate feature, not standalone NQMS scope
