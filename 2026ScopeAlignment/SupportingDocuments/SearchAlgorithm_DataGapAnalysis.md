# Search Algorithm — Data Gap Analysis

**Date:** 2026-03-16
**Triggered by:** Client report that AALEAD (Asian American LEAD) was missing from search results due to missing Accepting Mentors/Mentees flag.

---

## Search Algorithm Conditions

The search query in `SearchesController::list()` (lines 451-628) applies the following filters. A program must pass **all applicable conditions** to appear in results.

### Mandatory Filters (always applied)

| # | Condition | Impact |
|---|-----------|--------|
| 1 | `Programs.status = 'approved'` | Programs with status pending, paused, or deleted are excluded |
| 2 | `Programs.accepting_mentors = 1` OR `Programs.accepting_mentees = 1` | **The AALEAD bug.** Programs where BOTH are `0`/`NULL` will never appear in any search. If a user searches as "mentor", only `accepting_mentors = 1` is checked. If "mentee", only `accepting_mentees = 1`. |

### Conditional Filters (depend on what the searcher selects)

| # | Condition | Impact |
|---|-----------|--------|
| 3 | **Delivery methods** — if the searcher checks community/site-based/eMentoring, the program must have at least one matching flag set to `1` | Programs where ALL THREE of `community_based`, `site_based`, `e_mentoring` are `0`/`NULL` are invisible when any delivery filter is selected |
| 4 | **Location (non-national search)** — uses `->matching('ProgramLocations')` which is an **INNER JOIN** | Programs with **zero entries in `program_locations`** are excluded from any zip-code-based search. This is a silent killer — the program simply doesn't appear. |
| 5 | **National search** — `Programs.nation_wide = 1` | Only applies when searcher checks "nationwide". Programs with `nation_wide = 0` won't appear in nationwide searches. |

### Additional Filters (from advanced search criteria, not sent by 3-Step App)

| # | Condition | Impact |
|---|-----------|--------|
| 6 | Mentee ages | If specific ages selected, program must match via `mentee_ages_programs` join table |
| 7 | Grades | If specific grades selected, program must match via `grades_programs` join table |
| 8 | Mentee categories | If specific categories selected, program must match via `mentee_categories_programs` join table |
| 9 | Mentoring types | If specific types selected, program must match via `mentoring_types_programs` join table |
| 10 | Focus type | If specific focus type selected, program must match `Programs.focus_type_id` |

---

## SQL Queries for Production

### 1. Programs missing BOTH accepting flags (never appears in ANY search)

```sql
SELECT id, title, status, accepting_mentors, accepting_mentees
FROM programs
WHERE status = 'approved'
  AND (accepting_mentors IS NULL OR accepting_mentors = 0)
  AND (accepting_mentees IS NULL OR accepting_mentees = 0);
```

### 2. Programs with no delivery method set (invisible when delivery filters used)

```sql
SELECT id, title, status, community_based, site_based, e_mentoring
FROM programs
WHERE status = 'approved'
  AND (community_based IS NULL OR community_based = 0)
  AND (site_based IS NULL OR site_based = 0)
  AND (e_mentoring IS NULL OR e_mentoring = 0);
```

### 3. Programs with NO locations (invisible in all zip-code searches)

```sql
SELECT p.id, p.title, p.status
FROM programs p
LEFT JOIN program_locations pl ON pl.program_id = p.id
WHERE p.status = 'approved'
  AND pl.id IS NULL;
```

### 4. Combined report — all reasons an approved program could be invisible

```sql
SELECT p.id, p.title,
  CASE WHEN (p.accepting_mentors IS NULL OR p.accepting_mentors = 0)
        AND (p.accepting_mentees IS NULL OR p.accepting_mentees = 0)
       THEN 'YES' ELSE 'no' END AS missing_mentor_mentee,
  CASE WHEN (p.community_based IS NULL OR p.community_based = 0)
        AND (p.site_based IS NULL OR p.site_based = 0)
        AND (p.e_mentoring IS NULL OR p.e_mentoring = 0)
       THEN 'YES' ELSE 'no' END AS missing_delivery_method,
  CASE WHEN pl.id IS NULL
       THEN 'YES' ELSE 'no' END AS missing_location
FROM programs p
LEFT JOIN program_locations pl ON pl.program_id = p.id
WHERE p.status = 'approved'
GROUP BY p.id
HAVING missing_mentor_mentee = 'YES'
    OR missing_delivery_method = 'YES'
    OR missing_location = 'YES';
```

---

## Summary

The AALEAD case (missing mentor/mentee flag) is one of **three data gaps** that can silently hide an approved program from search results:

1. **No mentor/mentee flag** — the AALEAD issue. Program never appears in any search.
2. **No delivery method** — program disappears when a user filters by community/site-based/eMentoring (which most searches do via the 3-Step App).
3. **No program locations** — program disappears from all zip-code-based searches because the location join is an inner join. Only nationwide searches would find it.

### Recommendations

- These fields are not currently required on the program submission or edit forms, but the search algorithm depends on them.
- Making "Accepting Mentors" and/or "Accepting Mentees" required on the program form.
- Making at least one delivery method required on the program form.
- Reviewing affected programs from the reports above and backfilling missing data.

### Source Code Reference

- **Search query logic:** `plugins/Searches/src/Controller/Api/SearchesController.php` (lines 451-628)
- **Search record creation:** same file, `add()` method (lines 208-320)
- **Distance calculation:** `plugins/ServiceAreas/src/Model/Table/PostalCodesTable.php`
