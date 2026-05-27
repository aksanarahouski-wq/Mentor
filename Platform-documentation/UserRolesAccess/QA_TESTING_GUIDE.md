# MENTOR Connector - QA Testing Guide for Permissions

**Version:** 1.0
**Last Updated:** December 3, 2025
**Audience:** QA Testers, Test Engineers, Business Analysts

---

## Table of Contents

1. [Test Environment Setup](#test-environment-setup)
2. [Creating Test Users](#creating-test-users)
3. [Test Scenarios by Role](#test-scenarios-by-role)
4. [Module Access Testing](#module-access-testing)
5. [NQMS Assessment Workflow Testing](#nqms-assessment-workflow-testing)
6. [Negative Testing Scenarios](#negative-testing-scenarios)
7. [Edge Cases and Special Scenarios](#edge-cases-and-special-scenarios)
8. [Test Data Requirements](#test-data-requirements)
9. [Expected Results Reference](#expected-results-reference)

---

## Test Environment Setup

### Prerequisites

Before testing permissions, ensure you have:

1. **Access to a test environment**
   - Do NOT test in production
   - Use a dedicated QA database

2. **Admin credentials**
   - You need a Global Admin account to create test users
   - Username and password for admin access

3. **Test data**
   - At least 2 test affiliates with different ZIP codes
   - At least 4 test programs (2 per affiliate service area)
   - Test NQMS assessment data

4. **Browser setup**
   - Use incognito/private mode for each test user
   - Or clear cookies between user tests
   - Recommended: Multiple browser profiles

---

## Creating Test Users

### Test User Matrix

Create one user account for each role to test:

| Test User | Role Type | Access Level | Contractor | Assignments |
|-----------|-----------|--------------|------------|-------------|
| **admin_test** | Global Admin | N/A | No | Mark as Superuser |
| **aff_full_test** | Affiliate Full | Full Access | No | Test Affiliate A |
| **aff_mc_test** | Affiliate MC | MC-Access Only | No | Test Affiliate A |
| **aff_nqms_test** | Affiliate NQMS | NQMS-Access Only | No | Test Affiliate A |
| **aff_contractor_test** | Affiliate Contractor | NQMS-Access Only | Yes | Test Affiliate A |
| **prog_full_test** | Program Full | Full Access | No | Test Program 1 |
| **prog_nqms_test** | Program NQMS | NQMS-Access Only | No | Test Program 1 |
| **prog_contractor_test** | Program Contractor | NQMS-Access Only | Yes | Test Program 1 |

### Setup Instructions

**For each test user:**

1. Login as Global Admin
2. Go to Accounts → Add User
3. Fill in:
   - First Name: TestUser
   - Last Name: [RoleName] (e.g., AffFull, ProgNQMS)
   - Email: [username]@test.com
   - Password: Test1234! (or your standard test password)
4. For admin_test only: Check "Is Superuser"
5. For affiliate users:
   - Go to Affiliates tab
   - Add assignment to Test Affiliate A
   - Select appropriate Access Level
   - Check "Limited Contractor" if applicable
6. For program users:
   - Go to Programs tab
   - Add assignment to Test Program 1
   - Select appropriate Access Level
   - Check "Limited Contractor" if applicable
7. Mark as Active and Verified
8. Save

---

## Test Scenarios by Role

### Test Suite 1: Global Admin

**Test User:** admin_test

#### TC1.1: Login and Navigation
**Steps:**
1. Login with admin credentials
2. Check main navigation menu

**Expected Result:**
- Login successful
- Can see ALL menu items:
  - Dashboard
  - Programs
  - Affiliates
  - Inquiries
  - Searches
  - Accounts
  - Partners
  - Reports
  - NQMS
  - NQMS Admin
  - Reminders

**Pass/Fail:** _____

---

#### TC1.2: Access All Modules
**Steps:**
1. Click each menu item
2. Verify page loads without errors

**Expected Result:**
- All pages load successfully
- No "Not Authorized" errors
- Can view data in all modules

**Pass/Fail:** _____

---

#### TC1.3: Edit Permissions
**Steps:**
1. Go to Programs → Select a program
2. Try to edit program details
3. Save changes
4. Go to Affiliates → Select an affiliate
5. Try to edit affiliate details
6. Save changes

**Expected Result:**
- Can edit any program
- Can edit any affiliate
- Changes save successfully

**Pass/Fail:** _____

---

#### TC1.4: NQMS Admin Access
**Steps:**
1. Go to NQMS Admin
2. Try to view question templates
3. Try to edit a question

**Expected Result:**
- Can access NQMS Admin
- Can view all question templates
- Can edit templates

**Pass/Fail:** _____

---

#### TC1.5: Approve Assessment
**Steps:**
1. Go to a program with pending assessment
2. Open assessment in pending-review status
3. Click "Approve Assessment"

**Expected Result:**
- Can see "Approve" button
- Assessment status changes to "Approved"
- Success message displayed

**Pass/Fail:** _____

---

### Test Suite 2: Affiliate User (Full Access)

**Test User:** aff_full_test

#### TC2.1: Login and Navigation
**Steps:**
1. Login with affiliate full access credentials
2. Check main navigation menu

**Expected Result:**
- Login successful
- Can see:
  - Dashboard
  - Programs
  - Affiliates
  - Inquiries
  - Searches
  - Accounts
  - Reports
  - NQMS
  - Reminders
- CANNOT see:
  - Partners
  - NQMS Admin

**Pass/Fail:** _____

---

#### TC2.2: Access Programs in Service Area
**Steps:**
1. Go to Programs
2. Note which programs are listed
3. Verify they all belong to service area ZIP codes

**Expected Result:**
- Can see programs in affiliate's service area
- Cannot see programs outside service area
- List matches ZIP code coverage

**Pass/Fail:** _____

---

#### TC2.3: Edit Program in Service Area
**Steps:**
1. Select a program in service area
2. Click Edit
3. Make a change (e.g., phone number)
4. Save

**Expected Result:**
- Can edit program details
- Changes save successfully
- No permission errors

**Pass/Fail:** _____

---

#### TC2.4: Manage Inquiries
**Steps:**
1. Go to Inquiries
2. View inquiry list
3. Open an inquiry
4. Try to respond or update status

**Expected Result:**
- Can view inquiries for programs in service area
- Can edit inquiry responses
- Can update inquiry status

**Pass/Fail:** _____

---

#### TC2.5: Create and Manage Searches
**Steps:**
1. Go to Searches
2. Create a new search
3. Save search
4. Edit search
5. Delete search

**Expected Result:**
- Can create new searches
- Can edit existing searches
- Can delete searches

**Pass/Fail:** _____

---

#### TC2.6: Access NQMS Features
**Steps:**
1. Go to a program in service area
2. View NQMS tab
3. Create new assessment (if none exists)
4. Edit assessment
5. Submit for review

**Expected Result:**
- Can see NQMS tab
- Can create assessments
- Can edit assessments
- Can submit for review

**Pass/Fail:** _____

---

#### TC2.7: Approve Assessment
**Steps:**
1. Go to program with pending assessment
2. Open assessment in pending-review status
3. Look for "Approve Assessment" button
4. Click approve

**Expected Result:**
- Can see "Approve Assessment" button
- Can approve assessment
- Status changes to "Approved"

**Pass/Fail:** _____

---

#### TC2.8: Archive Assessment
**Steps:**
1. Go to program with approved assessment
2. Open assessment
3. Look for "Archive" button
4. Click archive

**Expected Result:**
- Can see "Archive" button
- Can archive assessment
- Assessment marked as archived

**Pass/Fail:** _____

---

### Test Suite 3: Affiliate User (MC-Only)

**Test User:** aff_mc_test

#### TC3.1: Login and Navigation
**Steps:**
1. Login with MC-only credentials
2. Check main navigation menu

**Expected Result:**
- Login successful
- Can see:
  - Dashboard
  - Programs
  - Affiliates
  - Inquiries
  - Searches
  - Accounts
  - Reminders
- CANNOT see:
  - NQMS
  - NQMS Admin
  - Reports
  - Partners

**Pass/Fail:** _____

---

#### TC3.2: Access Inquiries
**Steps:**
1. Go to Inquiries
2. View inquiry list
3. Open and edit an inquiry

**Expected Result:**
- Can access inquiries
- Can edit inquiry responses
- All inquiry features work

**Pass/Fail:** _____

---

#### TC3.3: Try to Access NQMS (Negative Test)
**Steps:**
1. Try to navigate to NQMS (if menu item exists)
2. Or try to access NQMS URL directly
3. Or try to open NQMS tab on program page

**Expected Result:**
- NQMS menu item should NOT be visible
- Direct URL access should show "Not Authorized"
- NQMS tab should NOT appear on program page

**Pass/Fail:** _____

---

#### TC3.4: Edit Program (Basic Info Only)
**Steps:**
1. Go to Programs
2. Select a program
3. Edit basic program details (name, phone, address)
4. Try to access NQMS tab (should not exist)

**Expected Result:**
- Can edit basic program info
- No NQMS tab visible
- Cannot access assessment data

**Pass/Fail:** _____

---

### Test Suite 4: Affiliate User (NQMS-Only)

**Test User:** aff_nqms_test

#### TC4.1: Login and Navigation
**Steps:**
1. Login with NQMS-only credentials
2. Check main navigation menu

**Expected Result:**
- Login successful
- Can see:
  - Dashboard
  - Programs (view only)
  - Affiliates (view only)
  - NQMS
  - Reports
  - Reminders
- CANNOT see:
  - Inquiries
  - Searches
  - Accounts
  - Partners
  - NQMS Admin

**Pass/Fail:** _____

---

#### TC4.2: View Program (Read-Only)
**Steps:**
1. Go to Programs
2. Select a program
3. Try to edit program details
4. Look for NQMS tab

**Expected Result:**
- Can view program details
- Cannot edit program details (fields disabled or no edit button)
- Can see NQMS tab

**Pass/Fail:** _____

---

#### TC4.3: Access NQMS Features
**Steps:**
1. Go to program NQMS tab
2. Open an assessment
3. Edit assessment
4. Submit for review

**Expected Result:**
- Can access NQMS assessments
- Can edit assessments
- Can submit for review

**Pass/Fail:** _____

---

#### TC4.4: Approve Assessment
**Steps:**
1. Open pending assessment
2. Look for "Approve" button
3. Click approve

**Expected Result:**
- Can see and click "Approve" button
- Assessment status changes to "Approved"

**Pass/Fail:** _____

---

#### TC4.5: Try to Access Inquiries (Negative Test)
**Steps:**
1. Try to navigate to Inquiries (menu should not exist)
2. Try direct URL access

**Expected Result:**
- No Inquiries menu item
- Direct URL shows "Not Authorized"

**Pass/Fail:** _____

---

### Test Suite 5: Affiliate Limited Contractor

**Test User:** aff_contractor_test

#### TC5.1: Login and Access
**Steps:**
1. Login with contractor credentials
2. Check navigation menu

**Expected Result:**
- Login successful
- Limited navigation visible
- Can see Programs, NQMS, Reminders

**Pass/Fail:** _____

---

#### TC5.2: Access Latest Assessment Only
**Steps:**
1. Go to a program with multiple assessments (e.g., 2023, 2024, 2025)
2. Try to open the latest assessment (2025)
3. Try to open an old assessment (2023)

**Expected Result:**
- Can open latest assessment (2025)
- Cannot open old assessment (2023) - should get "Not Authorized" error

**Pass/Fail:** _____

---

#### TC5.3: Edit Latest Assessment
**Steps:**
1. Open latest assessment
2. Edit responses
3. Save changes

**Expected Result:**
- Can edit latest assessment
- Changes save successfully

**Pass/Fail:** _____

---

#### TC5.4: Try to Approve Assessment (Negative Test)
**Steps:**
1. Open pending assessment
2. Look for "Approve" button

**Expected Result:**
- No "Approve" button visible
- Cannot approve assessment

**Pass/Fail:** _____

---

#### TC5.5: Try to Archive Assessment (Negative Test)
**Steps:**
1. Open approved assessment
2. Look for "Archive" button

**Expected Result:**
- No "Archive" button visible
- Cannot archive assessment

**Pass/Fail:** _____

---

### Test Suite 6: Program User (Full Access)

**Test User:** prog_full_test

#### TC6.1: Login and Access Own Program
**Steps:**
1. Login with program full credentials
2. Navigate to Programs
3. Check which programs are visible

**Expected Result:**
- Can see assigned program only
- Cannot see other programs
- Can access own program details

**Pass/Fail:** _____

---

#### TC6.2: Edit Own Program
**Steps:**
1. Go to assigned program
2. Edit program details
3. Save changes

**Expected Result:**
- Can edit program details
- Changes save successfully

**Pass/Fail:** _____

---

#### TC6.3: Manage Inquiries for Own Program
**Steps:**
1. Go to Inquiries
2. View inquiry list
3. Verify inquiries are for assigned program only
4. Edit an inquiry

**Expected Result:**
- Can see inquiries for assigned program
- Cannot see inquiries for other programs
- Can edit inquiry responses

**Pass/Fail:** _____

---

#### TC6.4: Create and Edit NQMS Assessment
**Steps:**
1. Go to program NQMS tab
2. Create new assessment (if none exists)
3. Edit assessment responses
4. Submit for review

**Expected Result:**
- Can create assessment
- Can edit assessment
- Can submit for review

**Pass/Fail:** _____

---

#### TC6.5: Try to Approve Own Assessment (Negative Test)
**Steps:**
1. Open pending assessment
2. Look for "Approve Assessment" button

**Expected Result:**
- No "Approve" button visible
- Cannot approve own assessment
- This is expected behavior!

**Pass/Fail:** _____

---

#### TC6.6: Try to Archive Assessment (Negative Test)
**Steps:**
1. Open approved assessment
2. Look for "Archive" button

**Expected Result:**
- No "Archive" button visible
- Cannot archive assessment

**Pass/Fail:** _____

---

#### TC6.7: Try to Access Affiliate Management (Negative Test)
**Steps:**
1. Try to navigate to Affiliates
2. Or try direct URL access

**Expected Result:**
- No access to affiliate management
- "Not Authorized" error if attempted

**Pass/Fail:** _____

---

### Test Suite 7: Program User (NQMS-Only)

**Test User:** prog_nqms_test

#### TC7.1: Login and Navigation
**Steps:**
1. Login with program NQMS credentials
2. Check navigation menu

**Expected Result:**
- Can see:
  - Dashboard
  - Programs (view only)
  - NQMS
  - Reports
  - Reminders
- CANNOT see:
  - Inquiries
  - Searches
  - Accounts
  - Affiliates

**Pass/Fail:** _____

---

#### TC7.2: View Program (Read-Only)
**Steps:**
1. Go to assigned program
2. Try to edit program details

**Expected Result:**
- Can view program details
- Cannot edit program details
- Can see NQMS tab

**Pass/Fail:** _____

---

#### TC7.3: Access NQMS Features
**Steps:**
1. Go to NQMS tab
2. Open assessment
3. Edit responses
4. Submit for review

**Expected Result:**
- Can access assessments
- Can edit assessments
- Can submit for review

**Pass/Fail:** _____

---

#### TC7.4: Try to Access Inquiries (Negative Test)
**Steps:**
1. Try to access Inquiries module
2. Try direct URL

**Expected Result:**
- No Inquiries menu item
- Direct URL shows "Not Authorized"

**Pass/Fail:** _____

---

### Test Suite 8: Program Limited Contractor

**Test User:** prog_contractor_test

#### TC8.1: Access Latest Assessment Only
**Steps:**
1. Login with program contractor credentials
2. Go to assigned program
3. Try to access latest assessment
4. Try to access old assessment

**Expected Result:**
- Can access latest assessment
- Cannot access old assessments
- "Not Authorized" error for old assessments

**Pass/Fail:** _____

---

#### TC8.2: Edit Latest Assessment
**Steps:**
1. Open latest assessment
2. Edit responses
3. Save

**Expected Result:**
- Can edit latest assessment
- Changes save successfully

**Pass/Fail:** _____

---

#### TC8.3: Try to Approve (Negative Test)
**Steps:**
1. Open pending assessment
2. Look for "Approve" button

**Expected Result:**
- No "Approve" button
- Cannot approve

**Pass/Fail:** _____

---

## Module Access Testing

### Test Matrix Template

For each test user, verify module access:

| Module | admin_test | aff_full_test | aff_mc_test | aff_nqms_test | aff_contractor_test | prog_full_test | prog_nqms_test | prog_contractor_test |
|--------|------------|---------------|-------------|---------------|---------------------|----------------|----------------|----------------------|
| Dashboard | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| Programs | ✅ Edit | ✅ Edit | ✅ Edit | ✅ View | ✅ View | ✅ Edit | ✅ View | ✅ View |
| Affiliates | ✅ Edit | ✅ Edit | ✅ Edit | ✅ View | ✅ View | ❌ | ❌ | ❌ |
| Inquiries | ✅ | ✅ | ✅ | ❌ | ❌ | ✅ | ❌ | ❌ |
| Searches | ✅ | ✅ | ✅ | ❌ | ❌ | ✅ | ❌ | ❌ |
| Accounts | ✅ | ✅ | ✅ | ❌ | ❌ | ✅ | ❌ | ❌ |
| Partners | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| Reports | ✅ | ✅ | ❌ | ✅ | ❌ | ✅ | ✅ | ❌ |
| NQMS | ✅ | ✅ | ❌ | ✅ | ✅* | ✅ | ✅ | ✅* |
| NQMS Admin | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| Reminders | ✅ | ✅ | ✅ | ✅ | ❌ | ✅ | ✅ | ❌ |

*Latest assessment only

### Testing Instructions

For each cell:
1. Login as that user
2. Try to access the module
3. Mark ✅ if accessible as expected
4. Mark ❌ if blocked as expected
5. Mark ⚠️ if unexpected result
6. Note any issues

---

## NQMS Assessment Workflow Testing

### Test Scenario: Complete Assessment Lifecycle

**Requires:**
- 2 test users: Program User (prog_full_test) and Affiliate User (aff_full_test)
- 1 test program
- Fresh assessment (not created yet)

#### Step 1: Create Assessment (Program User)
**Login as:** prog_full_test

**Steps:**
1. Navigate to assigned program
2. Click NQMS tab
3. Click "Start Self Assessment"
4. Verify assessment created
5. Note assessment ID

**Expected Result:**
- Assessment created successfully
- Status: In-Progress (or no status)
- Can see empty question responses

**Pass/Fail:** _____

---

#### Step 2: Fill Out Assessment (Program User)
**Login as:** prog_full_test

**Steps:**
1. Open the assessment
2. Answer at least 5 questions with ratings
3. Add comments to 2-3 questions
4. Upload evidence file to 1 question
5. Save (do not submit yet)

**Expected Result:**
- Can edit all questions
- Ratings save correctly
- Comments save correctly
- Files upload successfully
- Can save draft

**Pass/Fail:** _____

---

#### Step 3: Submit for Review (Program User)
**Login as:** prog_full_test

**Steps:**
1. Open the assessment
2. Click "Submit for Review" button
3. Verify status changes

**Expected Result:**
- "Submit for Review" button visible
- Status changes to "Pending Review"
- Success message displayed
- Can still view assessment

**Pass/Fail:** _____

---

#### Step 4: Try to Edit After Submission (Program User)
**Login as:** prog_full_test

**Steps:**
1. Try to edit submitted assessment
2. Check if edit button/form is available

**Expected Result:**
- Can still edit even in "Pending Review" status
- Changes save successfully
- This is allowed behavior

**Pass/Fail:** _____

---

#### Step 5: Try to Approve Own Assessment (Program User - Negative Test)
**Login as:** prog_full_test

**Steps:**
1. Open pending assessment
2. Look for "Approve Assessment" button

**Expected Result:**
- No "Approve Assessment" button visible
- Cannot approve own assessment
- This confirms proper permission enforcement

**Pass/Fail:** _____

---

#### Step 6: Review and Approve (Affiliate User)
**Login as:** aff_full_test

**Steps:**
1. Navigate to the program
2. Open NQMS tab
3. Open the pending assessment
4. Review responses
5. Click "Approve Assessment" button

**Expected Result:**
- Can see "Approve Assessment" button
- Approval succeeds
- Status changes to "Approved" or "Completed"
- Success message displayed

**Pass/Fail:** _____

---

#### Step 7: Verify Read-Only After Approval (Program User)
**Login as:** prog_full_test

**Steps:**
1. Open the approved assessment
2. Try to edit responses

**Expected Result:**
- Cannot edit approved assessment
- Edit buttons/forms not available
- Assessment is read-only

**Pass/Fail:** _____

---

#### Step 8: Create Goals (Program User)
**Login as:** prog_full_test

**Steps:**
1. Open approved assessment
2. Find a question with low rating (e.g., 2 out of 5)
3. Click "Create Goal" for that question
4. Fill out goal form:
   - Name: Improve volunteer training
   - Baseline score: 2
   - Target score: 4
   - Start date: Today
   - Target completion: 6 months from now
   - Notes: Develop new training materials
5. Save goal

**Expected Result:**
- Can create goal
- Goal saves successfully
- Goal appears in assessment view
- Goal status shows "Incomplete"

**Pass/Fail:** _____

---

#### Step 9: Archive Assessment (Affiliate User)
**Login as:** aff_full_test

**Steps:**
1. Open the approved assessment
2. Look for "Archive" button
3. Click archive
4. Confirm action

**Expected Result:**
- "Archive" button visible to affiliate user
- Can archive assessment
- Assessment marked as archived

**Pass/Fail:** _____

---

#### Step 10: Try to Archive as Program User (Negative Test)
**Login as:** prog_full_test

**Steps:**
1. Create a new assessment
2. Have affiliate approve it
3. Try to archive as program user

**Expected Result:**
- No "Archive" button visible to program user
- Cannot archive assessment

**Pass/Fail:** _____

---

## Negative Testing Scenarios

### NT1: Access Denied Tests

**Test unauthorized access for each user type**

#### NT1.1: Program User Accessing Other Programs
**Steps:**
1. Login as prog_full_test (assigned to Program 1)
2. Try to access Program 2 directly via URL
3. Try to see Program 2 in Programs list

**Expected Result:**
- Direct URL shows "Not Authorized" or redirects
- Program 2 not visible in list

**Pass/Fail:** _____

---

#### NT1.2: MC-Only User Accessing NQMS
**Steps:**
1. Login as aff_mc_test
2. Try to access NQMS URL directly
3. Try to open NQMS tab on program

**Expected Result:**
- "Not Authorized" error
- NQMS tab not visible

**Pass/Fail:** _____

---

#### NT1.3: NQMS-Only User Accessing Inquiries
**Steps:**
1. Login as aff_nqms_test
2. Try to access Inquiries URL directly
3. Look for Inquiries menu item

**Expected Result:**
- "Not Authorized" error
- No Inquiries menu item

**Pass/Fail:** _____

---

#### NT1.4: Program User Approving Assessment
**Steps:**
1. Login as prog_full_test
2. Create and submit assessment
3. Try to approve it

**Expected Result:**
- No "Approve" button visible
- Cannot approve

**Pass/Fail:** _____

---

#### NT1.5: Contractor Accessing Old Assessment
**Steps:**
1. Login as prog_contractor_test
2. Create 2 assessments (2024 and 2025)
3. Try to access 2024 assessment

**Expected Result:**
- Can access 2025 (latest)
- Cannot access 2024 (old)
- "Not Authorized" error for old assessment

**Pass/Fail:** _____

---

### NT2: Edit Denied Tests

#### NT2.1: NQMS User Editing Program
**Steps:**
1. Login as aff_nqms_test
2. Go to a program
3. Try to edit program details

**Expected Result:**
- Fields disabled or no edit button
- Cannot save changes

**Pass/Fail:** _____

---

#### NT2.2: Editing Completed Assessment
**Steps:**
1. Login as any user with NQMS access
2. Open an approved/completed assessment
3. Try to edit responses

**Expected Result:**
- Cannot edit completed assessment
- Edit forms not available

**Pass/Fail:** _____

---

## Edge Cases and Special Scenarios

### EC1: Multi-Role User

**Setup:**
1. Create user: multi_role_test
2. Assign to Affiliate A (MC-Access Only)
3. Assign to Program 1 (NQMS-Access Only)

**Test:**
1. Login as multi_role_test
2. Check what modules are accessible

**Expected Result:**
- Can access MC features (from affiliate assignment)
- Can access NQMS features (from program assignment)
- Gets UNION of both permissions

**Pass/Fail:** _____

---

### EC2: Contractor with Multiple Roles

**Setup:**
1. Create user: contractor_multi_test
2. Assign to Program 1 (NQMS-Only, Limited Contractor)
3. Assign to Affiliate A (NQMS-Access Only, NO contractor flag)

**Test:**
1. Login as contractor_multi_test
2. Try to access old assessments

**Expected Result:**
- Can access old assessments
- Affiliate role overrides contractor restriction
- Not "contractor only" anymore

**Pass/Fail:** _____

---

### EC3: Geographic Permissions

**Setup:**
1. Create Affiliate A with ZIP codes: 20001, 20002
2. Create Program X with ZIP code: 20001
3. Create Program Y with ZIP code: 30001 (different)
4. Assign aff_full_test to Affiliate A

**Test:**
1. Login as aff_full_test
2. Check which programs are accessible

**Expected Result:**
- Can access Program X (matching ZIP)
- Cannot access Program Y (different ZIP)

**Pass/Fail:** _____

---

### EC4: Assessment Status Transitions

**Test one-way status flow:**

1. Create assessment (status: in-progress)
2. Submit for review (status: pending-review)
3. Try to move back to in-progress (should not be possible)
4. Approve (status: completed)
5. Try to move back to pending-review (should not be possible)

**Expected Result:**
- Status transitions only move forward
- No rollback mechanism
- Cannot edit completed assessments

**Pass/Fail:** _____

---

### EC5: Goal Completion Auto-Status

**Test automatic status update:**

**Setup:**
1. Create and approve assessment
2. Create 2 goals with targets

**Test:**
1. Mark Goal 1 as complete (achieved_score >= target_score)
2. Check assessment status (should still be "completed")
3. Mark Goal 2 as complete
4. Check assessment status (should change to "goal_completed")
5. Mark Goal 1 as incomplete again
6. Check assessment status (should revert to "completed")

**Expected Result:**
- Status auto-updates based on goal completion
- "goal_completed" when ALL goals complete
- Reverts to "completed" if ANY goal incomplete

**Pass/Fail:** _____

---

## Test Data Requirements

### Minimum Test Data Needed

1. **Users:**
   - 1 Global Admin
   - 3 Affiliate users (Full, MC-Only, NQMS-Only)
   - 1 Affiliate contractor
   - 2 Program users (Full, NQMS-Only)
   - 1 Program contractor

2. **Affiliates:**
   - 2 test affiliates
   - Each with different ZIP codes assigned

3. **Programs:**
   - 4 test programs
   - 2 in Affiliate A's service area
   - 2 in Affiliate B's service area

4. **Assessments:**
   - 1 in-progress assessment
   - 1 pending-review assessment
   - 1 approved assessment
   - 1 old assessment (for contractor testing)

5. **Goals:**
   - 2-3 goals on approved assessment
   - Mix of complete and incomplete

6. **Inquiries:**
   - 3-4 test inquiries for different programs

---

## Expected Results Reference

### Module Visibility by Role

Use this quick reference to verify expected menu visibility:

| Module | Global | Aff Full | Aff MC | Aff NQMS | Aff Contractor | Prog Full | Prog NQMS | Prog Contractor |
|--------|--------|----------|--------|----------|----------------|-----------|-----------|-----------------|
| Dashboard | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| Programs | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| Affiliates | ✅ | ✅ | ✅ | ✅ | ✅ | ❌ | ❌ | ❌ |
| Inquiries | ✅ | ✅ | ✅ | ❌ | ❌ | ✅ | ❌ | ❌ |
| Searches | ✅ | ✅ | ✅ | ❌ | ❌ | ✅ | ❌ | ❌ |
| Accounts | ✅ | ✅ | ✅ | ❌ | ❌ | ✅ | ❌ | ❌ |
| Partners | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| Reports | ✅ | ✅ | ❌ | ✅ | ❌ | ✅ | ✅ | ❌ |
| NQMS | ✅ | ✅ | ❌ | ✅ | ✅ | ✅ | ✅ | ✅ |
| NQMS Admin | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| Reminders | ✅ | ✅ | ✅ | ✅ | ❌ | ✅ | ✅ | ❌ |

---

## Test Execution Checklist

### Pre-Testing
- [ ] Test environment set up
- [ ] All test users created
- [ ] Test data loaded
- [ ] Admin credentials confirmed

### Role Testing
- [ ] Global Admin tests complete
- [ ] Affiliate Full Access tests complete
- [ ] Affiliate MC-Only tests complete
- [ ] Affiliate NQMS-Only tests complete
- [ ] Affiliate Contractor tests complete
- [ ] Program Full Access tests complete
- [ ] Program NQMS-Only tests complete
- [ ] Program Contractor tests complete

### Module Testing
- [ ] Module visibility verified for all roles
- [ ] Edit permissions verified for all roles

### Workflow Testing
- [ ] Complete assessment lifecycle tested
- [ ] Goal creation and management tested
- [ ] Approval workflow tested

### Negative Testing
- [ ] Access denied scenarios tested
- [ ] Edit denied scenarios tested

### Edge Cases
- [ ] Multi-role user tested
- [ ] Geographic permissions tested
- [ ] Status transitions tested
- [ ] Auto-status updates tested

### Bug Reporting
- [ ] All defects logged
- [ ] Screenshots captured
- [ ] Steps to reproduce documented

---

**END OF QA TESTING GUIDE**
