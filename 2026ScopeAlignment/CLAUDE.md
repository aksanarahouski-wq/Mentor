# CLAUDE.md — 2026 Scope Alignment

## What This Is

This is the active working directory for the 2026 MENTOR Connector scope alignment. It contains everything related to planning, estimating, and prioritizing enhancements for the platform's next phase of work.

The master list of all 30 enhancement items (with client feedback and review status) is in `SystemEnhancements.md`.

## Status

**Active** — This is the current focus area for the MENTOR project.

## Directory Contents

| Folder/File | What's Inside |
|-------------|--------------|
| `estimates/` | **Current estimates** — post-Meeting-3, grouped by codebase area. 7 groups covering 15 items, 210-321 hours total. Group 7 (NQMS) separated for independent budgeting. Includes Item 21 detailed estimate (96-120h). `00_Summary.md` has the rollup. |
| `PRDs/` | Product requirements documents for items that need detailed specs (e.g., Item 21 — National Affiliate access). |
| `demos/` | Interactive HTML dashboard prototypes (7 dashboards: data health, quality, NQMS impact/status, program analytics/health, user activity). `index.html` links to all of them. |
| `Prototypes/` | Prototype prompts and planning docs (e.g., NQMS prototype prompts). |
| `Meeting/` | Scope alignment meeting notes and summaries. Includes internal prep docs and client-facing summaries. |
| `ClientFeedback/` | Client-provided documents — strategy PDFs, enhancement wishlists, meeting minutes from the client side. |
| `SupportingDocuments/` | Code analysis, gap analysis, dashboard specs, and detailed technical research supporting scope decisions. |

## Enhancement Categories (30 items total)

1. **User Account & Data Management** (#1, #2, #3, #28) — account archive, exports, duplicate detection, program archive
2. **UI/UX Improvements** (#4–#8) — interface polish, usability
3. **Search & Discovery** (#9, #10, #25, #26, #27) — search algorithm, filters, public search
4. **NQMS Enhancements** (#11–#15, #30) — multi-assessment, history, data export, goal status
5. **Automation & Engagement** (#16)
6. **Data Field Management** (#17) — organization field changes
7. **Permissions & Access** (#18–#21) — including National Affiliate cross-region access
8. **Forms & Data Collection** (#22, #23)
9. **Infrastructure** (#24)
10. **Data & Reporting** (#29) — centralized export hub

## Key Decisions Pending

- Item #3 (Duplicate Detection) — scope narrowing needed after Meeting 3
- Item #15 (Full Data Export) — deferred to June/July 2026
- Item #2 (Export Capabilities) — blocked on Sandy's desired field list

## Team

### MENTOR (Client)
- **Mike Garringer** — Senior Director of Research and Quality, product owner
- **Rachel Bennett** — Research Manager, testing/feedback
- **Sarah Provino** — MENTOR Colorado, power user and tester
- **Tim Wills** — Chief Impact Officer, sponsor
- **Sandy** — System oversight, NQMS lead

### Orases (Internal)
- **Aksana Rahouski** — Senior Product Manager
- **Hyun Masiello** — Project Manager
