# Group 2: Program Status & Archive Lifecycle
**Items:** #1, #7 (includes #28)
**Estimated Effort:** 14-22 hours
**Confidence Level:** HIGH
**Last Updated:** July 2026

---

## Scope Summary

Both items implement the same "archive with reason" pattern -- one for programs, one for user accounts. Building them together means the archive UX pattern, confirmation dialogs, and filtering logic are designed once and applied twice.

---

## Item #7 -- Program Status & Archive (includes #28)

### Problem

Programs currently have a "Deleted" status, but there's no structured archival workflow. Admins can't see *why* a program was archived -- Sandy: "There should be a note somewhere why... a lot of times I'm not even sure why it is in deleted status." The only way to change a program to "Deleted" is a status dropdown flip with no confirmation and no audit trail. There's also no way to restore a deleted program back to active.

### Solution

Replace the "Deleted" status concept with a proper archival workflow:

- **Rename "Deleted" to "Archived"** throughout the system (database value, UI labels, filters)
- **Archive button** on both Browse Programs (index) and Program View (detail) pages
- **Confirmation dialog** with a required "Reason for archiving" text field -- prompts the user to explain why before proceeding
- **Archive reason displayed** on the Program Detail page when viewing an archived program
- **Restore capability** -- archived programs can be returned to active status
- Archived programs remain **searchable and filterable by admins**, excluded from public search (already the case)

**Prototype Reference:** https://growth-buddy-platform.lovable.app/programs/browse -- shows Archive button per row in the Actions column and inline archive reasons (e.g., "Reason: Duplicate of Test Program 2 -- consolidated records").

### Technical Context

- Program statuses in `ProgramsTable.php` (lines 53-65): `approved`, `paused`, `pending`, `deleted` -- rename `deleted` to `archived`
- `getStatuses(bool $includeDeleted = true)` controls status visibility
- Public search already filters by `Programs.status = 'approved'` -- archived programs are already excluded
- No `archive_reason` or `archived_at` fields exist today -- need migration

### Estimate: 8-12 hours

| Component | Low | High |
|---|---|---|
| DB migration (archive_reason, archived_at) + rename deleted to archived across codebase | 1.5h | 2h |
| Archive/restore controller actions | 1h | 1.5h |
| Archive button on index + view pages | 0.5h | 0.5h |
| Confirmation modal with reason field | 1.5h | 2h |
| Display archive reason + date on detail page | 0.5h | 0.5h |
| Data migration for existing "deleted" records | 0.5h | 0.5h |
| Cleanup stale "deleted" references | 0.5h | 1h |
| QA/testing | 2h | 3h |

---

## Item #1 -- User Account Management (Archive + Table Enhancements)

### Problem

There's no way to remove old user accounts from the system. Global admins need to clean up legacy records but have no archive or delete capability. The accounts table also lacks key information -- it doesn't show which program a user belongs to (Tim: "many orphan accounts with no program attachment") and has no status column or status filter. Once archiving is available, admins will need to filter by status to manage the cleanup.

### Solution

Add account archival and improve the accounts table:

- **Archive capability** (soft delete) -- global admins can archive any user; affiliate/program admins can archive only users under their affiliate
- **Archived users cannot log in** -- archive sets `is_active = false`
- **Restore capability** -- archived users can be returned to the system
- **Add "Program" column** to accounts table (shows which program(s) a user belongs to)
- **Add "Status" column** to accounts table (Active / Archived)
- **Add status filter** to accounts table filter form
- Keep email visible for cleanup of legacy records with no first/last name

Out of scope: export, activity tracking (who changed what) -- deferred per Meeting 2.

### Technical Context

- User entity has `is_active` boolean but no status/archived field
- Programs linked via `ProgramsUsers` join table -- not a direct FK, so the Program column requires a join query
- Current accounts table columns: first_name, last_name, email, last_login
- Current filter fields: first_name, last_name, email, postal_code -- no status filter

### Estimate: 8-12 hours

| Component | Low | High |
|---|---|---|
| DB migration (is_archived, archived_at, archived_by fields) | 0.5h | 1h |
| Archive/restore actions + permission checks (reuses pattern from #7) | 2h | 3h |
| Add Status + Program columns to accounts table + status filter | 2h | 3h |
| Archive confirmation UI (reuse dialog pattern from #7) | 1h | 1h |
| QA/testing (3 admin types x archive/restore + filter/column verification) | 2h | 3h |

---

## Group Total

| Item | Hours (Low) | Hours (High) |
|------|-------------|--------------|
| #7 -- Program Status & Archive (+#28) | 8 | 12 |
| #1 -- User Account Archive | 8 | 12 |
| Bundling savings (shared modal pattern, shared QA) | -2 | -2 |
| **Group Total** | **14** | **22** |

---

## Implementation Order

1. **#7 -- Program Archive** (establishes the archive pattern: modal, reason field, restore flow)
2. **#1 -- User Account Archive** (reuses the pattern from #7, adds table enhancements)

---

## Risks

- **Medium risk.** Database migrations and status renaming require careful data handling.
- Renaming `deleted` to `archived` across the codebase needs thorough search for all references (controllers, templates, API responses, reports)
- User archive permission boundaries need clear testing -- affiliate admin should not be able to archive users outside their affiliate
- Program column on accounts table may be complex if users belong to multiple programs (display/truncation decisions)
