# System Enhancements — 2026 Scope
**Initiative Type:** Platform Enhancements
**Priority Level:** Top 3 Focus Area
**Status:** In Planning
**Last Updated:** May 2026
**Client Feedback Received:** May 2026 (Scope Review Meeting 3 — final review session)

---

## Overview

This document consolidates all identified low-hanging fruit and system enhancement opportunities for the Mentor Connector platform. The philosophy is to focus on improving existing functionality before major new builds, addressing immediate pain points and technical debt that can deliver quick value.

---

## Visual Legend

**Priority:** 🔴 Critical | 🟠 High | 🟡 Medium | 🟢 Low

**Impact:** ⬛⬛⬛ High (100%) | ⬛⬛◻ Medium (>70%) | ⬛◻◻ Low (<40%) | ◻◻◻ Minimal (10%)

**Review Status:** ✅ Reviewed | 🔒 Deferred | ⏳ Pending Follow-up

---

## Client Feedback Summary

| **#** | **Enhancement** | **Priority** | **Impact** | **Category** | **Status** |
|-------|----------------|-------------|-----------|--------------|------------|
| 1 | User Account Management | 🟠 High | ⬛◻◻ Low | User Account & Data Mgmt | ✅ Reviewed |
| 2 | Export Capabilities | 🟠 High | ⬛⬛◻ Medium | User Account & Data Mgmt | ✅ Reviewed |
| 3 | Duplicate Detection & Prevention | 🟠 High | ⬛⬛◻ Medium | User Account & Data Mgmt | ✅ Reviewed |
| 4 | UI/UX Consistency & Page Layout | 🟠 High | ⬛⬛⬛ High | UI/UX Improvements | ✅ Reviewed |
| 5 | Password Reset & Login UX | 🔴 Critical | ⬛⬛⬛ High | UI/UX Improvements | ✅ Reviewed |
| 6 | Navigation & Hyperlink Improvements | 🔴 Critical | ⬛⬛⬛ High | UI/UX Improvements | ✅ Reviewed |
| 7 | Program Status Visibility | 🟢 Low | ⬛⬛⬛ High | UI/UX Improvements | ✅ Reviewed |
| 8 | Badge Management | 🟢 Low | ⬛⬛⬛ High | UI/UX Improvements | ✅ Reviewed |
| 9 | Admin Program Search & Discovery | 🔴 Critical | ⬛⬛⬛ High | Search & Discovery | ✅ Reviewed |
| 10 | Public-Facing Site Improvements | 🟡 Medium | — | Search & Discovery | 🔒 Deferred |
| 11 | Assessment History & Multi-Assessment | 🔴 Critical | ⬛⬛◻ Medium | NQMS Enhancements | ✅ Reviewed |
| 12 | NQMS Assessment Workflow | 🟡 Medium | ⬛⬛◻ Medium | NQMS Enhancements | ✅ Reviewed |
| 13 | NQMS Assessment Question Mgmt | 🟡 Medium | ⬛⬛⬛ High | NQMS Enhancements | ✅ Reviewed |
| 14 | NQMS Reviewer Progress Tracking | 🟡 Medium | ⬛⬛⬛ High | NQMS Enhancements | ✅ Reviewed |
| 15 | Full Data Export for Research | 🟠 High | — | NQMS Enhancements | ✅ Reviewed |
| 16 | Automation & Engagement Features | 🔴 Critical | ⬛⬛⬛ High | Automation & Engagement | ✅ Reviewed |
| 17 | Data Field Enhancements | 🟡 Medium | ⬛◻◻ Low | Data Field Management | ✅ Reviewed |
| 18 | Program Admin Permission Enhancements | 🟠 High | ⬛◻◻ Low | Permissions & Access | ✅ Reviewed (no dev needed) |
| 19 | Affiliate Management UX | 🟠 High | ⬛◻◻ Low | Permissions & Access | ✅ Reviewed |
| 20 | Affiliate Deletion & Inactivation | 🟠 High | ⬛⬛◻ Medium | Permissions & Access | ✅ Reviewed |
| 21 | National Affiliate for Orphan Programs | 🟠 High | ⬛◻◻ Low | Permissions & Access | ✅ Reviewed |
| 22 | Form & Field Alignment Issues | 🟠 High | ⬛◻◻ Low | Forms & Data Collection | ✅ Reviewed (blocked on MENTOR field inventory) |
| 23 | Inquiries Module Cleanup | 🟢 Low | ◻◻◻ Minimal | Forms & Data Collection | 🔒 Deferred |
| 24 | SharePoint Migration | 🟠 High | ⬛◻◻ Low | Infrastructure | 🔒 Deferred |
| 25 | Public Search Iframe & Rich Text | 🟠 High | ⬛◻◻ Low | Search & Discovery | ✅ Reviewed (blocked on MENTOR field inventory) |
| 26 | Public Program Search & Mentee Discovery | — | — | Search & Discovery | 🔒 Deferred |
| 27 | Search Algorithm Data Requirements & Program Visibility | 🔴 Critical | ⬛⬛⬛ High | Search & Discovery | ✅ Reviewed |
| 28 | Program Archive & Lifecycle Management | 🟠 High | ⬛⬛◻ Medium | User Account & Data Mgmt | ✅ Reviewed (covered under #7) |
| 29 | Global Search & Analytics Export Hub | 🟡 Medium | ⬛⬛◻ Medium | Data & Reporting | ✅ Reviewed |
| 30 | NQMS Goal Status Enhancements | 🟠 High | ⬛⬛◻ Medium | NQMS Enhancements | ⏳ Pending follow-up with Mike |

---

## Estimation Readiness

| **Status** | **Items** | **Count** |
|------------|-----------|-----------|
| ✅ Ready to estimate | #1, #4, #5, #6, #7 (+#28), #8, #9, #12, #13, #14, #16, #19, #20, #21, #27 | 15 |
| ⏳ Blocked on MENTOR | #2 (Sandy's field list), #22 (field inventory), #25 (field inventory), #29 (field inventory for comprehensive export) | 4 |
| 🔍 Needs discovery | #3 (depends on #17), #11 (breakout with Mike), #30 (breakout with Mike) | 3 |
| 🔒 Deferred | #10, #15, #17, #23, #24, #26 | 6 |
| ✅ No estimate needed | #18 (descoped — no dev) | 1 |
| ✅ Covered under other item | #28 (covered under #7) | 1 |

**Key blockers:**
- **MENTOR field inventory** (Sandy) — unblocks #2, #22, #25, #29
- **Discovery session with Mike** — unblocks #11, #30
- **MENTOR internal strategy discussion** — unblocks #10, #26

---

## Summary Statistics

**Total Enhancement Areas Identified:** 30
- **User Account & Data Management:** 4 items (#1, #2, #3, #28)
- **Data & Reporting:** 1 item (#29)
- **UI/UX Improvements:** 5 items (#4 - consolidated, #5, #6, #7, #8)
- **Search & Discovery:** 5 items (#9, #10, #25, #26, #27)
- **NQMS Enhancements:** 6 items (#11, #12, #13, #14, #15, #30)
- **Automation & Engagement:** 1 item (#16)
- **Data Field Management:** 1 item (#17)
- **Permissions & Access:** 4 items (#18, #19, #20, #21)
- **Forms & Data Collection:** 2 items (#22, #23)
- **Infrastructure:** 1 item (#24)

**Priority Breakdown:**
- **CRITICAL:** 2 items (Full Data Export, Assessment History & Multi-Assessment Support)
- **Immediate/Time-Sensitive:** 3 items
- **High Value Quick Wins:** 7 items
- **Quality of Life (UI/UX):** 7 items
- **Quality of Life (NQMS):** 5 items
- **System Cleanup:** 4 items
- **Affiliate/Admin Experience:** 5 items
- **Infrastructure:** 1 item
- **Strategic Foundation:** 2 items
- **Nice to Have:** 2 items

---

## Identified Enhancement Areas

### 1. User Account Management ✅ `REVIEWED — Meeting 2, April 9, 2026`


**Current Issues:**
- Unable to delete old user accounts
- Can't export user account data with last login timestamps
- No visibility into who last logged in or updated records
- No tracking of user activity (who updated what, when)

**Proposed Solutions:**
- Enable deletion/archival of old user accounts
- Add export capabilities for user account data including:
  - Last login timestamps
  - Update history
  - Activity logs
- Implement user activity tracking across the system

> **CLIENT FEEDBACK:**
> This is an enhancement for Admins, including Global Admins who should only have the ability to delete users. Program and Affiliate Admins should have the option to archive only.
>
> **Client Priority:** 🟠 High | **Client Impact:** ⬛◻◻ Low - Some Users, Less than 40%
>
> **Meeting 2 Review (April 2026):** Scope refined significantly. Agreed on **archive only (soft delete)** — Sandy: "We should move away from the delete term." Global admins can archive any user; program/affiliate admins can archive users under their affiliate only. **Export removed from scope** — no immediate need (Sandy: "It's a want, not a need"). Tim flagged that the accounts table doesn't show which program a user belongs to — many orphan accounts with no program attachment. Also need to add a status column and status filter to the accounts table (especially needed once archive is available). Keep email visible for cleanup of legacy records with no first/last name. User activity tracking (who last changed what across goals/assessments/profiles) acknowledged as useful but **deferred as lower priority**.
>
> **Next Step:** Estimate. Refined scope is: archive capability (soft delete), add Program + Status columns to accounts table, add status filter. Export and activity tracking deferred.
>
> **REFINED SCOPE:**
> - Archive capability (soft delete) for user accounts — no permanent deletion
> - Global admins can archive any user; program/affiliate admins can archive users under their affiliate only
> - Add "Program" column to accounts table (show which program a user belongs to)
> - Add "Status" column to accounts table
> - Add status filter to accounts table (needed once archive is available)
> - Keep email visible for cleanup of legacy records with no first/last name
> - OUT OF SCOPE: Export, activity tracking (who changed what)
>
> **Readiness:** ✅ Ready to estimate

---

### 2. Export Capabilities ✅ `REVIEWED — Meeting 2, April 9, 2026`


**Current Issues:**
- Limited export options across various data types
- Export capabilities are limited on certain data sets
- Cannot effectively extract data for analysis and reporting

**Proposed Solutions:**
- Enhanced export capabilities across all data types
- Standardized export formats
- Bulk export functionality where needed

> **CLIENT FEEDBACK:**
> This feature would greatly improve National Staff who can leverage the information in the system for surveys, relationship management, research, and more.
>
> **Client Addition to Proposed Solutions:** Update Export Template
>
> **Client Priority:** 🟠 High | **Client Impact:** ⬛⬛◻ Medium - Most Users, More than 70%
>
> **Meeting 2 Review (April 2026):** Scope narrowed significantly after walkthrough of what's already exportable. **Accounts export: removed** (no immediate need). **Affiliates export: not needed** (Sandy: "It's a want — for 20-something records, we can just look on screen"). **Program export template: needs rework** — current template has 179 address placeholder columns (overkill); Sandy to send desired fields to Orases for trimming. Want to add missing program options data and align closer to CRM import format for potential data sync. Tim cautioned that MC and CRM don't collect equal data (e.g., organization field). **Inquiries/Searches export: already exists** — Beth confirmed. **NQMS export: deferred** (reiterated Meeting 1 decision — ad-hoc SQL from Orases). Sandy raised idea of a **centralized export page** (single menu item instead of navigating to each section) — Aksana noted this would be inexpensive since exports already exist. Cross-referencing data across MC + NQMS acknowledged as future need but not scoped now.
>
> **Next Step:** Sandy to send desired program export template fields to Orases. Orases trims template and adds missing program options data. Estimate for template rework. Centralized export page concept noted for future consideration.
>
> **REFINED SCOPE:**
> - Rework program export template — trim 179-column address bloat, add missing program options data
> - Align export fields closer to CRM import format
> - OUT OF SCOPE: Accounts export, affiliates export, NQMS export (all deferred)
> - Centralized export page concept noted for future (#29)
>
> **Readiness:** ⏳ Blocked — waiting on Sandy's desired field list before estimating

---

### 3. Duplicate Detection & Prevention ✅ `REVIEWED — Meeting 2, April 9, 2026`


**Current Issues:**
- Duplicate program entries exist in the system (though not exact name matches)
- Examples: "Academic Mentoring from Be A Mentor" / "Academic Mentoring with Be A Mentor"
- Programs missing Affiliate Region assignment (65 programs identified)
- Data inconsistency from similar but not identical entries

**Proposed Solutions:**
- Flag duplicate names in new program forms (implemented in 2023, but only for exact matches)
- Enhanced duplicate detection for similar names
- Tools to identify and merge potential duplicates
- Validation rules to prevent duplicate creation

**Note:** A change was implemented last year to flag duplicate names in new program forms, reducing future duplications for exact matches.

> **CLIENT FEEDBACK:**
> Additional Note, clean-up of the system continues until the end of this month (March 2026) with expectations to continue the work as phase 2 – the goal is to get to a standard list of cleaned active programs where we have actual numbers of how many programs are approved, paused, and on hold.
>
> **Client Priority:** 🟠 High | **Client Impact:** ⬛⬛◻ Medium - Most Users, More than 70%
>
> **Meeting 2 Review (April 2026):** Complex item — needs further discussion. Current duplicate detection only matches exact names. Sandy: need to match on more fields (phone number, email) like they did with CRM. Mike noted some "duplicates" are **intentional workarounds** — same organization with different program models needing separate NQMS assessments (e.g., "Buddy Program - School Based" vs "Buddy Program - Community Based"). This specific problem will be partially addressed by #11 (multi-assessment support). Hyun flagged that same program name can legitimately exist in different states — affiliates can't catch cross-state duplicates, only global admin can. Mike comfortable with **annual affiliate-driven cleanup** rather than heavy automated dedup. Sandy pushing for data maintenance requirements in affiliate agreements. **Organization field (#17) resurfaced strongly** — Sandy and Aksana agreed it should be revived to establish parent-child relationships (organization owns programs), which would help differentiate legitimate same-name programs from true duplicates. Organization field exists in DB and on public application but was removed from admin view due to misuse. Currently no ability to manage organizations as a separate entity — would need a management UI. This ties directly to #17 discussion planned for Meeting 3.
>
> **Next Step:** Further discussion in Meeting 3, especially around organization field (#17) and its role in duplicate prevention. Aksana to investigate current "Deleted" program status behavior. Consider whether #11 (multi-assessment) reduces the duplicate workaround problem. Estimate pending deeper scoping.
>
> **REFINED SCOPE:**
> - TBD — scope is not yet clear
> - Current exact-match duplicate detection exists but is insufficient
> - Needs to match on more fields (phone, email) and be case-insensitive
> - Some "duplicates" are intentional workarounds for multi-assessment (#11 may reduce this)
> - Organization field (#17) revival would help differentiate legitimate same-name programs
> - Mike comfortable with annual affiliate-driven cleanup rather than heavy automated dedup
>
> **Readiness:** 🔍 Needs discovery — depends on #17 (organization field) decisions and #11 (multi-assessment) reducing the workaround problem. Scope narrowing needed.

---

### 4. UI/UX Consistency & Page Layout Improvements ✅ `REVIEWED — Meeting 1, March 25, 2026`


**Current Issues:**
- Inconsistent UI patterns across the platform
- Filter panels are not collapsible across all pages
- Filters sometimes positioned below page fold, reducing visible content
- Inconsistent filter UI across different pages (Searches, Inquiries, Affiliates, Programs, Accounts)
- Missing breadcrumb navigation in some areas
- Users must scroll to see content when filters take up screen space
- Usability friction in workflows

**Proposed Solutions:**
- Make all filter panels collapsible
- Move filter panels above the page fold to maximize visible content
- Standardize filter and search UI across all relevant pages (Searches, Inquiries, Affiliates, Programs, Accounts)
- Add breadcrumb navigation consistently across all sections
- Review and standardize UI components
- Improve navigation flow
- Consistent user experience for filtering data

**Pages Affected:** Searches, Inquiries, Affiliates, Programs, Accounts

**Note:** This consolidates general UI/UX consistency improvements with specific filter panel layout enhancements.

> **CLIENT FEEDBACK:**
> *(No comment provided)*
>
> **Client Priority:** 🟠 High | **Client Impact:** ⬛⬛⬛ High - All Users - 100%
>
> **Meeting 1 Review (March 2026):** Referenced during #9 discussion. Collapsible, consistent filter panels should be applied across all pages, using NQMS assessment search as the model.
>
> **Next Step:** Include in T-shirt size estimation pass. Bundle with #9 filter alignment work.
>
> **REFINED SCOPE:**
> - Make all filter panels collapsible across all pages (Searches, Inquiries, Affiliates, Programs, Accounts)
> - Standardize filter UI using NQMS assessment search as the model
> - Add breadcrumb navigation consistently across all sections
> - Bundle with #9 filter alignment work
>
> **Readiness:** ✅ Ready to estimate

---

### 5. Password Reset & Login UX ✅ `REVIEWED — Meeting 1, March 25, 2026`


**Current Issues:**
- Password reset process UI needs improvement
- Related emails have poor UX
- When new Program is submitted, admin must go through reset password workflow to access system
- Confusing onboarding experience for new program admins

**Proposed Solutions:**
- Improve UI for reset password process
- Enhance password reset emails for clarity
- Streamline new program admin account creation workflow
- Better onboarding experience for first-time users

**User Impact:** New program administrators, users who need password resets

> **CLIENT FEEDBACK:**
> *(No comment provided)*
>
> **Client Priority:** 🔴 Critical | **Client Impact:** ⬛⬛⬛ High - All Users - 100%
>
> **Meeting 1 Review (March 2026):** Sandy reported ongoing user confusion despite the process being straightforward. The required mobile number field during password reset was questioned — Hyun explained it was future-proofing for MFA. Sandy confirmed MFA is unlikely, so phone number requirement should be removed. However, Beth demonstrated she could reset her password without being prompted for a phone number, creating uncertainty about whether the issue is role-dependent.
>
> **Next Step:** Aksana to investigate the current password reset flow — determine why/when the phone number is required, whether it varies by role, and document the actual current UX before proposing changes.
>
> **REFINED SCOPE:**
> - Investigate and document current password reset flow (phone number requirement varies by role?)
> - Remove mobile number requirement if MFA is not planned
> - Improve password reset email clarity
> - Streamline new program admin onboarding (account creation after program submission)
>
> **Readiness:** ✅ Ready to estimate — Aksana needs to investigate current flow first, but this is a quick investigation, not a full discovery session

---

### 6. Navigation & Hyperlink Improvements ✅ `REVIEWED — Meeting 1, March 25, 2026`


**Current Issues:**
- "Affiliate Region" column in Browse Programs is not clickable
- Program names in Affiliate Program Service Areas are not hyperlinked
- Users cannot quickly navigate to related records
- Extra clicks required to view related information

**Proposed Solutions:**
- Make "Affiliate Region" column a clickable link to Affiliate Region page
- Hyperlink program names in Program Service Areas for direct navigation
- Add hyperlinks throughout system where contextually appropriate
- Reduce navigation friction

> **CLIENT FEEDBACK:**
> *(No comment provided)*
>
> **Client Priority:** 🔴 Critical | **Client Impact:** ⬛⬛⬛ High - All Users - 100%
>
> **Meeting 1 Review (March 2026):** Sandy confirmed critical — NQMS side already has good hyperlink navigation and MC side should match. All entity names (programs, affiliates, assessments) should be clickable links to their respective pages.
>
> **Next Step:** Include in T-shirt size estimation pass. Likely a small effort item that can be bundled.
>
> **REFINED SCOPE:**
> - Make all entity names (programs, affiliates, assessments) clickable links to their respective pages
> - Match the hyperlink navigation pattern already established on the NQMS side
> - Specific: "Affiliate Region" column in Browse Programs, program names in Affiliate Program Service Areas
>
> **Readiness:** ✅ Ready to estimate — small effort, can bundle with other UI items

---

### 7. Program Status Visibility ✅ `REVIEWED — Meeting 3, May 20, 2026`


**Current Issues:**
- Program status badges not definitive enough
- Difficult to quickly identify program status at a glance
- Visual hierarchy could be improved

**Proposed Solutions:**
- Use more definitive UI status badges for program status
- Color coding and visual indicators for different statuses
- Clear visual distinction between Approved, Paused, Pending, Deleted
- Improved at-a-glance program status identification

> **CLIENT FEEDBACK — Meeting 3 (May 20, 2026):**
>
> **Scope defined — ready for estimation.** Aksana demoed a prototype with visual badges/tiling similar to NQMS assessment statuses.
>
> **Decisions:**
> - Add visual badges/tiling to program statuses in both list view and detail view
> - Rename "Deleted" status to **"Archived"** throughout the system (consistent with Meeting 2 decision)
> - Archived programs remain **searchable and filterable by admins** on the back end, excluded from public search
> - Add a **notes/reason field** for archival — Sandy: "There should be a note somewhere why... a lot of times I'm not even sure why it is in deleted status"
> - Archival should be a **dedicated action** (not just a status flip) — prompt for reason, then save
> - Programs must be **restorable** from archived status back to active
> - Archive reason valuable for auditing and NQMS side (programs that close mid-assessment)
>
> **Next Step:** Estimate. Scope is: visual status badges, rename Deleted→Archived, add archive reason field, ensure archived programs are admin-searchable. This also covers #28 (Program Archive & Lifecycle Management).
>
> **Client Priority:** 🟢 Low | **Client Impact:** ⬛⬛⬛ High - All Users - 100%
>
> **REFINED SCOPE:**
> - **Archive button on Browse Programs (index) page** — allows archiving a program directly from the list without navigating to the detail page
> - **Archive button on Program View (detail) page** — same action, available in context
> - **Archive confirmation dialog** — clicking Archive opens a confirmation with a required "Reason for archiving" text field, plus Proceed and Cancel buttons
> - **Rename "Deleted" status to "Archived"** throughout the system (database value, UI labels, filters)
> - **Status filter on Browse Programs** — users can filter by Archived status to find archived programs
> - **Archive reason displayed on Program Detail page** — when a program has status Archived, show the reason why it was archived
> - Archived programs remain searchable/filterable by admins, excluded from public search (already the case — public search only shows approved)
> - Programs must be restorable from archived status back to active
> - Covers #28 (Program Archive & Lifecycle Management)
>
> **Readiness:** ✅ Ready to estimate

---

### 8. Badge Management ✅ `REVIEWED — Meeting 1, March 25, 2026`


**Current Issues:**
- Cannot reorder badges
- Fixed badge order may not reflect desired priority

**Proposed Solutions:**
- Enable ability to reorder badges
- Drag-and-drop or numbering system for badge ordering
- Flexible badge display priority

> **CLIENT FEEDBACK:**
> *(No comment provided)*
>
> **Client Priority:** 🟢 Low | **Client Impact:** ⬛⬛⬛ High - All Users - 100%
>
> **Meeting 1 Review (March 2026):** Badges follow a tiered progression (bronze → silver → gold) and should be swapped, not stacked. Current checkboxes should be changed to radio buttons (one badge at a time). Mike to confirm with Sarah that badges are used as a tier/replacement system. Sandy raised whether LMS badge concepts should be tied in — needs follow-up.
>
> **Next Step:** Include in T-shirt size estimation pass. Low priority but likely low effort — good candidate for bundling. Aksana to look into LMS badge connection. Mike to confirm badge usage model with Sarah.
>
> **REFINED SCOPE:**
> - Change badge checkboxes to radio buttons (one badge at a time — tier/replacement system, not stacking)
> - Enable badge reordering (drag-and-drop or numbering)
> - Pending: Mike to confirm badge usage model (tier/replacement) with Sarah
>
> **Readiness:** ✅ Ready to estimate — low effort, minor pending confirmation from Mike won't change scope significantly

---

### 9. Admin Program Search & Discovery Enhancements ✅ `REVIEWED — Meeting 1, March 25, 2026`


**Current Issues:**
- Admin-facing search functionality has known gaps and limitations
- Limited search capabilities for finding specific program data within the system
- **Cannot filter by Program Delivery type (Community-based, Site-based, E-mentoring)**
- E-mentoring only programs get "lost" in the system
- No visibility into programs by delivery type for Global Admins
- Difficult to identify and manage programs that don't fit traditional geographic affiliate model
- Browse Programs page has fewer filtering options than the NQMS Assessment search page

**Proposed Solutions:**
- Improve admin-facing search functionality on Browse Programs page
- Align Browse Programs filtering capabilities with the richer filtering already available on the NQMS Assessment search page
- Enhanced search filters and parameters, including:
  - **Program Delivery type filter (Community-based, Site-based, E-mentoring)**
  - Program characteristics filters
  - Age range filters
  - Zip code search with layered filters
- Better search results presentation
- Make filter panels collapsible and consistent with other pages (see #4)

> **CLIENT FEEDBACK:**
> *(No comment provided)*
>
> **Client Addition to Proposed Solutions:** Request to improve the search results program page – there was an issue where you can't add bullets to the description
>
> **Client Priority:** 🔴 Critical | **Client Impact:** ⬛⬛⬛ High - All Users - 100%
>
> **Meeting 1 Discussion (March 2026):** Agreed this item should focus on admin/internal search only. Public-facing search split into separate item #26. Beth noted the NQMS assessment search page already has richer filtering that should serve as the model for Browse Programs.
>
> **Next Step:** Include in T-shirt size estimation pass. Scope the filter alignment work using NQMS assessment search as the reference implementation.
>
> **REFINED SCOPE:**
> - Align Browse Programs filtering with NQMS assessment search (reference implementation)
> - Add filters: program delivery type, program characteristics, age range, ZIP code search
> - Make filter panels collapsible and consistent (ties into #4)
> - Admin/internal search only — public search split to #26
>
> **Readiness:** ✅ Ready to estimate

---

### 10. Public-Facing Site Improvements 🔒 `DEFERRED — Meeting 3, May 20, 2026`


**Current Issues:**
- Public site promoted for families to find mentoring opportunities
- Focus primarily on adult mentor recruitment
- Mentee functionality is limited (workaround directs to contact programs)
- Doesn't fully address mentee discovery needs
- Programs with long waitlists may hesitate to be listed

**Proposed Solutions:**
- Make public site more inclusive for mentees
- Clearer communication about volunteer vs. mentee pathways
- Address program concerns about waitlists and capacity
- Leverage unmet needs data for capacity building and advocacy
- Improve messaging about what the tool offers to different audiences

> **CLIENT FEEDBACK — Meeting 3 (May 20, 2026):**
>
> **Deferred — pending MENTOR internal strategy discussion.**
>
> The public search page conflates two distinct user needs: "become a mentor" vs. "find a mentor/mentee for me or someone else." Sandy noted the second option was added as a hack, never an intentional strategic decision. Mike shared a longer-term vision: Mentor Connector as a **multi-use directory** serving mentors, caregivers/parents, funders, researchers, and potentially young people directly. Mike raised **liability concerns** about minors accessing the system. Sandy proposed a **landing page** that routes users by intent.
>
> **Decisions:**
> - Defer search page redesign until MENTOR internally aligns on scope and audiences
> - No technical changes until strategy is clarified
> - Search algorithm changes (#27) will proceed independently
>
> **Next Step:** MENTOR to hold internal strategy discussion on search page audiences and purpose. Revisit after alignment.
>
> **Client Priority:** 🟡 Medium | **Client Impact:** —
>
> **REFINED SCOPE:**
> - N/A — deferred pending MENTOR internal strategy alignment
>
> **Readiness:** 🔒 Deferred — blocked on MENTOR internal discussion about search page audiences and purpose

---

### 11. Assessment History & Multi-Assessment Support ✅ `REVIEWED — Meeting 1, March 25, 2026`


**Current Issues:**
- System currently doesn't support multiple assessments per program
- Programs approaching 3-year mark need to complete second assessments
- No way to complete an assessment and start a new cycle while maintaining access to all historical data
- Cannot view past assessments to analyze progress over time
- Unable to compare ratings across assessment cycles
- Cannot reference previous goals when setting new assessment goals
- No timeline view of all assessment cycles for a program
- No clear distinction between active and closed assessments
- **Timeline:** This is a ticking clock item - needed soon as early adopters reach reassessment window

**Proposed Solutions:**
- **Multiple Assessments Per Program:** Support many assessments per program, with only 1 active at a time
- **Close and Open Assessments:** Clear workflow for closing an assessment and opening a new one
- **Visibility:** Dashboard/list view showing Active and Closed assessments for each program
- **Historical Access:** Access to view all past assessments for a program
- **Comparison Tools:**
  - Historical assessment data viewer/comparison tool
  - Side-by-side assessment comparison
  - Progress charts showing improvement over time
- **Goal Reference:** Ability to reference past assessment data when setting new goals
- **Reporting:** Reports should pull from active assessment only, with option to view historical reports
- **Timeline View:** Timeline showing all assessment cycles for a program

**Business Impact:** HIGH - Critical for tracking program progress over time and demonstrating measurable improvements to funders

**Note:** NQMS side has recently added an archiving feature that could serve as a model for other archival needs in the system.

> **CLIENT FEEDBACK:**
> *(No comment provided)*
>
> **Client Priority:** 🔴 Critical | **Client Impact:** ⬛⬛◻ Medium - Most Users, More than 70%
>
> **Meeting 1 Review (March 2026):** Confirmed as the **#1 priority on the NQMS side** by Mike. Foundation exists for multiple assessments but UI lacks lifecycle workflow (no close/complete trigger, no historical visibility). Mike requested a third assessment state beyond "active" and "archived" — something like "historical" that remains accessible for reporting, sharing with programs, and aggregate trend analysis. Valuable both at individual program level and for longitudinal research.
>
> **Next Step:** Aksana to scope this item, develop solution options, and prepare a list of questions for Mike. Schedule a dedicated breakout/discovery session before finalizing solution and estimate. This is too complex for T-shirt sizing alone.
>
> **REFINED SCOPE:**
> - Support multiple assessments per program (only 1 active at a time)
> - Close/complete workflow for finishing an assessment cycle and opening a new one
> - Third assessment state beyond "active" and "archived" — "historical" for completed assessments that remain accessible
> - Historical access: view past assessments, reference previous goals when setting new ones
> - Reporting: pull from active assessment by default, option to view historical
> - Ties into #30 (goal status cleanup on cycle completion)
> - OUT OF SCOPE (for now): Side-by-side comparison tools, progress charts, timeline view — these are nice-to-haves that can come later
>
> **Readiness:** 🔍 Needs discovery session with Mike — too complex for T-shirt sizing. Aksana to prepare solution options and questions.

---

### 12. NQMS Assessment Workflow Improvements ✅ `REVIEWED — Meeting 1, March 25, 2026`


**Current Issues:**
- "Edit Assessment" button on Program Details page disrupts consistent workflow
- Should follow: Program → View Assessment → Delete/Edit/View goals
- "Export Assessment Goals" button for approved assessments may not be needed
- "Notes" field label unclear about purpose

**Proposed Solutions:**
- Remove "Edit Assessment" button from Program Details; only display "View Assessment"
- Ensure consistent user flow throughout assessment process
- Reevaluate need for "Export Assessment Goals" button for approved assessments
- Update "Notes" field label to: "Notes (Why did you rate yourself at the above score or give yourself an NA?)"
- Clear guidance on purpose of each field

> **CLIENT FEEDBACK:**
> *(No comment provided)*
>
> **Client Priority:** 🟡 Medium | **Client Impact:** ⬛⬛◻ Medium - Most Users, More than 70%
>
> **Meeting 1 Review (March 2026):** Agreed this is minor cleanup — redundant buttons and breadcrumb inconsistencies. Low effort, nice to have. Confirmed not blocked by #24 (SharePoint migration), which only changes backend file storage.
>
> **Next Step:** Include in T-shirt size estimation pass. Likely small effort — good candidate for bundling with other quick wins.
>
> **REFINED SCOPE:**
> - Remove "Edit Assessment" button from Program Details page (keep only "View Assessment")
> - Fix breadcrumb inconsistencies in assessment flow
> - Reevaluate "Export Assessment Goals" button for approved assessments
> - Update "Notes" field label to clarify purpose
>
> **Readiness:** ✅ Ready to estimate — small effort, bundle with other NQMS quick wins

---

### 13. NQMS Assessment Question Management ✅ `REVIEWED — Meeting 1, March 25, 2026`


**Current Issues:**
- No ability to delete assessment questions
- File upload help text appears in NQMS assessments, but file uploads not supported
- All "Other" checkboxes don't consistently require explanatory text in comments

**Proposed Solutions:**
- Add ability to delete assessment questions
- Remove "file upload help text" from NQMS assessments
- Ensure all "Other" checkboxes require explanatory text in comments for consistency
- Cleaner question management interface

> **CLIENT FEEDBACK:**
> *(No comment provided)*
>
> **Client Priority:** 🟡 Medium | **Client Impact:** ⬛⬛⬛ High - All Users - 100%
>
> **Meeting 1 Review (March 2026):** Focused on file upload help text issue. Mike clarified file uploads were moved to the program profile (all documents uploaded at end, not per-question), but old instructional text referencing per-question uploads still exists and needs scrubbing. Mike said he should have rated this higher than medium — confusing instructions in the assessment is a real problem. Aksana characterized this as a "super minor, just text change."
>
> **Next Step:** Small text change — scrub outdated file upload help text from NQMS assessments. Can likely be done as a quick fix without further scoping.
>
> **REFINED SCOPE:**
> - Scrub outdated file upload help text from NQMS assessments (text references per-question uploads that were moved to program profile)
> - Quick text fix — no structural changes
>
> **Readiness:** ✅ Ready to estimate — trivial effort, quick fix

---

### 14. NQMS Reviewer Progress Tracking ✅ `REVIEWED — Meeting 1, March 25, 2026`


**Current Issues:**
- No way for reviewers to visually track changes or progress within assessment
- Cannot remember last completed section/question
- Difficult to resume review where left off
- No visual indicators of review progress

**Proposed Solutions:**
- Provide visual progress tracking for reviewers
- Remember last completed section/question
- Show which sections/questions have been reviewed
- Visual indicators for completed vs. pending review items
- Improve reviewer efficiency and reduce duplicate work

> **CLIENT FEEDBACK:**
> *(No comment provided)*
>
> **Client Priority:** 🟡 Medium | **Client Impact:** ⬛⬛⬛ High - All Users - 100%
>
> **Meeting 1 Review (March 2026):** Agreed on concept: visual indicators (red/yellow/green or icons like red exclamation points) on collapsed assessment sections to show completion status on landing — without requiring the user to open each section or attempt submission. Currently, validation errors only appear when you try to submit. Mike considered bumping to high priority but left at medium, saying cost/effort would be the real decision factor.
>
> **Next Step:** Include in T-shirt size estimation pass. Priority decision depends on effort estimate — if small, worth including; if medium/large, may defer.
>
> **REFINED SCOPE:**
> - Visual indicators (red/yellow/green or icons) on collapsed assessment sections showing completion status
> - Visible on the assessment landing page without opening each section or attempting submission
> - Currently validation errors only appear on submit — this surfaces them proactively
>
> **Readiness:** ✅ Ready to estimate — priority decision depends on effort estimate

---

### 15. Full Data Export for Research ✅ `REVIEWED — Meeting 1, March 25, 2026`


**Current Issues:**
- No comprehensive export showing full assessment history
- Cannot export improvements/re-ratings over time
- Current exports don't capture complete picture for statistical analysis
- No longitudinal data export capability
- External researchers cannot access data in format needed for analysis
- Missing data dictionary/codebook for researchers

**Proposed Solutions:**
- Wide-format CSV with one row per program
- All assessment cycles (Assessment 1, Assessment 2, etc.)
- Baseline and improved ratings for each question
- Goal tracking across assessments
- Mentor Connector program data included
- Data dictionary/codebook for researchers
- Format optimized for SPSS, R, Stata
- "Export All" button for comprehensive data extraction

**Business Impact:** CRITICAL - Essential for planned evaluation work, research teams, and demonstrating measurable impact to funders

**Customer Quote:** _"We don't have an export all button so I can't give you that... external researchers... were like, Oh could we just do an export of the data?"_

> **CLIENT FEEDBACK:**
> *(No comment provided)*
>
> **Client Priority:** 🟠 High | **Client Impact:** —
>
> **Meeting 1 Review (March 2026):** **Deprioritized for now.** Mike wants assessment data combined with program profile data (kids served, program model, etc.) in CSV format for researchers using SPSS/Stata. Agreed on interim approach: Orases provides ad-hoc CSV data exports via SQL query on request rather than building a full in-tool export. Mike will know more in 3-4 months when the evaluation plan is fleshed out.
>
> **Next Step:** No immediate development needed. Orases to fulfill ad-hoc data export requests as they come in. Revisit in ~3-4 months (June/July 2026) when Mike has clarity on the evaluation plan and researcher data requirements.
>
> **REFINED SCOPE:**
> - N/A — deprioritized. Interim approach: Orases provides ad-hoc CSV exports via SQL on request
> - Revisit June/July 2026 when evaluation plan is defined
>
> **Readiness:** 🔒 Deferred — revisit after Mike's evaluation plan is defined (~June/July 2026)

---

### 16. Automation & Engagement Features ✅ `REVIEWED — Meeting 3, May 20, 2026`


**Current Issues:**
- No automated reminders for programs to update profiles
- Manual effort required for all data maintenance outreach
- No automated engagement to drive profile currency
- Heavy reliance on manual intervention for routine tasks

**Proposed Solutions:**
- Automated email reminders (similar to e-commerce cart abandonment emails):
  - Programs that haven't updated in 6 months
  - Incomplete profile completion prompts
  - Seasonal engagement (peak search season: August-October)
- Automated status changes for inactive programs
- AI-powered reminders and engagement
- Reduced manual intervention where possible

**Context:** Peak searches and inquiries occur between August and October (start of school year), presenting opportunity for targeted automated campaigns.

> **CLIENT FEEDBACK — Meeting 3 (May 20, 2026):**
>
> **Scope defined — multiple components, ready for estimation.**
>
> **Inquiry Reminders (highest priority):**
> - Currently programs receive only one email when someone inquires — if ignored or bounced, inquiry sits pending indefinitely
> - Mike: "if someone's got an inquiry from a volunteer sitting there for weeks on end... I would love the system to be like, 'Hey, you had someone want to volunteer. Could you please address this?'"
> - Agreed on **automated reminder emails** for pending inquiries (cadence TBD — likely after X days/weeks)
>
> **Profile Update Prompts (lower priority):**
> - At least once a year, ping programs to review profiles; Mike could be talked into quarterly
> - Sandy compared it to Amazon cart abandonment emails
> - May not need to be automated — could be a manual mass email blast
>
> **Automated Status Changes:**
> - Sandy proposed: no login + no activity for 6 months → auto-change to inactive/pending
> - Mike cautioned: some programs legitimately don't log in — inactivity alone isn't always a red flag
> - Group leaned toward **automated with notification** — send reminders first, then auto-change status if no response
> - Bounced emails from automated sends would serve as a signal of dead accounts
>
> **Next Step:** Estimate. Define specific trigger conditions, email cadences, and the automated-vs-report approach for status changes.
>
> **Client Priority:** 🔴 Critical | **Client Impact:** ⬛⬛⬛ High - All Users - 100%
>
> **REFINED SCOPE:**
> - **Inquiry reminders (highest priority):** Automated reminder emails for pending inquiries after X days/weeks (cadence TBD)
> - **Profile update prompts (lower priority):** Annual or semi-annual ping to programs to review profiles — may be manual mass email rather than automated
> - **Automated status changes:** No login + no activity for 6 months → send reminders first, then auto-change to inactive/pending if no response. Bounced emails serve as dead account signal
> - Cadence and trigger conditions need to be defined during estimation
>
> **Readiness:** ✅ Ready to estimate — directional scope is clear, specific cadences can be defined during detailed estimation

---

### 17. Data Field Enhancements ✅ `REVIEWED — Meeting 1, March 25, 2026`


**Current Issues:**
- Organization field ("BBBS concept") was discontinued in 2023 launch
  - Originally intended for overarching organization structure
  - Led to confusion and underutilization
  - Users listed national affiliations instead of local ones
- Missing field for national affiliation tracking
- Need for separate field to track affiliate membership vs. program details

**Proposed Solutions:**
- Document historical decision about organization field removal
- Determine if/how to track organizational hierarchies
- Add dedicated field for national affiliation if needed
- Clarify data structure to prevent future confusion
- Consider implications if data merging occurs

**Historical Context:** The organization field was removed from program forms during 2023 relaunch due to confusion and data quality issues. Need to document this decision for future reference.

> **CLIENT FEEDBACK:**
> *(No comment provided)*
>
> **Client Priority:** 🟡 Medium | **Client Impact:** ⬛◻◻ Low - Some Users, Less than 40%
>
> **Meeting 1 Review (March 2026):** Sandy flagged this for deeper discussion in Meeting 2. The organization field was removed due to misuse, but MENTOR does have a legitimate need for organizational hierarchy tracking. Needs design discussion to understand the use case and proper implementation before proceeding.
>
> **Next Step:** Discuss in Meeting 2 (April 9, 2026). Sandy to clarify the use case and requirements for organizational hierarchy tracking.
>
> **REFINED SCOPE:**
> - Organization field exists in DB and on public form but was removed from admin view due to misuse
> - Meeting 3 deferred this — "too complex, zero organizations in production, would require defining parent-child relationships"
> - Revival would help with duplicate detection (#3) and parent-child program relationships
> - Would need: management UI for organizations, parent-child relationship model, data cleanup
>
> **Readiness:** 🔒 Deferred — too complex for current scope. Revisit if/when duplicate detection (#3) or CRM sync needs drive it

---

### 18. Program Admin Permission Enhancements ✅ `REVIEWED — Meeting 3, May 20, 2026 (No dev needed)`


**Current Issues:**
- Program Admins cannot self-pause their programs (must contact support)
- Program Admins cannot access Affiliate module or NQMS when appropriate
- Limited self-service capabilities create support bottleneck

**Proposed Solutions:**
- Allow Program Admins to self-pause programs
- Require Affiliate or Global Admin to unpause (prevents accidental activation)
- Grant Program Admins access to Affiliate module and NQMS as appropriate
- Reduce dependency on support for routine actions

**Impact:** Reduces support requests and empowers program administrators.

> **CLIENT FEEDBACK — Meeting 3 (May 20, 2026):**
>
> **Descoped — no development needed.** The original "self-pause" request was likely about stopping inquiries, which is already possible via mentor/mentee acceptance checkboxes.
>
> **Decisions:**
> - Program admins should **NOT** have access to change program status (approved/paused/archived/pending)
> - Program admins **can and should** toggle the mentor/mentee acceptance checkboxes to control inquiry flow
> - Status changes remain the responsibility of **affiliate admins and global admins** — Tim raised data integrity concern about unsupervised status changes
> - Sandy: "I'm not married to this at all... if it's nothing that we think doesn't bring value, then I'm okay with scratching it off"
>
> **Next Step:** No development. Ensure training communicates how program admins can toggle inquiry acceptance. May need minor UX improvement to make the toggle more discoverable.
>
> **Client Priority:** 🟠 High | **Client Impact:** ⬛◻◻ Low - Some Users, Less than 40%
>
> **REFINED SCOPE:**
> - No development needed — descoped
> - Possibly minor UX improvement to make mentor/mentee acceptance toggles more discoverable for program admins
>
> **Readiness:** ✅ No estimate needed — descoped (possibly trivial UX tweak)

---

### 19. Affiliate Management UX Improvements ✅ `REVIEWED — Meeting 3, May 20, 2026`


**Current Issues:**
- "Global Admin" field appears on Affiliate edit page (may not be needed)
- Unclear if Affiliates should be able to create their own Affiliate records
- Updating postal codes has cumbersome UX (difficult deselection process)
- Program Delivery filter not available to Affiliates and Global Admin

**Proposed Solutions:**
- Consider removing "Global Admin" field from Affiliate edit page
- Decide if Affiliates should be able to create their own Affiliate records
- Improve UX for updating postal codes (simplify deselection process)
- Add ability for Affiliates and Global Admin to filter by Program Delivery
- Streamline affiliate administration workflows

> **CLIENT FEEDBACK — Meeting 3 (May 20, 2026):**
>
> **Multiple sub-items scoped — ready for estimation.**
>
> **ZIP Code / Service Area Management:**
> - Current interface is cumbersome — Sandy: "It was a very complicated process"; editing is essentially "start over every time"
> - Aksana demoed a prototype: select state → optionally drill into county → see ZIP codes listed → select/deselect with checkboxes, bulk select all
> - Need to support multiple counties and cross-state affiliates (e.g., Georgia/Florida)
> - Sandy noted service area creation/editing is rare — most set up during migration; priority is moderate
>
> **Remove "Global Administrator" field** — No one could recall its purpose. Confirmed: remove it.
>
> **Replace "Programmatic Contact" with primary contact toggle** — Field is mostly empty in production. Tim suggested marking one existing admin as "primary contact" via radio button instead of a separate field. Agreed.
>
> **Remove "Trained" checkbox** — Only 9 affiliates have it checked. Sandy: "I don't think that thing means anything." Remove it.
>
> **Add program characteristic filters to internal program search** — NQMS search has detailed filters that general program browse does not. Mike: "I would like to see this applied to the general program search." Also add **ZIP code search** — Sandy: "So crazy that a system based on ZIP codes, I can't search by ZIP code."
>
> **Next Step:** Estimate. Sandy to provide cleanup data for programmatic contact. Aksana to scope service area UX rework and filter enhancements.
>
> **Client Priority:** 🟠 High | **Client Impact:** ⬛◻◻ Low - Some Users, Less than 40%
>
> **REFINED SCOPE:**
> - **ZIP code / service area management UX rework:** Select state → drill into county → see ZIP codes → select/deselect with checkboxes, bulk select all. Support multiple counties and cross-state affiliates
> - **Remove "Global Administrator" field** from affiliate edit page
> - **Replace "Programmatic Contact" with primary contact toggle** — radio button on existing admin list instead of separate field
> - **Remove "Trained" checkbox** from affiliates (only 9 have it checked, meaningless)
> - **Add program characteristic filters and ZIP code search** to internal program search (align with NQMS search — ties into #9)
>
> **Readiness:** ✅ Ready to estimate — multiple small sub-items with clear scope

---

### 20. Affiliate Deletion & Inactivation Management ✅ `REVIEWED — Meeting 3, May 20, 2026`


**Current Issues:**
- Affiliate can be marked "inactive" but behavior is unclear and inconsistent
- When Affiliate is marked inactive but still has zip codes assigned under Service Area, programs remain assigned to that Affiliate
- No clear way to delete an Affiliate
- No automated handling of program assignments when Affiliate is inactivated
- Users must manually uncheck all zip codes to detach programs from inactive Affiliate
- "Inactive" status doesn't prevent program-to-affiliate matching via Service Area zip codes
- Confusion about what "inactive" should do vs. what it actually does
- No clear workflow for decommissioning an Affiliate

**Real-World User Feedback:**
- _"What is the function of marking an Affiliate 'inactive'? It looks like when it is marked inactive but still has zip codes assigned under Service Area, the programs are still assigned to that Affiliate. Should we be removing the Service Area zip codes in addition to marking it 'inactive'?"_
- _"I set it to inactive and the program still show it was affiliated. To remove from it, I had to uncheck the zip code (02861). Where exactly can you delete an affiliate region, is that a new button or process?"_

**Decision Points:**
Need to determine the desired behavior and implementation approach:

**Option 1: Auto-Remove Service Areas on Inactivation**
- When Affiliate is marked inactive, automatically remove all Service Area zip codes
- This detaches all programs from the Affiliate immediately
- Pros: Clear separation, no orphaned assignments
- Cons: Data loss if Affiliate needs to be reactivated

**Option 2: Change Matching Logic**
- Keep Service Area zip codes intact when Affiliate marked inactive
- Update program-to-affiliate matching logic to only match active Affiliates
- Programs would no longer show affiliation to inactive Affiliates
- Pros: Preserves Service Area configuration for potential reactivation
- Cons: More complex logic, potential for confusion about why programs aren't matching

**Option 3: Add Hard Delete Capability**
- Add ability to permanently delete an Affiliate
- Require confirmation and handling of dependent data
- Determine what happens to programs assigned to deleted Affiliate
- Consider soft delete vs. hard delete implications

**Proposed Solutions:**
- **Clarify "Inactive" Status Behavior:**
  - Define and document what "inactive" should do
  - Update UI to clearly communicate the effects of marking Affiliate inactive
  - Add warning/confirmation when marking Affiliate inactive

- **Implement Consistent Logic:**
  - Choose and implement one of the three options above
  - Update program-to-affiliate matching logic accordingly
  - Ensure Browse Programs reflects correct affiliations based on active status

- **Add Delete Capability (if needed):**
  - Determine if hard delete is required or if inactive status is sufficient
  - If delete is needed, add "Delete Affiliate" functionality
  - Implement safeguards (confirmation, check for dependent data)
  - Document impact on programs and Service Areas

- **Improve User Experience:**
  - Add confirmation dialogs explaining what will happen to programs
  - Provide clear workflow for decommissioning an Affiliate
  - Consider bulk Service Area removal option if Option 1 is not implemented
  - Add audit trail for Affiliate status changes

**Business Impact:** MEDIUM - Affects Affiliate lifecycle management and data integrity

**User Impact:** Affiliate Admins, Global Admins managing Affiliate records

**Pages Affected:** Browse Affiliates, Edit Affiliate, Program assignment logic

**Related:** See #1 (User Account Management) for similar deletion/inactivation needs for user accounts.

> **CLIENT FEEDBACK — Meeting 3 (May 20, 2026):**
>
> **Solution agreed — ready for estimation.** Group chose a hybrid of Option 1 and Option 2.
>
> **Decisions:**
> - When an affiliate is marked inactive, **unlink all programs** from that affiliate but **preserve service areas** (for potential reactivation)
> - No hard delete of affiliates — inactive status is sufficient
> - Unlinked programs should automatically move to the **national affiliate** (safety net — see #21)
> - Show a **warning message** when deactivating: "This will unlink X programs from this affiliate"
> - Tim: "There are two or three affiliates in here right now that still... who knows where those inquiries are going anymore"
> - Sandy showed a production affiliate she marked inactive a year ago — service areas and programs are still assigned
>
> **Next Step:** Estimate. Implement unlinking logic tied to inactive status change.
>
> **Client Priority:** 🟠 High | **Client Impact:** ⬛⬛◻ Medium - Most Users, More than 70%
>
> **REFINED SCOPE:**
> - When affiliate is marked inactive: unlink all programs from that affiliate (programs move to national affiliate — #21)
> - Preserve service areas on inactive affiliate (for potential reactivation)
> - No hard delete of affiliates — inactive status only
> - Show warning message when deactivating: "This will unlink X programs from this affiliate"
> - Depends on #21 (National Affiliate) being in place first
>
> **Readiness:** ✅ Ready to estimate — clear scope, depends on #21 being implemented first

---

### 21. National Affiliate for Orphan Programs (Safety Net Approach) ✅ `REVIEWED — Meeting 3, May 20, 2026`


**Current Issues:**
- "Orphan programs" exist - programs not assigned to any affiliate because their zip codes don't match any affiliate's service area coverage
- Programs are currently assigned to affiliates by matching program zip codes with affiliate service area zip codes
- New capability to give affiliate users scoped/limited access to single programs doesn't work for orphan programs (no parent affiliate)
- Approximately 750 orphan programs identified (as of January 2026)
- No easy way to search/filter for programs without affiliate assignment
- Current workaround requires manually creating affiliate and adding all orphan program zip codes to affiliate's service area
- Maintaining orphan program assignments is time-consuming when affiliates change or new programs are added
- When affiliates become inactive or zip codes need to be transferred, requires unchecking/rechecking potentially hundreds of zip codes
- Quarterly zip code updates require manual maintenance for orphan programs

**Proposed Solutions:**

**Option A: Manual/Script Approach (Temporary)**
- Create "Mentor National" affiliate
- Run script to identify all orphan programs
- Manually add their zip codes to the national affiliate's service area coverage
- Requires ongoing maintenance: monthly/quarterly updates as programs change
- Time-consuming to maintain when affiliates deactivate or programs move

**Option B: Programmatic Safety Net Approach (Recommended)**
- Create "Mentor National" or "Global" affiliate with special behavior
- Treat this affiliate as a "unicorn" - system exception with different matching logic
- **Key Feature:** Does not match on zip code coverage at all
- Automatically captures any program that doesn't match any other affiliate's service area
- Acts as a "safety net" - "everybody who didn't get a home will land in the safety net"
- No need to specify or maintain service areas for this affiliate
- Automatically handles:
  - Programs with invalid/incorrect zip codes
  - Programs in states without affiliate coverage
  - Programs when affiliates become inactive
  - New programs in unaffiliated areas
- Eliminates need for constant manual zip code updates
- Provides visibility into programs that may have data quality issues (wrong zip codes)

**Implementation Details (Option B):**
- System checks program zip code against all active affiliates' service areas
- If match found → assign to that affiliate(s) (existing behavior)
- If no match found → automatically assign to National/Global affiliate (new behavior)
- Programs can still be assigned to multiple affiliates if zip codes match multiple service areas
- National affiliate acts as catch-all for unmatched programs

**Benefits of Safety Net Approach:**
- Ensures every program has an affiliate (no orphans)
- Enables scoped affiliate access feature to work for all programs
- Reduces manual administrative burden
- Self-healing: catches programs with data entry errors automatically
- No need to update zip codes when affiliates change status
- Provides data quality visibility (programs in National affiliate may indicate zip code issues)
- Scales automatically as new programs are added

**Business Impact:** MEDIUM-HIGH - Enables new affiliate permission features, reduces administrative burden, improves data quality

**User Impact:** Affiliate Admins, Global Admins, Program Admins

**Pages Affected:** Browse Programs, Affiliate service area management, Program assignment logic

**Related:**
- See #20 (Affiliate Deletion & Inactivation Management) for related affiliate lifecycle issues
- See #9 (Program Search & Discovery Enhancements) for filtering by affiliate status

**Implementation Complexity:** MEDIUM - Requires changes to affiliate-to-program matching logic

**Quick Win Component:** Option A can be implemented immediately via script

**Strategic Component:** Option B provides long-term sustainable solution with reduced maintenance

> **CLIENT FEEDBACK — Meeting 3 (May 20, 2026):**
>
> **Requirements confirmed — ready for estimation.** Aksana demoed the prototype. Proceed with Option B (programmatic safety net).
>
> **Decisions:**
> - One and only one affiliate can be designated as the **national affiliate**
> - National affiliate has the same data structure as regular affiliates but **no service areas** — acts as a catch-all
> - All orphan programs automatically listed under the national affiliate
> - When an active affiliate is deactivated, its programs automatically shift to the national affiliate
> - National affiliate will not have a service areas tab
> - Already has robust requirements written (see `SupportingDocuments/Item21_NationalAffiliate_Complete.md` and `PRDs/Item21_NationalAffiliate_PRD.md`)
>
> **Next Step:** Estimate based on existing requirements document.
>
> **Client Priority:** 🟠 High | **Client Impact:** ⬛◻◻ Low - Some Users, Less than 40%
>
> **REFINED SCOPE:**
> - One and only one affiliate designated as the national affiliate
> - Same data structure as regular affiliates but no service areas — acts as catch-all
> - All orphan programs automatically listed under the national affiliate
> - When an active affiliate is deactivated, its programs automatically shift to the national affiliate
> - National affiliate will not have a service areas tab
> - Detailed requirements already written: `SupportingDocuments/Item21_NationalAffiliate_Complete.md` and `PRDs/Item21_NationalAffiliate_PRD.md`
>
> **Readiness:** ✅ Ready to estimate — robust requirements already documented

---

### 22. Form & Field Alignment Issues ✅ `REVIEWED — Meeting 3, May 20, 2026`


**Current Issues:**
- Backend program application form doesn't match front-end
- "Country" field in backend may not be displayed on front-end
- Field order and naming inconsistent between front-end and back-end forms
- "Other" option handling inconsistent (sometimes collects explanatory text, sometimes doesn't)
- No confirmation email sent to users upon program submission

**Proposed Solutions:**
- Align field order and naming between front-end and back-end forms
- Remove "Country" field if not displayed on front-end
- When "Other" is selected for program specifics, add conditional text field to collect explanation
- Send confirmation email upon program submission for consistency
- Review all form fields for front/back-end alignment

**Areas Affected:** Program application, program specifics, general form consistency

> **CLIENT FEEDBACK — Meeting 3 (May 20, 2026):**
>
> **Reviewed — extensive discussion. Blocked on MENTOR completing field inventory.**
>
> Aksana walked through both forms side by side. Key findings:
> - Labels differ: "Program Title" vs "Program Name", "Physical Address" vs "Program Address"
> - Public form has "Other" options with text boxes, but internal model only stores "Other" as checkbox — **context text is never saved**
> - Country field on public form is unnecessary (US-only programs)
> - Public form is better organized with section headers; internal form is one long page
>
> **Sub-decisions:**
> - **Duplicate name checking:** Current detection is exact case-sensitive only. Need **case-insensitive matching** and potentially additional fields
> - **Organization field:** Defer — too complex, zero organizations in production, would require defining parent-child relationships
> - **Rich text for descriptions:** Add rich text formatting — descriptions currently stripped to "big blob"
> - **Logo upload:** Add file size/dimension recommendations and potentially crop/resize tool
> - **"Other" options:** Review each field — remove where not needed (e.g., age ranges), add DB storage where valuable (e.g., youth served categories)
> - **Form validation:** Number fields allow negative numbers — needs fix
>
> **Next Step:** **MENTOR to complete program field inventory** using Sandy's existing spreadsheet, mark which fields display in public search. Aksana to estimate form alignment work once field list is finalized.
>
> **Client Priority:** 🟠 High | **Client Impact:** ⬛◻◻ Low - Some Users, Less than 40%
>
> **REFINED SCOPE:**
> - Align field order and naming between public and internal program forms
> - Case-insensitive duplicate name checking (currently exact case-sensitive only)
> - Add rich text formatting for program descriptions (currently stripped to plain text)
> - Add logo upload file size/dimension recommendations and potentially crop/resize tool
> - Review each "Other" option — remove where not needed, add DB storage where valuable
> - Fix number field validation (currently allows negative numbers)
> - Remove Country field from public form (US-only programs)
> - OUT OF SCOPE: Organization field (deferred — #17)
>
> **Readiness:** ⏳ Blocked — waiting on MENTOR's program field inventory (Sandy's spreadsheet). Cannot estimate until field list is finalized.

---

### 23. Inquiries Module Cleanup 🔒 `DEFERRED — Meeting 3, May 20, 2026`


**Current Issues:**
- "ROLE" field still exists in Inquiries
- Only mentor inquiries are processed (mentees contact programs directly)
- Unnecessary data collection

**Proposed Solutions:**
- Remove "ROLE" field from Inquiries module
- Simplify inquiry form to reflect actual use case
- Reduce data collection overhead

> **CLIENT FEEDBACK — Meeting 3 (May 20, 2026):**
>
> **Deferred — substantial redesign needed.** The inquiry masking/reveal process (admin sees masked email/phone until clicking "Contacted") is confusing. Sandy: "A lot of times people are confused. They can't find that information." Aksana: "It could be that it's just over-engineered for what it is."
>
> **Decision:** Defer detailed scoping to a **separate focused discussion**. This needs a redesign, not a cleanup.
>
> **Client Priority:** 🟢 Low | **Client Impact:** ◻◻◻ Minimal Impact - 10%
>
> **REFINED SCOPE:**
> - N/A — deferred. Needs a full redesign, not a cleanup. Separate focused discussion required.
> - Inquiry masking/reveal process is confusing and possibly over-engineered
>
> **Readiness:** 🔒 Deferred — needs separate focused discussion before scoping

---

### 24. SharePoint Migration for Document Storage 🔒 `DEFERRED — Meeting 3, May 20, 2026`


**Current Issues:**
- Documents stored on local file system
- Limited scalability and collaboration capabilities
- Backup/disaster recovery challenges
- Cannot leverage enterprise-grade storage features

**Proposed Solutions:**
- Migrate all program documents to Microsoft SharePoint Online
- Migrate NQMS assessment attachments to SharePoint
- Improve document management capabilities
- Enable better collaboration features
- Enterprise-grade storage infrastructure
- Maintain or improve upload/download performance

**Business Impact:** MEDIUM - Infrastructure improvement for scalability and reliability

**Complexity:** HIGH - Significant backend migration effort

**User Impact:** LOW (backend improvement, transparent to users if done correctly)

> **CLIENT FEEDBACK — Meeting 3 (May 20, 2026):**
>
> **Deferred — heavy infrastructure lift, current state is functional.**
>
> Not discussed in detail during Meeting 3. Previously identified as a future infrastructure improvement. Current file-based document storage works; migration would be transparent to users but requires significant backend effort.
>
> **Decision:** Defer to a future phase after higher-priority items are completed.
>
> **Client Priority:** 🟠 High | **Client Impact:** ⬛◻◻ Low - Some Users, Less than 40%
>
> **REFINED SCOPE:**
> - N/A — deferred. Heavy infrastructure lift, current state is functional.
>
> **Readiness:** 🔒 Deferred

---

### 25. Public Search Iframe & Rich Text Support ✅ `REVIEWED — Meeting 3, May 20, 2026 (blocked on MENTOR field inventory)`


**Current Issues:**
- **Public Search Iframe (Embedded Program Profile):**
  - Search iframe embedded in external sites is missing critical program data
  - 'The mentor role description' field not included in search API response
  - Logo size is not displaying correctly in iframe
  - Limited program information available to public searchers

- **Rich Text Formatting:**
  - Text areas throughout the site do not support enriched formatting
  - Program description and other text fields cannot display formatted text
  - No support for bold, italic, lists, links, or other formatting in text areas
  - Content is displayed as plain text only, reducing readability and engagement

**Proposed Solutions:**

**Phase 1: Search Iframe Data Completeness**
- Add 'The mentor role description' to public search API response
- Fix logo sizing issues in iframe display
- Ensure all relevant program fields are included in search results
- Test iframe display across different embedding sites

**Phase 2: Rich Text Editor Implementation**
- Implement rich text editor (e.g., CKEditor, TinyMCE, Quill) for program forms
- Add rich text support for relevant text areas:
  - Program description
  - Mentor role description
  - Other program detail fields that would benefit from formatting
- Support common formatting: bold, italic, underline, lists (ordered/unordered), hyperlinks
- Editor saves content as HTML to database
- Backend HTML sanitization for security (prevent XSS attacks)

**Phase 3: Display & Testing**
- Update display components to render HTML content properly
- Ensure iframe displays formatted HTML correctly
- Test formatting across all display contexts:
  - Program edit forms
  - Public search iframe display
  - Browse Programs view
  - Program detail pages
- Verify HTML sanitization is working correctly

**Business Impact:** MEDIUM - Improves public-facing program visibility and content richness

**User Impact:**
- External site visitors see more complete program information
- Program administrators can create more engaging, readable content
- Better presentation of program details to potential mentors

**Pages Affected:**
- Public search iframe (embedded on external sites)
- Program edit forms
- Browse Programs
- Program detail pages
- Public-facing program profiles

**Complexity:** MEDIUM - Requires both frontend (rich text editor) and backend (API updates) changes

**Quick Win Component:** Adding missing 'mentor role description' to API response (Phase 1)

**Strategic Component:** Full rich text support implementation (Phase 2-3)

> **CLIENT FEEDBACK — Meeting 3 (May 20, 2026):**
>
> **Reviewed — combined with #22 and search improvements. Blocked on MENTOR field inventory.**
>
> Search results display is "pretty dry" — only shows program title with minimal information. Sandy: clicking a result should **expand inline** (accordion-style) rather than navigating to a separate page. Expanded view should show key program details and include a **direct inquiry button**. This overlaps with the form/field alignment work (#22) — the field inventory will determine what's displayed.
>
> **Decisions:**
> - Add more program information to search result listings
> - Implement **inline expansion** (accordion) for search results instead of navigating away
> - Include a **direct inquiry button** in the expanded search result view
> - Field display determined by MENTOR's program data inventory (tied to #22)
>
> **Next Step:** Dependent on MENTOR's field inventory. Estimate after field list is finalized.
>
> **Client Priority:** 🟠 High | **Client Impact:** ⬛◻◻ Low - Some Users, Less than 40%
>
> **REFINED SCOPE:**
> - Add more program information to search result listings
> - Implement inline expansion (accordion) for search results instead of navigating away
> - Include direct inquiry button in expanded search result view
> - Rich text support for program descriptions (ties into #22)
> - Field display determined by MENTOR's program data inventory (tied to #22)
>
> **Readiness:** ⏳ Blocked — waiting on MENTOR's field inventory (same dependency as #22)

---

### 26. Public Program Search & Mentee Discovery 🔒 `DEFERRED — Meeting 3, May 20, 2026`


**Current Issues:**
- Public-facing search is primarily designed for adult mentor recruitment
- Mentee search is currently a workaround (directs users to contact programs directly)
- System doesn't fully support mentee requests as originally intended
- No clear pathway distinction between volunteer/mentor search and mentee/family search
- Programs with long waitlists may hesitate to be listed publicly
- Limited program information available in public search results
- Doesn't fully address mentee discovery needs for families seeking mentoring opportunities

**Proposed Solutions:**
- Evaluate and define the public search strategy for mentee/family audiences:
  - Decide whether to support mentee intake through the platform or continue the current workaround (directing mentees to contact programs directly)
  - Define clear user pathways for mentors vs. mentees/families
- Improve public search experience:
  - Add relevant search filters for public users (program type, age range, location, delivery type)
  - Better search results presentation with more complete program information
  - Clearer communication about what the tool offers to different audiences
- Address program concerns:
  - Consider how to handle programs with capacity limitations or waitlists
  - Leverage unmet needs data for capacity building and advocacy

**Strategic Decision Required:** MENTOR needs to determine whether the platform will actively support mentee intake or continue the current approach of directing mentees to contact programs directly. This decision should be made before significant development effort is invested.

**Related:**
- See #9 (Admin Program Search & Discovery Enhancements) for internal/admin search improvements
- See #10 (Public-Facing Site Improvements) for broader public site strategy
- See #25 (Public Search Iframe & Rich Text Support) for iframe and content formatting improvements

**Business Impact:** MEDIUM-HIGH - Directly affects families and mentees seeking mentoring opportunities

**User Impact:** Public site visitors, families seeking mentoring, program administrators managing inquiries

**Pages Affected:** Public-facing search, program profiles, inquiry workflows

> **CLIENT FEEDBACK — Meeting 3 (May 20, 2026):**
>
> **Deferred alongside #10 — pending internal MENTOR strategy discussion.**
>
> Tied directly to #10 (Public-Facing Site Improvements). Cannot scope technical changes until MENTOR defines the strategy for serving different audiences (mentors, caregivers, funders, researchers).
>
> **Decision:** Deferred pending MENTOR's internal alignment on search audiences and public site purpose.
>
> **Next Step:** Revisit after MENTOR's internal strategy discussion on public search audiences.
>
> **Client Priority:** — *(Not yet rated)* | **Client Impact:** — *(Not yet rated)*
>
> **REFINED SCOPE:**
> - N/A — deferred pending MENTOR internal strategy alignment (tied to #10)
>
> **Readiness:** 🔒 Deferred — blocked on MENTOR internal discussion

---

### 27. Search Algorithm Data Requirements & Program Visibility ✅ `REVIEWED — Meeting 3, May 20, 2026`


**Current Issues:**
- Approved programs can be completely invisible in public search results due to missing data fields
- The search algorithm requires three data conditions to be met, but none are enforced as required fields on program submission or edit forms
- Programs like AALEAD have been confirmed missing from search results due to this gap
- Three data conditions that cause approved programs to be excluded from search:
  1. **Accepting Mentors/Mentees checkbox** — Program must have either "Accepting Mentors" or "Accepting Mentees" checked. When a user searches "become a mentor", only programs accepting mentors are shown (and vice versa for mentees). If neither is checked, the program never appears in any search
  2. **Delivery Method** — Program must have at least one delivery method selected (Community-Based, Site-Based, or E-Mentoring). Programs without a matching delivery method are excluded when filters are applied. If none are checked, the program becomes invisible whenever delivery filters are used
  3. **Program Location** — For zip-code-based searches, the program must have at least one location on file with coordinates (Community/Site Based Addresses). Programs with no locations will not appear in any proximity search — only in nationwide searches

**Proposed Solutions:**
- **Form Validation (Prevention):**
  - Make "Accepting Mentors" and/or "Accepting Mentees" a required field on the program submission and edit forms
  - Make at least one delivery method with a valid address a required field on the program form
- **Data Backfill (Remediation):**
  - Review programs identified in reports to determine if missing data should be backfilled
  - Backfill can be done through the portal UI or programmatically with scripts
- **Ongoing Monitoring:**
  - Consider adding a data completeness report or dashboard flag for programs missing search-critical fields

**Related:**
- See #26 (Public Program Search & Mentee Discovery) for broader public search strategy
- See #9 (Admin Program Search & Discovery Enhancements) for internal/admin search improvements
- See #22 (Form & Field Alignment Issues) for related form validation concerns

**Business Impact:** HIGH - Approved programs are currently invisible to the public, directly undermining MENTOR's mission to connect mentors and mentees with programs

**User Impact:** Program administrators (data entry), public site visitors (cannot find programs), MENTOR staff (unaware of invisible programs)

**Pages Affected:** Program submission form, program edit form, public search results, admin program reports

**Complexity:** LOW-MEDIUM - Form validation changes are straightforward; data backfill scope depends on number of affected programs

**Quick Win Component:** Add required field validation to program forms (Phase 1); generate reports of affected programs for review

**Strategic Component:** Data backfill execution and ongoing data quality monitoring (Phase 2)

> **CLIENT FEEDBACK — Meeting 3 (May 20, 2026):**
>
> **Reviewed — algorithm changes agreed. Scope refined.**
>
> Currently three conditions must be met for a program to appear in public search: (1) mentor/mentee checkbox, (2) delivery method, (3) program location. Mike: if a program exists and isn't archived, it should show up in search regardless of volunteer acceptance — "There should be an icon that says, 'We're accepting volunteers,' and if you don't see that icon, they're not accepting volunteers, and there's no inquiry button."
>
> **Decisions:**
> - **Loosen search algorithm:** Remove mentor/mentee checkbox from search criteria — programs appear based on status + delivery method + location only
> - Mentor/mentee checkbox toggles determine whether the **inquiry button** is displayed, not whether the program is found
> - **Delivery method remains required** — at least one must be selected
> - Programs with incomplete profiles (no delivery method) will still not appear in search — this is acceptable
> - E-mentoring programs can select "national" (no ZIP needed) or "limited" (with ZIP codes)
>
> **Next Step:** Estimate. Clear scope — implementation can proceed.
>
> **Client Priority:** 🔴 Critical | **Client Impact:** ⬛⬛⬛ High - All Users, 100%
>
> **REFINED SCOPE:**
> - **Remove role filter from search query** — the `accepting_mentors`/`accepting_mentees` flags are no longer used as WHERE conditions in the search SQL. All approved programs matching location + delivery method are returned regardless of acceptance status.
> - **Search form still collects role** — the user still selects "mentor" or "mentee" on the 3-Step form. This value is passed through to the results page but is NOT used to filter the query.
> - **Inquiry button controlled by role + acceptance flags** — on the results page, the user's selected role is compared against the program's `accepting_mentors`/`accepting_mentees` flags. If the program accepts that role, show the inquiry button. If not, show an indicator (e.g., "Not currently accepting mentors") with no inquiry option.
> - **Delivery method remains a required search condition** — at least one delivery method must be selected for a program to appear
> - Programs with no delivery method still won't appear in search (acceptable)
> - E-mentoring programs: "national" (no ZIP needed) or "limited" (with ZIP codes)
>
> **Readiness:** ✅ Ready to estimate — clear, scoped change to search algorithm

---

### 28. Program Archive & Lifecycle Management ✅ `REVIEWED — Meeting 3, May 20, 2026 (covered under #7)`


**Current Issues:**
- No clear ability to archive or permanently remove programs from the system
- A "Deleted" status exists in the program status dropdown (alongside Approved, Paused, Pending) but its behavior is undocumented and unclear — needs investigation
- Programs that have closed or are confirmed duplicates remain in the system with no appropriate status to reflect that they are no longer operational
- During the March 2026 data cleanup, affiliates requested the ability to delete/archive programs but no mechanism was available — they could only set programs to "Paused"
- Mike's NQMS cleanup found programs that had done assessments but have since closed — assessment data should be preserved but the program should no longer appear as active
- Duplicate program records exist as workarounds (same org, different program models) that need to be consolidated once #11 (multi-assessment) is in place

**Proposed Solutions:**
- **Investigate current "Deleted" status:** Determine what happens today when a program's status is set to "Deleted" — does it hide from search? Does it affect associated data (users, assessments, goals)? Is it role-restricted?
- **Rename "Deleted" to "Archived":** Programs cannot be permanently deleted — the term should reflect soft delete / archival. Sandy: "I like archived better"
- **Define archive behavior:**
  - Archived programs should not appear in public search results
  - Archived programs should still be accessible for reporting, NQMS historical data, and admin lookup
  - Associated user accounts, assessments, and goals should be preserved
  - Archived programs should be filterable in admin views (filter by status: Active / Paused / Archived)
- **Permission model:** Determine which roles can archive a program (likely global admin and affiliate admin for programs under their affiliate)
- **Bulk archive capability:** Support archiving multiple programs at once to assist with cleanup efforts

**Related:**
- See #1 (User Account Management) for user-level archive capability (same "archived not deleted" philosophy)
- See #3 (Duplicate Detection & Prevention) for duplicate program cleanup that drives the need for archival
- See #11 (Assessment History & Multi-Assessment Support) for preserving NQMS data on archived programs
- See #20 (Affiliate Deletion & Inactivation Management) for parallel affiliate-level archive concerns

**Business Impact:** MEDIUM - Essential for data hygiene and cleanup efforts. Without a proper archive mechanism, the system accumulates stale programs that pollute search results, confuse affiliates, and distort reporting metrics.

**User Impact:** Global admins, affiliate admins (cleanup workflows), MENTOR national staff (reporting accuracy)

> **CLIENT FEEDBACK — Meeting 3 (May 20, 2026):**
>
> **Reviewed — covered under #7 decisions.** Aksana presented findings from code analysis of the existing "Deleted" status.
>
> **Decisions:**
> - Rename "Deleted" to **"Archived"** with a **mandatory reason field** for auditing
> - Archived programs: hidden from public search, accessible for reporting, NQMS historical data, and admin lookup
> - Archived programs filterable in admin views (filter by status: Active / Paused / Archived)
> - Archival must be **reversible** (can reactivate an archived program)
> - Associated user accounts, assessments, and goals preserved
> - Consistent with the "archived not deleted" philosophy agreed across the platform (#1 users, #7 programs)
>
> See #7 (Program Status Visibility) for the full discussion on status badges and lifecycle management.
>
> **Next Step:** Estimate as part of #7 scope.
>
> **Client Priority:** 🟠 High | **Client Impact:** ⬛⬛◻ Medium - Most Users, More than 70%
>
> **REFINED SCOPE:**
> - Covered under #7 — not a separate work item
> - See #7 for full scope (rename Deleted→Archived, reason field, reversible, admin-searchable)
>
> **Readiness:** ✅ Covered under #7 estimate

---

### 29. Global Search & Analytics Export Hub ✅ `REVIEWED — Meeting 3, May 20, 2026`


**Current Issues:**
- Data is siloed across separate sections — programs, assessments, goals, inquiries, searches, affiliates, and accounts each have their own views and (in some cases) their own exports
- No way to cross-reference data across MC and NQMS from a single interface (e.g., "show me all programs that have NQMS assessments with active goals" or "all programs inactivated in the last 6 months that had assessments")
- To answer cross-cutting questions, staff must export from multiple sections individually, then manually combine and massage the data in Excel
- Mike's old NQMS system had a "build your own report" tool but the output was unwieldy and column labels were unclear
- As data grows, the gap between what the system stores and what staff can actually query is widening
- Sandy: "There needs to be an export site or section within the site itself where we can pick and choose fields and that exports out the data"
- Beth: "I'm used to every system I've worked in — you can export data and manipulate it. It gets frustrating when you can't"

**Proposed Solutions:**
- **Centralized Analytics Page:** A dedicated menu item / page that serves as the single entry point for data search and export across the platform
- **Cross-Entity Search:** Ability to query across data boundaries:
  - Programs + NQMS assessments + goals (Mike's primary use case)
  - Programs + affiliate data
  - Programs + inquiry data
  - Programs by status, date ranges, program characteristics
- **Layered Filtering / Query Builder:**
  - Step 1: Select data type (Programs, Assessments, Goals, Inquiries, etc.)
  - Step 2: Apply filters (status, date range, affiliate, program characteristics, assessment scores, etc.)
  - Step 3: Select which columns/fields to include in the export
  - Step 4: Preview results and export as CSV
- **Pre-Built Report Templates:** Common queries saved as templates (e.g., "Active Programs with Assessments", "Programs Missing Data Fields", "Goal Completion by Affiliate") to reduce the need to build from scratch each time
- **Clean Export Format:** Column headers should be human-readable (not database field names), with a data dictionary/legend included or available separately

**Considerations:**
- This overlaps with #15 (Full Data Export for Research) on the NQMS side — Mike's evaluation data needs could be served by this tool instead of a standalone NQMS export builder
- The existing individual exports (programs, inquiries, searches) would remain as quick shortcuts; this page would be for more complex, cross-referencing queries
- Sandy raised AI as a possibility for dynamic querying — Aksana cautioned that AI-generated SQL on a complex data model is unreliable without significant training; a structured query builder is more appropriate
- Tim cautioned that MC and CRM don't collect equal data — field mapping should be considered if exports are meant to feed into other systems
- Mike's old NQMS experience suggests keeping the UI simple and the output well-labeled — avoid a tool that produces exports "where you can't tell what the hell is in a column"

**Related:**
- See #2 (Export Capabilities) for individual section export improvements and program template rework
- See #15 (Full Data Export for Research) for NQMS-specific evaluation export needs (currently deferred to ad-hoc SQL)
- See #11 (Assessment History & Multi-Assessment Support) for assessment data that would feed into cross-entity queries

**Business Impact:** MEDIUM-HIGH - Unlocks the ability for MENTOR staff and affiliates to self-serve data needs instead of relying on ad-hoc SQL requests or manual data stitching. Becomes more valuable as data volume grows and evaluation/reporting demands increase.

**User Impact:** MENTOR national staff (Sandy, Beth — reporting and CRM sync), Mike (evaluation and research), affiliates (self-service data for their programs)

**Complexity:** MEDIUM-LARGE - Existing exports provide the building blocks, but the cross-entity query logic and UI for the query builder represent significant new work. Could be phased: Phase 1 as a centralized export landing page with existing exports consolidated, Phase 2 as the cross-entity query builder.

> **CLIENT FEEDBACK — Meeting 3 (May 20, 2026):**
>
> **Reviewed — comprehensive export agreed. Centralized report section endorsed.**
>
> Sandy: current program export is limited — does not include program detail fields (characteristics, youth served, etc.). Had to go through Orases for a full data extract. Sandy: "I definitely don't want to be restricted, because I think we shouldn't have to go through you all to get additional data." Mike: research partners are "super-duper interested" in correlating program characteristics with NQMS assessment data (e.g., school-based vs. non-school-based program outcomes).
>
> **Decisions:**
> - Program export needs to be **comprehensive** — include all program detail fields, not just basic info
> - Build a **centralized report/export section** rather than scattered export buttons
> - **Individual program data export** should also be available from the program detail page
> - Export scope to be defined alongside the field inventory from #22
>
> **Next Step:** Export scope dependent on MENTOR's field inventory (#22). Estimate centralized report section after field list is finalized. Individual exports can be scoped independently.
>
> **Client Priority:** 🟡 Medium | **Client Impact:** ⬛⬛◻ Medium - Most Users, More than 70%
>
> **REFINED SCOPE:**
> - Comprehensive program export — include all program detail fields (characteristics, youth served, etc.)
> - Centralized report/export section (single menu item consolidating all exports)
> - Individual program data export from program detail page
> - Export field scope tied to #22 field inventory
> - Phase 1: Centralized export landing page (low effort — consolidates existing exports)
> - Phase 2: Cross-entity query builder (larger effort — future)
>
> **Readiness:** ⏳ Partially blocked — Phase 1 (centralized landing page) can be estimated now. Comprehensive export fields depend on MENTOR's field inventory (#22). Phase 2 (query builder) is future scope.

---

### 30. NQMS Goal Status Enhancements ⏳ `PENDING FOLLOW-UP — Meeting 3, May 20, 2026`


**Current Issues:**
- Goals currently only have two statuses: **In Progress** and **Complete**
- No way to mark a goal that will never be completed without deleting it from the system
- During NQMS data cleanup, Mike and Rachel found many stale goals (1+ year old, no progress) that are effectively abandoned but cannot be appropriately categorized
- Some goals are abandoned because the program closed, leadership changed, or the goal was simply no longer relevant — these are different situations but all result in the same problem: a goal stuck in "In Progress" forever
- Abandoned goals inflate "active goals" counts in reports, making it appear programs have more pending work than they actually do
- Reviewers cannot tell affiliates to stop following up on a goal that will never be completed — there's no status to signal "stop asking about this one"
- Mike: "We need some way of marking them as 'you can stop asking the program about it 'cause they ain't gonna do it' status"
- Deleting abandoned goals is not acceptable — they have evaluation value (shows where programs set goals but didn't follow through, reveals barriers to change, informs process improvement)

**Proposed Solutions:**
- **Add new goal statuses** beyond "In Progress" and "Complete":
  - **"Not Pursued"** or **"Abandoned"** — goal was set but the program is not going to complete it (leadership change, program closed, priorities shifted)
  - **"Deferred"** — goal is paused and may be revisited in a future assessment cycle
  - Consider whether a **"Superseded"** status is needed — goal replaced by a different goal in a new cycle
- **Status should affect reporting:**
  - "Not Pursued" / "Abandoned" goals should be **excluded from active goal counts** by default
  - Should still be **visible in historical reports** and goal completion analysis
  - Mike wants to be able to report on: how many goals are active, how many completed, how many abandoned — and not have abandoned goals mixed into active counts
- **Require a reason when marking a goal as Not Pursued:**
  - Dropdown or free text: program closed, leadership turnover, goal no longer relevant, resources unavailable, etc.
  - This data is valuable for evaluation — understanding *why* goals are abandoned informs MENTOR's process
- **Goal status visible on assessment and program views:**
  - Ties into #14 (Reviewer Progress Tracking) — goal status indicators should be visible alongside assessment section progress
  - Ties into #11 (Assessment History) — when completing an assessment cycle, prompt reviewer to update status on any "In Progress" goals before closing

**Related:**
- See #11 (Assessment History & Multi-Assessment Support) for assessment lifecycle that should prompt goal status cleanup on cycle completion
- See #14 (NQMS Reviewer Progress Tracking) for visual indicators that would include goal status
- See #15 (Full Data Export for Research) for evaluation data that benefits from granular goal status tracking

**Business Impact:** MEDIUM-HIGH - Directly impacts the quality of NQMS evaluation data and the efficiency of reviewer workflows. Without this, stale goals accumulate, reports are misleading, and reviewers waste time following up on goals that will never be completed.

**User Impact:** NQMS reviewers (daily workflow), Mike and evaluation team (reporting accuracy), affiliate staff (know which goals to follow up on)

**Complexity:** SMALL-MEDIUM - Core change is adding status options to an existing field and updating report queries to respect the new statuses. The reason/dropdown for abandonment adds modest complexity. Integration with #11 assessment lifecycle adds scope but is a natural fit.

> **CLIENT FEEDBACK — Meeting 3 (May 20, 2026):**
>
> **Briefly discussed — Mike had departed. Needs follow-up.**
>
> Currently goals can exist or be hard-deleted — no intermediate status. Mike previously raised the need for an "Abandoned" or "Not Pursued" status for goals that will never be completed but have evaluation value. Aksana wanted to discuss further with Mike but he had left the meeting.
>
> **Previous context (Meeting 2):** Mike and Rachel reviewed all NQMS records and found many goals 1+ year old with no progress. Mike explicitly stated he does not want to delete these goals — they have evaluation value. He wants a status that removes them from active counts without losing the data. Sarah also identified the need independently.
>
> **Decision:** Schedule a **follow-up with Mike** to scope assessment goal status options (archive vs. delete vs. abandoned).
>
> **Next Step:** Dedicated follow-up session with Mike. Goal status enhancements are a natural companion to #11 assessment lifecycle work.
>
> **Client Priority:** 🟠 High | **Client Impact:** ⬛⬛◻ Medium - Most Users, More than 70%
>
> **REFINED SCOPE:**
> - Add new goal statuses: "Not Pursued" / "Abandoned" and potentially "Deferred"
> - Require reason when marking a goal as Not Pursued (dropdown or free text)
> - Not Pursued goals excluded from active goal counts but visible in historical reports
> - Goal status cleanup prompted when completing an assessment cycle (ties into #11)
> - Scope needs confirmation from Mike on specific statuses and reporting behavior
>
> **Readiness:** 🔍 Needs discovery session with Mike — natural companion to #11 breakout. Direction is clear but specific statuses and reporting behavior need to be defined before estimating.

---

## Work Stream Approach

This initiative represents **Stream 1** in the three-stream parallel approach:

- **Stream 1: Quick Wins / System Enhancements** (This Document)
  - Can start immediately
  - Focused on existing functionality improvements
  - Delivers tangible value quickly

- **Stream 2: Data Cleanup Strategy**
  - Requires reporting tools from Stream 1
  - Affiliate-assisted review and validation

- **Stream 3: Long-Term Vision**
  - Requires committee formation and deeper discovery
  - CRM evolution and integration decisions

---

## Success Metrics

**How We'll Measure Success:**
- Reduction in manual support requests
- Improved data export utilization
- Time savings in data quality monitoring
- User satisfaction with UI improvements
- QMS reassessment completion rates

---

## Related Documents

- [Meeting 1 Summary](Meeting/Meeting1_Summary.md) - Initial alignment discussion (Jan 2026)
- [Internal Strategy Meeting Minutes](2026-01-08 - MENTOR System Strategy (MC+NQMS) - Internal - Minutes.pdf) - Internal discussion (Jan 8, 2026)
- [MC Strategy Initiation Plan](Initiation - MC Strategy_2026_Orases.pdf) - Working document for Orases discussion
- [Orases Recommended Enhancements List](https://orases.atlassian.net/wiki/spaces/MTR/pages/2649292801/Recommended+Enhancements+List) - Confluence page with Orases-identified enhancements
- [Mentor 2026 Strategic Opportunities & Recommendations](https://orases.atlassian.net/wiki/spaces/MTR/pages/2648145923/Mentor+2026+Strategic+Opportunities+Recommendations) - Strategic analysis based on P2 implementation and customer interviews (Dec 17, 2025)
- Section 9 Requirements (TBD - pending export from Sandy)
- Orases Backlog (TBD - to be compiled)
- MC Backlog in Teamwork Governance space (requires review and prioritization)

## Change Log

| Date | Change | Updated By |
|------|--------|------------|
| January 2026 | Initial document creation with 5 enhancement areas | Aksana Rahouski |
| January 21, 2026 | Added 7 new enhancement areas from internal meeting minutes and MC strategy plan | Aksana Rahouski |
| January 21, 2026 | Added 13 new enhancement areas from Orases Confluence Recommended Enhancements List | Aksana Rahouski |
| January 21, 2026 | Added 5 items from Orases 2026 Strategic Opportunities document (Assessment History, Full Data Export, Cross-Affiliate Permissions, SharePoint Migration, Analytics Dashboard) | Aksana Rahouski |
| January 21, 2026 | Added #30 Program Analytics & Visibility Dashboard based on real-world testing feedback - e-mentoring programs getting "lost" without Program Delivery filter | Aksana Rahouski |
| January 21, 2026 | Consolidated duplicates: merged #5 & #24 (UI/UX & Filter Panels), merged #4 & #6 (Dashboards). Reduced from 31 to 29 enhancement areas. Renumbered all items and updated cross-references. | Aksana Rahouski |
| January 21, 2026 | Removed #11 Learning Management System (LMS) Integration. Reduced from 29 to 28 enhancement areas. Renumbered sections 11-29 and updated all cross-references. | Aksana Rahouski |
| January 21, 2026 | Added source documentation to all 28 enhancement items, indicating which source documents contributed to each item (Meeting 1 Summary, Internal Strategy Meeting, Orases Recommended Enhancements List, Orases 2026 Strategic Opportunities, Real-world testing feedback). | Aksana Rahouski |
| January 21, 2026 | MAJOR REORGANIZATION: Reordered all 28 enhancement sections to follow the grouping structure defined in Summary Statistics. All sections renumbered sequentially (1-28) according to new order. Updated all cross-references throughout document. New grouping order: User Account & Data Management (1-3), Admin Tools & Dashboards (4), UI/UX Improvements (5-9), Search & Discovery (10-11), NQMS Enhancements (12-17), Automation & Engagement (18), System Integration (19-20), Permissions & Access (21-23), Forms & Data Collection (24-25), Infrastructure (26), Strategic Initiatives (27-28). | Aksana Rahouski |
| January 21, 2026 | Moved Summary Statistics section to the top of the document (after Overview section) for better visibility and easier reference to enhancement categories and priorities. | Aksana Rahouski |
| January 22, 2026 | Added #23 Affiliate Deletion & Inactivation Management based on real-world testing feedback - unclear behavior when marking Affiliate inactive, programs remain assigned, no clear delete option. Increased total from 28 to 29 enhancement areas. Renumbered sections 23-28 to 24-29 and updated all cross-references throughout document. Updated Permissions & Access category from 3 to 4 items and Affiliate/Admin Experience from 3 to 4 items. | Aksana Rahouski |
| January 22, 2026 | Added #25 National Affiliate for Orphan Programs (Safety Net Approach) from Meeting 2 (NQMS Launch Planning) - programmatic solution to automatically assign orphan programs (programs without affiliate) to a National/Global affiliate that acts as safety net. Increased total from 29 to 30 enhancement areas. Renumbered sections 25-29 to 26-30 and updated all cross-references throughout document. Updated Permissions & Access category from 4 to 5 items and Affiliate/Admin Experience from 4 to 5 items. | Aksana Rahouski |
| January 27, 2026 | Removed all dashboard-related items (#4 Dashboard Improvements, #29 Analytics Dashboard, #30 Program Analytics & Visibility Dashboard) as dashboards are now tracked in a separate file. Reduced total from 30 to 27 enhancement areas. Removed "Admin Tools & Dashboards" category and "Strategic Initiatives" category. Renumbered sections 5-28 to 4-27 and updated all cross-references, priority recommendations, sources, and related sections throughout document. | Aksana Rahouski |
| January 27, 2026 | Added #28 Public Search Iframe & Rich Text Support based on client feedback - missing mentor role description in public search iframe API response, incorrect logo sizing, and need for rich text formatting support in text areas (program description, mentor role description). Increased total from 27 to 28 enhancement areas. Updated Search & Discovery category from 2 to 3 items. Added to Priority Recommendations under Quality of Life Improvements - UI/UX. | Aksana Rahouski |
| January 27, 2026 | Removed Sources section and all source references from enhancement items. Removed Key Insights from Orases Strategic Analysis section. Removed #18 Integration of MC & NQMS Tools. Reduced total from 28 to 27 enhancement areas. Renumbered sections 19-28 to 18-27 and updated all cross-references throughout document. Updated System Integration category to Data Field Management with 1 item. | Aksana Rahouski |
| January 27, 2026 | Removed #21 Cross-Affiliate NQMS Permissions Enhancement. Reduced total from 26 to 25 enhancement areas. Renumbered sections 22-26 to 21-25 and updated all cross-references throughout document. Updated Permissions & Access category from 5 to 4 items. | Aksana Rahouski |
| March 2026 | Added client feedback (MENTOR FEEDBACK), client priority ratings, and client impact assessments from client review document to all 25 enhancement areas | Aksana Rahouski |
| March 25, 2026 | Split #9 into admin-focused (#9) and public-facing (#26) items per Scope Review Meeting 1 discussion. #9 now focuses on admin Browse Programs search aligned with NQMS filtering patterns. Added #26 Public Program Search & Mentee Discovery as NEW item pending client review. Increased total from 25 to 26 enhancement areas. Updated Search & Discovery category from 3 to 4 items. | Aksana Rahouski |
| March 25, 2026 | Added REVIEWED tags, Meeting 1 review notes, and Next Steps to all items discussed in Scope Review Meeting 1: #4, #5, #6, #8, #9, #11, #12, #13, #14, #15, #17. Captured decisions, clarifications, and action items from meeting discussion. | Aksana Rahouski |
| March 25, 2026 | Added visual legend and emoji system for priority (🔴🟠🟡🟢), impact (⬛◻ bars), and review status (✅🆕⏳). Added Client Feedback Summary reference table with all 26 items. Applied emojis to all Client Priority/Impact lines throughout document. | Aksana Rahouski |
| April 9, 2026 | Added REVIEWED tags, Meeting 2 review notes, and Next Steps to items discussed in Scope Review Meeting 2: #1, #2, #3. Updated summary table status from Pending to Reviewed for all three items. Key decisions: #1 scoped to archive + table enhancements (export/activity tracking deferred); #2 narrowed to program export template rework only (Sandy to send field list); #3 needs further discussion tied to #17 organization field revival. New issues surfaced: goal "Abandoned" status need (#11), program website links bug (Beth), centralized export page concept (#2). | Aksana Rahouski |
| April 9, 2026 | Added #28 Program Archive & Lifecycle Management as NEW item per Scope Review Meeting 2 discussion. Surfaced from concurrent MC and NQMS data cleanup efforts — no mechanism exists to properly archive closed or duplicate programs. Existing "Deleted" status is undocumented and needs investigation. Increased total from 27 to 28 enhancement areas. Updated User Account & Data Management category from 3 to 4 items. | Aksana Rahouski |
| April 9, 2026 | Added #29 Global Search & Analytics Export Hub as NEW item per Scope Review Meeting 2 discussion. Sandy proposed centralized export page; conversation expanded into cross-entity search and query builder concept when multiple team members described needs to cross-reference MC + NQMS data. Not urgent — ad-hoc SQL provides stopgap. Increased total from 28 to 29 enhancement areas. Added new Data & Reporting category with 1 item. | Aksana Rahouski |
| April 9, 2026 | Added #30 NQMS Goal Status Enhancements as NEW item per Scope Review Meeting 2 discussion. Mike identified need for "Abandoned/Not Pursued" goal status during NQMS data cleanup — stale goals can't be deleted (evaluation value) but inflate active counts and confuse reviewers. Increased total from 29 to 30 enhancement areas. Updated NQMS Enhancements category from 5 to 6 items. | Aksana Rahouski |
