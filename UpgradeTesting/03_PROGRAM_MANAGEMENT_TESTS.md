# Test Suite 03: Program Management Tests

**Priority:** HIGH
**Total Test Cases:** 72
**Focus:** Validate program CRUD operations, workflows, and data integrity

## Overview

This test suite covers the core program management functionality including:
1. Program creation and editing
2. Program listing and filtering
3. Program status workflows
4. Program-affiliate associations
5. Program dimensions (ages, genders, types, etc.)
6. Program locations and service areas
7. Program documents
8. Program NQMS readiness

---

## Section 1: Program Creation

### TC-PROG-001: Create New Program with Required Fields Only
**Priority:** CRITICAL
**Prerequisites:** Logged in with program creation permissions

**Test Steps:**
1. Navigate to `/admin/programs`
2. Click "Create New Program"
3. Fill in only required fields:
   - Title
   - Organization
   - Contact Email
4. Save program

**Expected Result:**
- Program created successfully
- Redirect to program view or list
- Flash message confirms creation
- Program appears in database with status "pending" (or default status)
- Created_by and modified_by fields populated

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-PROG-002: Create Program with All Fields Populated
**Priority:** HIGH
**Prerequisites:** Logged in with program creation permissions

**Test Steps:**
1. Navigate to create program page
2. Fill in all available fields including:
   - Title, organization, contact info
   - Demographics (ages, genders, categories)
   - Meeting types, locations, frequency
   - Program description
   - Background check requirements
   - Volunteer training details
3. Save program

**Expected Result:**
- Program created with all data saved correctly
- All fields persist to database
- Program displays correctly on view page
- No data loss

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-PROG-003: Create Program - Required Field Validation
**Priority:** CRITICAL
**Prerequisites:** Program creation form

**Test Steps:**
1. Navigate to create program page
2. Leave required fields empty
3. Attempt to save

**Expected Result:**
- Validation errors display
- "Title is required" message
- "Organization is required" message
- Form not submitted
- User remains on create page

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-PROG-004: Create Program - Email Format Validation
**Priority:** HIGH
**Prerequisites:** Program creation form

**Test Steps:**
1. Navigate to create program page
2. Enter invalid email format in contact_email field
3. Attempt to save

**Expected Result:**
- Validation error: "Please enter a valid email address"
- Form not submitted
- Email field highlighted

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-PROG-005: Create Program - Logo Upload
**Priority:** HIGH
**Prerequisites:** Image file for logo

**Test Steps:**
1. Navigate to create program page
2. Fill in required fields
3. Upload logo image (PNG/JPG)
4. Save program

**Expected Result:**
- Logo uploads successfully
- Logo saved to S3/storage
- Program's logo_id field populated
- Logo displays on program page

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

## Section 2: Program Editing

### TC-PROG-006: Edit Existing Program - Basic Fields
**Priority:** CRITICAL
**Prerequisites:** Existing program

**Test Steps:**
1. Navigate to program edit page
2. Modify title and description
3. Save changes

**Expected Result:**
- Changes saved successfully
- Modified timestamp updated
- Modified_by field updated
- Changes visible on program view page

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-PROG-007: Edit Program - Change Organization
**Priority:** HIGH
**Prerequisites:** Program with Organization A, Organization B exists

**Test Steps:**
1. Open program edit page
2. Change organization from A to B
3. Save changes

**Expected Result:**
- Organization updated
- Program now associated with Organization B
- No data integrity issues
- Change reflected immediately

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-PROG-008: Edit Program - Add/Remove Mentee Ages
**Priority:** HIGH
**Prerequisites:** Program with some mentee ages selected

**Test Steps:**
1. Open program edit page
2. Add new mentee age range
3. Remove existing mentee age range
4. Save changes
5. Verify in database: mentee_ages_programs table

**Expected Result:**
- New age range added to junction table
- Removed age range deleted from junction table
- Changes reflected on program view page
- Many-to-many relationship handled correctly

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-PROG-009: Edit Program - Modify All Demographics
**Priority:** HIGH
**Prerequisites:** Program with existing demographics

