# Test Suite 01: Critical Upgrade Tests

**Priority:** CRITICAL
**Total Test Cases:** 45
**Focus:** Validate specific code changes made during CakePHP 4.4.14 → 4.6.2 upgrade

## Overview

This test suite validates the specific code changes made during the upgrade, focusing on:
1. Query method updates (query() → updateQuery()/deleteQuery())
2. Helper loading updates (loadHelper() → addHelper())
3. Transaction support in SortableController
4. Orases/Files plugin functionality

All tests in this suite must pass before proceeding to other test suites.

---

## Section 1: Login Controller - Last Login Timestamp Update

**File:** `plugins/Users/src/Controller/LoginController.php:132`
**Change:** Updated from deprecated `query()->update()` to `updateQuery()`

### TC-CRT-001: Successful Login Updates Last Login Timestamp
**Priority:** CRITICAL
**Prerequisites:** Valid user account exists

**Test Steps:**
1. Navigate to `/users/login`
2. Enter valid email and password
3. Click "Login" button
4. Query database: `SELECT last_login FROM users WHERE email = '[test_email]'`

**Expected Result:**
- User successfully logs in
- `last_login` field updated with current timestamp
- No PHP errors in logs
- Redirected to intended destination or `/admin`

**Test Data:**
- Email: [test user email]
- Password: [test user password]

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-CRT-002: Multiple Sequential Logins Update Timestamp Each Time
**Priority:** CRITICAL
**Prerequisites:** Valid user account exists

**Test Steps:**
1. Log in as test user
2. Note the `last_login` timestamp from database
3. Log out
4. Wait 2 minutes
5. Log in again as same user
6. Query database for new `last_login` timestamp

**Expected Result:**
- Second `last_login` timestamp is later than first
- Both timestamps accurately reflect login times
- No errors in application logs

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-CRT-003: Failed Login Does Not Update Last Login Timestamp
**Priority:** HIGH
**Prerequisites:** Valid user account exists with known last_login timestamp

**Test Steps:**
1. Note current `last_login` value for test user
2. Attempt login with correct email but wrong password
3. Verify login fails
4. Check `last_login` timestamp in database

**Expected Result:**
- Login fails with error message
- `last_login` timestamp remains unchanged
- No PHP errors (only validation error displayed)

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-CRT-004: Last Login Timestamp Timezone Accuracy
**Priority:** MEDIUM
**Prerequisites:** Application timezone set to 'America/New_York'

**Test Steps:**
1. Log in as test user
2. Note the current time in EST/EDT
3. Query `last_login` from database
4. Compare database timestamp to actual login time

**Expected Result:**
- `last_login` timestamp matches actual login time
- Timezone correctly set to America/New_York
- Timestamp format follows configured format

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

## Section 2: NQMS Assessment Questions Sorting

**File:** `src/Controller/Admin/Api/SortableController.php`
**Change:** Added transaction support, updated to use `updateQuery()`
**Previous Issue:** 500 errors when reordering questions

### TC-CRT-005: Sort NQMS Assessment Questions Successfully
**Priority:** CRITICAL
**Prerequisites:**
- Logged in as superuser or NQMS affiliate
- At least 5 assessment questions exist in a section

**Test Steps:**
1. Navigate to `/admin/nqms/assessment-questions`
2. Open a section with multiple questions
3. Drag and drop a question from position 3 to position 1
4. Release the drag
5. Observe the response
6. Refresh the page

**Expected Result:**
- No 500 error occurs
- Questions reorder immediately on drag
- Order persists after page refresh
- `display_order` field updated correctly in database
- No errors in PHP or JavaScript console

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-CRT-006: Sort Questions - Transaction Rollback on Error
**Priority:** CRITICAL
**Prerequisites:**
- Database connection available
- Multiple questions in a section

**Test Steps:**
1. Navigate to NQMS assessment questions
2. Begin dragging a question to new position
3. Simulate database error (if possible, otherwise skip to manual testing)
4. Complete the drag operation
5. Check database for `display_order` consistency

