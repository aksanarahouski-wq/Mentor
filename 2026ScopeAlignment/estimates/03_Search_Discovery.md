# Estimates: Search & Discovery
**Category:** Search & Discovery
**Items:** #9 (reviewed) | #10, #25, #26, #27 (pending/new — excluded)
**Status:** Reviewed items only
**Last Updated:** April 2026

---

## #9 — Admin Program Search & Discovery Enhancements

**Priority:** Critical | **Impact:** High | **Status:** Reviewed (Meeting 1)

### Refined Scope (Post-Meeting 1)
1. **Align Browse Programs filtering capabilities with NQMS assessment search page** (richer filtering model)
2. **Add Program Delivery type filter** (Community-based, Site-based, E-mentoring)
3. **Add additional search filters** (program characteristics, age range, zip code with layered filters)
4. **Make filter panels collapsible and consistent** (see #4)
5. **Fix rich text in program description** (can't add bullets to description)

> **Bundle with:** #4 (UI/UX Consistency) for filter panel standardization

### Preliminary Scope Breakdown

#### 9a. Add Program Delivery Type Filter
**What exists today:**
- Database fields exist: `community_based`, `site_based`, `e_mentoring` (boolean columns on `programs` table)
- Program locations have a `type` field storing: 'communityBased', 'siteBased', 'eMentoring'
- These fields are editable on the program edit form
- **NOT exposed as filters on Browse Programs page**
- `ProgramsFilterForm.php` currently has 6 filters: Program Name, Contact Name/Email, Organization, Status, State, Affiliate Region

**Work required:**
- Add delivery type multi-checkbox or multi-select filter to `ProgramsFilterForm.php`
- Add filter query logic: `WHERE programs.community_based = 1 OR programs.site_based = 1 OR programs.e_mentoring = 1`
- Add filter UI element to Browse Programs template

**Estimate:** ~6-8 hours

#### 9b. Add Program Characteristics Filters
**What exists today:**
- Program characteristics data exists in the database (program options, age ranges, etc.)
- Not currently exposed as filters

**Work required:**
- Identify which characteristics to add as filters (age range, program type, etc.)
- Add filter controls to `ProgramsFilterForm.php`
- Add corresponding query logic with appropriate joins
- Depends on which specific characteristics are prioritized

**Estimate:** ~12-20 hours (depends on number of characteristics)

#### 9c. Add Zip Code Search with Layered Filters
**What exists today:**
- Searches page has zip code filter (via `SearchesFilterForm`)
- Programs are linked to locations via `program_locations` table with coordinates
- Proximity search exists on public-facing search but not on admin Browse Programs

**Work required:**
- Add zip code text input to ProgramsFilterForm
- Implement proximity search logic (programs with locations within X miles of zip code)
- May require geocoding the input zip code and calculating distances
- Alternatively, simpler approach: filter by exact zip code match on program locations

**Estimate:** ~16-24 hours (proximity) or ~6-8 hours (exact match)

#### 9d. Collapsible Filter Panel (Shared with #4)
**Estimated under #4 — no additional cost here if done together.**

**Estimate:** ~0 hours (bundled with #4)

#### 9e. Rich Text in Program Description (Bullets)
**What exists today:**
- Program description is a plain text field
- No rich text editor on any program fields
- Client reported: "can't add bullets to the description"

**Work required:**
- Integrate a rich text editor (CKEditor, TinyMCE, or Quill) for the program description field on the edit form
- Store content as HTML in the database (may require field type change from TEXT to LONGTEXT or ensure existing TEXT is sufficient)
- Add HTML sanitization on save (prevent XSS)
- Update display templates to render HTML instead of escaped text
- Test across all display contexts: edit form, view page, browse list, public search, iframe

**Estimate:** ~20-30 hours (this is a broader change affecting multiple display contexts — consider if this should be a separate line item)

### Item #9 Total Estimate

| Sub-Item | Hours (Low) | Hours (High) |
|----------|-------------|--------------|
| 9a. Delivery type filter | 6 | 8 |
| 9b. Characteristics filters | 12 | 20 |
| 9c. Zip code search | 6 | 24 |
| 9d. Collapsible panel | 0 | 0 |
| 9e. Rich text (description) | 20 | 30 |
| **QA & Testing** | **8** | **12** |
| **Total** | **52** | **94** |

> **Note:** The range is wide because of two scope decisions:
> - Zip code: exact match (~6h) vs. proximity search (~24h)
> - Rich text: could be deferred as a separate item if budget is tight — it's not strictly a "search" enhancement
> - Without rich text: **32-64 hours**

---

## Category Summary

| Item | Description | Hours (Low) | Hours (High) | Notes |
|------|-------------|-------------|--------------|-------|
| #9 | Admin Program Search & Discovery | 52 | 94 | Range depends on zip code and rich text scope |
| | **Without rich text** | **32** | **64** | |
| | **Category Total** | **52** | **94** | |