**Test Steps:**
1. Open program edit page
2. Modify all demographic selections:
   - Mentee ages, mentor ages
   - Mentee genders, mentor genders
   - Mentee categories
   - Focus types
   - Grades
3. Save changes

**Expected Result:**
- All demographic changes saved
- Junction tables updated correctly
- No orphaned records
- Changes display correctly

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-PROG-010: Edit Program - Replace Logo
**Priority:** MEDIUM
**Prerequisites:** Program with existing logo

**Test Steps:**
1. Open program edit page
2. Remove existing logo
3. Upload new logo
4. Save program

**Expected Result:**
- Old logo reference removed (or file deleted)
- New logo uploaded to S3/storage
- logo_id field updated
- New logo displays on program page

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

## Section 3: Program Listing & Filtering

### TC-PROG-011: View Program List - All Programs
**Priority:** CRITICAL
**Prerequisites:** Multiple programs exist

**Test Steps:**
1. Navigate to `/admin/programs`
2. View program list

**Expected Result:**
- All programs display (or filtered by user permissions)
- Program title, organization, status visible
- Pagination works if many programs
- List loads without errors

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-PROG-012: Filter Programs by Status - Approved
**Priority:** HIGH
**Prerequisites:** Programs with various statuses

**Test Steps:**
1. Navigate to `/admin/programs`
2. Apply filter: Status = "Approved"
3. View results

**Expected Result:**
- Only approved programs display
- Other statuses hidden
- Filter persists if navigating away and back
- Count reflects filtered results

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-PROG-013: Filter Programs by Status - Pending
**Priority:** HIGH
**Prerequisites:** Programs with "pending" status

**Test Steps:**
1. Navigate to programs list
2. Filter by Status = "Pending"

**Expected Result:**
- Only pending programs display
- Filter works correctly

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-PROG-014: Filter Programs by Affiliate
**Priority:** HIGH
**Prerequisites:** Programs associated with different affiliates

**Test Steps:**
1. Navigate to programs list
2. Apply filter: Affiliate = "Affiliate A"

**Expected Result:**
- Only programs associated with Affiliate A display
- Filter based on program-affiliate associations
- Correct filtering logic

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-PROG-015: Search Programs by Title
**Priority:** HIGH
**Prerequisites:** Programs with known titles

**Test Steps:**
1. Navigate to programs list
2. Enter search term in title search field
3. Submit search

**Expected Result:**
- Programs matching search term display
- Partial match works (e.g., "Mentor" finds "Big Brothers Mentoring")
- Case-insensitive search
- Results accurate

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-PROG-016: Programs List Pagination
**Priority:** MEDIUM
**Prerequisites:** More than 25 programs (or configured page size)

**Test Steps:**
1. Navigate to programs list
2. Observe pagination controls
3. Click "Next Page"
4. Navigate to page 2, 3, etc.

**Expected Result:**
- Pagination displays correctly
- Page 1 shows first X programs
- Page 2 shows next X programs
- Page numbers accurate
- "Previous" and "Next" buttons work

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-PROG-017: Programs List Sorting
**Priority:** MEDIUM
**Prerequisites:** Multiple programs

**Test Steps:**
1. Navigate to programs list
2. Click column header to sort (e.g., Title, Status, Created)
3. Observe sort order

**Expected Result:**
- Sorting works correctly
- Ascending/descending toggle works
- Sorted data accurate
- Sort persists across pagination

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

## Section 4: Program Status Workflows

### TC-PROG-018: Change Program Status - Pending to Approved
**Priority:** CRITICAL
**Prerequisites:** Program with "pending" status

**Test Steps:**
1. Open pending program
2. Change status to "Approved"
3. Save changes

**Expected Result:**
- Status updated to "approved"
- Status change reflected in database
- Program appears in "approved" filtered list
- Status change logged (if audit log exists)

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-PROG-019: Change Program Status - Approved to Paused
**Priority:** HIGH
**Prerequisites:** Approved program

