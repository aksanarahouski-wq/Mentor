# MENTOR Connector - CakePHP 4.6.2 Upgrade Test Library

## 📋 Project Summary

A comprehensive test cases library has been created for validating the MENTOR Connector application following the CakePHP upgrade from version 4.4.14 to 4.6.2.

**Created:** December 3, 2025
**Location:** `/Users/aksana/Documents/Projects/Mentor/UpgradeTesting`
**Total Documents:** 15 files
**Total Test Cases:** 587
**Total Lines:** 8,047

---

## 📁 Deliverables

### Core Documents

1. **README.md** (7.2 KB)
   - Overview and usage guide
   - Testing methodology
   - Environment setup
   - Success criteria

2. **00_TEST_EXECUTION_TRACKER.md** (7.5 KB)
   - Master tracking spreadsheet
   - Progress monitoring
   - Defects log
   - Sign-off sheets

### Test Suite Documents

| # | Document | Tests | Priority | Size |
|---|----------|-------|----------|------|
| 1 | 01_CRITICAL_UPGRADE_TESTS.md | 45 | CRITICAL | 31 KB |
| 2 | 02_AUTHENTICATION_AUTHORIZATION_TESTS.md | 58 | CRITICAL | 35 KB |
| 3 | 03_PROGRAM_MANAGEMENT_TESTS.md | 72 | HIGH | 39 KB |
| 4 | 04_NQMS_ASSESSMENT_TESTS.md | 64 | CRITICAL | 24 KB |
| 5 | 05_API_ENDPOINTS_TESTS.md | 48 | HIGH | 14 KB |
| 6 | 06_FILE_MANAGEMENT_TESTS.md | 36 | HIGH | 6.7 KB |
| 7 | 07_EMAIL_WEBHOOKS_TESTS.md | 28 | HIGH | 6.7 KB |
| 8 | 08_USER_AFFILIATE_MANAGEMENT_TESTS.md | 54 | HIGH | 8.4 KB |
| 9 | 09_DATABASE_OPERATIONS_TESTS.md | 42 | HIGH | 6.8 KB |
| 10 | 10_FRONTEND_UI_TESTS.md | 48 | MEDIUM | 7.4 KB |
| 11 | 11_REPORTING_ANALYTICS_TESTS.md | 32 | MEDIUM | 5.2 KB |
| 12 | 12_SERVICE_AREAS_TESTS.md | 24 | HIGH | 5.5 KB |
| 13 | 13_REGRESSION_TESTS.md | 36 | MEDIUM | 6.2 KB |

---

## 📊 Test Coverage Breakdown

### By Priority

| Priority | Test Cases | Percentage | Files |
|----------|-----------|------------|-------|
| **CRITICAL** | 167 | 28% | 3 |
| **HIGH** | 304 | 52% | 7 |
| **MEDIUM** | 116 | 20% | 3 |

### By Functional Area

| Area | Test Cases | Key Focus |
|------|-----------|-----------|
| Upgrade-Specific Changes | 45 | Query methods, helpers, transactions |
| Authentication & Authorization | 58 | Login, roles, policies |
| Program Management | 72 | CRUD, workflows, associations |
| NQMS Assessments | 64 | Questions, responses, approval |
| API Endpoints | 48 | REST API, authentication |
| File Management | 36 | Upload, download, S3 |
| Email & Webhooks | 28 | SendGrid integration |
| User & Affiliate Management | 54 | Users, affiliates, roles |
| Database Operations | 42 | CRUD, integrity, transactions |
| Frontend UI | 48 | Rendering, forms, accessibility |
| Reporting & Analytics | 32 | Reports, exports |
| Service Areas (Vue.js) | 24 | Vue component, compilation |
| Regression Testing | 36 | Integration, edge cases |

---

## 🎯 Critical Areas Requiring Extra Attention

Based on the upgrade changes, these areas are most critical:

### 1. **Last Login Timestamp Update** (LoginController:132)
- Test Case: TC-CRT-001 to TC-CRT-004
- Change: `query()->update()` → `updateQuery()`
- Impact: User authentication

### 2. **NQMS Question Sorting** (SortableController)
- Test Case: TC-CRT-005 to TC-CRT-008, TC-NQMS-004
- Change: Added transaction support, updated query methods
- Previous Issue: 500 errors
- Impact: CRITICAL business functionality

