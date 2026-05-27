
# File 09: Database Operations
# Test Suite 09: Database Operations Tests

**Priority:** HIGH
**Total Test Cases:** 42
**Focus:** CRUD operations across all plugins, data integrity, transactions

## Overview
Tests cover database operations after upgrade to ensure all CRUD operations work correctly with updated query methods (updateQuery, deleteQuery).

## Section 1: Programs Table Operations

### TC-DB-001: Insert Program Record
**Priority:** CRITICAL
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-DB-002: Update Program Record
**Priority:** CRITICAL
**Expected Result:** updateQuery() works correctly
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-DB-003: Delete Program Record
**Priority:** HIGH
**Expected Result:** deleteQuery() works correctly
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-DB-004: Bulk Update Programs
**Priority:** MEDIUM
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-DB-005: Program Timestamps Auto-Update
**Priority:** MEDIUM
**Expected Result:** created, modified timestamps work
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

## Section 2: Users Table Operations

### TC-DB-006: Insert User Record
**Priority:** CRITICAL
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-DB-007: Update User Record
**Priority:** CRITICAL
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-DB-008: Delete User Record
**Priority:** HIGH
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-DB-009: Last Login Timestamp Update
**Priority:** CRITICAL (Upgrade specific)
**Expected Result:** LoginController updateQuery() works
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

## Section 3: Affiliates Table Operations

### TC-DB-010: Insert Affiliate Record
**Priority:** CRITICAL
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-DB-011: Update Affiliate Record
**Priority:** HIGH
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-DB-012: Delete Affiliate Record
**Priority:** MEDIUM
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

## Section 4: Assessments Table Operations

### TC-DB-013: Insert Assessment Record
**Priority:** CRITICAL
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-DB-014: Update Assessment Status
**Priority:** CRITICAL
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-DB-015: Update Program Latest Assessment Link
**Priority:** CRITICAL (Upgrade specific)
**Expected Result:** ProgramAssessmentsTable updateQuery() works
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-DB-016: Delete Assessment Record
**Priority:** HIGH
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

## Section 5: Assessment Responses Operations

### TC-DB-017: Insert Assessment Response
**Priority:** CRITICAL
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-DB-018: Update Assessment Response
**Priority:** HIGH
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-DB-019: Bulk Insert Responses
**Priority:** HIGH
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-DB-020: Delete Assessment Responses
**Priority:** MEDIUM
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

## Section 6: Junction Table Operations

### TC-DB-021: Insert mentee_ages_programs Record
**Priority:** HIGH
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-DB-022: Delete mentee_ages_programs Record
**Priority:** HIGH
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-DB-023: Insert affiliates_users Record
**Priority:** HIGH
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-DB-024: Delete affiliates_users Record
**Priority:** HIGH
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-DB-025: Insert programs_users Record
**Priority:** HIGH
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

## Section 7: Postal Codes Operations

### TC-DB-026: Bulk Delete Postal Codes
**Priority:** CRITICAL (Upgrade specific)
**Expected Result:** UpdatePostalCodesCommand deleteQuery() works
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-DB-027: Bulk Insert Postal Codes
**Priority:** HIGH
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-DB-028: Program Locations Foreign Key Integrity
**Priority:** HIGH
**Expected Result:** FK to postal_codes maintained
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

## Section 8: Transaction Handling

### TC-DB-029: Successful Transaction Commit
**Priority:** CRITICAL
**Expected Result:** Multi-table updates committed together
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-DB-030: Transaction Rollback on Error
**Priority:** CRITICAL
**Expected Result:** All changes rolled back on error
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-DB-031: Sortable Transaction Support
**Priority:** CRITICAL (Upgrade specific)
**Expected Result:** SortableController transactions work
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

## Section 9: Foreign Key Constraints

### TC-DB-032: FK Constraint - Program to Organization
**Priority:** HIGH
**Expected Result:** Cannot delete org with programs
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-DB-033: FK Constraint - Assessment to Program
**Priority:** HIGH
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-DB-034: FK Constraint - User Associations
**Priority:** HIGH
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

## Section 10: Data Integrity

### TC-DB-035: No Orphaned Records After Delete
**Priority:** HIGH
**Expected Result:** Cascade deletes or FK constraints prevent orphans
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-DB-036: Unique Constraints Enforced
**Priority:** HIGH
**Expected Result:** Duplicate prevention works (user emails, etc.)
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-DB-037: NOT NULL Constraints Enforced
**Priority:** MEDIUM
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

## Section 11: Migrations

### TC-DB-038: All Migrations Execute Successfully
**Priority:** CRITICAL
**Test Steps:** Run `composer migrations`
**Expected Result:** All 156+ migrations complete without errors
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-DB-039: Migration Rollback (if needed)
**Priority:** MEDIUM
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

## Section 12: Database Performance

### TC-DB-040: Query Performance - Simple Select
**Priority:** MEDIUM
**Expected Result:** Single record retrieval < 50ms
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-DB-041: Query Performance - Complex Join
**Priority:** MEDIUM
**Expected Result:** Multi-table query < 500ms
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-DB-042: No N+1 Query Issues
**Priority:** MEDIUM
**Expected Result:** Relationships eager loaded where appropriate
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

---

## Summary
**Total:** 42 | **Critical:** 12 | **High:** 21 | **Medium:** 9
**Completion:** _____ / 42 (_____%)

**Sign-Off:** _______________________ **Date:** ___________
