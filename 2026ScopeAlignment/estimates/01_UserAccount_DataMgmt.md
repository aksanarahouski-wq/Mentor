# Estimates: User Account & Data Management
**Category:** User Account & Data Mgmt
**Items:** #1, #2, #3
**Status:** All Reviewed (Meeting 2, April 9, 2026)
**Last Updated:** April 2026

---

## #1 — User Account Management

**Priority:** High | **Impact:** Low | **Status:** Reviewed

### Refined Scope (Post-Meeting 2)
1. **Archive capability (soft delete) for user accounts**
   - Global admins can archive any user
   - Program/affiliate admins can archive users under their affiliate only
2. **Add Program column to accounts table**
3. **Add Status column to accounts table**
4. **Add Status filter to accounts table**

> **Out of scope (deferred):** Export, user activity tracking (who changed what)

### Preliminary Scope Breakdown

#### 1a. User Archive (Soft Delete)
**What exists today:**
- `is_active` boolean field already exists on the `users` table (migration `20220725132953_CreateUsers.php`)
- `disable()` and `enable()` methods already exist in `UsersController.php` — set `is_active = 0/1`
- No UI button currently exposed for archive/disable

**Work required:**
- Add "Archive" button to user edit/view page (permission-gated)
- Add permission check: global admin → archive any user; affiliate/program admin → archive only users under their affiliate (requires checking `AffiliatesUsers` join table)
- Add confirmation dialog ("Are you sure you want to archive this user?")
- Ensure archived users cannot log in (verify `is_active` check in authentication)
- Add "Restore" button for global admins to reactivate archived users

**Estimate:** ~16-20 hours

#### 1b. Add Program Column to Accounts Table
**What exists today:**
- Accounts table (`plugins/Users/templates/Admin/Users/index.php`) shows: First Name, Last Name, Email, Last Login
- Users are linked to programs via `ProgramsUsers` join table (belongsToMany)
- Controller already loads user data but does not join program names

**Work required:**
- Modify `UsersController::index()` to contain/join program associations
- Add "Program(s)" column to the accounts table template
- Handle users with multiple programs (comma-separated or list display)
- Handle orphan accounts with no program (display "—" or "None")
- Consider performance: may need a subquery or counter cache if the user list is large

**Estimate:** ~8-12 hours

#### 1c. Add Status Column to Accounts Table
**What exists today:**
- `is_active` field exists but is not displayed as a column in the accounts table

**Work required:**
- Add "Status" column to accounts table template displaying Active/Archived based on `is_active`
- Style with badge/label (green = Active, gray = Archived)

**Estimate:** ~2-3 hours

#### 1d. Add Status Filter to Accounts Table
**What exists today:**
- Filter form: `UsersFilterForm.php` has First Name, Last Name, Email, Postal/Zip Code filters
- Filter infrastructure: extends `Orases\Helpers\Form\FilterForm` with session persistence

**Work required:**
- Add Status dropdown to `UsersFilterForm.php` (options: All, Active, Archived)
- Add filter logic in `filterQuery()` to filter by `is_active`
- Default filter to "Active" so archived users are hidden by default

**Estimate:** ~4-6 hours

### Item #1 Total Estimate

| Sub-Item | Hours (Low) | Hours (High) |
|----------|-------------|--------------|
| 1a. Archive (soft delete) | 16 | 20 |
| 1b. Program column | 8 | 12 |
| 1c. Status column | 2 | 3 |
| 1d. Status filter | 4 | 6 |
| **QA & Testing** | **6** | **8** |
| **Total** | **36** | **49** |

---

## #2 — Export Capabilities

**Priority:** High | **Impact:** Medium | **Status:** Reviewed

