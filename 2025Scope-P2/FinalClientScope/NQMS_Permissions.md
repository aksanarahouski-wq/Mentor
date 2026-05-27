# NQMS Permissions Enhancement: Specific Program Access

## Overview

This enhancement addresses a critical limitation in affiliate staff permissions by allowing assignment to specific programs outside their geographic service area while maintaining affiliate relationships for approval workflows and reporting.

---

## Problem Statement

### Current State

- Affiliate staff can only access programs in their geographic service area (determined by ZIP codes)
- Direct program access exists but doesn't maintain affiliate context or grant approval permissions

### Business Impact

- **Blocks cross-affiliate NQMS consulting relationships** - Washington consultants cannot support California programs
- **Requires manual workarounds** that compromise data integrity
- **Prevents proper approval workflows** for out-of-state support
- **Limits resource sharing** across affiliate boundaries

### Root Cause

The system only supports "all programs in region" access based on ZIP code matching. There's no mechanism to assign specific programs while maintaining the affiliate relationship required for:

- Assessment approval permissions
- Affiliate-based reporting
- Proper audit trails (who from which affiliate did what)

---

## Proposed Solution

### High-Level Approach

Enhance the existing Affiliate Access Controls to support two scope options:

1. **All programs in region** (current behavior, remains default)
2. **Specific programs only** (new capability)

### How It Works

When assigning a user to an affiliate, admins can now choose:

**Scope = "All programs"**
- User gets access to all programs in affiliate's service area (existing behavior)
- Default option
- Works exactly as it does today

**Scope = "Specific programs"**
- User selects which programs to grant access to (new)
- Programs can be from any affiliate's service area
- Maintains affiliate relationship for approvals and reporting

Both options maintain the affiliate relationship, so approval permissions and reporting work correctly.

### Permission Logic

Access is granted when user has:

1. Superuser status (existing)
2. Direct program access (existing)
3. **Specific program access via affiliate assignment (NEW)**
4. All-programs access via ZIP codes (existing)

### UI Changes

**In the User Edit page, Affiliate Access Controls section:**

1. Add "Scope" radio buttons:
   - "All programs in region" (default)
   - "Specific programs only"

2. Add "Programs" multi-select dropdown (hidden by default)
   - Appears when "Specific programs only" is selected
   - Loads programs dynamically based on selected affiliate
   - Supports multiple program selection

3. Form validation:
   - If scope='specific_programs', must select at least 1 program
   - When affiliate changes, program list reloads

### Use Case Example

**Cross-Affiliate NQMS Consulting:**

Emily works for MENTOR Washington but provides NQMS consulting to a specific program in California.

**Current Problem:** Emily cannot access the California program because it's outside Washington's service area.

**Solution:** Admin assigns Emily to MENTOR Washington with:
- Access Level: NQMS-Only
- Scope: Specific programs
- Programs: [Big Brothers LA]

**Result:**
- Emily can view, edit, and approve assessments for Big Brothers LA
- Emily cannot see other California programs
- Reports show Emily as MENTOR Washington staff
- Approval audit trail correctly identifies her affiliate

---

## Acceptance Criteria

### UI & Form Behavior

- [ ] User edit page shows new "Scope" radio buttons in Affiliate Access Controls section
- [ ] Default scope is "All programs in region"
- [ ] Programs multi-select is hidden when "All programs" is selected
- [ ] Programs multi-select appears when "Specific programs" is selected
- [ ] Programs multi-select loads options when affiliate is selected
- [ ] Programs list is filtered to show programs available for selection
- [ ] Form validation shows error if scope='specific_programs' and no programs selected
- [ ] When editing existing user, scope and selected programs load correctly
- [ ] Multiple affiliate assignments can have different scopes

### Permissions & Access Control

- [ ] User with scope='all_programs' can access all programs in affiliate's service area (existing behavior)
- [ ] User with scope='specific_programs' can ONLY access selected programs
- [ ] User with scope='specific_programs' CANNOT access other programs in affiliate's service area
- [ ] Access respects access_level (Full Access / MC-Only / NQMS-Only)
- [ ] User with specific program access can view assessments for those programs (if not MC-Only)
- [ ] User with specific program access can edit assessments for those programs (if not MC-Only)
- [ ] User with specific program access can APPROVE assessments for those programs (if not MC-Only)
- [ ] User with MC-Only access cannot approve, even with specific program access
- [ ] User cache is cleared when affiliate assignments are saved/deleted
- [ ] Permissions recalculate immediately after changes

### Edge Cases

- [ ] User assigned to same affiliate twice (different access levels) - system handles gracefully
- [ ] Program with no ZIP code / affiliate with no service areas - system handles gracefully
- [ ] Deleting affiliate removes all user assignments and specific program assignments
- [ ] Changing scope from "specific" to "all" clears program selections
- [ ] Changing scope from "all" to "specific" requires program selection before save

---

## Example Scenarios

### Scenario 1: Cross-Affiliate NQMS Consulting

**Situation:** MENTOR Washington consultant supports California program

**Setup:**
- User: Emily
- Primary Affiliate: MENTOR Washington
- Target Program: Big Brothers LA (California)

**Configuration:**
- Assign Emily to MENTOR Washington
- Access Level: NQMS-Only
- Scope: Specific programs
- Programs: [Big Brothers LA]

**Result:**
- Emily can view/edit/approve assessments for Big Brothers LA
- Emily cannot see other California programs
- Reports show Emily as MENTOR Washington staff

### Scenario 2: Mixed Scope Assignments

**Situation:** User has full access to home region, specific access to other region

**Setup:**
- User: Sarah
- Home Affiliate: MENTOR Colorado (5 programs)
- Additional Affiliate: MENTOR Washington (3 programs)

**Configuration:**
- Assign Sarah to MENTOR Colorado
  - Access Level: Full Access
  - Scope: All programs
- Assign Sarah to MENTOR Washington
  - Access Level: NQMS-Only
  - Scope: Specific programs
  - Programs: [Program 101]

**Result:**
- Sarah can access ALL Colorado programs with Full Access
- Sarah can access ONLY Program 101 from Washington with NQMS-Only access
- Sarah can edit program details for Colorado programs
- Sarah cannot edit program details for Washington Program 101 (NQMS-Only restriction)
- Sarah can approve assessments for all Colorado programs AND Washington Program 101

### Scenario 3: Changing Assignment Scope

**Situation:** Admin changes user's access from all-programs to specific-programs

**Setup:**
- User: Mike
- Affiliate: MENTOR Texas (5 programs)
- Current Access: All programs

**Change:**
- Update Mike's assignment:
  - Scope: Specific programs
  - Programs: [Program 501, Program 502]

**Result:**
- Mike can now access ONLY Programs 501 and 502
- Mike cannot access Programs 503, 504, 505
- Mike's permissions update immediately

---

## Out of Scope

The following are explicitly OUT OF SCOPE for this enhancement:

❌ Bulk assignment tools (assigning multiple users at once)
❌ Self-service access requests (users requesting access themselves)
❌ Approval workflows for access requests
❌ Notifications for access changes
❌ Audit log UI (data is captured, but no dedicated UI to view it)
❌ Changes to existing reports (beyond maintaining compatibility)
❌ Deprecating existing Program Access Controls (direct program access remains available)
