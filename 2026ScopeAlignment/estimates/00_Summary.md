# Refined Estimates Summary — 2026 Scope
**Last Updated:** July 2026
**Based On:** Scope Review Meetings 1-3 (March-May 2026), prototype review (July 2026)
**Status:** Complete

---

## Overview

These estimates reflect the **refined scope** agreed during client scope review meetings. Items are grouped by codebase area and delivery efficiency — working on related items together reduces context switching and leverages shared code changes.

Group 7 (NQMS) was expanded in July 2026 to include Items #11 and #30, informed by the assessment prototype shared with the client. Items #11 and #30 carry medium confidence — discovery session with Mike still recommended to finalize scope.

Items that are deferred, blocked on MENTOR, or need discovery sessions are excluded (see `08_Not_Ready_To_Estimate.md` for details).

---

## Estimate Groups

| # | Group | Items | Hours (Low) | Hours (High) | Doc |
|---|-------|-------|-------------|--------------|-----|
| 1 | UI/UX Polish & Navigation | #4, #6, #7 (badges) | 14 | 22 | `01_UIUX_Polish_Navigation.md` |
| 2 | Program Status & Archive Lifecycle | #1, #7 (+#28) | 14 | 22 | `02_Program_Status_Archive.md` |
| 3 | Search & Filters | #9, #27 | 30 | 46 | `03_Search_Filters.md` |
| 4 | Affiliate Management | #19, #20, #21 | 72 | 109 | `04_Affiliate_Management.md` |
| 5 | Automation & Engagement | #16 | 34 | 50 | `05_Automation_Engagement.md` |
| 6 | Login & Onboarding | #5, #8 | 16 | 28 | `06_Login_Onboarding.md` |
| 7 | NQMS Assessment Enhancements | #11, #12, #13, #14, #30 | 73 | 121 | `07_NQMS_Enhancements.md` |
| | **Grand Total** | **18 items** | **253** | **398** | |

**Range: 253-398 hours (32-50 business days)**

*Note: Group 7 includes Items #11 and #30 at medium confidence — discovery session with Mike still needed to finalize scope. See `07_NQMS_Enhancements.md` for scope tiers and detailed breakdown.*

---

## Scope Tiers for Group 7 (NQMS)

The NQMS group has a wide range (73-121h) because it now includes assessment lifecycle and goal status work. The estimate document defines tiers to support budgeting conversations:

| Tier | Scope | Hours |
|------|-------|-------|
| Tier 1 | Quick wins only (#12, #13) | 4-6h |
| Tier 2 | Quick wins + progress tracking (#12, #13, #14) | 22-36h |
| Tier 3 | Full prototype (#11, #12, #13, #14, #30) | 73-121h |
| Tier 3a | Full prototype minus "View Previous Response" | 57-97h |

---

## Not Included in Estimates

| Item | Reason |
|------|--------|
| #2 — Export Capabilities | Blocked on Sandy's field list |
| #3 — Duplicate Detection | Needs discovery (depends on #17 and #11) |
| #10 — Public-Facing Site | Deferred — MENTOR internal strategy |
| #15 — Full Data Export | Deferred — revisit June/July 2026 |
| #17 — Organization Field | Deferred — too complex |
| #18 — Program Admin Perms | Descoped — no dev needed |
| #22 — Form Alignment | Blocked on MENTOR field inventory |
| #23 — Inquiries Redesign | Deferred — needs dedicated session |
| #24 — SharePoint Migration | Deferred |
| #25 — Public Search Iframe | Blocked on MENTOR field inventory |
| #26 — Public Program Search | Deferred — tied to #10 |
| #28 — Program Archive | Covered under #7 |
| #29 — Export Hub | Partially blocked on field inventory |

For full details on all non-estimated items (blockers, directional approach, what's needed to unblock), see `08_Not_Ready_To_Estimate.md`.

---

## Notes

- Hours include development, QA/testing, and code review
- Does not include meeting time, deployment, or context switching overhead
- Item #21 has a detailed standalone estimate (`Item21_NationalAffiliate_WorkEstimate.md`) — Group 4 references it
- Bundling savings are called out per group where applicable
