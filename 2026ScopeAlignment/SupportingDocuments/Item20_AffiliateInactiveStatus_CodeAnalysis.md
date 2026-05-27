# Item #20: Affiliate Inactive Status — Codebase Analysis

**Related Enhancement:** Affiliate Deletion & Inactivation Management
**Analysis Date:** May 2026
**Source:** Mentor Connect codebase (`mentor-connect`)

---

## Summary

Marking an affiliate "inactive" currently has **minimal functional effect**. The `active` flag is stored but the program-to-affiliate matching logic does not respect it. Programs continue to be assigned to inactive affiliates as long as Service Area zip codes remain in place. This confirms the user feedback documented in Item #20.

---

## How Affiliate Status Is Stored

**File:** `plugins/Affiliates/src/Model/Entity/Affiliate.php` (Line 13)

- Field: `active` (boolean)
- Default: `true`
- Column defined in migration `20220803193648_CreateAffiliates.php` (Lines 24-27)

```php
$table->addColumn('active', 'boolean', [
    'default' => true,
    'null' => false,
]);
```

**Toggled via:** Admin edit form in `plugins/Affiliates/src/Controller/Admin/AffiliatesController.php` (Lines 136-214)

---

## Where Active Status IS Respected

**`AffiliatesTable::getList()`** — `plugins/Affiliates/src/Model/Table/AffiliatesTable.php` (Lines 344-377)

```php
public function getList(bool $activeOnly = true, array $affiliateIds = []): array {
    $queryAffiliates = $this->find('list')->orderAsc('name');
    if ($activeOnly) {
        $queryAffiliates->andWhere(['active' => 1]);
    }
    // ...
}
```

This method populates the **Affiliate Region filter dropdown** on Browse Programs. The dropdown correctly shows only active affiliates.

**Used at:** `plugins/Programs/src/Controller/Admin/ProgramsController.php` (Line 308)

---

## Where Active Status IS NOT Respected (The Problem)

### 1. Program-to-Affiliate Matching (Service Area Zip Codes)

**File:** `plugins/ServiceAreas/src/Model/Table/PostalCodesServiceAreasTable.php` (Lines 184-237)

```php
public function getAffiliateServiceAreasByPostalCodes(array $postalCodes): array {
    // get Service Areas with Affiliates ID's
    $queryServiceAreaAffiliateIds = $this->find()
        ->select(['ServiceAreas.affiliate_id'])
        ->innerJoinWith('PostalCodes', function ($qPostalCodes) use ($postalCodes) {
            return $qPostalCodes->where(['PostalCodes.code IN' => $postalCodes]);
        })
        ->contain(['ServiceAreas' => ['fields' => ['affiliate_id']]]);

    return \Cake\ORM\TableRegistry::getTableLocator()->get('Affiliates.Affiliates')->find()
        ->select(['id', 'name'])
        ->where(['Affiliates.id IN' => $queryServiceAreaAffiliateIds])
        // ^^^ NO FILTER for Affiliates.active = 1
        ->orderAsc('Affiliates.name')
        ->all()
        ->combine('id', 'name')
        ->toArray();
}
```

**Result:** All affiliates matching zip codes are returned, regardless of active status.

### 2. View Program Affiliates Page

**File:** `plugins/Programs/src/Controller/Admin/AffiliatesController.php` (Lines 115-143)

```php
$affiliates = $this->Affiliates->find()
    ->where(['Affiliates.id IN' => $queryServiceAreaAffiliateIds])
    // ^^^ NO FILTER for Affiliates.active = 1
    ->orderAsc('Affiliates.name')
    ->all();
```

### 3. Browse Programs Display

**File:** `plugins/Programs/templates/Admin/Programs/index.php` (Lines 230-246)

The template renders `$program->affiliate_regions` without any active/inactive distinction. Inactive affiliates appear identically to active ones.

---

## What Happens When an Affiliate Is Marked Inactive

**Nothing cascades.** The `afterSave()` hook in `AffiliatesTable.php` (Lines 92-98) only clears the cache:

```php
public function afterSave(Event $event, EntityInterface $affiliate, \ArrayObject $options) {
    if (!$affiliate->isNew()) {
        \Cake\Cache\Cache::clear('affiliates');
    }
}
```

- Service Area zip codes are NOT removed
- Program assignments are NOT cleared
- No warnings or confirmation dialogs are shown
- No audit trail is recorded

---

## The Disconnect (Visual Summary)

| Area | Filters by Active Status? |
|------|--------------------------|
| Affiliate Region filter dropdown (Browse Programs) | Yes |
| Program-to-affiliate matching via zip codes | **No** |
| View Program Affiliates page | **No** |
| Browse Programs affiliate column display | **No** |
| Cascade effects on inactivation (zip removal, etc.) | **None** |

---

## Confirmed User Feedback

The codebase confirms both user reports from Item #20:

> "What is the function of marking an Affiliate 'inactive'? It looks like when it is marked inactive but still has zip codes assigned under Service Area, the programs are still assigned to that Affiliate."

**Confirmed.** The matching logic has no active status filter.

> "I set it to inactive and the program still show it was affiliated. To remove from it, I had to uncheck the zip code."

**Confirmed.** Manually removing zip codes is currently the only way to detach programs from an inactive affiliate.

---

## Recommended Fix: Option 2 (Change Matching Logic)

The lowest-risk, most reversible approach is to update the matching queries to filter by active status.

### Changes Required

**1. `PostalCodesServiceAreasTable.php` (~Line 230)**

Add active filter to the affiliates query:

```php
return \Cake\ORM\TableRegistry::getTableLocator()->get('Affiliates.Affiliates')->find()
    ->select(['id', 'name'])
    ->where([
        'Affiliates.id IN' => $queryServiceAreaAffiliateIds,
        'Affiliates.active' => 1,  // ADD THIS
    ])
    ->orderAsc('Affiliates.name')
    ->all()
    ->combine('id', 'name')
    ->toArray();
```

**2. `Programs/AffiliatesController.php` (~Line 149)**

Add active filter:

```php
$affiliates = $this->Affiliates->find()
    ->where([
        'Affiliates.id IN' => $queryServiceAreaAffiliateIds,
        'Affiliates.active' => 1,  // ADD THIS
    ])
    ->orderAsc('Affiliates.name')
    ->all();
```

### Why Option 2

- **Preserves data:** Service Area zip codes remain intact, allowing easy reactivation
- **Small change:** Two lines of code added
- **Consistent behavior:** Inactive affiliates disappear from program assignments immediately
- **Reversible:** Removing the filter restores previous behavior
- **No data migration needed**

### Additional Considerations

- Should add a confirmation dialog when marking an affiliate inactive, explaining that programs will no longer be associated with this affiliate
- Consider displaying a count of currently-matched programs before inactivation
- May want to add visual indicator on the Edit Affiliate page showing how many programs are currently matched via Service Area
