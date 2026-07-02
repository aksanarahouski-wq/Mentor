# Items Not Ready to Estimate — 2026 Scope
**Last Updated:** July 2026
**Based On:** Scope Review Meetings 1-3 (March-May 2026)

---

## Overview

These items from `SystemEnhancements.md` are **not included in the refined estimates** because they are blocked on external dependencies, need further discovery sessions, or have been deferred. This document captures the current state, directional approach, and what's needed to unblock each item.

---

## Summary

| # | Item | Category | Blocker |
|---|------|----------|---------|
| 2 | Export Capabilities | Blocked on MENTOR | Sandy's field list |
| 3 | Duplicate Detection & Prevention | Needs Discovery | Depends on #17; partially unblocked by #11 (now estimated in Group 7) |
| 10 | Public-Facing Site Improvements | Deferred | MENTOR internal strategy |
| 15 | Full Data Export for Research | Deferred | Revisit June/July 2026 |
| 17 | Data Field Enhancements (Organization) | Deferred | Too complex for current scope |
| 22 | Form & Field Alignment Issues | Blocked on MENTOR | Field inventory (Sandy's spreadsheet) |
| 23 | Inquiries Module Cleanup | Deferred | Needs dedicated redesign session |
| 24 | SharePoint Migration | Deferred | Heavy infrastructure lift, low priority |
| 25 | Public Search Iframe & Rich Text | Blocked on MENTOR | Field inventory (tied to #22) |
| 26 | Public Program Search & Mentee Discovery | Deferred | Tied to #10 strategy discussion |
| 29 | Global Search & Analytics Export Hub | Blocked on MENTOR | Field inventory for comprehensive export |

**Total: 11 items** (down from 13 — #11 and #30 moved to estimates in July 2026)
- Blocked on MENTOR action: 4
- Needs discovery session: 1
- Deferred: 6

---

## Blocked on MENTOR Action

These items have a defined directional approach but cannot be estimated until MENTOR provides specific inputs.

### #2 — Export Capabilities (Program Export Template Rework)

**Blocker:** Sandy's desired program export field list

**What was decided:**
- Current program export template has 179 address placeholder columns — needs trimming
- Missing program options data needs to be added to the export
- Export should align closer to CRM import format for potential data sync
- Accounts export, affiliates export, and NQMS export are all out of scope (deferred)
- Tim cautioned that MC and CRM don't collect equal data (e.g., organization field)

**What was removed from scope:**
- Accounts export (no immediate need)
- Affiliates export (only ~20 records, no value)
- NQMS export (ad-hoc SQL from Orases per Meeting 1 decision)

**Directional approach:**
- Orases trims the 179-column template based on Sandy's field list
- Add missing program options data to the export
- Align fields closer to CRM import format where feasible
- Scope is narrow — this is a template rework, not a new export system

**To unblock:** Sandy sends desired program export template fields to Orases. Once received, estimate is straightforward.

---

### #22 — Form & Field Alignment Issues

**Blocker:** MENTOR's program field inventory (Sandy's spreadsheet marking which fields display in public search)

**What was decided:**
- Public and internal program forms have mismatched labels ("Program Title" vs "Program Name", "Physical Address" vs "Program Address")
- Public form has "Other" options with text boxes, but the internal model only stores "Other" as a checkbox — context text is never saved to the database
- Country field on public form is unnecessary (US-only programs) — remove it
- Public form is better organized with section headers; internal form is one long page
- Case-insensitive duplicate name checking needed (currently exact case-sensitive only)
- Add rich text formatting for program descriptions (currently stripped to plain text)
- Add logo upload file size/dimension recommendations and potentially crop/resize tool
- Review each "Other" option — remove where not needed (e.g., age ranges), add DB storage where valuable (e.g., youth served categories)
- Fix number field validation (currently allows negative numbers)
- Organization field (#17) deferred — too complex

**Directional approach:**
- Once MENTOR finalizes which fields matter and which display publicly, Orases aligns both forms
- Multiple small fixes bundled together: label alignment, "Other" text storage, validation fixes, rich text, logo guidance
- Scope is clear per sub-item but the full list of affected fields depends on the inventory

**To unblock:** Sandy completes the program field inventory spreadsheet, marking which fields display in public search and which are internal-only.

---

### #25 — Public Search Iframe & Rich Text Support

**Blocker:** MENTOR's field inventory (same dependency as #22)

**What was decided:**
- Search results display is "pretty dry" — only shows program title with minimal information
- Clicking a search result should expand inline (accordion-style) rather than navigating to a separate page
- Expanded view should show key program details and include a direct inquiry button
- Rich text support for program descriptions (ties into #22 rich text work)
- Field display in search results determined by MENTOR's program data inventory

**What was already identified as issues:**
- "The mentor role description" field not included in search API response
- Logo size not displaying correctly in iframe
- Limited program information available to public searchers

**Directional approach:**
- Add more program fields to search result listings
- Implement inline expansion (accordion) on search results page
- Include direct inquiry button in expanded view
- Add rich text rendering for descriptions
- Which fields to display depends on the same field inventory blocking #22

**To unblock:** Same as #22 — Sandy's field inventory. These two items will likely be estimated together since they share the same dependency and overlapping scope (rich text, field display).

---

### #29 — Global Search & Analytics Export Hub

**Blocker:** Field inventory (for comprehensive export scope) — partially blocked

**What was decided:**
- Current program export is too limited — does not include program detail fields (characteristics, youth served, etc.)
- Sandy had to go through Orases for a full data extract — wants self-service: "I definitely don't want to be restricted, because I think we shouldn't have to go through you all to get additional data"
- Mike's research partners are interested in correlating program characteristics with NQMS assessment data
- Build a centralized report/export section rather than scattered export buttons
- Individual program data export should also be available from the program detail page
- Sandy raised AI-powered querying; Aksana cautioned that AI-generated SQL is unreliable on a complex data model — structured query builder is more appropriate

**Phased approach agreed:**
- **Phase 1 (low effort, can be estimated now):** Centralized export landing page — single menu item consolidating all existing exports in one place
- **Phase 2 (larger effort, future):** Cross-entity query builder — ability to query across programs + NQMS + goals + inquiries. This is the "build your own report" capability.

**Directional approach:**
- Phase 1 is essentially a new page with links/sections for each existing export — minimal new logic
- Comprehensive export fields (what's included in each export) depend on the field inventory from #22
- Phase 2 is future scope and significantly more complex

**To unblock:** Phase 1 centralized landing page could potentially be estimated now as a standalone. Comprehensive export content depends on #22 field inventory. Phase 2 is a separate future effort.

---

## Needs Discovery Session

These items have directional agreement but are too complex to estimate without a focused breakout session to define the solution approach.

### #3 — Duplicate Detection & Prevention

**Needs:** Further discovery — depends on #17 (organization field) decisions. #11 (multi-assessment) is now estimated in Group 7 and will partially reduce the duplicate workaround problem once implemented.

**What was decided:**
- Current exact-match, case-sensitive duplicate detection exists but is insufficient
- Need matching on more fields: phone number, email (like CRM dedup)
- Case-insensitive matching needed
- Some "duplicates" are intentional workarounds — same organization with different program models needing separate NQMS assessments (e.g., "Buddy Program - School Based" vs "Buddy Program - Community Based")
- Multi-assessment support (#11) would partially solve this by letting one program have multiple assessments, reducing the need for duplicate entries
- Mike is comfortable with annual affiliate-driven cleanup rather than heavy automated dedup
- Sandy pushing for data maintenance requirements in affiliate agreements

**The organization field connection (#17):**
- Reviving the organization field would establish parent-child relationships (organization owns programs)
- This would help differentiate legitimate same-name programs (same org, different models) from true duplicates
- Organization field exists in DB and on public form but was removed from admin view due to misuse
- Currently no ability to manage organizations as a separate entity — would need a management UI
- #17 was deferred as too complex, which means #3 scope remains unclear

**Directional approach:**
- Improve existing duplicate detection: case-insensitive matching, match on additional fields (phone, email)
- Wait for #11 (multi-assessment) to reduce the duplicate workaround problem before investing heavily in dedup
- Organization field (#17) revival would be the strategic long-term solution but is deferred
- Scope will narrow naturally once #11 is implemented and the duplicate landscape is reassessed

**To unblock:** #11 multi-assessment is now estimated (Group 7, 40-64h) — once implemented, the duplicate landscape should be reassessed. Decisions on #17 (organization field) inform the long-term approach. A scoping session after #11 is built would be ideal.

---

## Deferred

These items were intentionally deferred during scope review meetings. They are not blocked — the team agreed to revisit them later.

### #10 — Public-Facing Site Improvements

**Why deferred:** MENTOR needs to internally align on strategy before any technical work.

**Context:** The public search page conflates two distinct user needs: "become a mentor" vs. "find a mentor/mentee for me or someone else." The second option was added as a hack, never an intentional strategic decision. Mike shared a longer-term vision of Mentor Connector as a multi-use directory serving mentors, caregivers/parents, funders, researchers, and potentially young people directly. Liability concerns were raised about minors accessing the system. Sandy proposed a landing page that routes users by intent.

**Decision:** No technical changes until MENTOR internally defines the strategy for serving different audiences. Search algorithm changes (#27) proceed independently.

**Revisit when:** MENTOR holds their internal strategy discussion on search page audiences and purpose.

---

### #15 — Full Data Export for Research

**Why deferred:** Mike's evaluation plan is not yet defined; interim approach agreed.

**Context:** Mike wants assessment data combined with program profile data in CSV format for researchers using SPSS/Stata. However, the evaluation plan won't be fleshed out for 3-4 months. Agreed on interim approach: Orases provides ad-hoc CSV data exports via SQL query on request rather than building a full in-tool export.

**Revisit when:** June/July 2026 when Mike has clarity on the evaluation plan and researcher data requirements. May overlap with #29 (centralized export hub) Phase 2.

---

### #17 — Data Field Enhancements (Organization Field)

**Why deferred:** Too complex for current scope — zero organizations in production, would require defining parent-child relationships and building a management UI.

**Context:** The organization field was removed from admin view in the 2023 relaunch due to misuse (users listed national affiliations instead of local ones). The field still exists in the database and on the public application form. Reviving it would help with duplicate detection (#3) and establishing program-to-organization relationships, but would require: a management UI for organizations, a parent-child relationship model, and significant data cleanup.

**Revisit when:** If duplicate detection (#3) needs or CRM sync requirements drive the need for organizational hierarchy. This is a foundational data model change, not a quick enhancement.

---

### #23 — Inquiries Module Cleanup

**Why deferred:** What started as a simple cleanup (remove the "ROLE" field) revealed a larger redesign need.

**Context:** The inquiry masking/reveal process (admin sees masked email/phone until clicking "Contacted") is confusing to users. Sandy: "A lot of times people are confused. They can't find that information." Aksana: "It could be that it's just over-engineered for what it is." The group agreed this needs a full redesign, not a patch.

**Revisit when:** A dedicated focused session is scheduled to redesign the inquiries workflow from scratch.

---

### #24 — SharePoint Migration for Document Storage

**Why deferred:** Heavy infrastructure lift with low user-facing impact. Current file-based storage works.

**Context:** Documents are stored on the local file system. Migration to SharePoint would improve scalability and enterprise features, but is a significant backend effort that would be transparent to users. Not discussed in detail during Meeting 3.

**Revisit when:** After higher-priority items are completed. This is a future-phase infrastructure improvement.

---

### #26 — Public Program Search & Mentee Discovery

**Why deferred:** Directly tied to #10 — cannot scope technical changes until MENTOR defines the public site strategy.

**Context:** The system doesn't fully support mentee requests. There's no clear pathway distinction between volunteer/mentor search and mentee/family search. Programs with long waitlists may hesitate to be listed publicly. All of these decisions depend on the same strategic alignment that blocks #10.

**Revisit when:** After MENTOR's internal strategy discussion on public search audiences (same trigger as #10).

---

## Key Blockers Summary

| Blocker | Owner | Unblocks | Status |
|---------|-------|----------|--------|
| Program export field list | Sandy | #2 | Pending — Sandy to send desired fields |
| Program field inventory spreadsheet | Sandy | #22, #25, #29 | Pending — Sandy marking which fields display publicly |
| MENTOR internal strategy discussion | Tim / Mike / Sandy | #10, #26 | No timeline set |
| #11 implementation + #17 decisions | Development + MENTOR | #3 | #11 now estimated (Group 7); #17 still deferred |

*Note: #11 and #30 were moved to estimated status in July 2026 (see `07_NQMS_Enhancements.md`). Discovery session with Mike still recommended to finalize scope but medium-confidence estimates are included in the Group 7 total.*