**Test Steps:**
1. Open approved program
2. Change status to "Paused"
3. Save changes

**Expected Result:**
- Status updated to "paused"
- Program visible in paused filter
- Status change persists

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-PROG-020: Change Program Status - To Deleted
**Priority:** HIGH
**Prerequisites:** Program that can be marked deleted

**Test Steps:**
1. Open program
2. Change status to "Deleted"
3. Save changes
4. Check program list

**Expected Result:**
- Status updated to "deleted"
- Program may no longer appear in default list (soft delete)
- Program record remains in database
- Can be filtered/viewed if needed

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-PROG-021: Status Workflow Permissions
**Priority:** HIGH
**Prerequisites:** User with limited status change permissions

**Test Steps:**
1. Login as user who can create but not approve programs
2. Create program (status = pending)
3. Attempt to change status to "approved"

**Expected Result:**
- If permissions restrict: Status change denied or option unavailable
- If permissions allow: Status changes successfully
- Authorization enforced per policy

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

## Section 5: Program-Affiliate Associations

### TC-PROG-022: Associate Program with Single Affiliate
**Priority:** HIGH
**Prerequisites:** Program and Affiliate exist

**Test Steps:**
1. Open program edit page
2. Assign program to Affiliate A
3. Save changes

**Expected Result:**
- Program associated with Affiliate A
- Users of Affiliate A can view/edit program
- Association reflected in database

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-PROG-023: Associate Program with Multiple Affiliates
**Priority:** HIGH
**Prerequisites:** Program and multiple Affiliates

**Test Steps:**
1. Open program edit page
2. Assign program to Affiliate A and Affiliate B
3. Save changes

**Expected Result:**
- Program associated with both affiliates
- Users from both affiliates can access program
- Many-to-many relationship handled correctly

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-PROG-024: Remove Affiliate Association
**Priority:** HIGH
**Prerequisites:** Program associated with Affiliate A

**Test Steps:**
1. Open program edit page
2. Remove Affiliate A association
3. Save changes
4. Verify Affiliate A users can no longer access program

**Expected Result:**
- Association removed from database
- Affiliate A users lose access to program
- Program no longer visible to Affiliate A users

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

## Section 6: Program Locations & Service Areas

### TC-PROG-025: Add Program Location by Zip Code
**Priority:** HIGH
**Prerequisites:** Postal codes loaded in database

**Test Steps:**
1. Open program edit page
2. Navigate to locations/service areas section
3. Add zip code (e.g., 21201)
4. Save program

**Expected Result:**
- Zip code added to program_locations table
- Location appears on program page
- City, county, state automatically populated from postal_codes table

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-PROG-026: Add Multiple Service Area Zip Codes
**Priority:** HIGH
**Prerequisites:** Program edit access

**Test Steps:**
1. Open program edit page
2. Add multiple zip codes (5-10 different zips)
3. Save program

**Expected Result:**
- All zip codes saved to program_locations
- All locations display on program page
- Service area coverage accurate

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-PROG-027: Remove Program Location
**Priority:** MEDIUM
**Prerequisites:** Program with multiple locations

**Test Steps:**
1. Open program edit page
2. Remove one or more zip codes from service areas
3. Save program

**Expected Result:**
- Removed zip codes deleted from program_locations
- Remaining zip codes preserved
- Program page reflects changes

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-PROG-028: Service Areas Vue.js Component (if applicable)
**Priority:** HIGH
**Prerequisites:** Service areas Vue.js component enabled

**Test Steps:**
1. Open program edit or service areas page
2. Interact with Vue.js map-based service area selector
3. Select areas by county or zip code
4. Save selections

**Expected Result:**
- Vue.js component loads correctly
- Map displays properly
- Can select areas via map interface
- Selections save correctly
- JSON data structure valid

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

## Section 7: Program Demographics & Dimensions

### TC-PROG-029: Select Mentee Ages
**Priority:** HIGH
**Prerequisites:** Program edit form

**Test Steps:**
1. Open program edit page
2. Select multiple mentee age ranges
3. Save program
4. Verify in database: mentee_ages_programs table