**Expected Result:**
- If error occurs, transaction rolls back
- All questions maintain valid display_order
- No orphaned or duplicate display_order values
- Error logged appropriately
- User sees friendly error message

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-CRT-007: Sort Multiple Questions Sequentially
**Priority:** HIGH
**Prerequisites:** At least 10 questions in a section

**Test Steps:**
1. Navigate to `/admin/nqms/assessment-questions`
2. Reorder question from position 10 to position 1
3. Without refreshing, reorder another question from position 5 to position 2
4. Perform a third reorder operation
5. Refresh the page

**Expected Result:**
- All three reorder operations succeed
- Final order matches expected order after all operations
- No race conditions or ordering conflicts
- `display_order` values are sequential with no gaps

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-CRT-008: Sort Questions - Concurrent User Scenario
**Priority:** MEDIUM
**Prerequisites:**
- Two users logged in (same or different browsers)
- Both viewing same section

**Test Steps:**
1. User A drags question from position 2 to position 5
2. Simultaneously, User B drags question from position 4 to position 1
3. Both users complete their operations
4. Both users refresh their pages

**Expected Result:**
- No data corruption
- Final order is consistent for both users
- All questions have valid, sequential display_order
- Potential race condition handled gracefully

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

## Section 3: Program Assessments - Latest Assessment Linking

**File:** `plugins/Programs/src/Model/Table/ProgramAssessmentsTable.php:93`
**Change:** Updated to use `updateQuery()` for setting `latest_assessment_id`

### TC-CRT-009: Create New Assessment Updates Program Latest Assessment
**Priority:** CRITICAL
**Prerequisites:**
- Program exists with `latest_assessment_id = NULL`
- Logged in as user with program access

**Test Steps:**
1. Navigate to program details page
2. Click "Create New Assessment"
3. Fill in required assessment fields
4. Save the assessment
5. Query database: `SELECT latest_assessment_id FROM programs WHERE id = '[program_id]'`

**Expected Result:**
- Assessment created successfully
- Program's `latest_assessment_id` updated to new assessment's ID
- No PHP errors
- Assessment shows as "latest" on program page

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-CRT-010: Submit Assessment Updates Latest Assessment Link
**Priority:** CRITICAL
**Prerequisites:**
- Program with draft assessment
- Assessment in "draft" status

**Test Steps:**
1. Open draft assessment
2. Complete all required fields
3. Click "Submit Assessment"
4. Verify assessment status changes to "submitted"
5. Check program's `latest_assessment_id` field

**Expected Result:**
- Assessment status updates to "submitted"
- Program's `latest_assessment_id` points to submitted assessment
- No errors in logs
- Database query executes successfully

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-CRT-011: Multiple Assessments - Latest Assessment Tracking
**Priority:** HIGH
**Prerequisites:** Program with 2+ existing assessments

**Test Steps:**
1. Navigate to program with existing assessments
2. Create a new assessment (Assessment C)
3. Submit Assessment C
4. Query: `SELECT latest_assessment_id FROM programs WHERE id = '[program_id]'`
5. Verify the ID matches Assessment C

**Expected Result:**
- `latest_assessment_id` points to most recently created/submitted assessment
- Previous assessments remain in database unchanged
- Latest assessment flagged correctly in UI

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-CRT-012: Assessment Approval Updates Latest Assessment
**Priority:** HIGH
**Prerequisites:**
- Program with submitted assessment
- Logged in as user with approval permissions

**Test Steps:**
1. Navigate to submitted assessment
2. Review assessment details
3. Click "Approve Assessment"
4. Check program's `latest_assessment_id`
5. Verify assessment status is "approved"

**Expected Result:**
- Assessment approved successfully
- Status changes to "approved"
- Program's `latest_assessment_id` remains linked to approved assessment
- Approved timestamp recorded

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

## Section 4: Postal Codes Update Command

**File:** `src/Command/UpdatePostalCodesCommand.php`
**Change:** Updated to use `deleteQuery()` for removing old postal codes

### TC-CRT-013: Execute Postal Codes Update Command
**Priority:** CRITICAL
**Prerequisites:**
- CLI access to application
- Postal codes data file available

