# Item #20 (Related): "Deleted" Program Status — Codebase Analysis

**Related Enhancement:** Affiliate Deletion & Inactivation Management / Program Lifecycle
**Analysis Date:** May 2026
**Source:** Mentor Connect codebase (`mentor-connect`)

---

## Summary

The "Deleted" program status is a **soft delete** — it changes the status field to `'deleted'` but does not remove any data. The behavior is functional but undocumented: deleted programs are correctly hidden from public search, affiliate matching, and NQMS reports, but remain visible in the admin interface with no visual distinction from other statuses. Programs can be restored by simply changing the status back.

---

## How Program Statuses Are Defined

**File:** `plugins/Programs/src/Model/Table/ProgramsTable.php` (Lines 51-58)

```php
private array $programStatuses = [
    'approved' => 'Approved',
    'paused' => 'Paused',
    'pending' => 'Pending',
    'deleted' => 'Deleted',
];
```

**Database column:** MySQL ENUM — originally created with `approved`, `paused`, `pending` in migration `20220728173229_CreatePrograms.php`. The `deleted` value was added in migration `20220811171729_ChangeProgramsLogoColumn.php`.

**`getStatuses()` method** (Lines 868-875) accepts `$includeDeleted = true` parameter. When `false`, hides "Deleted" from the Add Program form dropdown.

---

## What Happens When a Program Is "Deleted"

**File:** `plugins/Programs/src/Controller/Admin/ProgramsController.php` (Lines 67-95)

```php
public function delete(string $id): ?Response
{
    $this->canAccessProgram((int)$id);
    $this->getRequest()->allowMethod(['post', 'delete']);

    $program = $this->Programs->get($id);
    $this->Programs->patchEntity(
        $program,
        ['status' => 'deleted']  // Status change only — NOT actual deletion
    );
    if ($this->Programs->save($program)) {
        $this->Flash->success(__('The program has been deleted.'));
    }

    return $this->redirect(...);
}
```

**Effects:**
- Program record remains in the database with `status = 'deleted'`
- No cascade deletions or dependent record removals
- No special hooks, listeners, or afterSave logic triggered
- All associated records (assessments, locations, badges) remain intact

---

## Where "Deleted" Programs ARE Hidden

### Public-Facing Search
**File:** `plugins/Searches/src/Controller/Api/SearchesController.php` (Line 454)
```php
$query = $programsTable->find()
    ->andWhere(['Programs.status' => 'approved'])  // Only approved programs
```

### Affiliate Program Matching
**File:** `plugins/Affiliates/src/Controller/Api/AffiliatesController.php` (Line 148)
```php
$programs = $this->fetchTable('Programs.Programs')
    ->find()
    ->where([
        'id IN' => $programIds,
        'status' => 'approved',  // Only approved
    ])
```

### NQMS Assessments & Reports
All report filter forms enforce `Programs.status = 'approved'`:
- `plugins/Reports/src/Form/Admin/NqmsAssessmentsFilterForm.php` (Line 123)
- `plugins/Reports/src/Form/Admin/AssessmentDetailsFilterForm.php` (Line 133)
- `plugins/Reports/src/Form/Admin/GoalsFilterForm.php` (Line 93)
- `plugins/Reports/src/Form/Admin/NqmsReportFilterForm.php` (Line 146)
- `plugins/Reports/src/Form/Admin/NqmsAggregateFilterForm.php` (Lines 93, 263)

### Program API
**File:** `plugins/Programs/src/Controller/Api/ProgramsController.php` (Lines 254-268)
- `me()` endpoint filters for `'status' => 'approved'` only

---

## Where "Deleted" Programs ARE Visible

### Admin Browse Programs
**File:** `plugins/Programs/src/Controller/Admin/ProgramsController.php` (Lines 254-363)
- Deleted programs appear in the admin list
- Status filter dropdown can select "Deleted" to show only deleted programs
- No automatic filtering to hide them

### Exports
- Exports include whatever programs match the admin's current filters
- If "Deleted" status is in the filter, deleted programs will appear in CSV export

### No Visual Distinction in UI
**File:** `plugins/Programs/templates/Admin/Programs/index.php` (Line 227)
```php
<?= h($program->status); ?>
```
- Plain text display — no color, badge, icon, or styling
- "Deleted" looks identical to "Approved", "Paused", or "Pending"

**File:** `plugins/Programs/templates/element/Admin/program-header.php` (Lines 202-206)
- Program detail header also shows status as plain text with no distinction

---

## Restoration

- No dedicated "restore" action exists
- Any admin with edit permissions can change status from "Deleted" back to Approved, Paused, or Pending
- All associated data is preserved, so restoration is seamless
- No audit trail tracks the deletion or restoration

---

## Hard Delete

**No hard delete functionality exists for programs.** There is no destroy action, no DELETE SQL query, and no way to permanently remove a program record from the database.

Note: Program assessments have a separate `deleted` datetime column (migration `20251124150000_ProgramAssessmentsAddDeletedColumn.php`) — this is independent of the program status.

---

## Behavior Summary

| Context | Deleted Programs Shown? | How Filtered |
|---------|------------------------|--------------|
| Public program search | No | `status = 'approved'` |
| Affiliate program matching | No | `status = 'approved'` |
| NQMS assessments & reports | No | `status = 'approved'` |
| Program API (`me()`) | No | `status = 'approved'` |
| Admin Browse Programs | Yes | No auto-filter; can filter by status |
| Admin exports | Yes (if in filtered results) | Depends on applied filters |
| Admin program detail/edit | Yes | Directly accessible |

---

## Gaps & Considerations

1. **No visual distinction** — Deleted programs look the same as active ones in admin views. Should have a badge or color indicator (e.g., red badge, strikethrough, or row styling).
2. **No confirmation dialog** — The delete action does not warn admins about consequences or confirm the action.
3. **No audit trail** — No record of who deleted a program or when, and no record of restoration.
4. **Ambiguity with "Deleted" label** — The flash message says "The program has been deleted" which implies permanent removal, but it's actually a soft delete. Could cause confusion.
5. **Relationship to Item #28 (Program Archive & Lifecycle Management)** — The Deleted status overlaps with archival concepts. May need to clarify the distinction between "deleted" (should not exist) vs. "archived" (historical, preserved intentionally).