**Expected Result:**
- Selected age ranges saved
- Junction table populated correctly
- Ages display on program view page

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-PROG-030: Select Mentor Ages
**Priority:** HIGH
**Prerequisites:** Program edit form

**Test Steps:**
1. Open program edit page
2. Select mentor age ranges
3. Save program

**Expected Result:**
- Mentor ages saved correctly
- Data in mentor_ages_programs table

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-PROG-031: Select Mentee Genders
**Priority:** HIGH
**Prerequisites:** Program edit form

**Test Steps:**
1. Open program edit page
2. Select mentee genders
3. Save program

**Expected Result:**
- Mentee genders saved
- Junction table updated correctly

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-PROG-032: Select Mentor Genders
**Priority:** HIGH
**Prerequisites:** Program edit form

**Test Steps:**
1. Open program edit page
2. Select mentor genders
3. Save program

**Expected Result:**
- Mentor genders saved correctly

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-PROG-033: Select Mentee Categories
**Priority:** HIGH
**Prerequisites:** Program edit form

**Test Steps:**
1. Open program edit page
2. Select mentee categories (e.g., at-risk youth, foster youth, etc.)
3. Save program

**Expected Result:**
- Categories saved correctly
- Junction table populated

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-PROG-034: Select Focus Types
**Priority:** HIGH
**Prerequisites:** Program edit form

**Test Steps:**
1. Open program edit page
2. Select focus types (e.g., academic, career, social)
3. Save program

**Expected Result:**
- Focus types saved
- Data correct in focus_types_programs table

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-PROG-035: Select Grades Served
**Priority:** HIGH
**Prerequisites:** Program edit form

**Test Steps:**
1. Open program edit page
2. Select grade levels served
3. Save program

**Expected Result:**
- Grade levels saved
- Junction table updated

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-PROG-036: Select Meeting Locations
**Priority:** HIGH
**Prerequisites:** Program edit form

**Test Steps:**
1. Open program edit page
2. Select meeting location types (e.g., school, community center)
3. Save program

**Expected Result:**
- Meeting locations saved
- Data in meeting_locations_programs table

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-PROG-037: Select Mentoring Types
**Priority:** HIGH
**Prerequisites:** Program edit form

**Test Steps:**
1. Open program edit page
2. Select mentoring types (e.g., one-on-one, group, peer)
3. Save program

**Expected Result:**
- Mentoring types saved correctly
- Junction table populated

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-PROG-038: Select Operations
**Priority:** MEDIUM
**Prerequisites:** Program edit form

**Test Steps:**
1. Open program edit page
2. Select operations (program operational characteristics)
3. Save program

**Expected Result:**
- Operations saved
- Data in operations_programs table

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

## Section 8: Program Details & Configuration

### TC-PROG-039: Set Meeting Frequency
**Priority:** MEDIUM
**Prerequisites:** Program edit form

**Test Steps:**
1. Open program edit page
2. Specify meeting frequency (e.g., weekly, monthly)
3. Save program

**Expected Result:**
- Meeting frequency saved
- Displays correctly on program page

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-PROG-040: Set Minimum Match Commitment
**Priority:** MEDIUM
**Prerequisites:** Program edit form

**Test Steps:**
1. Open program edit page
2. Enter minimum match commitment (e.g., "6 months", "1 year")
3. Save program

**Expected Result:**
- Commitment duration saved
- Value displays correctly

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-PROG-041: Configure Background Check Requirements
**Priority:** HIGH
**Prerequisites:** Program edit form

**Test Steps:**
1. Open program edit page
2. Toggle background check requirement
3. Add background check details if required
4. Save program

**Expected Result:**
- Background check configuration saved
- Details stored in program_background_details if applicable
- Requirements display on program page

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-PROG-042: Configure Volunteer Training Requirements
**Priority:** HIGH
**Prerequisites:** Program edit form

**Test Steps:**
1. Open program edit page
2. Specify volunteer training requirements
3. Add training details
4. Save program