**Test Steps:**
1. Open terminal
2. Navigate to application root
3. Run: `bin/cake update_postal_codes`
4. Observe command output
5. Check application logs for errors

**Expected Result:**
- Command executes without errors
- Old postal codes deleted successfully
- New postal codes imported
- Database integrity maintained
- Success message displayed
- No deprecation warnings in logs

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-CRT-014: Postal Codes - Data Integrity After Update
**Priority:** HIGH
**Prerequisites:** Known postal code count before update

**Test Steps:**
1. Query: `SELECT COUNT(*) FROM postal_codes` (record count)
2. Run: `bin/cake update_postal_codes`
3. Query: `SELECT COUNT(*) FROM postal_codes` (new count)
4. Verify data integrity: `SELECT * FROM postal_codes WHERE city IS NULL OR zip_code IS NULL`

**Expected Result:**
- New postal code count is reasonable (within expected range)
- No postal codes with NULL required fields
- Referential integrity maintained (counties, states still valid)
- No orphaned records

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-CRT-015: Postal Codes Update with Existing Program Locations
**Priority:** CRITICAL
**Prerequisites:**
- Programs exist with `program_locations` records
- Postal codes referenced by programs

**Test Steps:**
1. Identify programs with existing postal code associations
2. Run: `bin/cake update_postal_codes`
3. Verify program locations still valid
4. Check that no foreign key constraints violated

**Expected Result:**
- Command completes successfully
- Program locations remain intact
- No foreign key errors
- Programs still display correct geographic data
- Service areas unchanged

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

## Section 5: Helper Loading Updates

**Changes:** Updated from `loadHelper()` to `addHelper()` in 5 files

### TC-CRT-016: Programs Index Page Renders Correctly
**Priority:** CRITICAL
**Prerequisites:** Logged in with program view permissions

**Test Steps:**
1. Navigate to `/admin/programs`
2. Observe page rendering
3. Check for helper-related errors in PHP logs
4. Verify all UI elements display correctly

**Expected Result:**
- Page renders without errors
- All helpers loaded successfully (Form, Html, Flash, etc.)
- No deprecation warnings related to helpers
- Page styling and layout correct

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-CRT-017: Assessment Form Renders with All Helpers
**Priority:** CRITICAL
**Prerequisites:** Access to create/edit assessment

**Test Steps:**
1. Navigate to assessment creation/edit page
2. Verify all form elements render
3. Check browser console for JavaScript errors
4. Check PHP logs for helper loading errors
5. Test form submission

**Expected Result:**
- Form renders completely
- All helpers available (Form, Html, Text, etc.)
- CKEditor loads if present
- Form validation works
- No deprecated helper warnings

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-CRT-018: Affiliate Management Pages Render
**Priority:** HIGH
**Prerequisites:** Logged in with affiliate management permissions

**Test Steps:**
1. Navigate to `/admin/affiliates`
2. Click "Add Affiliate"
3. Navigate to "Edit Affiliate" page
4. Check all views for helper errors

**Expected Result:**
- All pages render successfully
- Forms functional
- No helper loading errors
- View helpers working (pagination, form, flash messages)

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-CRT-019: User Management Views Render
**Priority:** HIGH
**Prerequisites:** Logged in as superuser

**Test Steps:**
1. Navigate to `/admin/users`
2. View user list page
3. Click "Edit" on a user
4. Navigate to account settings
5. Check for helper-related errors

**Expected Result:**
- All user management views render
- No deprecated helper warnings
- Forms and UI elements functional
- Flash messages display correctly

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-CRT-020: Template Rendering Across All Plugins
**Priority:** MEDIUM
**Prerequisites:** Access to all plugin areas

**Test Steps:**
1. Navigate through each plugin's admin interface:
   - Users
   - Programs
   - Affiliates
   - Inquiries
   - Searches
   - NQMS
   - ServiceAreas
   - Reports
2. Check each page for rendering errors

**Expected Result:**
- All templates render successfully across all plugins
- No helper loading failures
- Consistent layout and styling
- No deprecation warnings

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

## Section 6: Orases/Files Plugin Update

**Change:** Updated from previous version to ^2.3

