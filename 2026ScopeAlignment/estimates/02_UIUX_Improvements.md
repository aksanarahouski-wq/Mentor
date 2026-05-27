# Estimates: UI/UX Improvements
**Category:** UI/UX Improvements
**Items:** #4, #5, #6, #8 (reviewed) | #7 (pending — excluded)
**Status:** Reviewed items only
**Last Updated:** April 2026

---

## #4 — UI/UX Consistency & Page Layout Improvements

**Priority:** High | **Impact:** High | **Status:** Reviewed (Meeting 1)

### Refined Scope (Post-Meeting 1)
1. **Make all filter panels collapsible** across all pages
2. **Standardize filter UI** using NQMS assessment search as the model
3. **Consistent filter panel positioning** — above the fold

> **Bundle with:** #9 (Search & Discovery) filter alignment work

### Preliminary Scope Breakdown

#### 4a. Collapsible Filter Panels — All Pages
**What exists today:**
- Shared collapse component: `plugins/ThemeAdmin/templates/element/admin_filter_header_options.php` — provides minimize/collapse toggle
- Inquiries page already has Bootstrap collapse with "Advanced Filters" button
- Programs and Accounts pages do NOT use collapse
- Filter forms are bespoke per page but follow a shared pattern via `Orases\Helpers\Form\FilterForm` base class

**Pages requiring work:**
1. Programs (`plugins/Programs/templates/Admin/Programs/index.php`) — no collapse
2. Accounts/Users (`plugins/Users/templates/Admin/Users/index.php`) — no collapse
3. Affiliates (`plugins/Affiliates/templates/Admin/Affiliates/index.php`) — needs verification
4. Searches (`plugins/Searches/templates/Admin/Searches/index.php`) — needs verification
5. Inquiries (`plugins/Inquiries/templates/Admin/Inquiries/index.php`) — already has collapse (verify consistency)

**Work required:**
- Apply the existing `admin_filter_header_options.php` collapse element consistently to all 5 pages
- Ensure collapse state persists (via localStorage or session)
- Standardize the visual layout: filters above fold, content below
- Test responsiveness on all pages

**Estimate:** ~12-16 hours

#### 4b. Standardize Filter UI Across Pages
**What exists today:**
- Each page has its own filter form class and template layout
- No shared filter template — each page renders its own filter HTML
- ProgramsFilterForm: 6 filters
- UsersFilterForm: 4 filters
- InquiryFilterForm: separate implementation
- SearchesFilterForm: 4 filters with date range picker

**Work required:**
- Create or refine a shared filter panel template element
- Standardize visual spacing, field widths, button placement
- Ensure "Reset Filters" button is consistently available
- Align field types (dropdowns, text inputs, date pickers) visually

**Estimate:** ~12-18 hours

### Item #4 Total Estimate

| Sub-Item | Hours (Low) | Hours (High) |
|----------|-------------|--------------|
| 4a. Collapsible filter panels | 12 | 16 |
| 4b. Standardize filter UI | 12 | 18 |
| **QA & Testing** | **6** | **8** |
| **Total** | **30** | **42** |

---

## #5 — Password Reset & Login UX

**Priority:** Critical | **Impact:** High | **Status:** Reviewed (Meeting 1)

### Refined Scope (Post-Meeting 1)
1. **Investigate current password reset flow** — determine when/why phone number is required
2. **Remove phone number requirement** (if confirmed unnecessary — MFA unlikely)
3. **Improve reset password email clarity**

> **Dependency:** Aksana to investigate current flow before proposing changes

### Preliminary Scope Breakdown

#### 5a. Investigation & Documentation
**What exists today:**
- Forgot password form: `plugins/Users/templates/Login/forgot_password.php` — only asks for email
- Reset password form: `plugins/Users/templates/Login/reset_password.php` — password & confirm password fields
- Email notification: `plugins/Users/templates/email/html/reset_password.php` — sends link with user ID and challenge token
- Controller: `plugins/Users/src/Controller/LoginController.php`
- **No phone fields found in the password reset flow** — the phone number requirement may come from a different flow (account creation or profile completion, not password reset)

**Work required:**
- Document the actual current UX flow end-to-end
- Identify where phone number prompt appears (may be user profile or account setup, not password reset)
- Test across different roles to confirm behavior

**Estimate:** ~4-6 hours (investigation)

#### 5b. Phone Number Removal (if applicable)
**Work required:**
- Remove or make optional the phone/mobile field from wherever it's being required
- Update validation rules
- Test across roles

**Estimate:** ~4-6 hours

#### 5c. Improve Password Reset Email
**What exists today:**
- Email template at `plugins/Users/templates/email/html/reset_password.php`
- Sends a clickable link with user ID and challenge token

**Work required:**
- Redesign email template for clarity (clearer subject line, instructions, expiration notice)
- Add branding consistency
- Test email rendering across clients

**Estimate:** ~4-8 hours

### Item #5 Total Estimate

