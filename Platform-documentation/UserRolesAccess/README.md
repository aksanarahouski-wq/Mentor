# MENTOR Connector - User Roles & Permission Documentation

**Generated:** December 3, 2025
**Status:** Complete - Ready for Review

---

## Overview

This folder contains comprehensive documentation for the MENTOR Connector user roles and permission system. The documentation was generated through detailed analysis of both the existing Confluence documentation and the actual codebase implementation.

**Key Finding:** The system has 3 major discrepancies between documentation and code that require team decisions.

---

## Documents in This Folder

### Technical Documents (For Developers)

#### 1. COMPLETE_PERMISSION_MATRIX.md
**Purpose:** Comprehensive technical documentation
**Audience:** Developers, Technical Leads, System Architects
**Length:** ~40 pages

**Contains:**
- All 8 user roles with detailed definitions
- Complete permission matrix for all 10 modules
- Database schema with migration history
- Permission flow diagrams
- Code file locations and line numbers
- Detailed discrepancy analysis
- Implementation recommendations

**Use this when:**
- Developing new features that interact with permissions
- Troubleshooting permission issues
- Onboarding new developers
- Planning system changes

---

#### 2. QUICK_REFERENCE_GUIDE.md
**Purpose:** Quick lookup and practical guide
**Audience:** System Administrators, Support Staff, Team Leads
**Length:** ~15 pages

**Contains:**
- Quick role lookup tables
- Decision tree for role assignment
- Common user type setup instructions
- Troubleshooting guide
- SQL queries for finding users by role
- Code snippets for permission checking

**Use this when:**
- Setting up new user accounts
- Determining which access level to assign
- Troubleshooting user access issues
- Training new administrators

---

#### 3. DISCREPANCIES_AND_ACTION_ITEMS.md
**Purpose:** Issue tracking and decision-making
**Audience:** Product Owners, Project Managers, Team Leads
**Length:** ~25 pages

**Contains:**
- 3 major discrepancies between documentation and code
- Detailed impact analysis for each
- Multiple resolution options with pros/cons
- Effort estimates and risk assessments
- Action items requiring decisions
- Testing checklists
- Communication plan

**Use this when:**
- Planning documentation or code updates
- Making decisions about system changes
- Estimating effort for fixes
- Coordinating changes across teams

---

#### 4. NQMS_ASSESSMENT_WORKFLOW_AND_PERMISSIONS.md
**Purpose:** Deep-dive into NQMS Assessment module
**Audience:** All roles - detailed workflow and permission documentation
**Length:** ~50 pages

**Contains:**
- Complete assessment business flow (Creation → Completion → Goals)
- Status definitions and transition rules
- Action-by-action permission breakdown (15 actions documented)
- Goals management workflow
- Critical business rules (7 key rules)
- Special cases and restrictions
- Code references with file paths and line numbers

**Use this when:**
- Understanding assessment lifecycle
- Determining who can approve assessments (critical rule!)
- Setting up goals for programs
- Troubleshooting assessment access issues
- Understanding limited contractor restrictions
- Planning assessment-related features

---

### Business-Friendly Documents (For Everyone)

#### 5. BUSINESS_PERMISSION_GUIDE.md
**Purpose:** Non-technical permission guide
**Audience:** Business Users, System Administrators, Program & Affiliate Staff
**Length:** ~30 pages

**Contains:**
- Plain-language explanation of roles
- Access levels explained with examples
- What each role can do (no technical jargon)
- How to assign roles (step-by-step)
- Common user scenarios
- Important business rules in simple terms
- Troubleshooting in plain language

**Use this when:**
- Setting up new users
- Understanding what you can access
- Explaining roles to non-technical staff
- Training new administrators

---

#### 6. QA_TESTING_GUIDE.md
**Purpose:** Test scenarios for permission validation
**Audience:** QA Testers, Business Analysts, Test Engineers
**Length:** ~35 pages

**Contains:**
- Test user setup instructions
- Test scenarios for each role (8 complete test suites)
- Module access verification
- NQMS workflow testing
- Negative test scenarios
- Edge cases
- Expected results reference
- Test execution checklist

**Use this when:**
- Testing permission changes
- Validating role assignments
- Regression testing
- Creating test cases

---

#### 7. NQMS_ASSESSMENT_BUSINESS_GUIDE.md
**Purpose:** Assessment workflow for business users
**Audience:** Program Staff, Affiliate Staff, NQMS Consultants
**Length:** ~35 pages

**Contains:**
- Assessment workflow explained step-by-step
- Status definitions in plain language
- Who can do what (no technical details)
- How to create, fill out, submit, and approve
- Goals management explained
- Critical business rules
- Common questions and answers
- Troubleshooting guide