### TC-CRT-021: File Upload - Program Logo
**Priority:** CRITICAL
**Prerequisites:** Program without logo

**Test Steps:**
1. Navigate to program edit page
2. Click "Upload Logo" or similar
3. Select an image file (PNG, JPG)
4. Upload the file
5. Verify logo displays on program page

**Expected Result:**
- File uploads successfully
- Logo saved to S3/storage
- Logo displays correctly
- Thumbnail generated
- Database record created in `ofiles` table

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-CRT-022: File Upload - Program Documents
**Priority:** CRITICAL
**Prerequisites:** Program with assessment

**Test Steps:**
1. Navigate to program documents section
2. Upload a PDF document
3. Verify document appears in list
4. Download the document
5. Verify content is correct

**Expected Result:**
- Document uploads successfully
- File stored in S3/storage
- Download link works
- Downloaded file matches uploaded file
- File metadata stored correctly

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-CRT-023: File Upload - Dropzone Integration
**Priority:** HIGH
**Prerequisites:** Any page with Dropzone uploader

**Test Steps:**
1. Navigate to page with Dropzone file uploader
2. Drag and drop multiple files onto Dropzone area
3. Observe upload progress
4. Verify all files upload successfully

**Expected Result:**
- Dropzone interface displays correctly
- Drag and drop works
- Progress bars display
- All files upload successfully
- Success message shown for each file

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-CRT-024: File Download - Various File Types
**Priority:** HIGH
**Prerequisites:** Files of different types uploaded (PDF, DOCX, JPG, PNG, XLSX)

**Test Steps:**
1. Navigate to page with file downloads
2. Download a PDF file
3. Download an image file
4. Download a Word document
5. Download an Excel file
6. Verify each file opens correctly

**Expected Result:**
- All file types download successfully
- Correct MIME types sent
- Files open in appropriate applications
- No corruption or errors
- Download links work across file types

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-CRT-025: File Delete Operation
**Priority:** HIGH
**Prerequisites:** Files uploaded and associated with records

**Test Steps:**
1. Navigate to file management area
2. Select a file to delete
3. Click delete/remove
4. Confirm deletion
5. Verify file removed from UI and database
6. Verify file removed from S3/storage

**Expected Result:**
- Delete confirmation modal appears
- File deleted from database
- File removed from S3/storage (or marked for deletion)
- UI updates to reflect deletion
- No orphaned records

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-CRT-026: File Thumbnail Generation
**Priority:** MEDIUM
**Prerequisites:** Image files uploaded

**Test Steps:**
1. Upload a large image file (e.g., 4000x3000px)
2. Navigate to page displaying thumbnails
3. Verify thumbnail generated
4. Check thumbnail file in storage
5. Verify thumbnail loads quickly

**Expected Result:**
- Thumbnail generated automatically
- Thumbnail size appropriate (e.g., 150x150px)
- Original image preserved
- Thumbnail loads quickly
- No errors in thumbnail generation

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

## Section 7: Database Query Operations Across Application

### TC-CRT-027: Programs Table - Update Operations
**Priority:** CRITICAL
**Prerequisites:** Existing program record

**Test Steps:**
1. Navigate to program edit page
2. Modify program title and description
3. Save changes
4. Verify changes persisted in database
5. Check logs for query errors

**Expected Result:**
- Program updates successfully
- Changes saved to database
- No deprecated query method warnings
- `updateQuery()` executes without errors

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-CRT-028: Users Table - Update Operations
**Priority:** CRITICAL
**Prerequisites:** Existing user record

**Test Steps:**
1. Navigate to user edit page
2. Update user first name and email
3. Save changes
4. Verify user data updated
5. Test login with new email (if changed)

**Expected Result:**
- User record updates successfully
- `modified` timestamp updated
- `modified_by` set correctly
- No query method deprecation warnings

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-CRT-029: Affiliates Table - Update Operations
**Priority:** CRITICAL
**Prerequisites:** Existing affiliate record

**Test Steps:**
1. Navigate to affiliate edit page
2. Modify affiliate title and contact email
3. Save changes
4. Verify changes in database
5. Check application logs