| Sub-Item | Hours (Low) | Hours (High) |
|----------|-------------|--------------|
| 5a. Investigation & documentation | 4 | 6 |
| 5b. Phone number removal | 4 | 6 |
| 5c. Improve reset email | 4 | 8 |
| **QA & Testing** | **4** | **6** |
| **Total** | **16** | **26** |

---

## #6 — Navigation & Hyperlink Improvements

**Priority:** Critical | **Impact:** High | **Status:** Reviewed (Meeting 1)

### Refined Scope (Post-Meeting 1)
1. **Make entity names clickable links** throughout MC admin pages
2. **Match NQMS-side hyperlink navigation quality**

### Preliminary Scope Breakdown

#### 6a. Hyperlink Entity Names
**What exists today:**
- Browse Programs page (`plugins/Programs/templates/Admin/Programs/index.php`):
  - Program names: **NOT clickable** — displayed as plain text with `h()`
  - Affiliate Region: **NOT clickable** — plain text `<li>` list
  - Physical Location: **NOT clickable** — plain text
  - Only navigation: "View/Edit" action button
- Affiliate > Programs tab (`plugins/Affiliates/templates/Admin/Programs/index.php`):
  - Program titles: **NOT clickable** — plain text
  - Has separate "View" action button
- Websites in Affiliate view use `Html->link()` (so the pattern exists)

**Pages requiring hyperlink updates:**
1. Browse Programs — program name → link to program view/edit
2. Browse Programs — affiliate region → link to affiliate page
3. Affiliate Programs tab — program name → link to program view/edit
4. Any other tables showing entity names (searches, inquiries referencing programs)

**Work required:**
- Replace `h($program->title)` with `Html->link()` to program view page across all relevant templates
- Replace affiliate region text with `Html->link()` to affiliate view page
- Audit all admin table views for entity names that should be links
- Ensure link styling is consistent (underlined, colored appropriately)

**Estimate:** ~8-12 hours

### Item #6 Total Estimate

| Sub-Item | Hours (Low) | Hours (High) |
|----------|-------------|--------------|
| 6a. Hyperlink entity names | 8 | 12 |
| **QA & Testing** | **3** | **4** |
| **Total** | **11** | **16** |

---

## #8 — Badge Management

**Priority:** Low | **Impact:** High | **Status:** Reviewed (Meeting 1)

### Refined Scope (Post-Meeting 1)
1. **Change badge assignment from checkboxes to radio buttons** (one badge at a time — tier/replacement system)
2. **Confirm badge usage model with Sarah** (Mike to confirm)
3. **Investigate LMS badge connection** (Aksana)

> **Dependencies:** Mike to confirm badge usage model with Sarah; Aksana to investigate LMS badge connection

### Preliminary Scope Breakdown

#### 8a. Change Checkboxes to Radio Buttons
**What exists today:**
- Badge assignment in program edit form: `plugins/Programs/templates/Admin/Programs/edit.php` (lines 1029-1037)
- Uses `multicheckbox` control type for `badges._ids`
- Badge model: `plugins/NQMS/src/Model/Entity/Badge.php`
- Badge CRUD: `plugins/NQMS/templates/Admin/Badges/edit.php`
- Access: only visible to superusers or affiliate users

**Work required:**
- Change `multicheckbox` to `radio` input type in program edit template
- Update form processing to accept single badge ID instead of array
- Update `ProgramsTable` save logic for single badge association (currently saves array via `_ids`)
- May need to change from belongsToMany to belongsTo if only one badge per program, OR keep belongsToMany but enforce single selection in UI
- Add migration if relationship model changes

**Estimate:** ~6-10 hours

#### 8b. Badge Ordering (if still needed)
**What exists today:**
- No explicit ordering mechanism for badges
- Badge list displayed in default query order

**Work required:**
- Add `display_order` column to badges table (if not exists)
- Add drag-and-drop reordering to badge admin list (using jQuery Nestable or similar — already used in NQMS questions)
- Update badge list queries to sort by display_order

**Estimate:** ~8-12 hours (if needed — may be unnecessary if badges are tiers and only one is assigned)

### Item #8 Total Estimate

| Sub-Item | Hours (Low) | Hours (High) |
|----------|-------------|--------------|
| 8a. Checkboxes → radio buttons | 6 | 10 |
| 8b. Badge ordering (if needed) | 8 | 12 |
| **QA & Testing** | **3** | **4** |
| **Total (with ordering)** | **17** | **26** |
| **Total (without ordering)** | **9** | **14** |

---

## Category Summary

| Item | Description | Hours (Low) | Hours (High) | Notes |
|------|-------------|-------------|--------------|-------|
| #4 | UI/UX Consistency & Filters | 30 | 42 | Bundle with #9 |
| #5 | Password Reset & Login UX | 16 | 26 | Needs investigation first |
| #6 | Navigation & Hyperlinks | 11 | 16 | Straightforward |
| #8 | Badge Management | 9–17 | 14–26 | Scope depends on ordering need |
| | **Category Total** | **66–74** | **98–110** | |