**Use this when:**
- Creating your first assessment
- Understanding assessment statuses
- Learning who can approve (critical rule!)
- Setting up improvement goals
- Training new staff on NQMS process

---

### 8. README.md (This File)
**Purpose:** Navigation and overview
**Audience:** Everyone
**Length:** 5 pages

---

## Quick Start

### For Business Users & System Administrators
**Start here:** BUSINESS_PERMISSION_GUIDE.md
- Read "Understanding User Roles" section
- Use "Decision Tree: Which Access Level?" flowchart
- Follow "How to Assign Roles" step-by-step guide
- Reference "Common Scenarios" for typical setups

**For NQMS work:** NQMS_ASSESSMENT_BUSINESS_GUIDE.md
- Learn assessment workflow (no technical jargon)
- Understand who can approve (critical rule!)
- Follow step-by-step guides for each action

### For QA Testers
**Start here:** QA_TESTING_GUIDE.md
- Follow "Test Environment Setup" section
- Create test users using provided matrix
- Execute test scenarios for each role
- Use test matrix to verify module access

### For Developers
**Start here:** COMPLETE_PERMISSION_MATRIX.md
- Review "User Roles (Complete List)" section
- Check "Permission Flow & Implementation" section
- Use "File Locations" section to find relevant code

**For NQMS Assessment work:** NQMS_ASSESSMENT_WORKFLOW_AND_PERMISSIONS.md
- Detailed technical documentation
- All 15 assessment-related actions documented
- Code references with file paths and line numbers

**Quick reference:** QUICK_REFERENCE_GUIDE.md
- Fast lookups and SQL queries
- Troubleshooting guide
- Code snippets

### For Project Managers/Product Owners
**Start here:** DISCREPANCIES_AND_ACTION_ITEMS.md
- Review "Executive Summary"
- Read each discrepancy section
- Make decisions on recommended options
- Use action items to track progress

---

## Key Findings Summary

### System Overview

**Access Levels:** 3
- Full Access (1)
- MC-Access Only (2)
- NQMS-Access Only (3)

**User Roles:** 8
- `global` (superuser)
- `affiliate` (Full Access at affiliate level)
- `mc_affiliate` (MC-Only at affiliate level)
- `nqms_affiliate` (NQMS-Only at affiliate level)
- `nqms_affiliate_limited` (NQMS-Only contractor at affiliate level)
- `program` (Full OR MC-Only at program level)
- `nqms_program` (NQMS-Only at program level)
- `nqms_program_limited` (NQMS-Only contractor at program level)

**Protected Modules:** 10
- Reminders, Searches, Inquiries, Programs, Affiliates, Accounts, Partners, Reports, NQMS, NQMS Admin

---

### Critical Discrepancies

#### Discrepancy #1: Program Role Consolidation (HIGH PRIORITY)
**Issue:** Documentation shows separate "Program User (Full Access)" and "Program User (MC-only)" roles, but code combines both into a single `program` role.

**Impact:** Medium - Could cause confusion about user capabilities

**Recommendation:** Update documentation to reflect actual code behavior (merge the columns)

**Estimated Effort:** 2-3 hours

**Decision Required:** Yes - Choose documentation update OR code update

---

#### Discrepancy #2: Contractor Access Level Not Specified (MEDIUM PRIORITY)
**Issue:** Documentation doesn't specify that contractors can ONLY have NQMS-Only access. Contractor flag with other access levels is ignored by the system.

**Impact:** Medium - Could lead to incorrect role assignments

**Recommendation:** Update documentation AND add UI validation to prevent mistakes

**Estimated Effort:** 5-7 hours

**Decision Required:** Yes - Choose documentation-only OR documentation + validation

---