**Expected Result:**
- Affiliate updates successfully
- Database reflects changes
- No errors or deprecation warnings
- Timestamps updated correctly

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-CRT-030: Inquiries Table - Update Status
**Priority:** HIGH
**Prerequisites:** Inquiry in "pending" status

**Test Steps:**
1. Navigate to inquiries list
2. Open pending inquiry
3. Change status to "contacted"
4. Save changes
5. Verify status updated in database

**Expected Result:**
- Status updates successfully
- `contacted_at` timestamp set (if applicable)
- Status change reflected in UI
- No query errors

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-CRT-031: Program Assessment Responses - Bulk Update
**Priority:** HIGH
**Prerequisites:** Assessment with multiple responses

**Test Steps:**
1. Navigate to assessment response page
2. Update multiple response ratings
3. Save all changes
4. Verify all responses updated correctly

**Expected Result:**
- All responses update successfully
- Bulk update operation completes
- No query method errors
- Response data accurate in database

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-CRT-032: Delete Operations - Programs
**Priority:** CRITICAL
**Prerequisites:** Test program that can be safely deleted

**Test Steps:**
1. Navigate to program management
2. Select program to delete
3. Click delete/remove
4. Confirm deletion
5. Verify program removed from database

**Expected Result:**
- Delete confirmation modal appears
- Program deleted using `deleteQuery()`
- Record removed from database
- Related records handled (cascade/restrict based on FK)
- No errors in logs

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-CRT-033: Delete Operations - Users
**Priority:** HIGH
**Prerequisites:** Test user account that can be deleted

**Test Steps:**
1. Navigate to user management
2. Attempt to delete test user
3. Confirm deletion
4. Verify user removed or marked as deleted

**Expected Result:**
- User deletion succeeds or appropriate error shown
- `deleteQuery()` executes correctly
- Related records handled properly (programs_users, affiliates_users)
- No orphaned records

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-CRT-034: Delete Operations - Affiliates
**Priority:** HIGH
**Prerequisites:** Test affiliate with no critical associations

**Test Steps:**
1. Navigate to affiliates management
2. Select affiliate to delete
3. Click delete
4. Confirm deletion
5. Verify affiliate removed

**Expected Result:**
- Affiliate deleted successfully
- `deleteQuery()` works correctly
- Junction table records cleaned up
- No foreign key constraint violations

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-CRT-035: Delete Operations - Assessments
**Priority:** CRITICAL
**Prerequisites:** Draft assessment that can be deleted

**Test Steps:**
1. Navigate to program assessments
2. Select draft assessment
3. Delete assessment
4. Confirm deletion
5. Verify all related records handled

**Expected Result:**
- Assessment deleted successfully
- Related responses, goals, documents handled appropriately
- Program's `latest_assessment_id` updated if necessary
- No orphaned records

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

## Section 8: Transaction Handling

### TC-CRT-036: Database Transaction - Successful Commit
**Priority:** CRITICAL
**Prerequisites:** Any multi-step operation that uses transactions

**Test Steps:**
1. Perform operation that updates multiple tables (e.g., assessment submission)
2. Verify all changes committed
3. Check database for data consistency
4. Review logs for transaction messages

**Expected Result:**
- Transaction begins
- All operations within transaction succeed
- Transaction commits successfully
- Data consistent across all affected tables

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-CRT-037: Database Transaction - Rollback on Error
**Priority:** CRITICAL
**Prerequisites:** Ability to simulate error during transaction

**Test Steps:**
1. Begin operation that uses transaction
2. Simulate error mid-transaction (if possible)
3. Verify transaction rolls back
4. Check that no partial data committed

**Expected Result:**
- Error occurs during transaction
- Transaction automatically rolls back
- No partial data in database
- Error logged appropriately
- User sees error message

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

## Section 9: Performance & Optimization

### TC-CRT-038: Query Performance - Update Operations
**Priority:** MEDIUM
**Prerequisites:** Database with substantial data

**Test Steps:**
1. Enable query logging
2. Perform update operation (e.g., update program)
3. Review query log for performance
4. Compare to expected query execution time
5. Check for N+1 query issues

