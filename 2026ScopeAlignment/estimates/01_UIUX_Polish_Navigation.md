# Group 1: UI/UX Polish & Navigation
**Items:** #4, #6, #7 (status badges only)
**Estimated Effort:** 14-22 hours
**Confidence Level:** HIGH
**Last Updated:** July 2026

---

## Scope Summary

These are small, low-risk items that touch view templates and minor frontend logic. A developer working in these areas can address all three in a single pass with minimal context switching.

---

## Item #4 — UI/UX Consistency & Page Layout

### Problem

Filter panels across the platform are inconsistent. Some pages have collapsible filters, others don't. Users must scroll past open filter panels to reach their data. Breadcrumb navigation is missing in several areas. The NQMS Assessment search page already has a clean, collapsible filter layout — but the rest of the system (Browse Programs, Inquiries, Accounts, Affiliates) doesn't match.

### Solution

Standardize filter panels and navigation across all pages using the NQMS Assessment search as the reference. Specifically:

- Make all filter panels collapsible using the existing `FilterFieldset` Vue component (already used on some pages, just not all)
- Add breadcrumb navigation where missing (component `Breadcrumbs.vue` exists, just needs to be wired up)
- Standardize filter field ordering and styling across pages

### Technical Context

- Vue filter components already exist: `ProgramFilter.vue`, `InquiryFilter.vue`, `AccountFilter.vue`, `OrganizationFilter.vue`
- `FilterFieldset.vue` (collapsible) and `FilterMixin.ts` are the established patterns
- `ProgramFilter.vue` already uses `FilterFieldset` — consistency check needed across other pages
- Breadcrumb component exists with `{title, url}` trail structure

### Estimate: 6-10 hours

| Component | Low | High |
|---|---|---|
| Filter audit and standardization (apply FilterFieldset consistently) | 2h | 4h |
| Breadcrumb additions (wire up existing component) | 2h | 3h |
| QA/testing across all affected pages | 2h | 3h |

---

## Item #6 — Navigation & Hyperlink Improvements

### Problem

Entity names throughout the system are rendered as plain text instead of clickable links. The "Affiliate Region" column in Browse Programs isn't clickable. Program names in Affiliate Service Areas aren't hyperlinked. Users need extra clicks to navigate to related records. The NQMS side already has good hyperlink navigation — the MC side should match.

### Solution

Make all entity names (programs, affiliates, assessments) clickable links to their respective pages. This follows the navigation pattern already established on the NQMS side.

Key areas:
- Affiliate Region names in Browse Programs -> link to affiliate view
- Program names in Browse Programs -> link to program view
- Program names in Affiliate Service Areas -> link to program view
- Audit other tables (assessments, goals, inquiries) for missing hyperlinks

### Technical Context

- Browse Programs (`Programs/index.php`): Affiliate Region rendered as plain text `h($affiliateRegion)` (lines 229-247), Program Name as plain text `h($program->title)` (lines 218-220)
- Fix pattern: replace `h($text)` with `$this->Html->link()` — mechanical template changes
- Vue-side uses `router-link` for the same pattern

### Estimate: 4-6 hours

| Component | Low | High |
|---|---|---|
| Hyperlink additions across templates | 2h | 3h |
| Audit and catch remaining missing links | 1h | 2h |
| QA/testing | 1h | 1h |

---

## Item #7 (partial) — Program Status Badges

### Problem

Program statuses (Approved, Paused, Pending, Archived) are displayed as plain text in both the Browse Programs list and Program Detail page. It's difficult to quickly identify a program's status at a glance. There's no visual hierarchy or color coding to distinguish between states.

### Solution

Add color-coded badges/tiling to program statuses, following the visual pattern already used for NQMS assessment statuses. Statuses should be immediately recognizable:

- **Approved** — green badge
- **Paused** — yellow badge
- **Pending** — orange badge
- **Archived** — grey badge (renamed from "Deleted" per Meeting 2 decision)

Apply consistently across Browse Programs list, Program Detail header, search results, and affiliate program lists.

**Prototype Reference:** https://growth-buddy-platform.lovable.app/programs/browse — shows status badges with color coding in the programs table, including "Archived" with reason notes.

### Technical Context

- Program list template (`Programs/index.php`): status currently plain text in table column
- Program detail view (`Programs/view.php`): status displayed as plain text
- NQMS assessment statuses already use badge/tiling pattern — CSS model exists
- Implementation: CSS-only changes plus minor template updates to wrap status text in badge markup

### Estimate: 4-6 hours

| Component | Low | High |
|---|---|---|
| Badge CSS + template changes (list and detail views) | 2h | 3h |
| Audit and apply to other pages where status appears | 1h | 2h |
| QA/testing | 1h | 1h |

---

## Group Total

| Item | Hours (Low) | Hours (High) |
|------|-------------|--------------|
| #4 — UI/UX Consistency | 6 | 10 |
| #6 — Hyperlinks | 4 | 6 |
| #7 — Status Badges (visual only) | 4 | 6 |
| **Group Total** | **14** | **22** |

---

## Implementation Order

1. **#7 — Status Badges** (CSS-only, quickest win, most visible impact)
2. **#6 — Hyperlinks** (template-only, mechanical changes)
3. **#4 — UI/UX Consistency** (broader audit, benefits from seeing #6/#7 changes first)

---

## Risks

- **Low risk.** All items are template/view changes with no database or business logic impact.
- Minor risk: #4 filter standardization may uncover inconsistencies that require more work than expected, but the component architecture (`FilterFieldset`) already exists.
