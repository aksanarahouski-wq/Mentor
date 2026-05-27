# CLAUDE.md — User Roles & Access Documentation

## What This Is

Comprehensive documentation of the MENTOR Connector permission system, generated December 2025 through analysis of both Confluence docs and the actual codebase. Covers all 8 user roles, 3 access levels, and 10 protected modules.

**Status:** Complete, awaiting decisions on 3 discrepancies.

## Files — Quick Guide

### For Developers
| File | Use When |
|------|----------|
| `COMPLETE_PERMISSION_MATRIX.md` | Full technical reference — all roles, modules, database schema, code file locations |
| `QUICK_REFERENCE_GUIDE.md` | Fast lookup — role tables, SQL queries, code snippets, troubleshooting |
| `NQMS_ASSESSMENT_WORKFLOW_AND_PERMISSIONS.md` | Deep dive into assessment lifecycle — 15 actions documented with code references |
| `DISCREPANCIES_AND_ACTION_ITEMS.md` | 3 doc-vs-code mismatches needing team decisions |

### For Business Users
| File | Use When |
|------|----------|
| `BUSINESS_PERMISSION_GUIDE.md` | Plain-language role explanations, how to assign roles, common scenarios |
| `NQMS_ASSESSMENT_BUSINESS_GUIDE.md` | Assessment workflow without technical jargon — create, submit, approve, goals |
| `QA_TESTING_GUIDE.md` | Test scenarios for permission validation — 8 role-based test suites |

### Navigation
| File | Purpose |
|------|---------|
| `README.md` | Full overview with system architecture, role computation examples, business rules, troubleshooting |

## Key Facts

- **8 roles:** global, affiliate, mc_affiliate, nqms_affiliate, nqms_affiliate_limited, program, nqms_program, nqms_program_limited
- **3 access levels:** Full Access (1), MC-Only (2), NQMS-Only (3)
- **Critical rule:** Program users cannot approve their own assessments — only affiliate staff with service area coverage can
- **Contractors** can only have NQMS-Only access and can only edit the most recent assessment

## Open Discrepancies

1. **Program role consolidation** (HIGH) — Docs show separate full/MC-only program roles, code has one combined `program` role
2. **Contractor access not documented** (MEDIUM) — Docs don't specify contractors are limited to NQMS-Only
3. **Identical permission columns** (LOW) — Resolved by fixing #1