### Refined Scope (Post-Meeting 2)
1. **Rework program export template** — trim from 179 address placeholder columns, add missing program options data
2. **Align closer to CRM import format** (pending Sandy's desired fields list)

> **Out of scope (deferred):** Accounts export, affiliates export, NQMS export (ad-hoc SQL), centralized export page (#29)
> **Dependency:** Sandy to send desired program export template fields to Orases

### Preliminary Scope Breakdown

#### 2a. Rework Program Export Template
**What exists today:**
- Program export in `ProgramsController::index()` triggered by `?export=csv`
- Current export includes: Title, Organization, Status, Contact info, Address fields, Affiliate/Service Area regions, Modified timestamp
- Uses `Export::export()` utility (`/src/Export/Export.php`) supporting CSV and XLSX
- Export element: `templates/element/Export/export.php`
- Current template has 179 address placeholder columns (confirmed from client feedback)

**Work required:**
- Receive Sandy's desired field list (external dependency)
- Restructure export query to include requested program options data (delivery type, age ranges, program characteristics, etc.)
- Remove excess address placeholder columns
- Add missing program options fields to export
- Align column headers with CRM import format where possible
- Test export with various data sets (programs with/without locations, multiple locations, etc.)

**Estimate:** ~16-24 hours (dependent on final field list complexity)

### Item #2 Total Estimate

| Sub-Item | Hours (Low) | Hours (High) |
|----------|-------------|--------------|
| 2a. Rework program export template | 16 | 24 |
| **QA & Testing** | **4** | **6** |
| **Total** | **20** | **30** |

> **Note:** Estimate may shift based on Sandy's field list. If the desired fields require joining additional tables or computing derived data, effort could increase.

---

## #3 — Duplicate Detection & Prevention

**Priority:** High | **Impact:** Medium | **Status:** Reviewed (needs further discussion)

### Refined Scope (Post-Meeting 2)
- Complex item — needs further discussion in Meeting 3
- Current duplicate detection only matches exact program names
- Some "duplicates" are intentional workarounds (different program models)
- #11 (multi-assessment) will partially address duplicate workaround problem
- Organization field (#17) is key to solving this properly
- Mike comfortable with annual affiliate-driven cleanup rather than heavy automated dedup

> **Blocked on:** Meeting 3 discussion re: organization field (#17), investigation of "Deleted" program status
> **Dependencies:** #11 (multi-assessment), #17 (organization field)

### Preliminary Scope Breakdown

#### 3a. Enhanced Duplicate Detection (Fuzzy Matching)
**What exists today:**
- No program name uniqueness validation in the database
- Program titles are not unique — `ProgramsTable` has no unique constraint on title
- Service area postal code duplicate detection exists (`ServiceAreasController::checkDuplicates()`) but nothing for programs
- Program search by title exists (`ProgramsController::search()`) for autocomplete but not dedup

**Work required (if pursued):**
- Add fuzzy matching on program creation/edit (Levenshtein distance or similar)
- Match on multiple fields: name, phone, email, organization
- Display warning with similar programs found (not blocking, just informational)
- Consider cross-state matching (affiliate admins can't see cross-state duplicates)
- Add admin tool to review flagged potential duplicates

**Estimate:** ~32-48 hours (if pursued — scope depends on Meeting 3 decisions)

#### 3b. Duplicate Review/Merge Tool
**What exists today:**
- Nothing — no merge capability exists

**Work required (if pursued):**
- Admin interface to view potential duplicate pairs
- Side-by-side comparison view
- Merge workflow (choose primary record, merge data from secondary)
- Handle cascading data: assessments, goals, users, service areas
- Audit trail of merges

**Estimate:** ~60-80 hours (if pursued — significant effort)

### Item #3 Total Estimate

| Sub-Item | Hours (Low) | Hours (High) |
|----------|-------------|--------------|
| 3a. Enhanced duplicate detection | 32 | 48 |
| 3b. Duplicate review/merge tool | 60 | 80 |
| **QA & Testing** | **16** | **24** |
| **Total** | **108** | **152** |

> **IMPORTANT:** This item is NOT ready for estimation — blocked on Meeting 3 decisions. The estimate above is a rough range assuming full scope. Actual scope will likely be significantly smaller if limited to fuzzy name warnings on program creation only (estimated ~20-30 hours in that case).

---

## Category Summary

| Item | Description | Hours (Low) | Hours (High) | Status |
|------|-------------|-------------|--------------|--------|
| #1 | User Account Management | 36 | 49 | Ready to estimate |
| #2 | Export Capabilities | 20 | 30 | Blocked on Sandy's field list |
| #3 | Duplicate Detection & Prevention | 108 | 152 | Blocked on Meeting 3 |
| | **Category Total** | **164** | **231** |  |
| | **Ready to start (#1 only)** | **36** | **49** |  |
