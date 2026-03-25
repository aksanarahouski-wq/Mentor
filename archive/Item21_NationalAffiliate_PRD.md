# National Affiliate "Safety Net" Enhancement
## Programmatic Assignment for Orphan Programs
---

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