**Expected Result:**
- Training requirements saved
- Details display on program page

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-PROG-043: Add Program Description with Rich Text
**Priority:** MEDIUM
**Prerequisites:** Program edit form with CKEditor or rich text editor

**Test Steps:**
1. Open program edit page
2. Enter program description with formatting:
   - Bold, italic text
   - Bullet lists
   - Links
3. Save program

**Expected Result:**
- Rich text content saved (HTML)
- Formatting preserved
- Content displays correctly with formatting

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

## Section 9: Program Documents

### TC-PROG-044: Upload Program Document
**Priority:** HIGH
**Prerequisites:** Program exists

**Test Steps:**
1. Navigate to program documents section
2. Upload a PDF document
3. Save/associate with program

**Expected Result:**
- Document uploads successfully
- Stored in S3/storage
- Document linked to program in program_documents table
- Document appears in program's document list

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-PROG-045: Download Program Document
**Priority:** HIGH
**Prerequisites:** Program with uploaded document

**Test Steps:**
1. Navigate to program documents
2. Click download link for document
3. Verify file downloads

**Expected Result:**
- Document downloads successfully
- File opens correctly
- Content matches uploaded document

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-PROG-046: Delete Program Document
**Priority:** MEDIUM
**Prerequisites:** Program with uploaded document

**Test Steps:**
1. Navigate to program documents
2. Delete a document
3. Confirm deletion

**Expected Result:**
- Document removed from list
- Record deleted from program_documents table
- File removed from S3/storage (or marked for deletion)

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-PROG-047: Associate Document with Assessment
**Priority:** HIGH
**Prerequisites:** Program with assessment

**Test Steps:**
1. Navigate to assessment documents
2. Upload document associated with specific assessment
3. Save association

**Expected Result:**
- Document linked to assessment
- Assessment ID stored in program_documents
- Document visible from assessment view

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

## Section 10: Program NQMS Readiness

### TC-PROG-048: Mark Program as NQMS Ready
**Priority:** HIGH
**Prerequisites:** Program edit access

**Test Steps:**
1. Open program edit page
2. Toggle "NQMS Ready" flag to true
3. Save program

**Expected Result:**
- nqms_ready field set to true
- Program eligible for NQMS assessments
- Flag displays on program page

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-PROG-049: Link Program to Latest Assessment
**Priority:** CRITICAL
**Prerequisites:** Program with completed assessment

**Test Steps:**
1. Create assessment for program
2. Submit assessment
3. Verify program's latest_assessment_id field updated

**Expected Result:**
- latest_assessment_id points to most recent assessment
- Link maintained in programs table
- Latest assessment displays on program page

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-PROG-050: NQMS Badges Display on Program
**Priority:** MEDIUM
**Prerequisites:** Program with earned NQMS badges

**Test Steps:**
1. Associate program with NQMS badges
2. View program details page
3. Verify badges display

**Expected Result:**
- Earned badges display on program page
- Badge icons/images visible
- Badge names and descriptions shown

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

## Section 11: Program Reminders

### TC-PROG-051: Configure Program Reminders
**Priority:** MEDIUM
**Prerequisites:** Program with reminder configuration

**Test Steps:**
1. Navigate to program reminders section
2. Configure reminder settings
3. Save configuration

**Expected Result:**
- Reminder settings saved
- Configuration stored in database
- Reminders will trigger per schedule

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-PROG-052: Dismiss Program Reminder
**Priority:** MEDIUM
**Prerequisites:** Program with active reminder

**Test Steps:**
1. View program with active reminder
2. Click "Dismiss" on reminder
3. Verify reminder dismissed

**Expected Result:**
- Reminder dismissed
- Record added to reminder_dismissals table
- Reminder no longer displays for user

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

## Section 12: Program Deletion & Soft Delete

### TC-PROG-053: Soft Delete Program (Status = Deleted)
**Priority:** HIGH
**Prerequisites:** Program that can be deleted

**Test Steps:**
1. Open program
2. Change status to "Deleted"
3. Save changes
4. Verify program no longer in active list

