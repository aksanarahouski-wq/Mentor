# Group 4: Affiliate Management
**Items:** #19, #20, #21
**Estimated Effort:** 128-176 hours

---

## Scope Summary

These three items are tightly coupled — #21 (National Affiliate) must exist before #20 (affiliate inactivation unlinking) works, and #19 (UX improvements) touches the same plugin and templates. Building them as a unit avoids rework and ensures the affiliate lifecycle is coherent end-to-end.

**Note:** Item #21 has a detailed standalone estimate at `estimates/Item21_NationalAffiliate_WorkEstimate.md` (96-120 hours). That estimate remains the authoritative reference for #21. This document layers #19 and #20 on top and identifies bundling savings.

---

## Item #21 — National Affiliate for Orphan Programs

**What:** Create a "safety net" affiliate that automatically captures programs not matching any other affiliate's service area. One and only one affiliate can be designated as national. No service areas — acts as catch-all.

**Detailed Estimate:** See `estimates/Item21_NationalAffiliate_WorkEstimate.md`

**Summary from existing estimate:**

| Feature | Hours |
|---------|-------|
| Core Configuration (DB, logic, migration) | 16-24 |
| Affiliate Management UI Support | 16-24 |
| Program Display and Assignment | 8-16 |
| Search and Filtering | 16-24 |
| NQMS Assessments and Reporting | 12-16 |
| User Access Control and Permissions | 16-24 |
| Testing and QA | 16-24 |
| **Total** | **96-120** |
| Recommended Buffer | 24 |
| **Total with Buffer** | **120-144** |

**Key Technical Details (from codebase exploration):**
- Affiliates plugin: `plugins/Affiliates/` with controllers, models, templates
- Affiliate status: `active` boolean field (not enum)
- Program-to-affiliate matching: ZIP-code-based via `PostalCodesServiceAreas` join — programs matched through `ProgramLocations.zip_code`
- Service areas managed in separate `ServiceAreas` plugin
- Vue frontend: `ServiceAreas.vue` component at `mentor-connect-app/src/modules/regions/service-areas/`

---

## Item #20 — Affiliate Inactivation (Unlink Programs)

**What:** When an affiliate is marked inactive, unlink all programs from that affiliate (programs move to national affiliate). Preserve service areas for potential reactivation. Show warning with program count.

**Technical Context:**
- Affiliate edit form (`plugins/Affiliates/templates/Admin/Affiliates/edit.php`): `active` checkbox at lines 46-54
- Programs are NOT linked to affiliates via FK — they're matched via ZIP code. "Unlinking" means the matching logic must exclude inactive affiliates
- `AffiliatesTable::getList()` method (lines 344-377) already filters inactive affiliates when `$activeOnly = true`
- Current behavior: inactive affiliate keeps service areas, programs still match because ZIP codes still exist

**Work:**