### 3. **Program Assessment Linking** (ProgramAssessmentsTable:93)
- Test Case: TC-CRT-009 to TC-CRT-012
- Change: `query()->update()` → `updateQuery()`
- Impact: Assessment tracking

### 4. **Postal Code Updates** (UpdatePostalCodesCommand)
- Test Case: TC-CRT-013 to TC-CRT-015
- Change: `query()->delete()` → `deleteQuery()`
- Impact: Geographic data management

### 5. **All Database Operations**
- Test Cases: TC-CRT-027 to TC-CRT-035, entire suite 09
- Change: Query method updates across entire application
- Impact: All CRUD operations

### 6. **File Operations** (Orases/Files ^2.3)
- Test Cases: Entire suite 06 (36 tests)
- Change: Plugin version upgrade
- Impact: File uploads, downloads, S3 integration

### 7. **Helper Loading**
- Test Cases: TC-CRT-016 to TC-CRT-020
- Change: `loadHelper()` → `addHelper()` (5 instances)
- Impact: Template rendering

---

## 🚀 Getting Started

### Step 1: Review the README
Open `README.md` to understand:
- Testing approach
- Environment requirements
- Test data needed
- Success criteria

### Step 2: Set Up Test Environment
```bash
# Ensure environment ready
cd /Users/aksana/Documents/Projects/Mentor/mentor-connect

# Run migrations
composer migrations

# Clear cache
bin/cake cache clear_all

# Rebuild autoloader
composer dumpautoload

# Compile Vue.js assets
./compile.sh service-areas

# Run automated tests
composer test
```

### Step 3: Start with Critical Tests
Begin testing in this order:

#### Phase 1: Critical (Must Pass)
1. `01_CRITICAL_UPGRADE_TESTS.md` - Validate upgrade changes
2. `02_AUTHENTICATION_AUTHORIZATION_TESTS.md` - Ensure security
3. `04_NQMS_ASSESSMENT_TESTS.md` - Core business functionality

#### Phase 2: High Priority
4. `03_PROGRAM_MANAGEMENT_TESTS.md` - Program workflows
5. `05_API_ENDPOINTS_TESTS.md` - API functionality
6. `06_FILE_MANAGEMENT_TESTS.md` - File operations
7. `07_EMAIL_WEBHOOKS_TESTS.md` - Email delivery
8. `08_USER_AFFILIATE_MANAGEMENT_TESTS.md` - User management
9. `09_DATABASE_OPERATIONS_TESTS.md` - Database integrity
10. `12_SERVICE_AREAS_TESTS.md` - Vue.js component

#### Phase 3: Medium Priority
11. `10_FRONTEND_UI_TESTS.md` - UI/UX validation
12. `11_REPORTING_ANALYTICS_TESTS.md` - Reporting
13. `13_REGRESSION_TESTS.md` - General regression

### Step 4: Track Progress
Use `00_TEST_EXECUTION_TRACKER.md` to:
- Record test results
- Track defects
- Monitor overall progress
- Document sign-offs

---

## ✅ Release Approval Criteria

### Must Pass (100% Required)

- ✅ All CRITICAL priority test cases pass
- ✅ All automated tests pass: `composer test`
- ✅ No critical or high-severity defects open
- ✅ Authentication and authorization functional
- ✅ NQMS assessment system operational
- ✅ Database operations work correctly
- ✅ Last login timestamp updates (upgrade-specific)
- ✅ NQMS question sorting works (upgrade-specific)

### Should Pass (≥98% Required)

- ✅ HIGH priority test cases
- ✅ Program management workflows
- ✅ API endpoints functional
- ✅ File operations working
- ✅ Email notifications delivering

### Nice to Have (≥95% Required)

- ✅ MEDIUM priority test cases
- ✅ UI/UX rendering correctly
- ✅ Reports generating
- ✅ No major regression issues

---

## 📝 Test Case Format

Each test case follows this structure:

```markdown
### TC-XXX-001: Test Case Title
**Priority:** CRITICAL | HIGH | MEDIUM | LOW
**Prerequisites:** Any setup required

**Test Steps:**
1. Step one
2. Step two
3. Step three

**Expected Result:**
- What should happen
- Expected behavior
- Success criteria

**Test Data:** (if applicable)
- Specific data needed

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**
```

