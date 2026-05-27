# MENTOR Connector - CakePHP 4.6.2 Upgrade Test Cases Library

## Overview

This test cases library provides comprehensive validation testing for the MENTOR Connector application following the CakePHP upgrade from version 4.4.14 to 4.6.2.

## Upgrade Context

**Upgrade Date:** November 2025
**Previous Version:** CakePHP 4.4.14
**Current Version:** CakePHP 4.6.2
**PHP Version:** 8.1.*

### Critical Changes Made During Upgrade

1. **Query Method Updates** - Migrated from deprecated `query()` to `updateQuery()` and `deleteQuery()`
2. **Helper Loading** - Changed from `loadHelper()` to `addHelper()` (5 instances)
3. **Transaction Support** - Added transaction support to SortableController
4. **Orases/Files Plugin** - Updated to version ^2.3

## Test Suite Structure

This library contains 14 test case documents organized by functional area:

| Document | Focus Area | Priority | Test Cases |
|----------|-----------|----------|------------|
| `00_TEST_EXECUTION_TRACKER.md` | Master tracking document | REQUIRED | N/A |
| `01_CRITICAL_UPGRADE_TESTS.md` | Upgrade-specific changes | **CRITICAL** | 45 |
| `02_AUTHENTICATION_AUTHORIZATION_TESTS.md` | Auth/authz flows | **CRITICAL** | 58 |
| `03_PROGRAM_MANAGEMENT_TESTS.md` | Programs CRUD & workflows | HIGH | 72 |
| `04_NQMS_ASSESSMENT_TESTS.md` | NQMS functionality | **CRITICAL** | 64 |
| `05_API_ENDPOINTS_TESTS.md` | REST API testing | HIGH | 48 |
| `06_FILE_MANAGEMENT_TESTS.md` | File upload/download | HIGH | 36 |
| `07_EMAIL_WEBHOOKS_TESTS.md` | SendGrid integration | HIGH | 28 |
| `08_USER_AFFILIATE_MANAGEMENT_TESTS.md` | User/affiliate CRUD | HIGH | 54 |
| `09_DATABASE_OPERATIONS_TESTS.md` | Database CRUD operations | HIGH | 42 |
| `10_FRONTEND_UI_TESTS.md` | UI/UX and templates | MEDIUM | 48 |
| `11_REPORTING_ANALYTICS_TESTS.md` | Reports generation | MEDIUM | 32 |
| `12_SERVICE_AREAS_TESTS.md` | Vue.js service areas | HIGH | 24 |
| `13_REGRESSION_TESTS.md` | General regression | MEDIUM | 36 |

**Total Test Cases:** 587+

## How to Use This Library

### 1. Start with the Tracker

Open `00_TEST_EXECUTION_TRACKER.md` and use it to track your overall testing progress.

### 2. Test Execution Order

We recommend testing in this priority order:

#### Phase 1: Critical (Must Pass Before Any Release)
1. `01_CRITICAL_UPGRADE_TESTS.md` - Validate all upgrade changes
2. `02_AUTHENTICATION_AUTHORIZATION_TESTS.md` - Ensure security is intact
3. `04_NQMS_ASSESSMENT_TESTS.md` - Critical business functionality

#### Phase 2: High Priority (Core Functionality)
4. `03_PROGRAM_MANAGEMENT_TESTS.md` - Core program workflows
5. `05_API_ENDPOINTS_TESTS.md` - API integrations
6. `06_FILE_MANAGEMENT_TESTS.md` - File operations
7. `07_EMAIL_WEBHOOKS_TESTS.md` - Email delivery
8. `08_USER_AFFILIATE_MANAGEMENT_TESTS.md` - User management
9. `09_DATABASE_OPERATIONS_TESTS.md` - CRUD operations
10. `12_SERVICE_AREAS_TESTS.md` - Geographic functionality

#### Phase 3: Medium Priority (Extended Functionality)
11. `10_FRONTEND_UI_TESTS.md` - UI/UX validation
12. `11_REPORTING_ANALYTICS_TESTS.md` - Reporting features
13. `13_REGRESSION_TESTS.md` - General regression

### 3. Test Case Format

Each test case follows this structure:

