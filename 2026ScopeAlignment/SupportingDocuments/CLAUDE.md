# CLAUDE.md — Supporting Documents

## What This Is

Deep-dive research and code analysis for specific items from `../SystemEnhancements.md`. When an enhancement item needs investigation before it can be estimated or turned into a PRD, the analysis goes here.

## Naming Convention

Files are named by item number from the master list: `Item{##}_{Topic}_{Type}.md`

## Files

| File | Item # | What It Covers |
|------|--------|---------------|
| `Item20_AffiliateInactiveStatus_CodeAnalysis.md` | #20 | Code analysis of how affiliate inactivation works and what it affects |
| `Item20_DeletedProgramStatus_CodeAnalysis.md` | #20 | Code analysis of program deletion status — what happens to deleted programs |
| `Item21_NationalAffiliate_Complete.md` | #21 | Complete analysis of the National Affiliate concept for orphan programs — requirements, implementation options, impact |
| `SearchAlgorithm_DataGapAnalysis.md` | #27 | Analysis of data gaps affecting the search algorithm and program visibility |
| `MetricsDashboards_Recommendations.md` | #1, #3, #11, #15, #27 | 6 prioritized dashboard specs with interactive demo links (in `../demos/`). Covers program health, data quality, analytics, NQMS status/impact, user activity. |

## Workflow

1. Item is identified in `SystemEnhancements.md`
2. If it needs research before estimating, a supporting doc is created here
3. Findings feed into `../estimates/` (hour estimates) and/or `../PRDs/` (detailed requirements)