**Expected Result:**
- Update queries execute efficiently
- No significant performance degradation from upgrade
- Query execution time reasonable (<100ms for simple updates)
- No unexpected additional queries

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-CRT-039: Query Performance - Delete Operations
**Priority:** MEDIUM
**Prerequisites:** Database with substantial data

**Test Steps:**
1. Enable query logging
2. Perform delete operation with `deleteQuery()`
3. Review query log
4. Check execution time
5. Verify no cascade performance issues

**Expected Result:**
- Delete queries execute efficiently
- Cascade deletes (if any) perform acceptably
- No timeout errors
- Foreign key constraints handled efficiently

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

## Section 10: Error Handling & Logging

### TC-CRT-040: Query Error Logging
**Priority:** HIGH
**Prerequisites:** Access to application logs

**Test Steps:**
1. Perform operations that trigger query methods
2. Induce error (if possible in test environment)
3. Review error logs
4. Check for deprecated method warnings
5. Verify error messages are clear

**Expected Result:**
- No deprecated method warnings in logs
- Query errors logged with useful context
- Error messages helpful for debugging
- Stack traces include relevant information

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-CRT-041: Validation Error Handling
**Priority:** HIGH
**Prerequisites:** Any form with validation

**Test Steps:**
1. Submit form with invalid data
2. Observe validation errors
3. Check logs for exceptions
4. Verify user sees appropriate messages

**Expected Result:**
- Validation errors display correctly
- No unhandled exceptions
- User-friendly error messages
- No deprecation warnings
- Form retains submitted values

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-CRT-042: Database Constraint Violation Handling
**Priority:** HIGH
**Prerequisites:** Database with foreign key constraints

**Test Steps:**
1. Attempt operation that violates FK constraint
2. Observe error handling
3. Check logs for constraint violation
4. Verify user sees appropriate error

**Expected Result:**
- Constraint violation caught
- User sees friendly error message (not raw SQL)
- Error logged with details
- No application crash
- Transaction rolled back if applicable

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

## Section 11: Compatibility & Integration

### TC-CRT-043: CakePHP Debug Kit Compatibility
**Priority:** MEDIUM
**Prerequisites:** Debug Kit enabled in DEV environment

**Test Steps:**
1. Enable Debug Kit
2. Navigate to various pages
3. Check Debug Kit toolbar displays
4. Review SQL log in Debug Kit
5. Verify no compatibility issues

**Expected Result:**
- Debug Kit toolbar displays correctly
- SQL log shows `updateQuery()` and `deleteQuery()` methods
- No deprecated method warnings in toolbar
- All Debug Kit panels functional

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-CRT-044: Redis Cache Integration
**Priority:** HIGH
**Prerequisites:** Redis configured and running

**Test Steps:**
1. Perform operations that use cache
2. Verify cache reads/writes
3. Clear cache: `bin/cake cache clear_all`
4. Verify cache cleared successfully

**Expected Result:**
- Cache reads/writes work correctly
- No compatibility issues with CakePHP 4.6
- Cache clear command succeeds
- Redis connection stable

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-CRT-045: Console Commands After Upgrade
**Priority:** HIGH
**Prerequisites:** CLI access

**Test Steps:**
1. Run: `bin/cake`
2. List all available commands
3. Run sample commands:
   - `bin/cake update_postal_codes`
   - `bin/cake migrations status`
   - `bin/cake cache clear_all`
4. Verify all execute without errors

**Expected Result:**
- All console commands list correctly
- Commands execute without deprecation warnings
- No query method errors in console operations
- Expected output for each command

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

## Summary

**Total Test Cases:** 45
**Critical Priority:** 25
**High Priority:** 15
**Medium Priority:** 5

**Completion Status:**
- Tests Passed: _____ / 45 (_____%)
- Tests Failed: _____ / 45 (_____%)
- Tests Blocked: _____ / 45 (_____%)
- Tests Skipped: _____ / 45 (_____%)

**Overall Status:** ☐ PASS ☐ FAIL ☐ BLOCKED

**Sign-Off:**
**Tester:** _______________________ **Date:** ___________
**Reviewer:** _______________________ **Date:** ___________

---

**Notes:**