**Expected Result:**
- Status changed to "deleted"
- Program record remains in database (soft delete)
- Not visible in default program list
- Can be recovered if needed

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-PROG-054: Hard Delete Program (if implemented)
**Priority:** MEDIUM
**Prerequisites:** Test program safe to delete

**Test Steps:**
1. Navigate to program management
2. Select program to permanently delete
3. Confirm deletion
4. Verify program removed from database

**Expected Result:**
- Program record deleted from programs table
- Related records handled (cascade or restrict per FK constraints)
- No orphaned records

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-PROG-055: Cannot Delete Program with Active Assessments
**Priority:** HIGH
**Prerequisites:** Program with submitted/approved assessments

**Test Steps:**
1. Attempt to delete program with active assessments
2. Observe result

**Expected Result:**
- Deletion prevented (if business rule enforced)
- Error message: "Cannot delete program with active assessments"
- OR status changed to "deleted" but record retained

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

## Section 13: Program View & Display

### TC-PROG-056: View Program Details Page
**Priority:** HIGH
**Prerequisites:** Existing program

**Test Steps:**
1. Navigate to program details page
2. Verify all sections display:
   - Basic information
   - Demographics
   - Service areas
   - Assessments
   - Documents
   - Badges

**Expected Result:**
- All program data displays correctly
- Images/logos render
- Links functional
- Layout correct

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-PROG-057: Program Card/Summary Display
**Priority:** MEDIUM
**Prerequisites:** Program list with multiple programs

**Test Steps:**
1. View program list
2. Observe program cards/summaries
3. Verify key information visible:
   - Title
   - Logo
   - Organization
   - Status
   - Brief description

**Expected Result:**
- Program cards display correctly
- Information accurate
- Styling consistent
- Clickable to view full details

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-PROG-058: Public Program View (if applicable)
**Priority:** MEDIUM
**Prerequisites:** Program marked as public/approved

**Test Steps:**
1. Log out or use incognito browser
2. Navigate to public program view (frontend)
3. View program details

**Expected Result:**
- Public can view approved program details
- Sensitive information hidden (if applicable)
- Program search and discovery works
- Public layout displays correctly

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

## Section 14: Program Data Integrity

### TC-PROG-059: Program Foreign Key Constraints - Organization
**Priority:** HIGH
**Prerequisites:** Program with organization

**Test Steps:**
1. Attempt to delete organization that has associated programs
2. Observe result

**Expected Result:**
- Deletion prevented by FK constraint
- Error message explains constraint violation
- OR programs reassigned/orphaned per business rules

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-PROG-060: Program Junction Table Integrity - Demographics
**Priority:** MEDIUM
**Prerequisites:** Program with demographics

**Test Steps:**
1. Query junction tables (mentee_ages_programs, etc.)
2. Verify no orphaned records
3. Verify all foreign keys valid

**Expected Result:**
- All junction table records have valid program_id
- All junction table records have valid dimension ID
- No NULL values in foreign keys
- Referential integrity maintained

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-PROG-061: Program Locations Referential Integrity
**Priority:** HIGH
**Prerequisites:** Program with locations

**Test Steps:**
1. Query program_locations table
2. Verify all postal_code_id values exist in postal_codes table
3. Check for orphaned records

**Expected Result:**
- All program_locations have valid postal_code_id
- Referential integrity maintained
- No orphaned location records

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-PROG-062: Program Logo File Integrity
**Priority:** MEDIUM
**Prerequisites:** Program with logo

**Test Steps:**
1. Query program's logo_id
2. Verify ofile record exists
3. Verify file exists in S3/storage
4. Verify logo displays on page

**Expected Result:**
- logo_id references valid ofile record
- File exists in storage
- File accessible and displays correctly
- No broken image links

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

## Section 15: Program Validation & Business Rules

### TC-PROG-063: Program Title Uniqueness (if enforced)
**Priority:** MEDIUM
**Prerequisites:** Existing program with specific title

**Test Steps:**
1. Attempt to create new program with duplicate title
2. Observe validation

