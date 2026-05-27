# Scope Review Meeting 1 — Summary
**Date:** March 25, 2026
**Attendees:** Aksana Rahouski, Hyun Masiello (Orases), Mike Garringer, Sandy Martins, Beth Tallarico (MENTOR)
**Absent:** Tim Wills (sick)
**Reference Document:** [System Enhancements — With Client Feedback](../LowHangingFruit_SystemEnhancements_WithClientFeedback.md) | [Confluence Page](https://orases.atlassian.net/wiki/spaces/MTR/pages/2749857799/System+Enhancements)

---

## Purpose

First of two meetings to walk through all 25 proposed system enhancements with the client, review their priority/impact ratings, discuss details, and align on next steps. The goal is to finalize scope and sequencing for 2026 development work.

---

## What Was Accomplished

- Reviewed **11 of 25 items** (#4, #5, #6, #8, #9, #11, #12, #13, #14, #15, #17)
- Identified the **#1 NQMS priority** (#11 Assessment History) — needs a dedicated discovery session
- **Deprioritized #15** (Full Data Export) — agreed on ad-hoc SQL exports as interim solution
- **Split #9** into two separate items:
  - **#9** — Admin Program Search & Discovery (refocused on internal/admin Browse Programs filtering)
  - **#26** — Public Program Search & Mentee Discovery (NEW — pending client review)
- Agreed to add **T-shirt size effort estimates** (S/M/L/XL) to all items so low-priority but low-cost items can be bundled — Mike emphasized "low priority ≠ don't do it if it's cheap"
- Updated both the local document and Confluence page with review notes and next steps for all discussed items

---

## Item-by-Item Discussion Summary

### #4 — UI/UX Consistency & Page Layout Improvements
**Client Priority:** High | **Status:** Reviewed — straightforward
- Referenced during #9 discussion; collapsible, consistent filter panels should be applied across all pages
- NQMS assessment search is the model to follow
- **Next Step:** T-shirt size estimate. Bundle with #9 filter alignment work.

### #5 — Password Reset & Login UX
**Client Priority:** Critical | **Status:** Reviewed — needs investigation
- Sandy reported ongoing user confusion with password resets
- Phone number requirement during reset was questioned — Hyun explained it was future-proofing for MFA
- Sandy confirmed MFA is unlikely → phone number should be removed
- **Complication:** Beth tested live and was NOT prompted for a phone number, creating uncertainty about whether the behavior is role-dependent
- **Next Step:** Aksana to investigate the current password reset flow — determine why/when the phone number appears, whether it varies by role, and document the actual current UX before proposing changes.

### #6 — Navigation & Hyperlink Improvements
**Client Priority:** Critical | **Status:** Reviewed — confirmed critical
- Sandy: NQMS side already has good hyperlink navigation, MC side should match
- All entity names (programs, affiliates, assessments) should be clickable links to their respective pages
- **Next Step:** T-shirt size estimate. Likely small effort — good candidate for bundling.

### #8 — Badge Management
**Client Priority:** Low | **Status:** Reviewed — clarified requirements
- Badges follow a tiered progression (bronze → silver → gold) and should be swapped, not stacked
- Fix: change checkboxes to radio buttons (one badge at a time)
- Sandy raised whether LMS badge concepts should be tied in
- **Next Step:** T-shirt size estimate. Low priority but likely low effort — good bundling candidate. Mike to confirm badge tier model with Sarah. Aksana to look into LMS badge connection.

### #9 — Admin Program Search & Discovery (was "Program Search & Discovery")
**Client Priority:** Critical | **Status:** Reviewed — refocused & split
- Agreed this item should focus on admin/internal search only
- Beth flagged that admin search and public search are separate concerns with different audiences
- NQMS assessment search page already has richer filtering — should be the model for Browse Programs
- Default search should be zip code with layered filters for program characteristics, delivery type, and age ranges
- Public-facing search concerns split into new item #26
- **Next Step:** T-shirt size estimate. Scope filter alignment using NQMS assessment search as reference implementation.

### #11 — Assessment History & Multi-Assessment Support
**Client Priority:** Critical | **Status:** Reviewed — **#1 NQMS priority**
- Mike: "by far the most important of all of these" on the NQMS side
- Foundation exists for multiple assessments, but UI lacks lifecycle workflow (no close/complete trigger, no historical visibility)
- Mike requested a **third assessment state** beyond "active" and "archived" — something like "historical" that remains accessible for reporting, sharing with programs, and aggregate trend analysis
- Valuable both at individual program level and for longitudinal research
- **Next Step:** Aksana to scope this item, develop solution options, and prepare questions for Mike. Schedule a **dedicated breakout/discovery session** before finalizing solution and estimate. Too complex for T-shirt sizing alone.

### #12 — NQMS Assessment Workflow Improvements
**Client Priority:** Medium | **Status:** Reviewed — minor cleanup
- Redundant buttons (view/edit appearing in multiple places) and breadcrumb inconsistencies
- Confirmed NOT blocked by #24 (SharePoint migration) — SharePoint only changes backend file storage, transparent to users
- **Next Step:** T-shirt size estimate. Likely small effort — good candidate for bundling.

### #13 — NQMS Assessment Question Management
**Client Priority:** Medium | **Status:** Reviewed — quick fix identified
- File uploads were moved to the program profile (all documents uploaded at end), but old instructional text referencing per-question uploads still exists
- Mike: should have rated this higher than medium — confusing instructions in the assessment is a real problem
- Aksana: "super minor, just text change"
- **Next Step:** Scrub outdated file upload help text from NQMS assessments. Can be done as a quick fix without further scoping.

### #14 — NQMS Reviewer Progress Tracking
**Client Priority:** Medium | **Status:** Reviewed — concept agreed
- Visual indicators (red/yellow/green or icons) on collapsed assessment sections to show completion status on landing
- Currently, validation errors only appear when you try to submit — much better to show progress state without requiring an action
- Mike considered bumping to high but left at medium — cost/effort is the real decision factor
- **Next Step:** T-shirt size estimate. Priority decision depends on effort — if small, include; if medium/large, may defer.

### #15 — Full Data Export for Research
**Client Priority:** High | **Status:** Reviewed — **deprioritized**
- Mike wants assessment data combined with program profile data (kids served, program model, etc.) in CSV for researchers using SPSS/Stata
- Agreed on **interim approach:** Orases provides ad-hoc CSV data exports via SQL query on request
- Full in-tool export builder would be more expensive and is not immediately needed
- Mike will know more in 3-4 months when evaluation plan is fleshed out
- **Next Step:** No immediate development. Orases fulfills ad-hoc export requests as needed. Revisit in **June/July 2026** when evaluation plan and researcher requirements are defined.

### #17 — Data Field Enhancements (Organization Field)
**Client Priority:** Medium | **Status:** Reviewed — deferred to Meeting 2
- Organization field was removed due to misuse, but MENTOR does have a legitimate need for organizational hierarchy tracking
- Sandy specifically flagged this for deeper discussion in Meeting 2
- **Next Step:** Discuss in **Meeting 2 (April 9, 2026)**. Sandy to clarify the use case and requirements.

---

## New Item Created

### #26 — Public Program Search & Mentee Discovery `NEW`
- Split from #9 based on Beth's feedback that admin search and public search are separate concerns
- Includes the mentee search strategy question (Sandy flagged this as a strategic decision MENTOR needs to make before development)
- Marked as pending client review — not yet rated for priority/impact
- **Next Step:** Review in Meeting 2. MENTOR to discuss internally whether they will support mentee intake through the platform or continue the current workaround.

---

## Key Themes & Decisions

1. **T-shirt sizing is critical.** Mike made clear that "low priority" items are still worth doing if cheap. Adding effort estimates (S/M/L/XL) to all items will unlock better prioritization decisions.

2. **NQMS as the UX model.** Recurring theme that the NQMS side has better patterns (collapsible filters, hyperlinks, richer search) that should be extended to the Mentor Connector side.

3. **Mentee search is a strategic question, not just technical.** Before enhancing public search for mentees, MENTOR needs to decide whether they are going to support mentee intake through the platform or keep the current workaround.

4. **Ad-hoc data support as a safety valve.** Orases can fulfill data export needs via custom SQL on request, providing breathing room while in-tool exports are deprioritized.

---

## Action Items

### Aksana (Orases)
| Action | Related Item | Timeline |
|--------|-------------|----------|
| Investigate current password reset flow (phone number behavior, role differences) | #5 | Before Meeting 2 |
| Add T-shirt size effort estimates (S/M/L/XL) to all 26 items | All | Before Meeting 2 |
| Scope Assessment History — develop solution options, prepare questions for Mike | #11 | Before breakout session |
| Schedule dedicated breakout/discovery session for Assessment History | #11 | After initial scoping |
| Look into LMS badge connection | #8 | Before Meeting 2 |

### Mike (MENTOR)
| Action | Related Item | Timeline |
|--------|-------------|----------|
| Confirm badge tier/replacement model with Sarah | #8 | Before Meeting 2 |
| Define evaluation plan timeline (informs data export needs) | #15 | ~3-4 months |

### Sandy (MENTOR)
| Action | Related Item | Timeline |
|--------|-------------|----------|
| Clarify organizational hierarchy use case and requirements | #17 | At Meeting 2 |

### Team / General
| Action | Related Item | Timeline |
|--------|-------------|----------|
| MENTOR to decide on mentee intake strategy (platform vs. workaround) | #26 | TBD |

---

## What's Left — Items for Meeting 2

**14 items not yet reviewed** (plus #26 new item needing client rating):

| # | Item | Client Priority | Category |
|---|------|----------------|----------|
| 1 | User Account Management | High | User Account & Data Mgmt |
| 2 | Export Capabilities | High | User Account & Data Mgmt |
| 3 | Duplicate Detection & Prevention | High | User Account & Data Mgmt |
| 7 | Program Status Visibility | Low | UI/UX Improvements |
| 10 | Public-Facing Site Improvements | Medium | Search & Discovery |
| 16 | Automation & Engagement Features | Critical | Automation & Engagement |
| 18 | Program Admin Permission Enhancements | High | Permissions & Access |
| 19 | Affiliate Management UX Improvements | High | Permissions & Access |
| 20 | Affiliate Deletion & Inactivation Mgmt | High | Permissions & Access |
| 21 | National Affiliate for Orphan Programs | High | Permissions & Access |
| 22 | Form & Field Alignment Issues | High | Forms & Data Collection |
| 23 | Inquiries Module Cleanup | Low | Forms & Data Collection |
| 24 | SharePoint Migration | High | Infrastructure |
| 25 | Public Search Iframe & Rich Text | High | Search & Discovery |
| **26** | **Public Program Search & Mentee Discovery** | **Not yet rated** | **Search & Discovery (NEW)** |

**Also on the Meeting 2 agenda:**
- #17 (Data Field / Organization Field) — Sandy requested deeper discussion
- Review T-shirt size estimates (if ready)
- Discuss #26 and mentee search strategy

---

## Meeting 2 Details

**Date:** Thursday, April 9, 2026 at 1:00 PM
**Goal:** Review remaining 14 items, discuss #17 in depth, review #26, begin aligning on final scope and sequencing

**Note:** Hyun and Aksana on PTO Monday–Wednesday of the week following Meeting 1. Coverage available via support@orases.com.
