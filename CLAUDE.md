# CLAUDE.md — MENTOR Project

## What This Is

This is the top-level working directory for the MENTOR platform — a web-based system that connects prospective mentors and mentees with mentoring programs across the US and Canada. It's built and maintained by Orases for MENTOR (mentoring.org).

## The Three Repositories

The platform consists of three interconnected applications:

| Repo | Tech | Purpose |
|------|------|---------|
| `mentor-connect/` | CakePHP 4.6, PHP 8.1, MySQL 8.0 | Backend API + admin system. Stores all data, processes searches, manages programs and NQMS assessments. |
| `mentor-connect-app/` | Vue.js 2, TypeScript | User-facing frontend. Search results, program profiles, inquiry forms, admin dashboards. |
| `mentor-connect-3-step-app/` | Symfony 5.2, PHP 8.0 | Embeddable search form for partner websites. No database — just a form gateway. |

### How They Connect

```
Partner Website (mentoring.org, etc.)
  [3-Step App iframe] --GET redirect--> Connect App (Vue.js)
                                              |
                                          REST API (JSON)
                                              |
                                        Connector (CakePHP)
                                              |
                                        MySQL 8.0 + Redis
```

Each repo has its own `CLAUDE.md` with detailed technical guidance.

## Directory Guide

Every folder listed below has its own `CLAUDE.md` with detailed contents and navigation guidance.

### Active Work

| Folder | What's Inside |
|--------|--------------|
| `2026ScopeAlignment/` | **Current active work.** 2026 scope planning — 25 enhancement items, estimates (463–691h), PRDs, interactive dashboard demos, meeting notes, client feedback. Has its own git repo. |

### Platform Documentation

| Folder | What's Inside |
|--------|--------------|
| `Platform-documentation/` | All platform docs — architecture (how the 3 apps connect, search flow, component overviews) and operations (user roles, permissions, access controls, NQMS workflows). Start here if you're new to the project. |
| `Mentor Solution/` | **Deprecated — contents moved to `Platform-documentation/`.** Kept temporarily for reference. |

### Past Work (Reference)

| Folder | What's Inside |
|--------|--------------|
| `2025Scope-P2/` | Completed 2025 scope ($40K engagement) — NQMS assessments, documents, permissions, SOW items, affiliate access controls. The analysis here informed both the platform docs and 2026 planning. |
| `UpgradeTesting/` | CakePHP 4.4 to 4.6 upgrade test suite (587+ test cases). Completed Nov 2025. Has its own README.md and SUMMARY.md. |
| `Meetings/` | Meeting transcripts from Oct–Nov 2025 (Phase 2 kickoff and discovery). More recent 2026 scope meetings are in `2026ScopeAlignment/Meeting/`. |
| `SQL/` | Utility SQL scripts — affiliate zip code mappings and orphaned program detection. |

## Key Business Concepts

- **NQMS** — National Quality Mentoring System. A certification/badge framework for evaluating mentoring program quality. Core feature of the platform.
- **Partner** — An organization that embeds the 3-Step search form on their website.
- **Affiliate** — An organization affiliated with MENTOR that may oversee multiple programs.
- **Inquiry** — A request from a prospective mentor/mentee to connect with a specific program.
- **Service Area** — The geographic region a mentoring program serves.

## Environments

| Environment | URL | Purpose |
|-------------|-----|---------|
| Dev | Local (DDEV) | Internal development |
| Review | https://portal.review.mentor.orases.dev/ | Internal QA and testing |
| Staging | https://portal.stage.mentor.orases.dev/ | External QA, client validation |
| Production | https://portal.mentoring.org/ | Live platform |

## Team

| Name | Role |
|------|------|
| Aksana Rahouski | Product Manager / QA |
| Hyun Masiello | Project Manager |
| Daniel | Developer (backend/deployments) |
| Jack Stefani | Developer (support tickets/deployments) |
| Brent | Developer (infrastructure/DevOps) |

## Key Links

- **Slack Channel:** `#proj-mentor` (C036JKVV8BT)
- **Confluence Space:** https://orases.atlassian.net/wiki/spaces/MTR/overview

## Current Focus (2026)

Active scope alignment work lives in `2026ScopeAlignment/`. Key workstreams include:
- User account and data management improvements
- UI/UX enhancements
- Search and discovery improvements
- NQMS assessment enhancements
- Data field management
- Metrics dashboards