**Expected Result:**
- If uniqueness enforced: Validation error displayed
- If not enforced: Duplicate allowed (document behavior)

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-PROG-064: Program Contact Email Validation
**Priority:** HIGH
**Prerequisites:** Program edit form

**Test Steps:**
1. Enter invalid email format
2. Attempt to save

**Expected Result:**
- Validation error: "Invalid email format"
- Form not submitted

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-PROG-065: Program Requires At Least One Demographic (if rule exists)
**Priority:** MEDIUM
**Prerequisites:** Program creation form

**Test Steps:**
1. Create program without selecting any demographics
2. Attempt to save

**Expected Result:**
- If rule enforced: Validation error
- If not enforced: Program saves (document behavior)

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

## Section 16: Program Export & Reporting

### TC-PROG-066: Export Program List to CSV/Excel
**Priority:** MEDIUM
**Prerequisites:** Multiple programs in system

**Test Steps:**
1. Navigate to programs list
2. Click "Export" button
3. Download file

**Expected Result:**
- Export file downloads successfully
- Contains all programs (or filtered subset)
- Data accurate in export
- File opens in Excel/CSV reader

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-PROG-067: Generate Program Report
**Priority:** MEDIUM
**Prerequisites:** Reporting functionality available

**Test Steps:**
1. Navigate to reports section
2. Select program report
3. Generate report

**Expected Result:**
- Report generates successfully
- Data accurate
- Report displays or downloads
- Formatting correct

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

## Section 17: Program Performance & Load

### TC-PROG-068: Program List Performance with Many Records
**Priority:** MEDIUM
**Prerequisites:** 100+ programs in database

**Test Steps:**
1. Navigate to programs list
2. Observe page load time
3. Check for performance issues

**Expected Result:**
- Page loads in reasonable time (<3 seconds)
- Pagination helps manage large datasets
- No timeout errors
- Query performance acceptable

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-PROG-069: Program Edit Form Load with Complex Data
**Priority:** MEDIUM
**Prerequisites:** Program with many demographics, locations, documents

**Test Steps:**
1. Open edit page for complex program
2. Observe load time
3. Verify all data loads

**Expected Result:**
- Page loads in reasonable time
- All data populated correctly
- No timeout errors
- Form usable

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-PROG-070: Concurrent Program Edits
**Priority:** MEDIUM
**Prerequisites:** Two users editing same program

**Test Steps:**
1. User A opens program edit page
2. User B opens same program edit page
3. User A saves changes
4. User B saves different changes

**Expected Result:**
- Last save wins (typical behavior)
- OR conflict detection/warning (if implemented)
- No data corruption
- Users informed of concurrent edits

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

## Section 18: Program Mobile Responsiveness

### TC-PROG-071: Program List on Mobile Device
**Priority:** MEDIUM
**Prerequisites:** Mobile device or responsive testing tool

**Test Steps:**
1. Access program list on mobile device
2. Verify layout and usability

**Expected Result:**
- Page responsive on mobile
- Content readable
- Navigation usable
- Touch targets adequate size

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-PROG-072: Program Edit on Mobile Device
**Priority:** LOW
**Prerequisites:** Mobile device

**Test Steps:**
1. Access program edit page on mobile
2. Attempt to edit program details
3. Save changes

**Expected Result:**
- Form usable on mobile (may not be optimal)
- Can save changes
- Basic functionality works
- OR message indicating desktop recommended

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

## Summary

**Total Test Cases:** 72
**Critical Priority:** 8
**High Priority:** 42
**Medium Priority:** 20
**Low Priority:** 2

**Completion Status:**
- Tests Passed: _____ / 72 (_____%)
- Tests Failed: _____ / 72 (_____%)
- Tests Blocked: _____ / 72 (_____%)
- Tests Skipped: _____ / 72 (_____%)

**Overall Status:** ☐ PASS ☐ FAIL ☐ BLOCKED

**Sign-Off:**
**Tester:** _______________________ **Date:** ___________
**Reviewer:** _______________________ **Date:** ___________

---

**Notes:**