```
TC-XXX-001: Test Case Title
Priority: CRITICAL | HIGH | MEDIUM | LOW
Prerequisites: Any setup required
Test Steps:
  1. Step one
  2. Step two
Expected Result: What should happen
Test Data: Any specific data needed
Notes: Additional context
```

### 4. Recording Results

For each test case, record:
- **Pass** ✅ - Test passed completely
- **Fail** ❌ - Test failed, bug found
- **Blocked** 🚫 - Cannot test due to blocker
- **Skip** ⏭️ - Intentionally skipped
- **N/A** - Not applicable for this environment

### 5. Bug Tracking

When you find a bug:
1. Mark the test case as **FAIL** ❌
2. Document the bug in the Notes section
3. Create a bug ticket in your tracking system
4. Reference the bug ticket ID in the test case

## Testing Environments

Test in these environments in order:

1. **DEV** - Internal development environment (DDEV local)
2. **REVIEW** - Internal QA environment
3. **STAGING** - External QA environment (pre-production)
4. **PRODUCTION** - Live environment (smoke testing only)

## Test Data Requirements

### User Accounts Needed
- Superuser account (`is_superuser = true`)
- MC Affiliate user
- Standard Affiliate user
- Program user
- NQMS Affiliate user
- NQMS Program user
- NQMS Limited Contractor user

### Program Data Needed
- At least 3 programs with different statuses (approved, pending, paused)
- Programs with various assessment states (draft, submitted, approved)
- Programs with different affiliate associations

### Other Data
- Active affiliates with user associations
- Postal codes data loaded
- NQMS assessment questions configured
- Sample inquiries and searches

## Automated Testing

In addition to manual testing, run these automated tests:

```bash
# Run all PHPUnit tests
composer test

# Check code style compliance
composer cs-check

# Run static analysis
composer stan

# Run specific plugin tests
vendor/bin/phpunit --testsuite Users
vendor/bin/phpunit --testsuite Programs
vendor/bin/phpunit --testsuite Affiliates
```

## Pre-Testing Checklist

Before starting manual testing:

- [ ] All migrations have been run: `composer migrations`
- [ ] Cache has been cleared: `bin/cake cache clear_all`
- [ ] Autoloader rebuilt: `composer dumpautoload`
- [ ] Environment is set correctly in `config/app_local.php`
- [ ] Database has current schema (156+ migrations)
- [ ] Test data is loaded
- [ ] All automated tests pass: `composer test`
- [ ] Vue.js assets compiled: `./compile.sh service-areas`

## Critical Areas Requiring Extra Attention

Based on the upgrade notes, pay special attention to:

1. **Last Login Timestamp Updates** - LoginController:132
2. **NQMS Question Sorting** - SortableController (was broken, now fixed)
3. **Program Assessment Linking** - ProgramAssessmentsTable:93
4. **Postal Code Updates** - UpdatePostalCodesCommand
5. **All Database Operations** - Any CRUD operations across all plugins
6. **File Operations** - Orases/Files plugin version bump
7. **Helper Rendering** - Template rendering with updated helper loading

## Success Criteria

The upgrade is validated when:

1. ✅ All CRITICAL priority tests pass (100%)
2. ✅ All HIGH priority tests pass (≥98%)
3. ✅ MEDIUM priority tests pass (≥95%)
4. ✅ All automated tests pass (`composer test`)
5. ✅ No critical or high-severity bugs remain open
6. ✅ Performance is equal to or better than previous version
7. ✅ No security vulnerabilities introduced

## Rollback Plan

If critical issues are found:

1. Document all failing test cases
2. Assess severity and impact
3. If critical functionality broken, rollback to CakePHP 4.4.14
4. Rollback procedure:
   ```bash
   composer require cakephp/cakephp:4.4.14
   composer update
   bin/cake cache clear_all
   ```

## Support & Questions

- Review upgrade notes: `mentor-connect/UPGRADE_NOTES.md`
- Check CakePHP migration guide: https://book.cakephp.org/4/en/appendices/4-6-migration-guide.html
- Review deprecation warnings in application logs

## Version History

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | 2025-12-03 | Claude Code | Initial test library creation |

---

**Ready to begin testing!** Start with `00_TEST_EXECUTION_TRACKER.md` to track your progress.
