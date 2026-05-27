# Group 3: Search & Filters
**Items:** #9, #14, #27
**Estimated Effort:** 52-76 hours

---

## Scope Summary

These items improve how programs are found and how assessment progress is tracked. #9 and #27 both touch the search pipeline (admin and public respectively), and #14 adds visual indicators to the NQMS assessment UI. Grouping them together lets a developer build the filter infrastructure once and apply it to both admin and public search contexts.

---

## Item #9 — Admin Program Search & Discovery

**What:** Align Browse Programs filtering with the richer filtering already available on the NQMS assessment search page. Add program delivery type, characteristics, age range, and ZIP code search filters.

**Technical Context:**
- Current admin filters (`plugins/Programs/src/Form/Admin/ProgramsFilterForm.php`, lines 101-239):
  - Status, program name, contact name/email, organization, affiliate, state
- NQMS assessment search filters (`plugins/Reports/src/Form/Admin/NqmsAssessmentsFilterForm.php`, lines 78-232):
  - Has: affiliate, state, city, youth served range, mentoring types, grades, mentee categories, assessment date range, assessment status
  - Uses `$query->matching()` pattern for many-to-many (MentoringTypes, Grades, MenteeCategories)
- What Browse Programs is missing vs NQMS:
  - Delivery type filter (community_based, site_based, e_mentoring — boolean fields on Programs)
  - Youth served range filter
  - Mentoring types filter (many-to-many)
  - Mentee categories filter (many-to-many)
  - Grades filter (many-to-many)
  - ZIP code proximity search
- Vue frontend: `ProgramFilter.vue` already has expandable sections via `FilterFieldset`

**Work:**

### Backend (CakePHP)
- Add filter fields to `ProgramsFilterForm.php`:
  - Delivery type: OR condition on `Programs.community_based`, `Programs.site_based`, `Programs.e_mentoring` (boolean fields, pattern exists in SearchesController lines 531-557)
  - Youth served range: from/to on numeric field (pattern exists in NQMS filter lines 173-189)
  - Mentoring types: `$query->matching('MentoringTypes', ...)` (pattern exists in NQMS filter lines 191-196)
  - Grades: `$query->matching('Grades', ...)` (pattern exists, lines 198-203)
  - Mentee categories: `$query->matching('MenteeCategories', ...)` (pattern exists, lines 205-210)
  - ZIP code search: use existing Haversine logic from `SearchesController::getHaversineExpr()` (lines 748-771)
- Add validation rules for new filter fields
- Ensure new filters combine correctly with existing filters (AND logic)

### Frontend (Vue.js)
- Update `ProgramFilter.vue` to add new filter sections:
  - Delivery Type section (checkboxes: Community-Based, Site-Based, E-Mentoring)
  - Program Characteristics section (youth served range, mentoring types, grades, mentee categories)
  - ZIP Code search (input field + distance dropdown, similar to public search)
- Load select options from API (mentoring types, grades, categories already have API endpoints)

### QA/Testing
- Test each new filter independently
- Test filter combinations (e.g., delivery type + state + mentoring type)
- Test ZIP code search accuracy
- Verify existing filters still work correctly
- Performance testing with full program dataset

**Estimate:** 28-40 hours
- Backend filter logic: 10-14 hours (patterns exist, replicating from NQMS)
- Frontend filter UI: 10-14 hours
- QA/testing: 8-12 hours

---

## Item #27 — Search Algorithm (Loosen Criteria)

**What:** Remove mentor/mentee checkbox from public search criteria. Programs appear based on status + delivery method + location only. Mentor/mentee checkboxes control inquiry button visibility, not search visibility.

**Technical Context:**
- Public search in `plugins/Searches/src/Controller/Api/SearchesController.php`:
  - Acceptance filter (lines 475-489): currently adds `Programs.accepting_mentees = 1` or `Programs.accepting_mentors = 1` based on search role flags
  - Delivery method filter (lines 531-557): OR conditions on boolean fields
  - Haversine search (lines 507-529): geographic proximity matching