#### Discrepancy #3: Identical Permission Columns (LOW PRIORITY)
**Issue:** Two columns in permission matrix show identical values (resolved by fixing Discrepancy #1)

**Impact:** Low - Minor confusion

**Recommendation:** Addressed by Discrepancy #1 resolution

---

## System Architecture

### Database Structure
```
users (is_superuser flag for global admin)
  |
  +-- affiliates_users (affiliate_id, user_id, access_level, is_limited_contractor)
  |      |
  |      +-- affiliates
  |             |
  |             +-- affiliates_zip_codes
  |                    |
  |                    +-- programs (via zip_code)
  |
  +-- programs_users (program_id, user_id, access_level, is_limited_contractor)
         |
         +-- programs
```

### Permission Flow
```
1. User authenticates
2. System computes roles from database relationships
3. Roles are cached (key: user_permissions_{user_id})
4. Each request checks authorization via RequestPolicy
5. RequestPolicy matches route to required roles
6. Access granted or denied
```

### Code Locations
**Core Files:**
- `/src/General/UniversalEnumerations.php` - Access level constants
- `/plugins/Users/src/Trait/UserPermissionsTrait.php` - Role computation (778 lines)
- `/plugins/Users/src/Policy/RequestPolicy.php` - Authorization policy
- `/config/request_policy_configs.php` - Route-to-role mappings

---

## How Roles Are Computed

### Example 1: Affiliate Full Access User
```
User ID: abc-123
Assignment: affiliates_users (affiliate_id=5, access_level=1, is_limited_contractor=0)

Computation:
1. Query affiliates_users → Found affiliate_id=5, access_level=1
2. access_level == 1 (FULL_ACCESS) → Set affiliate role
3. Get ZIP codes for affiliate_id=5
4. Get programs in those ZIP codes
5. Cache result

Result: { affiliate: true, [all other roles]: false }
```

### Example 2: Program NQMS Contractor
```
User ID: xyz-789
Assignment: programs_users (program_id=42, access_level=3, is_limited_contractor=1)

Computation:
1. Query programs_users → Found program_id=42, access_level=3, is_limited_contractor=1
2. access_level == 3 (NQMS_ONLY) AND is_limited_contractor == 1
3. Set nqms_program_limited role
4. Cache result

Result: { nqms_program_limited: true, [all other roles]: false }
```

### Example 3: Multi-Role User
```
User ID: multi-456
Assignments:
- affiliates_users (affiliate_id=10, access_level=1, is_limited_contractor=0)
- programs_users (program_id=99, access_level=3, is_limited_contractor=0)

Computation:
1. Query affiliates_users → Found affiliate_id=10, access_level=1
2. Set affiliate role
3. Query programs_users → Found program_id=99, access_level=3
4. Set nqms_program role
5. Cache result

Result: { affiliate: true, nqms_program: true, [all others]: false }

Effective Permissions: UNION of both roles
- Can edit MC features (from affiliate role)
- Can edit NQMS features (from nqms_program role)
- Can access Reports (from both roles)
```

---

## Important Business Rules

### 1. Contractor Restrictions
- Contractors can ONLY have `access_level = 3` (NQMS-Only)
- Contractor flag with any other access level is IGNORED
- Contractors can only edit the MOST RECENT assessment per program
- Contractors CANNOT approve/finalize assessments

### 2. Geographic Permissions
- Affiliate users get access to programs via ZIP code matching
- `affiliates_zip_codes.zip_code` = `programs.zip_code`
- This is automatic - no explicit program assignment needed

### 3. Multi-Assignment Permissions
- Users can have MULTIPLE affiliate assignments
- Users can have MULTIPLE program assignments
- Permissions are the UNION of all roles
- Example: User with both `affiliate` and `nqms_program` roles can access both MC and NQMS features

### 4. Superuser Bypass
- `is_superuser = 1` grants `global` role
- Global role BYPASSES all permission checks
- Global admins see and can edit everything
- No affiliate or program assignments needed

### 5. Navigation Menu Rules
- Module appears in menu if user has "Can-See" OR "Can-Edit" access
- Modules with no access are completely hidden
- Within visible modules, edit buttons may be hidden for "Can-See" only users

---

## Common Tasks

### Assign Full Access to Affiliate User
```
1. Users → Edit User
2. Affiliates tab → Add Assignment
3. Select Affiliate
4. Access Level: "Full Access"
5. Limited Contractor: Unchecked
6. Save

Result: affiliate role
```

### Assign NQMS Contractor to Program
```
1. Users → Edit User
2. Programs tab → Add Assignment
3. Select Program
4. Access Level: "NQMS-Access Only"
5. Limited Contractor: Checked
6. Save

Result: nqms_program_limited role
```

### Make User a Global Admin
```
1. Users → Edit User
2. Check "Is Superuser"
3. Save

Result: global role (no assignments needed)
```

### Clear User Permission Cache
```sql
-- In database or via Cache::delete()
DELETE FROM cache WHERE key = 'user_permissions_{user_id}';

-- Or in code:
Cache::delete('user_permissions_' . $userId);
```

---

## Troubleshooting

### User can't access a module
**Check:**
1. Is user active? (`is_active = 1`)
2. Is user verified? (`is_verified = 1`)
3. Do they have correct affiliate/program assignment?
4. Is access level correct?
5. Clear permission cache

### Contractor can edit old assessments
**Expected:** Contractors should only edit most recent assessment

**Check:**
1. Is `is_limited_contractor = 1`?
2. Is `access_level = 3` (NQMS-Only)?
3. Check `canApproveAssessment()` method logic

### Affiliate user can't access program
**Check:**
1. Does affiliate have ZIP codes? (Check `affiliates_zip_codes`)
2. Does program have matching ZIP code? (Check `programs.zip_code`)
3. Is user's access level appropriate for the action?
   - NQMS-only users can VIEW but not EDIT programs

---

## Next Steps

### Immediate Actions Required
1. **Review DISCREPANCIES_AND_ACTION_ITEMS.md**
2. **Make decisions on 3 discrepancies**
3. **Assign owners for action items**
4. **Set deadlines for resolution**

### Week 1
- [ ] Project team reviews all documentation
- [ ] Stakeholder meeting to discuss discrepancies
- [ ] Decisions made on Option A vs B for each discrepancy
- [ ] Action items assigned

### Week 2 (if code changes needed)
- [ ] Implement chosen solutions
- [ ] Write/update unit tests
- [ ] Internal testing
- [ ] Update Confluence documentation

### Week 3
- [ ] QA testing
- [ ] Update training materials
- [ ] Prepare communication

### Week 4
- [ ] Deploy changes (if any)
- [ ] Notify stakeholders
- [ ] Monitor for issues
- [ ] Gather feedback

---

## Critical Findings Summary

### NQMS Assessment Module Critical Rules

**Rule #1: Assessment Approval Requires Affiliate Assignment (Most Important!)**
- Program users CANNOT approve their own assessments
- Only affiliate staff with service area coverage can approve
- Direct program assignment does NOT grant approval authority
- See NQMS_ASSESSMENT_WORKFLOW_AND_PERMISSIONS.md for full details

**Rule #2: Limited Contractors Can Only Access Latest Assessment**
- Historical assessment data is restricted for contractors
- Enforced by `canAccessOldAssessment()` permission check

**Rule #3: Completed Assessments Cannot Be Edited**
- Status transitions are one-way
- No rollback mechanism exists

**Rule #4: Goals Automatically Update Assessment Status**
- When all goals completed: status changes to "goal_completed"
- System-driven via event listeners

---

## Related Resources

### External Documentation
- **Confluence Original:** https://orases.atlassian.net/wiki/spaces/MTR/pages/667058186/Permission+Levels+NQMS-Only+MC-Only+Full+Access

### Codebase
- **Repository:** /Users/aksana/Documents/Projects/Mentor/mentor-connect
- **Permission Files:** See "File Locations" section in COMPLETE_PERMISSION_MATRIX.md
- **Assessment Files:** See "Code References" section in NQMS_ASSESSMENT_WORKFLOW_AND_PERMISSIONS.md

### Contacts
- **Product Owner:** [NAME]
- **Tech Lead:** [NAME]
- **System Administrator:** [NAME]

---

## Document Maintenance

### When to Update These Documents

**Update when:**
- New roles are added
- New access levels are added
- Permission policies change
- New modules are added
- Database schema changes

**How to update:**
1. Update code first
2. Update COMPLETE_PERMISSION_MATRIX.md with new details
3. Update QUICK_REFERENCE_GUIDE.md with new instructions
4. Update Confluence documentation
5. Notify all stakeholders

**Ownership:**
- These documents should be owned by the Tech Lead
- Reviews should happen quarterly or after major changes
- Keep documents in sync with code at all times

---

## Questions or Issues?

If you have questions about this documentation or find errors:

1. Check the relevant document first (use guide above)
2. Review the code files listed in COMPLETE_PERMISSION_MATRIX.md
3. Contact the Tech Lead
4. Create a ticket in the project management system

---

**END OF README**

## Document Status

| Document | Type | Status | Last Review | Next Review |
|----------|------|--------|-------------|-------------|
| **Technical Documents** | | | | |
| COMPLETE_PERMISSION_MATRIX.md | Technical | ✅ Complete | 2025-12-03 | [DATE + 3 months] |
| QUICK_REFERENCE_GUIDE.md | Technical | ✅ Complete | 2025-12-03 | [DATE + 3 months] |
| NQMS_ASSESSMENT_WORKFLOW_AND_PERMISSIONS.md | Technical | ✅ Complete | 2025-12-03 | [DATE + 3 months] |
| DISCREPANCIES_AND_ACTION_ITEMS.md | Planning | ⚠️ Awaiting Decisions | 2025-12-03 | After decisions made |
| **Business Documents** | | | | |
| BUSINESS_PERMISSION_GUIDE.md | Business | ✅ Complete | 2025-12-03 | [DATE + 3 months] |
| QA_TESTING_GUIDE.md | QA | ✅ Complete | 2025-12-03 | [DATE + 3 months] |
| NQMS_ASSESSMENT_BUSINESS_GUIDE.md | Business | ✅ Complete | 2025-12-03 | [DATE + 3 months] |
| **Navigation** | | | | |
| README.md | Overview | ✅ Complete | 2025-12-03 | [DATE + 3 months] |