---

## 🔍 Test Environments

Test in these environments sequentially:

1. **DEV** - Internal development (DDEV local)
2. **REVIEW** - Internal QA
3. **STAGING** - External QA (pre-production)
4. **PRODUCTION** - Live environment (smoke testing only)

---

## 🎓 Test Data Requirements

### User Accounts Needed
- ✅ Superuser (`is_superuser = true`)
- ✅ MC Affiliate user
- ✅ Standard Affiliate user
- ✅ Program user
- ✅ NQMS Affiliate user
- ✅ NQMS Program user
- ✅ NQMS Limited Contractor user

### Sample Data
- ✅ 3+ programs (approved, pending, paused statuses)
- ✅ Programs with various assessment states
- ✅ Active affiliates with user associations
- ✅ Postal codes loaded
- ✅ NQMS questions configured
- ✅ Sample inquiries and searches

---

## 🐛 Defect Tracking

When bugs are found:

1. Mark test case as **FAIL** ❌
2. Document in test case Notes section
3. Log in `00_TEST_EXECUTION_TRACKER.md`
4. Create ticket in bug tracking system
5. Reference ticket ID in test case

### Severity Definitions

- **Critical:** Blocks testing, data corruption, security issue
- **High:** Major functionality broken, no workaround
- **Medium:** Functionality impaired, workaround exists
- **Low:** Minor issue, cosmetic, edge case

---

## 📚 Additional Resources

### CakePHP Upgrade Documentation
- [CakePHP 4.6 Migration Guide](https://book.cakephp.org/4/en/appendices/4-6-migration-guide.html)
- Application upgrade notes: `mentor-connect/UPGRADE_NOTES.md`

### Application Documentation
- Architecture overview (in this test library)
- Plugin structure (13 feature plugins)
- Authorization policies: `config/request_policy_configs.php`
- Routing: `config/routes.php`

### Automated Testing
```bash
# All tests
composer test

# Code style
composer cs-check

# Static analysis
composer stan

# Specific plugin tests
vendor/bin/phpunit --testsuite Users
vendor/bin/phpunit --testsuite Programs
vendor/bin/phpunit --testsuite Affiliates
```

---

## 📞 Support

### Questions About Tests
- Review test case prerequisites
- Check application documentation
- Consult with development team

### Issues Found During Testing
- Document in tracker
- Assess severity and impact
- Escalate critical issues immediately

### Testing Environment Issues
- Verify pre-testing checklist completed
- Check environment configuration
- Review setup documentation

---

## 📈 Progress Tracking

Update `00_TEST_EXECUTION_TRACKER.md` daily with:
- Tests executed
- Pass/fail counts
- Defects found
- Blockers encountered
- Next steps

---

## ✍️ Sign-Off Process

### Testing Complete
1. **Test Lead** reviews all results
2. **QA Manager** approves test completion
3. Document any known issues

### Release Approval
1. **Product Owner** reviews test results
2. **Tech Lead** confirms technical readiness
3. **Sign-off** on tracker document
4. **Schedule deployment**

---

## 🎉 Success!

This comprehensive test library provides:

✅ **587 test cases** covering all application areas
✅ **Focused critical tests** for upgrade-specific changes
✅ **Organized by priority** for efficient execution
✅ **Detailed test steps** for consistent testing
✅ **Progress tracking** tools
✅ **Clear success criteria** for release approval

**Ready to validate your CakePHP 4.6.2 upgrade!**

---

## 📋 Quick Reference

| Need | Location |
|------|----------|
| Start here | README.md |
| Track progress | 00_TEST_EXECUTION_TRACKER.md |
| Upgrade-specific tests | 01_CRITICAL_UPGRADE_TESTS.md |
| Security tests | 02_AUTHENTICATION_AUTHORIZATION_TESTS.md |
| Core functionality | 03, 04, 08, 09 test suites |
| API testing | 05_API_ENDPOINTS_TESTS.md |
| Integration testing | All suites |
| Regression testing | 13_REGRESSION_TESTS.md |

---

**Version:** 1.0
**Created:** December 3, 2025
**Created By:** Claude Code

**For questions or clarifications, refer to the README.md file in this directory.**
