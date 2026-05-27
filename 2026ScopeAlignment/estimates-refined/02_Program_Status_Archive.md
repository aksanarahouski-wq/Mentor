# Group 2: Program Status & Archive Lifecycle
**Items:** #1, #7 (includes #28)
**Estimated Effort:** 14-22 hours

---

## Scope Summary

Both items implement the same "archive with reason" pattern — one for user accounts, one for programs. Building them together means the archive UX pattern, confirmation dialogs, and filtering logic are designed once and applied twice.

---

## Item #7 — Program Status Visibility + Archive (includes #28)

**What:** Add Archive button to Browse Programs index page and Program View page. Archive button triggers a confirmation dialog with mandatory reason field. Rename "Deleted" → "Archived" throughout the system. Show archive reason on program detail page. Ensure archived programs are filterable by admins and excluded from public search.

**Technical Context:**
- Program statuses defined in `plugins/Programs/src/Model/Table/ProgramsTable.php` (lines 53-65): `approved`, `paused`, `pending`, `deleted`
- `getStatuses(bool $includeDeleted = true)` method controls status visibility — rename `deleted` → `archived` here
- "Deleted" status is just a value in the status enum — no soft-delete mechanism, no automatic filtering. Callers must manually filter.
- Program list template (`plugins/Programs/templates/Admin/Programs/index.php`): status appears in filter dropdown via `$programStatusList`
- Program detail view (`plugins/Programs/templates/Admin/Programs/view.php`): status displayed but no visual badge/tiling
- Public search (`plugins/Searches/src/Controller/Api/SearchesController.php`): already filters by `Programs.status = 'approved'` — archived programs already excluded from public search

**Work:**

### Backend (CakePHP)
- Rename `deleted` → `archived` in `ProgramsTable::getStatuses()` and all references across codebase
- Add `archive_reason` text field and `archived_at` timestamp to programs table (migration)
- Create `archive` action in `ProgramsController` — accepts reason, sets status to `archived`, records timestamp
- Create `restore` action — re-activates an archived program (back to approved or paused)
- Update `getStatuses()` to include/exclude archived based on context
- Grep for any remaining `deleted` status references and update

### Frontend (CakePHP templates / Vue.js)
- **Browse Programs index page:** Add "Archive" button in the actions column per row (next to existing View/Edit). Button triggers confirmation dialog.
- **Program View page:** Add "Archive" button (visible when program is not already archived). Same confirmation dialog.
- **Confirmation dialog:** Modal with "Reason for archiving" text field (required), Proceed button, Cancel button. On Proceed → calls archive action.
- **Program Detail page:** When status = Archived, display the archive reason and archived date in the detail view
- **Status filter:** Ensure "Archived" appears in the status filter dropdown on Browse Programs so admins can filter for archived programs
- **Restore:** Add "Restore" button on archived program detail page
- Update filter dropdown label from "Deleted" to "Archived"

### QA/Testing
- Test archive from index page (confirmation dialog, reason required, status changes)
- Test archive from view page (same flow)
- Test restore from archived detail page
- Test status filter includes Archived option and returns correct results
- Test archive reason is displayed on detail page
- Verify public search still excludes archived programs (already the case — confirms `status = 'approved'` filter)
- Regression: existing approved/paused/pending flows unaffected

**Estimate:** 8-12 hours
- Database migration + rename `deleted` → `archived` across codebase: 1 hour (Claude Code generates migration and does grep-replace)
- Archive/restore controller actions: 1 hour (simple status change + save reason — straightforward CakePHP action)
- Archive button on index + view pages: 0.5 hour (one button each in existing action columns)
- Confirmation modal with reason field: 1.5-2 hours (main frontend work — modal pattern likely exists in codebase to follow)
- Display archive reason + date on detail page: 0.5 hour (conditional template block)
- Data migration for existing `deleted` records: 0.5 hour
- QA/testing: 2-3 hours (two entry points, modal, filter, restore, reason display, regression)
- Cleanup of stale `deleted` references: 0.5-1 hour

---

## Item #1 — User Account Management (Archive + Table Enhancements)

**What:** Add archive capability for user accounts (soft delete), add Program and Status columns to accounts table, add status filter.

**Technical Context:**
- User entity (`plugins/Users/src/Model/Entity/User.php`): has `is_active` boolean but NO status/archived field
- Users table (`plugins/Users/src/Model/Table/UsersTable.php`): standard CakePHP ORM table
- User has `UserProfile` with phone, zipcode, notification preferences
- Accounts list page (`plugins/Users/templates/Admin/Users/index.php`): CakePHP template with filter form
- Current filter fields: first_name, last_name, email, postal_code
- Current table columns: first_name, last_name, email, last_login (sortable)
- No "Program" column — programs are linked via `ProgramsUsers` join table, not a direct FK
- No status/archive column currently displayed

**Work:**

### Backend (CakePHP)
- Add `is_archived` boolean field to users table (migration) — keep `is_active` for login control, add `is_archived` for archive state
- Add `archived_at` timestamp and `archived_by` fields (migration)
- Create archive action: set `is_archived = true`, `is_active = false` (prevent login)
- Create restore action: set `is_archived = false` (keep `is_active = false` until explicit reactivation)
- Add permission checks: global admins archive anyone, affiliate/program admins only their users
- Update `UsersTable` queries to exclude archived by default, with option to include
- Add program association lookup for table display (join through `ProgramsUsers`)

### Frontend (CakePHP templates)
- Add "Status" column to accounts table (Active / Archived)
- Add "Program" column to accounts table (program name via ProgramsUsers join — may show multiple)
- Add status filter to filter form (Active / Archived / All)
- Add archive action button with confirmation
- Add restore action for archived users
- Keep email visible for legacy cleanup

### QA/Testing
- Test archive by global admin, affiliate admin, program admin (permission boundaries)
- Test archived user cannot log in
- Test restore flow
- Test filter by status
- Verify Program column displays correctly (including users with 0 or multiple programs)

**Estimate:** 8-12 hours
- Database migration (`is_archived`, `archived_at`, `archived_by` fields): 0.5-1 hour (Claude Code generates migration)
- Archive/restore actions + permission checks: 2-3 hours (reuses exact pattern from #7, permission framework already exists — Claude Code scaffolds actions)
- Add Status + Program columns to accounts table + status filter: 2-3 hours (CakePHP `contain()` handles ProgramsUsers join, main complexity is multi-program display)
- Archive confirmation UI (reuse dialog pattern from #7): 1 hour (copy modal pattern, change field names)
- QA/testing: 2-3 hours (3 admin types × archive/restore + filter/column verification — pattern already validated in #7)

---

## Group Total

| Item | Hours (Low) | Hours (High) |
|------|-------------|--------------|
| #7 — Program Status & Archive (+#28) | 8 | 12 |
| #1 — User Account Archive | 8 | 12 |
| Bundling savings (shared modal pattern, shared QA) | -2 | -2 |
| **Group Total** | **14** | **22** |

---

## Risks

- **Medium risk.** Database migrations and status renaming require careful data handling.
- Renaming `deleted` → `archived` across the codebase needs thorough search for all references (controllers, templates, API responses, reports)
- User archive permission boundaries need clear testing — affiliate admin should not be able to archive users outside their affiliate
- Program column on accounts table may be complex if users belong to multiple programs (display/truncation decisions)
