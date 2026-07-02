# Group 3: Search & Filters
**Items:** #9, #27
**Estimated Effort:** 30-46 hours
**Confidence Level:** HIGH
**Last Updated:** July 2026

---

## Scope Summary

These items improve how programs are found via admin and public search. #9 enhances admin-side Browse Programs filtering and #27 loosens the public search algorithm. Grouping them together lets a developer work across the shared search infrastructure.

---

## Item #9 — Admin Program Search & Discovery

### Problem

The Browse Programs page has significantly fewer filtering options than the NQMS Assessment search page. Admins cannot filter programs by delivery type (Community-Based, Site-Based, E-Mentoring), mentoring types, grades served, mentee categories, youth served count, or ZIP code proximity. E-mentoring-only programs get "lost" because there's no way to surface them. Global admins have no visibility into programs by delivery type or program characteristics.

The NQMS Assessment search page already supports these filters — the Browse Programs page just hasn't been updated to match.

### Solution

Add the missing filter fields to Browse Programs, reusing the patterns already established in the NQMS Assessment search and public search. Specifically:

- **Delivery Type filter** — checkboxes for Community-Based, Site-Based, E-Mentoring (pattern exists in public search)
- **Mentoring Types filter** — multi-select dropdown (pattern exists in NQMS Assessment search)
- **Grades filter** — multi-select dropdown (pattern exists in NQMS Assessment search)
- **Mentee Categories filter** — multi-select dropdown (pattern exists in NQMS Assessment search)
- **Youth Served range** — from/to numeric fields (pattern exists in NQMS Assessment search)
- **ZIP Code proximity search** — input + distance dropdown (pattern exists in public search Haversine logic)

All filter patterns, validation rules, and query builders already exist in the codebase — this is replication work, not invention.

**Prototype Reference:** https://growth-buddy-platform.lovable.app/programs/browse — shows the current Browse Programs layout with a "National Affiliate" quick-filter addition.

### Technical Context

- Current admin filters (`ProgramsFilterForm.php`): status, program name, contact, organization, affiliate, state
- Missing vs. NQMS Assessment search (`NqmsAssessmentsFilterForm.php`): delivery type, youth served range, mentoring types, grades, mentee categories
- Missing vs. public search (`SearchesController.php`): ZIP code proximity (Haversine), delivery method
- Vue frontend `ProgramFilter.vue` already uses expandable `FilterFieldset` sections — adding new sections follows the existing component pattern
- Many-to-many filters use `$query->matching()` pattern — established in both NQMS filter (lines 191-210) and public search (lines 560-614)

### Estimate: 28-40 hours

| Component | Low | High |
|---|---|---|
| Backend filter logic (replicating patterns from NQMS/public search) | 10h | 14h |
| Frontend filter UI (new FilterFieldset sections in ProgramFilter.vue) | 10h | 14h |
| QA/testing (individual filters, combinations, performance) | 8h | 12h |

---

## Item #27 — Search Algorithm: Loosen Criteria

### Problem

Approved programs can be completely invisible in public search results because the search algorithm requires programs to have the "Accepting Mentors" or "Accepting Mentees" checkbox checked. When a prospective mentor searches, only programs with `accepting_mentors = 1` appear. If neither checkbox is checked, the program never appears in any search — even though it's approved and active.

This has been confirmed in production: programs like AALEAD were missing from search results because of this gap.

Mike's position: "If a program exists and isn't archived, it should show up in search. There should be an icon that says 'We're accepting volunteers,' and if you don't see that icon, they're not accepting volunteers, and there's no inquiry button."

### Solution

Remove the role-based filter from the search query. All approved programs matching location + delivery method appear in results regardless of whether they're accepting mentors/mentees. The user's role selection (from the 3-Step form) is still collected and passed to the results page, but it only controls inquiry button visibility — not search results.

On the results page:
- If a program accepts the user's selected role, show the inquiry button
- If not, show a "Not currently accepting [mentors/mentees]" indicator with no inquiry option

### Technical Context

- The acceptance filter is a single WHERE clause block in `SearchesController::list()` (lines 475-489) — removing it is the core backend change
- The `accepting_mentors`/`accepting_mentees` flags need to be added to the search result JSON response (currently not included) so the frontend can conditionally render the inquiry button
- The 3-Step form is unchanged — role selection stays, value still submitted as query parameter
- Delivery method and location filters remain as-is

### Estimate: 8-14 hours

| Component | Low | High |
|---|---|---|
| Backend: remove acceptance filter + add flags to JSON response | 1h | 2h |
| Frontend: conditional inquiry button + "not accepting" indicator on results page | 4h | 6h |
| QA/testing (role combinations, acceptance states, regression) | 3h | 6h |

---

## Group Total

| Item | Hours (Low) | Hours (High) |
|------|-------------|--------------|
| #9 — Admin Search Filters | 28 | 40 |
| #27 — Search Algorithm | 8 | 14 |
| Bundling savings (shared search infrastructure, shared QA) | -6 | -8 |
| **Group Total** | **30** | **46** |

---

## Implementation Order

1. **#27 — Search Algorithm** (smaller, higher priority, independent)
2. **#9 — Admin Search Filters** (larger, benefits from #27 context)

---

## Risks

- **Low-Medium risk overall.** Both items leverage existing patterns in the codebase.
- #9: Many-to-many filter combinations can have performance implications on large datasets — may need query optimization or indexing
- #27: Changing the public search algorithm affects all external-facing search results — needs careful rollout and monitoring. However, the backend change is minimal (removing a WHERE clause), so risk is contained
- #27: Need to confirm the `accepting_mentors`/`accepting_mentees` boolean values are reliably populated across all programs before changing how they're used in the UI
