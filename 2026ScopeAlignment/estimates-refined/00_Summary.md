# Refined Estimates Summary — 2026 Scope
**Last Updated:** May 2026
**Based On:** Scope Review Meetings 1-3 (March-May 2026)
**Status:** Complete

---

## Overview

These estimates reflect the **refined scope** agreed during client scope review meetings. Items are grouped by codebase area and delivery efficiency — working on related items together reduces context switching and leverages shared code changes.

Only **estimate-ready** items are included. Items that are deferred, blocked on MENTOR, or need discovery sessions are excluded (see `SystemEnhancements.md` Estimation Readiness table for full status).

---

## Estimate Groups

| # | Group | Items | Hours (Low) | Hours (High) | Doc |
|---|-------|-------|-------------|--------------|-----|
| 1 | UI/UX Polish & Navigation | #4, #6, #7 (badges), #12, #13 | 20 | 30 | `01_UIUX_Polish_Navigation.md` |
| 2 | Program Status & Archive Lifecycle | #1, #7 (+#28) | 14 | 22 | `02_Program_Status_Archive.md` |
| 3 | Search & Filters | #9, #14, #27 | 52 | 76 | `03_Search_Filters.md` |
| 4 | Affiliate Management | #19, #20, #21 | 128 | 167 | `04_Affiliate_Management.md` |
| 5 | Automation & Engagement | #16 | 34 | 50 | `05_Automation_Engagement.md` |
| 6 | Login & Onboarding | #5, #8 | 16 | 28 | `06_Login_Onboarding.md` |
| | **Grand Total** | **15 items** | **264** | **373** | |

**Range: 264-373 hours (33-47 business days)**

---

## Not Included in Estimates

| Item | Reason |
|------|--------|
| #2 — Export Capabilities | Blocked on Sandy's field list |
| #3 — Duplicate Detection | Needs discovery (depends on #17) |
| #10 — Public-Facing Site | Deferred — MENTOR internal strategy |
| #11 — Multi-Assessment | Needs discovery session with Mike |
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
| #30 — Goal Status | Needs discovery session with Mike |

---

## Notes

- Hours include development, QA/testing, and code review
- Does not include meeting time, deployment, or context switching overhead
- Item #21 has a detailed standalone estimate (`estimates/Item21_NationalAffiliate_WorkEstimate.md`) — Group 4 references it
- Bundling savings are called out per group where applicable