- The `list()` action (lines 406-735) is the main search execution method
- 3-step form (`mentor-connect-3-step-app`): Step 1 asks user to select role (mentor/mentee) — this drives the acceptance filter

**Work:**

### Backend (CakePHP)
- Remove or conditionalize the acceptance filter in `SearchesController::list()` (lines 475-489)
- Programs should appear in results regardless of accepting_mentors/accepting_mentees status
- Keep delivery method and location as required search conditions
- Add `accepting_mentors` and `accepting_mentees` fields to search result response (so frontend can control inquiry button visibility)

### Frontend (Symfony 3-step form + Vue)
- Update 3-step search form: role selection may become optional or repurposed (controls inquiry button, not results)
- Update search results display: show inquiry button only when program is accepting mentors/mentees matching user's role
- Add visual indicator for acceptance status (e.g., "Accepting Volunteers" badge)

### QA/Testing
- Verify programs without acceptance checkboxes now appear in search
- Verify inquiry button visibility is role-dependent
- Verify delivery method and location filters still work
- Test e-mentoring programs with national/limited scope
- Regression: ensure search result quality and relevance aren't degraded

**Estimate:** 16-24 hours
- Backend search logic changes: 6-8 hours
- Frontend (3-step form + results display): 6-10 hours
- QA/testing: 4-6 hours

---

## Item #14 — NQMS Reviewer Progress Tracking

**What:** Add visual indicators (red/yellow/green or icons) on collapsed assessment sections showing completion status on the landing page, without requiring the user to open each section.

**Technical Context:**
- Assessment edit form (`plugins/Programs/templates/Admin/Assessments/edit.php`):
  - Sections rendered as accordion (collapsible) groups
  - Each section contains questions with: rating dropdown, N/A checkbox, checkboxes, notes field
  - Validation currently only triggers on submit
- Assessment controller (`plugins/Programs/src/Controller/Admin/AssessmentsController.php`):
  - `getSectionsFromResponses()` groups questions by section
  - Assessment data loaded with all responses

**Work:**

### Backend (CakePHP)
- Add section completion status calculation logic:
  - For each section: count total required fields vs. completed fields
  - Return completion percentage or status (complete/partial/empty) per section
- Add this to the assessment view/edit data payload

### Frontend (CakePHP templates)
- Add visual indicators next to each section header in the accordion:
  - Green check: all required fields completed
  - Yellow warning: partially completed
  - Red alert: no fields completed or critical fields missing
- Indicators visible when sections are collapsed
- Update on each field change (may require JavaScript/AJAX to recalculate without page reload)

### QA/Testing
- Test indicator accuracy across various completion states
- Test indicators update correctly as user fills in fields
- Verify no impact on existing save/submit functionality
- Test with sections that have N/A responses

**Estimate:** 16-24 hours
- Backend completion calculation: 6-8 hours
- Frontend indicators: 6-10 hours
- QA/testing: 4-6 hours

---

## Group Total

| Item | Hours (Low) | Hours (High) |
|------|-------------|--------------|
| #9 — Admin Search Filters | 28 | 40 |
| #27 — Search Algorithm | 16 | 24 |
| #14 — Reviewer Progress | 16 | 24 |
| **Group Total** | **60** | **88** |

**Bundling Savings:** ~8-12 hours saved. #9 and #27 share the same search infrastructure — a developer working on the filter logic for admin search (#9) is already familiar with the public search algorithm (#27). The delivery type filter pattern is identical in both contexts. QA testing can cover both search contexts in one pass.

**Adjusted Group Estimate: 52-76 hours**

---

## Risks

- **Medium risk** overall.
- #9: Many-to-many filter combinations can have performance implications on large datasets — may need query optimization or indexing
- #27: Changing the public search algorithm affects all external-facing search results — needs careful rollout and monitoring
- #27: 3-step form role selection is Step 1 of the public search — changing its purpose requires careful UX consideration
- #14: Real-time indicator updates may require AJAX calls or client-side calculation logic, adding frontend complexity
