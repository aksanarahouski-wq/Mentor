# Estimates: Data Field Management
**Category:** Data Field Management
**Items:** #17 (reviewed)
**Status:** Reviewed (Meeting 1)
**Last Updated:** April 2026

---

## #17 — Data Field Enhancements (Organization Field)

**Priority:** Medium | **Impact:** Low | **Status:** Reviewed (Meeting 1) — needs deeper discussion in Meeting 2/3

### Refined Scope (Post-Meeting 1)
1. **Design discussion needed** — Sandy flagged for deeper discussion around organizational hierarchy tracking
2. **Organization field was reportedly removed due to misuse** — but needs proper design before reintroduction

> **Dependency:** Sandy to clarify use case and requirements. Discussed further in Meeting 2 context of #3 (Duplicate Detection).

### Codebase Findings

**IMPORTANT DISCOVERY: The organization field was NOT removed from the admin UI.** Contrary to the historical notes suggesting it was removed during the 2023 relaunch:

- **Database:** `organizations` table exists and is actively used (migration `20220728152039_CreateOrganizations.php`)
- **Programs table:** Has a **required** (NOT NULL) foreign key `organization_id` → `organizations.id`
- **Admin form:** Organization dropdown IS present in program edit form (`plugins/Programs/templates/Admin/Programs/edit.php`, lines 130-136) — renders as a `<select>` with all organizations
- **Program view:** Organization is displayed on program view page (`plugins/Programs/templates/Admin/Programs/view.php`, lines 74-80)
- **Filter:** Organization filter IS implemented in `ProgramsFilterForm.php` (LIKE search on `Organizations.label`)
- **Public API:** Organization field accepted in program submissions (`ProgramsController::add()`)
- **API endpoint:** Public API at `/admin/api/programs/organizations` returns all organizations for selection

### What the Item Actually Needs (Revised Understanding)

Given that the organization field **still exists and is active**, the real need from client feedback is:

1. **Organization as a parent entity** — establish parent-child relationships (organization owns programs) to help differentiate legitimate same-name programs from true duplicates
2. **Organization management UI** — currently no way to manage organizations as a standalone entity (create, edit, merge, delete organizations independent of programs)
3. **Historical context documentation** — document the original misuse issue and how the new design addresses it

### Preliminary Scope Breakdown

#### 17a. Organization Management Admin Page
**What exists today:**
- Organizations exist as a lookup table with `label` field
- No dedicated admin CRUD page for organizations (created implicitly through program forms)
- Organizations model: `plugins/Programs/src/Model/Table/OrganizationsTable.php`
- Organization entity: `plugins/Programs/src/Model/Entity/Organization.php`

**Work required:**
- Create Organization admin index page (list all organizations with program count)
- Create Organization edit page (edit label, view associated programs)
- Add ability to merge duplicate organizations
- Add search/filter on organization list
- Add navigation link in admin menu

**Estimate:** ~24-36 hours

#### 17b. Organization-Program Hierarchy Visibility
**What exists today:**
- One-to-many relationship: Organization hasMany Programs
- Displayed as a dropdown on program edit, but no "organization detail" view showing all its programs

**Work required:**
- Organization detail page showing all programs under that organization
- Clickable from program views and organization list
- Helps identify "same org, different programs" vs true duplicates

**Estimate:** ~12-16 hours

### Item #17 Total Estimate

| Sub-Item | Hours (Low) | Hours (High) |
|----------|-------------|--------------|
| 17a. Organization management page | 24 | 36 |
| 17b. Hierarchy visibility | 12 | 16 |
| **QA & Testing** | **6** | **8** |
| **Total** | **42** | **60** |

> **IMPORTANT:** This item is still pending deeper discussion (Meeting 2/3). The scope above assumes the full organization management feature. If the decision is simpler (e.g., just improve the existing dropdown or add better validation), the estimate drops significantly:
> - **Minimal scope** (clean up existing field + documentation): ~8-12 hours
> - **Medium scope** (add org management page): ~24-36 hours
> - **Full scope** (management + hierarchy + merge tool): ~42-60 hours

---

## Category Summary

| Item | Description | Hours (Low) | Hours (High) | Notes |
|------|-------------|-------------|--------------|-------|
| #17 | Data Field Enhancements (Organization) | 42 | 60 | Scope depends on Meeting 2/3 decisions |
| | **Category Total** | **42** | **60** | |
