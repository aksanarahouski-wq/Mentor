# Scope Review Meeting 2 — Summary
**Date:** April 9, 2026
**Attendees:** Aksana Rahouski, Hyun Masiello (Orases), Mike Garringer, Sandy Martins, Beth Tallarico, Tim Wills (MENTOR)
**Duration:** ~1 hour
**Reference Document:** [System Enhancements — With Client Feedback](../LowHangingFruit_SystemEnhancements_WithClientFeedback.md) | [Meeting 1 Summary](ScopeReviewMeeting1_Summary.md)

---

## Purpose

Second of three meetings to walk through the remaining proposed system enhancements. Continued from Meeting 1 (March 25), which covered 11 of 25 items. Goal was to review the remaining 14 items, but significant pre-agenda discussion about data cleanup findings and new issues meant only 3 items were fully reviewed.

---

## What Was Accomplished

- Reviewed **3 of the remaining 14 items** (#1, #2, #3)
- Significant pre-agenda discussion about **MC and NQMS data cleanup findings**, surfacing new requirements
- **New need identified:** a goal status for abandoned/not-pursued goals (#11 sub-requirement)
- **Bug reported:** program website links broken on public search results (Beth — support ticket)
- **Organization field** resurfaced as a key discussion topic tied to duplicate detection
- Agreed to **estimate all items** (not just high/critical) — Mike reiterated: "low priority doesn't mean don't do it if it's cheap"
- **Meeting 3 needed** — Hyun to schedule 1.5–2 hours to cover remaining 11 items

---

## Pre-Agenda Discussion

### MC Data Cleanup Results (Sandy)
- Cleanup completed but only **~15% of records fully resolved** (~450 records)
- Many records flagged for follow-up; some need to be inactivated/deactivated
- No delete functionality exists — people are requesting it
- Sandy to share the cleanup spreadsheet with Mike (covers ~12 affiliates)

### NQMS Data Cleanup (Mike)
- Mike and Rachel reviewed all NQMS records, focusing on **goals 1+ year old with no progress**
- Asking reviewers to clean up stale goals — are they complete? Can new target dates be set?
- **New requirement surfaced: a new goal status** beyond "In Progress" and "Complete" — something like "Abandoned" or "Not Pursued"
  - For goals that will never be completed but shouldn't be deleted
  - Valuable for evaluation: shows where programs set goals but didn't follow through vs. programs that closed
  - Mike: "I'd like to keep them in the system, but I would like to note that they maybe wouldn't show up in certain reports"
- Found **duplicate program records** and programs that have since closed
- Found programs entered twice because of **workarounds** (same org, different program models needing separate assessments)

### Program Status Investigation
- Discovered existing statuses: **Approved, Paused, Pending, Deleted**
  - "Paused" removes from search results
  - "Pending" is auto-set on new program applications
  - "Deleted" status exists but behavior is unclear — needs investigation
- Agreed: prefer **"Archived" terminology over "Deleted"** (soft delete, not hard delete)

### Bug Report (Beth)
- Program website links from search results don't load — affects users actively trying to use the system
- Beth to email details to Aksana for a Trello ticket (covered under support contract as a defect)
- Beth clarified: bugs/defects are covered under the existing support contract, separate from enhancements

---

## Item-by-Item Discussion Summary

### #1 — User Account Management
**Client Priority:** High | **Status:** Reviewed — scope refined

**Decisions made:**
- **Archive capability needed** (soft delete only, no hard delete)
  - Sandy: "We should probably move away from that term [delete]"
  - Global admins can archive any user
  - Program/affiliate admins can archive users under their affiliate only
- **Export removed from scope** — no immediate need for user account export
  - Sandy: "It's a want, it's not a need"
  - Tim raised mass email use case, but Sandy confirmed they use the program export for that
- **Add "Program" column** to the accounts table
  - Tim flagged that you can't see what program a user belongs to
  - Many orphan accounts with no program attachment
  - Tim: "It'd be good to see who's attached to what program at a glance"
- **Add "Status" column and status filter** to accounts table
  - Currently can't search by status — needed especially once archive is available
  - Want to filter: show all archived vs. all active
- **Keep email visible** in the table (needed for cleanup of legacy records with no first/last name)
- **User activity tracking** (who last changed what, across goals/assessments/profiles) — acknowledged as useful but **deferred as lower priority**

**Timestamp discussion (Mike):**
- Wants to see who last updated a goal in NQMS (for affiliate staff turnover situations — new staff needs to know who last touched a record)
- Program detail page already shows "last modified" with date + who, but this does **NOT** extend to NQMS assessments/goals
- Beth confirmed: timestamp only covers program profile data, not NQMS data
- Agreed this ties into NQMS progress tracking (#14) — can be addressed there
- **Lower priority** for now given everything else on the list

**Next Step:** Estimate. Scope is: archive capability (soft delete), add Program + Status columns to accounts table, add status filter.

---

### #2 — Export Capabilities
**Client Priority:** High | **Status:** Reviewed — scope narrowed significantly

**Decisions made:**
- **Accounts export:** Removed from scope (see #1 discussion)
- **Affiliates export:** Not needed
  - Sandy: "For 20-something records, I feel like that should be able to [just view on screen]"
  - Beth acknowledged: "We could just click on the last updated"
  - Sandy: "It's a want. I don't see an immediate need"
- **Program export template: needs rework**
  - Current template has **179 address placeholder columns** (overkill for actual usage)
  - Sandy to send Orases a list of desired fields; Orases will trim/update
  - Want it **close enough to CRM import format** for potential data sync
  - Tim cautioned: MC and CRM don't collect equal data (e.g., "organization" exists in CRM but not MC)
  - Also want to **add program options data** (program characteristics) that's currently missing from export — Sandy: "That's where the value of the data we're collecting in MC is"
  - Aksana: if the data already exists in the system, adding it to export is minor
- **Inquiries/Searches export:** Already exists — Beth confirmed she's used it
- **NQMS export:** Deferred — reiterated Meeting 1 decision (ad-hoc SQL from Orases)

**Centralized Export Page concept (Sandy):**
- Instead of navigating to each section to export, have a single "Export" menu item where you pick what data to pull
- Aksana: this wouldn't be expensive since exports already exist — just a UX reorganization
- Not scoped for immediate work but noted as a future improvement

**Cross-referencing data (Sandy/Aksana):**
- Sandy wants ability to query across MC + NQMS (e.g., "all programs with assessments that have goals")
- Acknowledged as a growing need as data scales but **not scoped for now**
- Mike referenced old NQMS system's "build your own report" tool — worked but output was unwieldy

**AI for exports (Sandy asked):**
- Sandy asked about using AI for dynamic export/report building
- Aksana cautioned against: AI would hallucinate on SQL queries unless extensively trained on the data model
- Better to define specific report needs and build targeted queries

**Next Step:** Sandy to send desired program export fields to Orases. Orases trims template and adds missing program options data. Estimate for template rework.

---

### #3 — Duplicate Detection & Prevention
**Client Priority:** High | **Status:** Reviewed — complex, needs more thought

**Current state:**
- Duplicate detection exists but only matches **exact program names**
- Many duplicates from: legacy data import, staff turnover (new director re-enters program), and workarounds (same org with different program models needing separate NQMS assessments)

**Discussion points:**
- Sandy: need to match on more than just name — phone number, email (like they did with CRM)
- Mike: some "duplicates" are **intentional workarounds** (e.g., "Buddy Program - School Based" vs "Buddy Program - Community Based" to get separate NQMS assessments)
  - This specific problem will be partially solved by #11 (multi-assessment support)
- Hyun: same program name can exist in different states — affiliates can't catch cross-state duplicates, only global admin can see those
- Mike: comfortable with **annual affiliate-driven cleanup** rather than automated dedup, but acknowledges affiliates can't catch everything
- Sandy: pushing for **data maintenance requirements in affiliate agreements** — cleanup shouldn't require paying affiliates extra

**Organization field resurfaced (#17 connection):**
- Sandy and Aksana agreed: **organization field should be brought back** and used properly
- Would establish parent-child relationships (organization owns programs)
- Helps differentiate: "Big Brothers Big Sisters of Boston" (org) can have multiple programs under it
- Two different organizations could legitimately have the same program name — blocking on name alone is problematic
- Organization field exists in DB and on the public application form but was **removed from admin view** due to misuse
- Currently **no ability to manage organizations as a separate entity** — would need a management UI
- This is a deeper architectural discussion tied to #17

**Next Step:** Further discussion needed in Meeting 3, especially around organization field (#17). Aksana to investigate current "Deleted" status behavior. Consider whether multi-assessment (#11) reduces the duplicate workaround problem.

---

## New Issues / Items Surfaced

| Issue | Source | Related Item | Action |
|-------|--------|-------------|--------|
| New goal status needed ("Abandoned/Not Pursued") | Mike | #11 (Assessment History) | Discuss during #11 breakout session |
| Goal status valuable for evaluation data — don't delete, just mark | Mike | #11 | Include in scoping |
| Program website links broken (bug) | Beth | Support ticket | Beth to email Aksana |
| Organization field needs revival + management UI | Sandy/Aksana | #17 (Data Fields) | Discuss in Meeting 3 |
| Centralized export page concept | Sandy | #2 | Note for future |
| Program export template needs field review | Sandy | #2 | Sandy to send field list |
| Programs with no way to be deleted/archived | Sandy/Mike | #1 / #20 | Investigate "Deleted" status |

---

## Key Themes & Decisions

1. **"Archived" not "Deleted" — everywhere.** Consistent theme across users, programs, goals, and assessments. Soft delete everywhere; keep the data for reporting and evaluation. Mike specifically: abandoned goals have evaluation value even if never completed.

2. **Organization as a first-class entity.** The missing organization hierarchy is causing duplicate problems and preventing proper parent-child program relationships. This keeps resurfacing across meetings and ties directly to #17 and #3.

3. **Data growing beyond current tooling.** Sandy and Mike both hitting walls trying to cross-reference MC + NQMS data. The system was built as a directory but is being used for CRM-like reporting. Export and querying needs are evolving.

4. **Cleanup is manual and painful.** Only got through 15% of records in the cleanup effort, and affiliate cooperation is inconsistent. Software-assisted detection (beyond exact name match) would help but is complex.

5. **Estimate everything.** Mike reiterated from Meeting 1: "I'd hate to leave a bunch of low-hanging fruit unaddressed even though it would've been cheap." Want cost visibility on all items, with NQMS items broken out separately.

---

## Action Items

### Aksana (Orases)
| Action | Related Item | Timeline |
|--------|-------------|----------|
| Investigate "Deleted" program status behavior | #1 / #3 | Before Meeting 3 |
| Start estimating reviewed items (all, not just high/critical) | All | Before Meeting 3 |
| Create Trello ticket for website link bug (after Beth's email) | Bug | When received |
| Share NQMS prototype mockups when ready | #11 | When available |

### Sandy (MENTOR)
| Action | Related Item | Timeline |
|--------|-------------|----------|
| Send desired program export template fields to Orases | #2 | Before Meeting 3 |
| Share cleanup spreadsheet with Mike | Cleanup | Soon |

### Beth (MENTOR)
| Action | Related Item | Timeline |
|--------|-------------|----------|
| Email program website link bug details to Aksana | Bug | ASAP |

### Hyun (Orases)
| Action | Related Item | Timeline |
|--------|-------------|----------|
| Schedule Meeting 3 (1.5–2 hours) | All | Next available slot |

---

## What's Left — Items for Meeting 3

**11 items not yet reviewed** (plus #26 new item needing client rating):

| # | Item | Client Priority | Category |
|---|------|----------------|----------|
| 7 | Program Status Visibility | Low | UI/UX Improvements |
| 10 | Public-Facing Site Improvements | Medium | Search & Discovery |
| 16 | Automation & Engagement Features | Critical | Automation & Engagement |
| 17 | Data Field Enhancements (Organization Field) | Medium | Data Field Management |
| 18 | Program Admin Permission Enhancements | High | Permissions & Access |
| 19 | Affiliate Management UX Improvements | High | Permissions & Access |
| 20 | Affiliate Deletion & Inactivation Mgmt | High | Permissions & Access |
| 21 | National Affiliate for Orphan Programs | High | Permissions & Access |
| 22 | Form & Field Alignment Issues | High | Forms & Data Collection |
| 23 | Inquiries Module Cleanup | Low | Forms & Data Collection |
| 24 | SharePoint Migration | High | Infrastructure |
| 25 | Public Search Iframe & Rich Text | High | Search & Discovery |
| **26** | **Public Program Search & Mentee Discovery** | **Not yet rated** | **Search & Discovery (NEW)** |

**Also on the Meeting 3 agenda:**
- #17 (Organization Field) — deeper discussion, now tied to #3 duplicate detection findings
- Review estimates for items reviewed in Meetings 1 and 2
- Discuss remaining permissions/access items (#18, #19, #20, #21)
- Affiliate inactivation behavior (what happens to zip codes and attached programs)

---

## Meeting 3 Details

**Date:** TBD — Hyun to schedule
**Duration:** 1.5–2 hours (extended from 1 hour based on Meeting 2 experience)
**Goal:** Review remaining 11+ items, review estimates, begin finalizing scope and sequencing for 2026 development
