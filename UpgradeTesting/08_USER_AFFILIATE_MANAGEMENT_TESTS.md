
# File 08: User & Affiliate Management
# Test Suite 08: User & Affiliate Management Tests

**Priority:** HIGH
**Total Test Cases:** 54
**Focus:** User CRUD, affiliate management, role assignments, associations

## Overview
Tests cover user management, affiliate management, user-affiliate associations, user-program associations, and role-based access.

## Section 1: User Creation

### TC-USER-001: Create New User - Required Fields
**Priority:** CRITICAL
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-USER-002: Create User - All Fields
**Priority:** HIGH
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-USER-003: User Email Uniqueness Validation
**Priority:** CRITICAL
**Expected Result:** Duplicate email rejected
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-USER-004: Password Hashing on User Creation
**Priority:** CRITICAL (Security)
**Expected Result:** Password stored as bcrypt hash
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-USER-005: User Profile Creation
**Priority:** HIGH
**Expected Result:** UserProfile record created automatically
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

## Section 2: User Editing

### TC-USER-006: Edit User Basic Information
**Priority:** HIGH
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-USER-007: Change User Email
**Priority:** HIGH
**Expected Result:** Email updated, uniqueness validated
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-USER-008: Update User Password
**Priority:** HIGH
**Expected Result:** New password hashed, can login with new password
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-USER-009: Toggle Superuser Flag
**Priority:** CRITICAL
**Expected Result:** Only superusers can set is_superuser flag
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-USER-010: Edit User Profile Details
**Priority:** MEDIUM
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

## Section 3: User Listing & Search

### TC-USER-011: View All Users List
**Priority:** HIGH
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-USER-012: Search Users by Name
**Priority:** MEDIUM
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-USER-013: Search Users by Email
**Priority:** MEDIUM
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-USER-014: Filter Users by Affiliate
**Priority:** HIGH
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-USER-015: Filter Users by Role/Type
**Priority:** HIGH
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

## Section 4: User-Affiliate Associations

### TC-USER-016: Assign User to Affiliate
**Priority:** CRITICAL
**Expected Result:** Record created in affiliates_users table
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-USER-017: Assign User to Multiple Affiliates
**Priority:** HIGH
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-USER-018: Remove User from Affiliate
**Priority:** HIGH
**Expected Result:** Association deleted, user loses access
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-USER-019: Set Limited Contractor Flag
**Priority:** HIGH
**Expected Result:** is_limited_contractor flag set on affiliates_users
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-USER-020: View User's Affiliate Associations
**Priority:** MEDIUM
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

## Section 5: User-Program Associations

### TC-USER-021: Assign User to Program
**Priority:** CRITICAL
**Expected Result:** Record created in programs_users table
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-USER-022: Assign User to Multiple Programs
**Priority:** HIGH
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-USER-023: Remove User from Program
**Priority:** HIGH
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-USER-024: Program User Limited Access
**Priority:** HIGH
**Expected Result:** User can only access assigned programs
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

## Section 6: User Role Management

### TC-USER-025: Assign User Type/Role
**Priority:** CRITICAL
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-USER-026: User with Multiple Roles
**Priority:** HIGH
**Expected Result:** User can have multiple roles (affiliate + program)
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-USER-027: Role Change Takes Effect
**Priority:** HIGH
**Expected Result:** Access changes based on new role
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

## Section 7: Affiliate Management - CRUD

### TC-USER-028: Create New Affiliate
**Priority:** CRITICAL
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-USER-029: Edit Affiliate Details
**Priority:** HIGH
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-USER-030: View Affiliate List
**Priority:** HIGH
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-USER-031: Delete Affiliate (if allowed)
**Priority:** MEDIUM
**Expected Result:** Delete prevented if associations exist
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-USER-032: Search Affiliates
**Priority:** MEDIUM
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

## Section 8: Affiliate-Program Associations

### TC-USER-033: Assign Programs to Affiliate
**Priority:** HIGH
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-USER-034: View Affiliate's Programs
**Priority:** HIGH
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-USER-035: Remove Program from Affiliate
**Priority:** MEDIUM
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

## Section 9: Affiliate Users Management

### TC-USER-036: View Users in Affiliate
**Priority:** HIGH
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-USER-037: Add User to Affiliate from Affiliate Page
**Priority:** HIGH
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-USER-038: Remove User from Affiliate
**Priority:** MEDIUM
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

## Section 10: User Deletion

### TC-USER-039: Soft Delete User
**Priority:** HIGH
**Expected Result:** User marked inactive, retains data
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-USER-040: Hard Delete User (if implemented)
**Priority:** MEDIUM
**Expected Result:** User record deleted, associations handled
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-USER-041: Cannot Delete User with Critical Associations
**Priority:** HIGH
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

## Section 11: Account Settings

### TC-USER-042: User Can View Own Account
**Priority:** MEDIUM
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-USER-043: User Can Edit Own Profile
**Priority:** MEDIUM
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-USER-044: User Can Change Own Password
**Priority:** HIGH
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-USER-045: User Cannot Change Own Role
**Priority:** CRITICAL (Security)
**Expected Result:** Role modification restricted to admins
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

## Section 12: Data Integrity

### TC-USER-046: User Foreign Key Constraints
**Priority:** HIGH
**Expected Result:** Referential integrity maintained
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-USER-047: Affiliate-User Junction Table Integrity
**Priority:** MEDIUM
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-USER-048: Program-User Junction Table Integrity
**Priority:** MEDIUM
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

## Section 13: User Audit Trail

### TC-USER-049: Created_by Tracking
**Priority:** MEDIUM
**Expected Result:** User creation tracked
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-USER-050: Modified_by Tracking
**Priority:** MEDIUM
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-USER-051: Timestamps Accurate
**Priority:** MEDIUM
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

## Section 14: User Permissions Caching

### TC-USER-052: User Permissions Cached
**Priority:** MEDIUM
**Expected Result:** UserCachesTrait works correctly
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-USER-053: Cache Invalidation on Association Change
**Priority:** MEDIUM
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

## Section 15: User/Affiliate Export

### TC-USER-054: Export User List to CSV
**Priority:** LOW
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

---

## Summary
**Total:** 54 | **Critical:** 9 | **High:** 30 | **Medium:** 14 | **Low:** 1
**Completion:** _____ / 54 (_____%)

**Sign-Off:** _______________________ **Date:** ___________
