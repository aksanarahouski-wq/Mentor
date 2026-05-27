# Group 1: UI/UX Polish & Navigation
**Items:** #4, #6, #7 (status badges only), #12, #13
**Estimated Effort:** 20-30 hours

---

## Scope Summary

These are small, low-risk items that touch view templates and minor frontend logic. A developer working in these areas can address all four in a single pass with minimal context switching.

---

## Item #4 — UI/UX Consistency & Page Layout

**What:** Make filter panels collapsible and consistent across all pages, using NQMS assessment search as the model.

**Technical Context:**
- Filters are already implemented as Vue.js components using `FilterFieldset.vue` (collapsible) and `FilterMixin.ts`
- Page-specific filters exist: `ProgramFilter.vue`, `InquiryFilter.vue`, `AccountFilter.vue`, `OrganizationFilter.vue`
- NQMS assessment search (`NqmsAssessmentsFilterForm.php` in Reports plugin) already has richer filtering with expandable sections
- `ProgramFilter.vue` already uses `FilterFieldset` for collapsible sections — consistency check needed across other pages

**Work:**
- Audit all filter pages for consistent use of `FilterFieldset` component
- Ensure all filters are above the fold / collapsible by default on pages where they aren't
- Standardize filter field ordering and styling across pages
- Add breadcrumb navigation where missing (component exists: `Breadcrumbs.vue` with `{title, url}` trail)

**Estimate:** 6-10 hours
- Filter audit and standardization: 2-4 hours (pattern exists in `FilterFieldset`, mostly applying it consistently)
- Breadcrumb additions: 2-3 hours (component exists, just need to add `trail` data where missing)
- QA/testing across all affected pages: 2-3 hours

---

## Item #6 — Navigation & Hyperlink Improvements

**What:** Make entity names clickable links throughout the system, matching NQMS-side navigation.

**Technical Context:**
- Browse Programs table (`plugins/Programs/templates/Admin/Programs/index.php`):
  - Affiliate Region column (lines 229-247): rendered as **plain text** `<ul>` with `h($affiliateRegion)` — needs to become a link
  - Program Name column (line 218-220): plain text `h($program->title)` — needs to become a link
  - Actions column (lines 274-287): already has "View/Edit" link button
- Program Detail view (`plugins/Programs/templates/Admin/Programs/view.php`): organization name is plain text
- NQMS side already has good hyperlink navigation — pattern exists to follow

**Work:**
- Make Affiliate Region names in Browse Programs clickable (link to affiliate view page)
- Make Program Name in Browse Programs clickable (link to program view page)
- Make program names in Affiliate Service Areas clickable
- Audit other tables for missing hyperlinks (assessments, goals, inquiries)
- Follow existing Vue `router-link` and CakePHP `$this->Html->link()` patterns

**Estimate:** 4-6 hours
- Hyperlink additions across templates: 2-3 hours (replace `h($text)` with `$this->Html->link()` — mechanical changes)
- Audit and catch remaining missing links: 1-2 hours
- QA/testing: 1 hour

---

## Item #7 (partial) — Program Status Badges

**What:** Make program statuses more visually prominent with color-coded badges/tiling on both the Browse Programs list and Program Detail page. Statuses (Approved, Paused, Pending, Archived) should be immediately recognizable at a glance — not just text in a column.

**Technical Context:**
- Program list template (`plugins/Programs/templates/Admin/Programs/index.php`): status currently rendered as text in a filter dropdown and table column
- Program detail view (`plugins/Programs/templates/Admin/Programs/view.php`): status displayed as plain text
- NQMS assessment statuses already use a badge/tiling pattern — this is the visual model to follow
- Status values: `approved`, `paused`, `pending`, `archived` (renamed from `deleted`)

**Work:**
- Design color-coded badge styles: green (Approved), yellow (Paused), orange (Pending), grey (Archived)
- Apply badge styling to program status in Browse Programs table rows
- Apply badge styling to program status in Program Detail page header
- Ensure badges are used anywhere program status appears (search results, affiliate program lists, etc.)
- CSS-only changes plus minor template updates to wrap status text in badge markup

**Estimate:** 4-6 hours
- Badge CSS + template changes across list and detail views: 2-3 hours
- Audit and apply to other pages where status appears: 1-2 hours
- QA/testing: 1 hour

---

## Item #12 — NQMS Assessment Workflow Cleanup

**What:** Remove redundant buttons and fix breadcrumb inconsistencies in assessment flow.

**Technical Context:**
- Program header element (`plugins/Programs/templates/element/Admin/program-header.php`):
  - "Edit Assessment" button (lines 100-116): shows when assessment status == 'in-progress' AND user has access
  - "View Assessment" button (lines 84-98): links to `/admin/programs/assessments/view/{id}`
  - "Export Assessment Goals" button (lines 66-81): shows when assessment status == 'completed'
- The "Edit Assessment" button on Program Details disrupts the intended flow: Program → View Assessment → Edit/Delete/Goals

**Work:**
- Remove "Edit Assessment" button from program-header.php (keep only "View Assessment")
- Ensure "View Assessment" page has edit action accessible from within
- Evaluate "Export Assessment Goals" button — confirm with client if still needed on program header
- Fix breadcrumb inconsistencies in assessment navigation flow
- Update "Notes" field label to clarify purpose (currently: `__('Notes (Why did you rate yourself at the above score?)')` — may need refinement)

**Estimate:** 3-4 hours
- Button removal and flow adjustment: 1 hour (remove conditional block in program-header.php)
- Breadcrumb fixes: 1 hour
- QA/testing of assessment workflow: 1-2 hours

---

## Item #13 — NQMS Assessment Question Management (Help Text)

**What:** Scrub outdated file upload help text from NQMS assessments.

**Technical Context:**
- Assessment edit form (`plugins/Programs/templates/Admin/Assessments/edit.php`): renders accordion sections with questions, ratings, checkboxes, and notes
- `MimeTypes` variable is available in the template (line 8: `@var \Orases\Files\MimeTypes $mimeTypes`) but file upload help text was not found in the current edit template — may have been partially cleaned up already
- File uploads were moved to program profile (documents uploaded at end, not per-question)
- Need to search for any remaining references to per-question file uploads in assessment-related templates

**Work:**
- Search all NQMS assessment templates for file upload references
- Remove any remaining help text that references per-question uploads
- Verify no broken references after cleanup

**Estimate:** 1-2 hours
- Search and cleanup: 0.5-1 hour (grep for file upload references, remove)
- QA/verification: 0.5-1 hour

---

## Group Total

| Item | Hours (Low) | Hours (High) |
|------|-------------|--------------|
| #4 — UI/UX Consistency | 6 | 10 |
| #6 — Hyperlinks | 4 | 6 |
| #7 — Status Badges (visual only) | 4 | 6 |
| #12 — Assessment Workflow | 3 | 4 |
| #13 — Help Text Cleanup | 1 | 2 |
| **Group Total** | **18** | **28** |

**Bundling Savings:** Working these together saves ~2-4 hours vs. individually. A developer already in the template files for #6 and #7 badges can address #4 breadcrumb gaps and #12 button cleanup in the same pass. Shared QA.

**Adjusted Group Estimate: 20-30 hours** (includes buffer for unexpected inconsistencies across pages)

---

## Risks

- **Low risk.** All items are template/view changes with no database or business logic impact.
- Minor risk: #4 filter standardization may uncover inconsistencies that require more work than expected, but the component architecture (`FilterFieldset`) already exists.
