# Item #21: National Affiliate for Orphan Programs — Complete Package

**Enhancement:** National Affiliate "Safety Net" for Orphan Programs
**Status:** Work Estimate Complete, Pending Scheduling
**Last Updated:** February 2026

This document consolidates all Item #21 materials into a single reference:
- [Part 1: Product Requirements Document (PRD)](#part-1-product-requirements-document)
- [Part 2: Option B Recommendation & Business Analysis](#part-2-option-b-recommendation--business-analysis)
- [Part 3: Work Estimate](#part-3-work-estimate)
- [Part 4: Client Communication (Draft)](#part-4-client-communication-draft)

---

# Part 1: Product Requirements Document

## Programmatic Assignment for Orphan Programs

## Executive Summary

Implement a "National Affiliate" that acts as an automatic safety net for orphan programs (programs not assigned to any affiliate due to ZIP code mismatches). This programmatic solution automatically assigns unmatched programs to the National Affiliate without requiring manual ZIP code maintenance.

### Business Impact
- Eliminates 750+ orphan programs blocking new scoped affiliate access features
- Saves ~98 hours/year of ongoing maintenance work
- Provides automatic data quality visibility
- Enables consistent affiliate assignment for 100% of programs

---

## Background and Problem Statement

### Current State

Programs are assigned to affiliates by matching program location ZIP codes with affiliate service area ZIP codes. Currently, 750+ programs have no affiliate assignment because their ZIP codes don't match any affiliate's service area.

### Problems

**Problem 1: Orphan Programs Block New Features**
- 750+ programs have no parent affiliate assignment
- New scoped affiliate access permissions require parent affiliate
- Cannot roll out new permission features for 750+ programs

**Problem 2: Manual Maintenance Not Scalable**
- Alternative approach requires extracting ~500-1,000 unique ZIP codes
- Requires manual maintenance when programs change locations
- Requires updates when affiliates expand/contract service areas
- Estimated 98 hours/year ongoing maintenance burden

### Impact if Not Addressed

New affiliate permission features cannot be utilized for 750+ programs, creating inconsistent user experience and limiting feature adoption.

---

## Goals and Objectives

### Primary Goals

1. **Automatic Assignment**: Every program automatically assigned to an affiliate (no orphans)
2. **Zero Maintenance**: No ongoing manual ZIP code maintenance required
3. **Feature Enablement**: New scoped affiliate access features work for 100% of programs

### Success Criteria

- All 750+ current orphan programs automatically assigned to National Affiliate
- New programs without ZIP code matches automatically assigned to National Affiliate
- Assignment logic self-heals when programs change locations or affiliates change service areas
- Zero manual maintenance required post-deployment

---

## Target Users

### Primary Users

**1. Mentor Staff (Administrators)**
- **Role**: System administrators managing program and affiliate data
- **Need**: Clear ownership and assignment for all programs
- **Pain Point**: 750+ orphan programs with no affiliate assignment
- **Benefit**: Automatic assignment eliminates manual tracking and maintenance

**2. Affiliate Users (Limited Access)**
- **Role**: Users with scoped access to specific affiliate programs
- **Need**: Consistent permission model across all programs
- **Pain Point**: Cannot access orphan programs with new permission features
- **Benefit**: All programs have parent affiliate, enabling consistent access control

---

## Scope

This enhancement introduces a "National Affiliate" designation that automatically catches orphan programs (programs without ZIP code matches to regular affiliates). The National Affiliate functions like a regular affiliate throughout the system, with key differences: no service area required, and displays orphan programs instead of ZIP-matched programs. This orphan program logic applies consistently across program search, user access, and reporting (including NQMS assessments).

### Feature 1: National Affiliate Configuration

**What**: Create a special affiliate type that serves as a catch-all for programs without geographic affiliate matches.

**Includes:**
- Ability to designate one affiliate as "National Affiliate" in the system
- System enforces only one National Affiliate can exist at a time
- National Affiliate does not require service area (ZIP code) configuration
- Orphan programs (programs without ZIP matches) automatically assigned to National Affiliate

### Feature 2: Affiliate Management - National Affiliate Support

**What**: Enable administrators to create, edit, and find the National Affiliate through existing affiliate management pages.

**Includes:**

**Add Affiliate Page:**
- "National Affiliate" checkbox field
- Validation preventing duplicate National Affiliate creation
- When "National Affiliate" is checked, service area fields are disabled/hidden (National Affiliate does not use service areas)

**Edit Affiliate Page:**
- "National Affiliate" checkbox field (matching Add page)
- Validation preventing duplicate National Affiliate
- When "National Affiliate" is checked, service area fields are disabled/hidden
- Warning when removing National Affiliate designation (includes count of programs that will become orphans)

**Affiliate Index Page:**
- "National Affiliate" filter checkbox to quickly locate the affiliate
- All existing filters continue to work
- Search by name works for National Affiliate

**Affiliate View Page:**
- Service Area tab hidden for National Affiliate (not applicable)
- Programs tab displays orphan programs instead of ZIP-matched programs
- All other affiliate functionality works identically

### Feature 3: Program Display and Assignment

**What**: Programs assigned to National Affiliate display and behave consistently with regular affiliate assignments throughout the system.

**Includes:**

**Browse Programs Table:**
- Orphan programs display "Mentor National" in Affiliate column
- Visual distinction required to help users easily identify orphan programs:
  - Different styling/formatting from regular affiliate display (e.g., badge, icon, color, or italic text)
  - Clear visual indicator that this is National Affiliate vs regular affiliate

**Automatic Assignment:**
- Programs automatically reassign based on ZIP code matches (no manual intervention)
- New orphans → National Affiliate
- Orphan gains ZIP match → Moves to regular affiliate
- Regular affiliate match lost → Moves to National Affiliate

### Feature 4: Program Search and Filtering - National Affiliate Support

**What**: Enable users to search and filter programs specifically for National Affiliate using same interface as regular affiliates.

**CRITICAL**: When querying programs by National Affiliate, system must return orphan programs (programs with NO ZIP matches), NOT ZIP-matched programs. This orphan program logic applies everywhere National Affiliate is queried: Affiliate View Programs tab, program search/filter, NQMS assessments filter, user access dropdowns, permission enforcement, and any other search form that filters by affiliate. Regular affiliates continue using ZIP code matching logic.

**Includes:**

**National Affiliate Filter (Dedicated):**
- "National Affiliate" checkbox in program search/filter form
- When checked, displays only orphan programs (programs assigned to National Affiliate)
- Works in combination with all other existing filters
- Provides quick way to isolate National Affiliate programs without using dropdown

**Search by Affiliate Name:**
- User can type and select "Mentor National" in affiliate search dropdown
- Returns orphan programs (different query logic than regular affiliates)
- Regular affiliates continue to use ZIP code matching logic

**Affiliate Dropdown/Autocomplete:**
- National Affiliate ("Mentor National") appears in affiliate selection lists
- Selecting National Affiliate from dropdown returns orphan programs
- Works consistently across all search contexts

**Note:** Both the dedicated "National Affiliate" checkbox filter AND the affiliate dropdown are available. Users can use either method to search for National Affiliate programs.

### Feature 5: NQMS Assessments - National Affiliate Reporting

**What**: Enable filtering NQMS assessments by National Affiliate with proper orphan program logic.

**CRITICAL**: When filtering assessments by National Affiliate, system must return assessments for orphan programs (programs with NO ZIP matches), NOT ZIP-matched programs. This matches the orphan program logic used throughout the system.

**Includes:**

**NQMS Assessments Report Filter:**
- National Affiliate appears in affiliate filter dropdown
- When "Mentor National" selected, returns assessments for orphan programs only
- "National Affiliate" checkbox filter for quick isolation (in addition to dropdown)
- Works in combination with all other existing assessment filters
- Regular affiliates continue using ZIP code matching logic

**Other Search Forms:**
- Add "National Affiliate" checkbox filter to all forms that filter by affiliate
- Checkbox provides quick way to filter for orphan programs
- Applies orphan program logic (not ZIP matching) when selected

### Feature 6: User Access Control - National Affiliate Permissions

**What**: Administrators can grant users access to National Affiliate programs using same access control interface as regular affiliates.

**Includes:**

**Affiliate Selection:**
- National Affiliate searchable and selectable in User Profile → Affiliate Access section
- Selection enables scope configuration

**Full Access Scope:**
- User granted access to ALL programs assigned to National Affiliate (all orphan programs)
- Access is dynamic: automatically includes new orphan programs added after configuration
- Works identically to full access for regular affiliates

**Limited Access Scope:**
- User granted access to specific program(s) only
- Program selection dropdown displays only orphan programs (programs assigned to National Affiliate)
- User can select one or multiple specific programs
- User cannot access other orphan programs not selected

**Multiple Affiliate Access:**
- User can have access to National Affiliate AND regular affiliates simultaneously
- Permissions are additive (user sees programs from all assigned affiliates)
- No conflicts between National and regular affiliate access

### Out of Scope

The following are explicitly NOT included in this enhancement:

**Not Included:**
- Manual curation or selection of which programs belong to National Affiliate (fully automatic)
- Backfilling affiliate service areas to eliminate orphan programs
- Special administrative UI or dashboard for National Affiliate management
- Custom reporting dashboards or analytics specific to National Affiliate metrics
- Data quality reports or monitoring tools specific to orphan programs
- Bulk reassignment tools for moving programs between affiliates
- Changes to NQMS assessment creation, editing, or scoring workflows (only filtering affected)
- Public-facing changes (National Affiliate is internal administrative designation only)
- Changes to existing regular affiliate functionality or ZIP code matching logic

---

## Edge Cases

**No National Affiliate Exists**: Programs without ZIP matches remain orphans (current state continues)

**Program Has No Locations or Invalid ZIP**: Program assigned to National Affiliate (treated as orphan)

**Removing National Affiliate Flag**: System displays warning with program count and requires confirmation. If confirmed, programs become orphans.

**National Affiliate Made Inactive**: Programs remain assigned; matching logic stops assigning new orphans until reactivated

**Regular Affiliate Becomes Inactive**: Program with no other ZIP matches automatically reassigns to National Affiliate

**User Access When Program Moves**: User with limited access to National Affiliate programs loses access if program moves to regular affiliate (access is affiliate-specific, not program-specific)

---

## Acceptance Criteria / Definition of Done

### Feature 1: National Affiliate Configuration
- [ ] Administrator can designate one affiliate as "National Affiliate"
- [ ] System prevents creation of second National Affiliate with clear error message
- [ ] National Affiliate can be created without service area configuration
- [ ] All 750+ current orphan programs automatically assigned to National Affiliate on deployment
- [ ] New orphan programs automatically assigned to National Affiliate going forward

### Feature 2: Affiliate Management - National Affiliate Support
- [ ] "National Affiliate" checkbox appears on Add Affiliate page with validation
- [ ] When "National Affiliate" is checked on Add page, service area fields are disabled/hidden
- [ ] "National Affiliate" checkbox appears on Edit Affiliate page with validation
- [ ] When "National Affiliate" is checked on Edit page, service area fields are disabled/hidden
- [ ] Warning with program count displays when unchecking National Affiliate flag
- [ ] "National Affiliate" filter checkbox works on Affiliate Index page
- [ ] All existing affiliate filters and search continue to work unchanged
- [ ] Service Area tab hidden on Affiliate View page for National Affiliate
- [ ] Programs tab on Affiliate View page displays orphan programs for National Affiliate
- [ ] All other affiliate functionality works identically for National Affiliate

### Feature 3: Program Display and Assignment
- [ ] Browse Programs table displays "Mentor National" for orphan programs
- [ ] National Affiliate has distinct visual styling in Affiliate column (badge, icon, color, or italic text)
- [ ] Visual distinction makes it easy for users to identify orphan programs at a glance
- [ ] Programs automatically reassign when ZIP matches change (e.g., regular to National, National to regular)
- [ ] No existing program-affiliate assignments disrupted by deployment
- [ ] Program assignment happens automatically without manual intervention

### Feature 4: Program Search and Filtering
- [ ] "National Affiliate" checkbox filter works on program search/filter page (dedicated filter)
- [ ] Searching by "Mentor National" name in affiliate dropdown returns orphan programs (not ZIP-matched)
- [ ] National Affiliate appears in affiliate dropdowns/autocomplete across all search contexts
- [ ] Selecting National Affiliate from dropdown applies correct query logic (orphan programs)
- [ ] Both dedicated checkbox filter AND dropdown selection work correctly (two ways to search)
- [ ] All existing program filters work in combination with National Affiliate filter
- [ ] Regular affiliate searches continue using ZIP code matching logic

### Feature 5: NQMS Assessments and Reporting
- [ ] National Affiliate ("Mentor National") appears in NQMS Assessments affiliate filter dropdown
- [ ] Filtering by National Affiliate returns assessments for orphan programs (not ZIP-matched)
- [ ] "National Affiliate" checkbox filter works on NQMS Assessments report
- [ ] "National Affiliate" checkbox filter added to all other search forms that filter by affiliate
- [ ] Checkbox filter works in combination with other filters
- [ ] Regular affiliate filtering continues using ZIP code matching logic
- [ ] All existing assessment filters work unchanged

### Feature 6: User Access Control
- [ ] National Affiliate ("Mentor National") searchable and selectable in User Profile → Affiliate Access
- [ ] Full Access to National Affiliate grants access to all orphan programs dynamically
- [ ] Limited Access shows only orphan programs in program selection dropdown
- [ ] Limited Access correctly restricts user to selected programs only
- [ ] When program moves from National to regular affiliate, user with limited access loses access to that program
- [ ] Users with National Affiliate access can view/edit assigned programs
- [ ] Users can have access to both National and regular affiliates simultaneously (additive permissions)
- [ ] Existing user access to regular affiliates remains unchanged

### User Experience
- [ ] Error messages are clear and helpful when attempting to create duplicate National Affiliate
- [ ] Users can quickly locate National Affiliate using index page filter
- [ ] National Affiliate behaves consistently with regular affiliates (except service area)
- [ ] No confusion or unexpected behavior when interacting with National Affiliate
- [ ] Programs assigned to National Affiliate function identically to regularly assigned programs

### Data Quality & Integrity
- [ ] All programs have affiliate assignment (zero orphans after deployment)
- [ ] No data loss during deployment
- [ ] Assignment logic handles edge cases correctly (no locations, invalid ZIP, inactive affiliates)
- [ ] Existing program assignments remain intact

### Regression & Quality
- [ ] All existing affiliate management functionality works unchanged
- [ ] Regular affiliate ZIP matching logic unaffected
- [ ] User access permissions for regular affiliates unaffected
- [ ] No performance degradation in program queries or assignment logic
- [ ] System stable and error-free after deployment

---
---

# Part 2: Option B Recommendation & Business Analysis

**Document Type:** Technical Recommendation & Business Analysis
**Prepared By:** Aksana Rahouski
**Date:** January 28, 2026
**Status:** Recommended for Client Approval

---

## Executive Summary

We recommend implementing **Option B: Programmatic Safety Net Approach** for managing orphan programs (programs not assigned to any affiliate). This recommendation is based on analysis of the current data volume, maintenance complexity, and long-term scalability requirements.

**Key Decision Factors:**
- **750+ orphan programs** identified across multiple states and zip codes
- **High variability** in geographic distribution requiring complex manual maintenance
- **Option A (Manual/Script Approach)** creates unsustainable ongoing maintenance burden
- **Option B (Programmatic Approach)** provides automated, self-healing solution with zero ongoing maintenance

---

## Option A: Manual/Script Approach - Why Not Recommended

### Initial Setup Complexity

To implement Option A, we must:
- Query all 750+ orphan programs
- Identify all program locations for each program
- Extract all unique ZIP codes across all locations
- Manually add every State:ZIP Code combination to the National Affiliate's service area

**Estimated Data Points:**
- 750 programs x average 2-3 locations = ~1,500-2,250 location records
- Estimated 500-1,000+ unique ZIP codes to manage
- **Total Initial Setup: 18-34 hours**

### Ongoing Maintenance Burden (~98 hours/year)

| Scenario | Frequency | Time per Update |
|----------|-----------|-----------------|
| New Programs Added | Weekly/bi-weekly | 2-4 hours |
| Program Location Changes | Ongoing | 1-2 hours |
| Affiliate Coverage Changes | Quarterly | 4-8 hours |
| Affiliate Inactivation | 2-4x/year | 4-8 hours each |
| Data Cleanup Efforts | Ongoing | Variable |
| **Total Annual** | | **~98 hours/year (2.5 weeks)** |

### Data Quality & Synchronization Risks
- Risk of typos when manually entering ZIP codes
- Synchronization drift between service area and actual programs
- Does not scale with program growth

---

## Option B: Programmatic Safety Net - Recommended

### How It Works

```
FOR EACH Program:
  1. System checks program location ZIP codes against all ACTIVE affiliates' service areas
  2. IF match found with regular affiliate → assign to that affiliate(s) (existing behavior)
  3. IF NO match found with any regular affiliate → automatically assign to National affiliate (NEW behavior)
```

### Key Advantages

| Factor | Option A | Option B |
|--------|----------|----------|
| Initial Setup | 18-34 hours | 8-12 hours |
| Annual Maintenance | ~98 hours/year | 0 hours/year |
| Scalability | Linear growth | Automatic |
| Data Quality Risk | High (manual) | Low (automatic) |
| Self-Healing | No | Yes |

### Cost-Benefit Analysis (3-Year)

| | Option A | Option B |
|--|----------|----------|
| Year 1 | $17,400-$19,800 | $7,900-$11,900 |
| Year 2 | $14,700 | $0 |
| Year 3 | $14,700 | $0 |
| **3-Year Total** | **$46,800-$49,200** | **$7,900-$11,900** |
| **3-Year Savings** | — | **$34,900-$37,300** |

---

## Risk Comparison

### Option A: Overall Risk HIGH
- Manual entry errors (HIGH likelihood)
- Synchronization drift (HIGH likelihood)
- Scaling issues (HIGH likelihood)
- Staff turnover knowledge loss (MEDIUM likelihood)

### Option B: Overall Risk LOW
- Development bugs (LOW likelihood, mitigated by testing)
- Logic errors (LOW likelihood, mitigated by code review)
- Performance impact (LOW likelihood, mitigated by indexing)

---

## Technical Implementation Notes

### Database Changes
- Add field: `is_safety_net` (boolean, default: false) to affiliates table
- No changes to programs, program_locations, service_areas, or postal_codes_service_areas tables

### Query Performance Considerations
- Matching logic runs on: program creation, location update, service area update, affiliate status change
- Requires proper indexes on: `affiliates.active`, `affiliates.is_safety_net`, `program_locations.program_id`, `program_locations.zip_code`

### SQL Query for Current Orphan Programs
```sql
SELECT p.id, p.title, p.status,
    COUNT(DISTINCT pl.id) AS location_count,
    COUNT(DISTINCT pl.zip_code) AS unique_zipcodes
FROM programs p
LEFT JOIN program_locations pl ON p.id = pl.program_id
LEFT JOIN sam_postal_codes pc ON pl.zip_code = pc.code
LEFT JOIN postal_codes_service_areas pcsa ON pc.id = pcsa.postal_code_id
LEFT JOIN service_areas sa ON pcsa.service_area_id = sa.id
WHERE p.status = 'approved'
GROUP BY p.id, p.title, p.status
HAVING COUNT(DISTINCT pcsa.id) = 0
ORDER BY p.title;
```
**Result:** ~750 orphan programs identified (as of January 2026)

---
---

# Part 3: Work Estimate

**Project**: Item 21 - National Affiliate Implementation
**Date**: February 27, 2026
**Estimator**: Engineering Team

---

## Summary

**Total Estimated Effort**: **96-120 hours** (12-15 business days)
**Complexity Level**: Medium-High
**Risk Level**: Medium
**Recommended Buffer**: 24 hours
**Total with Buffer**: **120-144 hours** (15-18 business days)

### Time Assumptions
- Based on 8-hour workdays
- Estimates include development, testing, and documentation
- Does not include meeting time, code review time, or context switching overhead

---

## Breakdown by Feature

| Feature | Hours | Complexity | Risk |
|---------|-------|------------|------|
| Feature 1: Core Configuration & Migration | 16-24 | High | High |
| Feature 2: Affiliate Management UI | 16-24 | Medium | Medium |
| Feature 3: Program Display & Assignment | 8-16 | Low-Medium | Low |
| Feature 4: Search & Filtering | 16-24 | High | High |
| Feature 5: NQMS Reporting | 12-16 | Medium | Medium |
| Feature 6: User Access Control | 16-24 | High | High |
| Testing & QA | 16-24 | Medium | High |
| **Total** | **96-120** | — | — |
| **Buffer** | **24** | — | — |
| **Total with Buffer** | **120-144** | — | — |

---

## Recommended Implementation Phases

### Phase 1: Foundation (32 hours / 4 days)
- Database schema and migration
- Core business logic (orphan detection, automatic assignment)
- Assignment automation and validation
- Unit testing
- **Milestone**: 750+ programs correctly assigned in staging

### Phase 2: Management UI (32 hours / 4 days)
- Add/Edit/View affiliate pages with National Affiliate support
- Index page filtering
- Visual distinction in Browse Programs
- **Milestone**: Administrators can manage National Affiliate

### Phase 3: Search and Access (32 hours / 4 days)
- Program search checkbox filter and dropdown integration
- NQMS assessments filtering
- User access control (full and limited scope)
- Permission enforcement
- **Milestone**: Users can search, filter, and access National Affiliate programs

### Phase 4: Testing and Refinement (24 hours / 3 days)
- Comprehensive QA, edge case, regression, and performance testing
- UAT with administrators
- Bug fixes and refinements
- **Milestone**: Production-ready, all acceptance criteria met

---

## High Risk Areas

1. **Migration of 750+ Programs** — Must be bulletproof and reversible
2. **Query Logic Divergence** — Orphan vs ZIP-matching logic must be clearly separated
3. **Permission Enforcement** — Security-critical, requires thorough testing

## Confidence Level

**Overall**: Medium-High (75-80%)
- High confidence (90%+): UI changes, display logic, reporting
- Medium confidence (70-80%): Migration, query logic, dynamic permissions

---
---

# Part 4: Client Communication (Draft)

**To:** [Client Name/Team]
**From:** Aksana Rahouski, Orases
**Date:** January 28, 2026
**Re:** Important Update on Orphan Program Volume & Recommendation to Discuss Approach (Item #21)

---

## Purpose

We've completed our analysis of "orphan programs" (programs not assigned to any affiliate) and discovered new information about the scale of this challenge that significantly impacts our recommended approach. We'd like to schedule time to discuss this finding and our revised recommendation.

---

## Background: What We Discovered

As we worked through Item #21 (National Affiliate for Orphan Programs), we ran SQL queries to understand the scope of the orphan program challenge.

**Key Finding:** We discovered that approximately **750 programs** are currently not assigned to any affiliate because their location ZIP codes don't match any affiliate's service area coverage.

This volume is significantly higher than initially anticipated and represents a substantial portion of your total program inventory. These programs span multiple states with high geographic variability in their ZIP codes.

**Why This Matters:**

This creates several immediate challenges:
- Programs lack clear ownership and management responsibility
- New scoped affiliate access features cannot work for these programs (requires parent affiliate)
- No automated way to identify or manage these programs
- Data quality visibility is reduced

But more importantly, **this volume changes our recommended approach** for solving the problem.

---

## Impact on Our Original Approach

When we initially discussed Item #21, we outlined **Option A: Manual/Script Approach** - creating a "Mentor National" affiliate and manually adding all orphan program ZIP codes to its service area coverage.

**This approach made sense when we thought orphan program volume was smaller.**

However, now that we know the actual volume is **750+ programs** spanning multiple states with high geographic variability:

**Option A creates significant challenges:**

- **Initial setup complexity:** Extract all unique ZIP codes from 750+ programs, organize by state, manually add to service area. Estimated effort: 18-34 hours
- **Ongoing maintenance burden:** ~98 hours per year (approximately 2.5 weeks of work) for continuous updates as programs change, affiliates expand/contract, data cleanup modifies locations

**Key concern:** With 750+ programs, manually maintaining a static list of all their ZIP codes becomes a time-consuming, ongoing responsibility that doesn't scale.

---

## Alternative Approach Worth Discussing: Option B - Programmatic Safety Net

Instead of manually maintaining ZIP codes, we could create a "Mentor National" affiliate that functions differently from regular affiliates:

**How it would work:**
- This affiliate wouldn't match on ZIP codes at all (unlike regular affiliates)
- It would automatically capture any program that doesn't match any other affiliate's service area
- Think of it as: "everybody who didn't get a home will land in the safety net"

**Potential Benefits:**
- Zero ongoing maintenance (no scripts, no ZIP code updates)
- Scales automatically with program growth
- Self-healing when programs change locations or affiliates change coverage
- Programs in National affiliate serve as automatic "data quality report"
- Enables scoped affiliate access for 100% of programs

**What This Would Require:**
- Code changes to affiliate-to-program matching logic (medium complexity)
- Estimated timeline: 6-7 weeks for development, testing, and deployment

---

## Our Perspective

Based on the **new information about program volume (750+ programs)**, we believe the approach to solving this problem needs to be reconsidered.

**What we recommend:**

We recommend scheduling time to discuss:
- Whether the scale of Option A's maintenance burden aligns with your team's capacity
- Whether Option B (Programmatic Safety Net) is worth exploring further
- Trade-offs between implementation approaches
- How this decision fits with your broader data cleanup and system improvement priorities

Please let us know your availability for a 30-45 minute discussion.

---

## Document History

| Date | Version | Change | Author |
|------|---------|--------|--------|
| January 28, 2026 | 1.0 | Initial PRD and recommendation | Aksana Rahouski |
| January 28, 2026 | 1.0 | Client communication draft | Aksana Rahouski |
| February 27, 2026 | 2.0 | Work estimate added by Engineering Team | Engineering Team |
| March 2026 | 3.0 | Consolidated all Item 21 materials into single document | Aksana Rahouski |