### Backend (CakePHP)
- Modify affiliate inactivation logic in `AffiliatesController::edit()`:
  - When `active` changes from true to false: trigger program reassignment
  - Count affected programs (programs whose locations match this affiliate's service areas and no other active affiliate)
  - Move orphaned programs to the national affiliate (depends on #21 being in place)
  - Preserve service area ZIP codes on the inactive affiliate (for reactivation)
- Modify affiliate reactivation logic:
  - When `active` changes from false to true: re-run matching for programs in the affiliate's service areas
  - Programs that now match should be moved back from national affiliate
- Add warning/confirmation endpoint: return count of affected programs before deactivation

### Frontend (CakePHP templates / Vue)
- Add confirmation dialog when deactivating an affiliate: "This will unlink X programs from this affiliate. They will be assigned to the National Affiliate."
- Require explicit confirmation before proceeding
- Show reactivation impact message when reactivating

### QA/Testing
- Test deactivation with various program counts (0, few, many)
- Test that programs correctly move to national affiliate
- Test reactivation restores program matching
- Test that service areas are preserved
- Test edge case: program matches multiple affiliates, one goes inactive
- Verify no impact on programs matched to other active affiliates

**Estimate:** 20-28 hours
- Backend inactivation/reactivation logic: 8-12 hours
- Frontend confirmation dialogs: 4-6 hours
- QA/testing: 8-10 hours

**Dependency:** #21 must be implemented first — programs need somewhere to go when unlinked.

---

## Item #19 — Affiliate Management UX Improvements

**What:** Multiple sub-items: ZIP code management UX rework, remove unused fields, add program filters.

**Technical Context:**
- Affiliate edit form (`plugins/Affiliates/templates/Admin/Affiliates/edit.php`):
  - "Global Administrator" field: lines 191-224, autocomplete input with `global_admin_user_id`
  - "Programmatic Contact" field: lines 66-91, autocomplete input with `programmatic_contact_id`
  - "Trained" checkbox: lines 55-60, boolean `trained` field
- Service area management: Vue component `ServiceAreas.vue` at `mentor-connect-app/src/modules/regions/service-areas/`
- Program filters: see Group 3 (#9) — filter enhancements overlap here

**Work:**

### 19a: ZIP Code / Service Area Management UX Rework
- Redesign the service area management interface:
  - Select state → optionally drill into county → see ZIP codes listed → select/deselect with checkboxes
  - Bulk select all ZIPs in a county or state
  - Support multiple counties and cross-state affiliates
- Replace current interface (which is essentially "start over every time")
- Backend: may need new API endpoints for state → county → ZIP code drill-down
- Frontend: significant rework of `ServiceAreas.vue` component

**Estimate:** 20-28 hours
- Backend API for state/county/ZIP drill-down: 6-8 hours
- Frontend Vue component rework: 10-14 hours
- QA/testing: 4-6 hours

### 19b: Remove "Global Administrator" Field
- Remove from edit form template (lines 191-224)
- Remove from entity/table if no longer used
- Migration to drop column (or keep but hide — depends on whether any data is valuable)

**Estimate:** 2-3 hours

### 19c: Replace "Programmatic Contact" with Primary Contact Toggle
- Remove autocomplete field (lines 66-91)
- Add radio button / toggle on the affiliate admin list to mark one admin as primary contact
- Update affiliate model to support primary contact flag on `AffiliatesUsers` join table

**Estimate:** 4-6 hours

### 19d: Remove "Trained" Checkbox
- Remove from edit form template (lines 55-60)
- Migration to drop column (only 9 affiliates have it checked — data is meaningless)

**Estimate:** 1-2 hours

### 19e: Add Program Characteristic Filters + ZIP Code Search to Internal Program Search
- **Note:** This overlaps significantly with Item #9 (Group 3). If #9 is built first, this work is already done. If built here, it covers the same scope.
- If built with Group 3: 0 additional hours (already covered)
- If built standalone: 20-28 hours

**Estimate:** 0 hours (covered under #9 in Group 3)

### Item #19 Subtotal: 27-39 hours

---

## Group Total

| Item | Hours (Low) | Hours (High) |
|------|-------------|--------------|
| #21 — National Affiliate | 96 | 120 |
| #20 — Affiliate Inactivation | 20 | 28 |
| #19 — Affiliate UX Improvements | 27 | 39 |
| **Group Total** | **143** | **187** |

**Bundling Savings:** ~15-20 hours saved. A developer implementing #21 is already deep in the affiliate plugin and can address #19's field removals and #20's inactivation logic in the same pass. Service area UX rework (#19a) naturally follows the national affiliate work since it touches the same Vue components. Shared QA testing reduces overhead.

**Adjusted Group Estimate: 128-167 hours**

---

## Implementation Order

1. **#21 — National Affiliate** (must be first — #20 depends on it)
2. **#19b, #19c, #19d — Field removals** (quick wins while in affiliate templates)
3. **#20 — Inactivation unlinking** (now that national affiliate exists)
4. **#19a — Service area UX rework** (can be done in parallel with #20)

---

## Risks

- **Medium-High risk** (driven primarily by #21 complexity).
- #21: Migration of 750+ orphan programs is the highest-risk operation — needs staging testing and rollback plan
- #21: Query logic divergence (orphan vs ZIP matching) must be carefully separated
- #20: Edge cases when a program matches multiple affiliates and one goes inactive
- #19a: Service area UX rework scope could grow if additional requirements surface during implementation (county data sourcing, cross-state edge cases)
- #19e overlap with #9: Must coordinate to avoid duplicate work
