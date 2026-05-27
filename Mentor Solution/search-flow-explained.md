# MENTOR Search Flow — End-to-End Explanation

## Overview

The search flow spans two applications:

1. **MENTOR Connect 3-Step App** (`mentor-connect-app`) — A standalone frontend form that collects search criteria and submits them as a GET request
2. **MENTOR Connector** (`mentor-connect`) — The CakePHP backend that receives the request, saves the search, and returns matching mentoring programs

---

## Part 1: The Search Form (MENTOR Connect 3-Step App)

The 3-Step App is **only a search form** — it doesn't process results itself. It submits a traditional HTML GET form to an external URL configured via the `ACTION` environment variable (currently empty in `.env`).

### Form Fields Submitted

| Parameter   | Type     | Values                                                      |
|-------------|----------|-------------------------------------------------------------|
| `firstName` | text     | required                                                    |
| `lastName`  | text     | required                                                    |
| `email`     | text     | required                                                    |
| `zipCode`   | text     | required (set to `"app-national"` when nationwide selected) |
| `role`      | select   | `"mentor"` or `"mentee"`                                    |
| `distance`  | select   | 5, 10, 15 (default), 25 miles                               |
| `nationwide`| checkbox | `"true"` or absent                                          |
| `community` | checkbox | community-based mentoring                                   |
| `siteBased` | checkbox | site-based mentoring                                        |
| `eMentoring`| checkbox | e-mentoring                                                 |
| `action`    | hidden   | always `"search"`                                           |
| `fwID2`     | hidden   | partner ID from URL query param                             |

### How the Form Works

1. The form uses `method="get"` and `target="_top"` — a standard GET request that breaks out of the iframe
2. All fields become URL query parameters on the external `ACTION` endpoint
3. The resulting URL looks like:
   ```
   {ACTION_URL}?action=search&firstName=Jane&lastName=Doe&email=jane@example.com&zipCode=10001&role=mentor&distance=15&community=true&siteBased=true&eMentoring=true
   ```

### Conditional Logic

When **"Nationwide e-mentoring"** is checked:
- Zip code is hidden and set to `"app-national"`
- Distance selector is hidden
- Community-based and site-based checkboxes are unchecked and hidden
- Only e-mentoring remains selected

### What the 3-Step App Does NOT Do

- **No API calls** — despite Axios being in dependencies, it's unused
- **No search processing** — the external `ACTION` endpoint handles that
- **No results display** — the user is redirected to the external search results page

---

## Part 2: The Backend (MENTOR Connector)

The `ACTION` endpoint points to the MENTOR Connector CakePHP application, which receives the GET parameters and processes the search.

### Parameter Mapping

| Query Param  | DB Column        | Purpose                                |
|--------------|------------------|----------------------------------------|
| `firstName`  | `first_name`     | Searcher's first name (required)       |
| `lastName`   | `last_name`      | Searcher's last name (required)        |
| `email`      | `email`          | Searcher's email (trimmed on save)     |
| `zipCode`    | `zip_code`       | Center point for proximity search      |
| `role`       | `mentor`/`mentee`| Boolean flags based on role value      |
| `distance`   | `distance`       | Radius in miles (default 25)           |
| `nationwide` | `is_national`    | Nationwide search flag                 |
| `community`  | `community_based`| Include community-based programs       |
| `siteBased`  | `site_based`     | Include site-based programs            |
| `eMentoring` | `e_mentoring`    | Include e-mentoring programs           |
| `fwID2`      | `partner_id`     | Scopes search to a specific partner    |

### Processing Flow (2-step)

#### Step 1 — Save the Search (`POST /a/app/search/`)

The API controller (`SearchesController::add()`) receives the data, maps field names to entity columns, and persists a `Search` record with all criteria. Associated filter data (focus types, ages, grades, etc.) is saved to join tables. Returns a search ID.

#### Step 2 — Fetch Results (`GET /a/app/search/results/list/{id}`)

The `SearchesController::list()` action builds a complex query against the `Programs` table:

1. **Distance filtering** — Looks up lat/long for the zip code from the `postal_codes` table, then uses the **Haversine formula** to calculate great-circle distance between that point and each program's locations (`program_locations` table). Filters with `HAVING distance <= {miles}` using `MIN()` (closest location per program).

   ```sql
   -- Haversine formula (3959 = Earth's radius in miles)
   3959 * ACOS(
       COS(RADIANS(ref_lat)) * COS(RADIANS(lat)) *
       COS(RADIANS(lng) - RADIANS(ref_lng)) +
       SIN(RADIANS(ref_lat)) * SIN(RADIANS(lat))
   )
   ```

2. **National search override** — If `is_national = true` or no zip code provided, skips distance calculation and filters to programs with `Programs.nation_wide = 1`.

3. **Delivery method filtering** — OR logic (program matches ANY selected method):
   ```sql
   WHERE (Programs.community_based = 1
      OR Programs.site_based = 1
      OR Programs.e_mentoring = 1)
   ```

4. **Program status filtering** — Only programs with `Programs.status = 'approved'` are included. Paused, pending, and deleted programs are excluded.

5. **Role filtering** — If `role=mentor`, filters to `accepting_mentors = 1`. If `role=mentee`, filters to `accepting_mentees = 1`.

6. **Additional criteria** (not sent by 3-Step App but supported by the API):
   - Focus types, mentee ages, grades, mentee categories, mentoring types
   - Filtered via join tables with AND logic

7. **Results** are sorted by `badge_count` (NQMS quality badges) descending, paginated (default 100), and returned with distance info.

### Database Tables Involved

| Table                      | Role                                      |
|----------------------------|-------------------------------------------|
| `searches`                 | Stores each search request                |
| `programs`                 | Programs being matched against            |
| `program_locations`        | Program addresses with lat/lng            |
| `postal_codes`             | Zip code to lat/lng lookup                |
| `partners`                 | Partner orgs (linked via `fwID2`)         |
| `focus_types_searches`     | Join: search ↔ focus types                |
| `grades_searches`          | Join: search ↔ grades                     |
| `mentee_ages_searches`     | Join: search ↔ mentee ages                |
| `mentee_categories_searches`| Join: search ↔ mentee categories         |
| `mentoring_types_searches` | Join: search ↔ mentoring types            |

### Key Source Files

| File | Role |
|------|------|
| `plugins/Searches/src/Plugin.php` | Route definitions |
| `plugins/Searches/src/Controller/Api/SearchesController.php` | Main logic — `add()` saves, `list()` queries |
| `plugins/Searches/src/Model/Table/SearchesTable.php` | Validation, associations, email trimming |
| `plugins/Searches/src/Model/Entity/Search.php` | Entity definition |
| `plugins/ServiceAreas/src/Model/Table/PostalCodesTable.php` | Zip-to-coordinates lookup, Haversine formula |
| `plugins/Programs/src/Model/Table/ProgramLocationsTable.php` | Program location coordinates |

---

## Example Request in Plain English

Given this URL:
```
?action=search&firstName=Jane&lastName=Doe&email=jane@example.com&zipCode=10001&role=mentor&distance=15&community=true&siteBased=true&eMentoring=true
```

> "Jane Doe (jane@example.com) is looking to **be a mentor**. Find all **approved** mentoring programs within **15 miles** of zip code **10001** (Manhattan) that offer **community-based**, **site-based**, or **e-mentoring** delivery, and return them ranked by quality badges."
