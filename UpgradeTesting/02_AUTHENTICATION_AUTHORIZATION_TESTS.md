# Test Suite 02: Authentication & Authorization Tests

**Priority:** CRITICAL
**Total Test Cases:** 58
**Focus:** Validate authentication flows and authorization policies after upgrade

## Overview

This test suite validates:
1. User authentication (login/logout)
2. Session management
3. Role-based authorization
4. Request policy enforcement
5. Permission boundaries

All authentication and authorization tests are CRITICAL and must pass before release.

---

## Section 1: User Authentication - Login

### TC-AUTH-001: Successful Login with Valid Credentials
**Priority:** CRITICAL
**Prerequisites:** Valid user account exists

**Test Steps:**
1. Navigate to `/users/login`
2. Enter valid email address
3. Enter valid password
4. Click "Login" button

**Expected Result:**
- User authenticated successfully
- Redirected to `/admin` or intended destination
- User session created
- Flash message displays success (if configured)
- Last login timestamp updated

**Test Data:**
- Email: [valid user email]
- Password: [valid password]

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-AUTH-002: Failed Login with Invalid Password
**Priority:** CRITICAL
**Prerequisites:** Valid user account exists

**Test Steps:**
1. Navigate to `/users/login`
2. Enter valid email address
3. Enter incorrect password
4. Click "Login" button

**Expected Result:**
- Login fails
- Error message: "Invalid email or password"
- User remains on login page
- No session created
- Last login NOT updated

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-AUTH-003: Failed Login with Invalid Email
**Priority:** CRITICAL
**Prerequisites:** None

**Test Steps:**
1. Navigate to `/users/login`
2. Enter non-existent email address
3. Enter any password
4. Click "Login" button

**Expected Result:**
- Login fails
- Generic error message (no user enumeration)
- No session created
- User remains on login page

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-AUTH-004: Login with Email Case Insensitivity
**Priority:** HIGH
**Prerequisites:** User with email "test@example.com"

**Test Steps:**
1. Navigate to `/users/login`
2. Enter email in different case: "TEST@EXAMPLE.COM"
3. Enter valid password
4. Click "Login" button

**Expected Result:**
- User authenticated successfully (email matching should be case-insensitive)
- Redirected to admin area
- Session created

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-AUTH-005: Login Redirect to Intended Destination
**Priority:** HIGH
**Prerequisites:** Valid user account

**Test Steps:**
1. While logged out, attempt to access `/admin/programs`
2. Note redirect to login with query param: `/users/login?redirect=%2Fadmin%2Fprograms`
3. Enter valid credentials and login

**Expected Result:**
- After successful login, redirected to originally requested page (`/admin/programs`)
- Not redirected to default `/admin` page
- User can access intended resource

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-AUTH-006: Login Form CSRF Protection
**Priority:** CRITICAL
**Prerequisites:** CSRF protection enabled

**Test Steps:**
1. Navigate to `/users/login`
2. Using browser dev tools, remove or modify CSRF token
3. Enter valid credentials
4. Submit form

**Expected Result:**
- Request rejected
- CSRF error message displayed
- No authentication occurs
- User must reload page to get new token

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-AUTH-007: Login with Empty Fields
**Priority:** MEDIUM
**Prerequisites:** None

**Test Steps:**
1. Navigate to `/users/login`
2. Leave email field empty
3. Leave password field empty
4. Click "Login" button

**Expected Result:**
- Validation errors displayed
- "Email is required" message
- "Password is required" message
- Form not submitted

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-AUTH-008: Login Session Persistence
**Priority:** HIGH
**Prerequisites:** Valid user account

**Test Steps:**
1. Login with valid credentials
2. Navigate to several admin pages
3. Close browser tab (do not clear cookies)
4. Reopen browser and navigate to `/admin`

**Expected Result:**
- Session persists (depends on session configuration)
- User remains logged in (if "Remember Me" or long session timeout)
- If session expired, redirect to login

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

## Section 2: User Authentication - Logout

### TC-AUTH-009: Successful Logout
**Priority:** CRITICAL
**Prerequisites:** User logged in

**Test Steps:**
1. While logged in, click "Logout" link or navigate to logout URL
2. Observe redirect
3. Attempt to access admin area

**Expected Result:**
- User logged out successfully
- Session destroyed
- Redirected to login page or home page
- Cannot access admin area without re-authenticating
- Flash message confirms logout

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-AUTH-010: Logout Invalidates Session
**Priority:** CRITICAL
**Prerequisites:** User logged in

**Test Steps:**
1. Login and note session ID (from cookie)
2. Logout
3. Attempt to reuse old session ID by manually setting cookie
4. Try to access protected resource

**Expected Result:**
- Old session ID no longer valid
- Access denied to protected resources
- Redirected to login

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

## Section 3: Session Management

### TC-AUTH-011: Session Timeout After Inactivity
**Priority:** HIGH
**Prerequisites:** User logged in, known session timeout setting

**Test Steps:**
1. Login as valid user
2. Remain inactive for duration exceeding session timeout
3. Attempt to navigate to admin page

**Expected Result:**
- Session expires after configured timeout
- User redirected to login
- Flash message: "Your session has expired"
- Must re-authenticate to continue

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-AUTH-012: Concurrent Sessions - Same User Different Browsers
**Priority:** MEDIUM
**Prerequisites:** User account available

**Test Steps:**
1. Login to application in Browser A
2. Login as same user in Browser B
3. Perform actions in Browser A
4. Perform actions in Browser B
5. Verify both sessions remain active (unless configured otherwise)

**Expected Result:**
- Both sessions remain active (typical behavior)
- OR second login invalidates first session (if configured)
- Behavior consistent with security policy

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-AUTH-013: Session Regeneration on Login
**Priority:** HIGH (Security)
**Prerequisites:** Valid user account

**Test Steps:**
1. Navigate to login page
2. Note session ID before login
3. Login with valid credentials
4. Check session ID after successful login

**Expected Result:**
- Session ID changes after login (session regenerated)
- Prevents session fixation attacks
- New session ID created upon authentication

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

## Section 4: Authorization - Superuser Role

### TC-AUTH-014: Superuser Access to All Resources
**Priority:** CRITICAL
**Prerequisites:** Superuser account (`is_superuser = true`)

**Test Steps:**
1. Login as superuser
2. Navigate to all plugin areas:
   - `/admin/users`
   - `/admin/programs`
   - `/admin/affiliates`
   - `/admin/nqms/assessment-questions`
   - `/admin/inquiries`
   - `/admin/searches`
   - `/admin/reports`
3. Verify access granted to all

**Expected Result:**
- Superuser has access to ALL admin routes
- No "Unauthorized" errors
- All navigation items visible
- Can view, edit, create, delete across all modules

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-AUTH-015: Superuser Can Manage All Users
**Priority:** CRITICAL
**Prerequisites:** Superuser account

**Test Steps:**
1. Login as superuser
2. Navigate to `/admin/users`
3. View user list
4. Click "Edit" on any user
5. Modify user details and save

**Expected Result:**
- Can view all users
- Can edit any user's details
- Can assign roles and affiliates
- Can deactivate/activate users
- Authorization passes for all user management actions

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

## Section 5: Authorization - MC Affiliate Role

### TC-AUTH-016: MC Affiliate Access to Programs
**Priority:** CRITICAL
**Prerequisites:** User with `mc_affiliate` role

**Test Steps:**
1. Login as mc_affiliate user
2. Navigate to `/admin/programs`
3. View program list
4. Attempt to create new program
5. Edit existing program

**Expected Result:**
- Can access Programs plugin
- Can view all programs (not restricted to specific affiliates)
- Can create new programs
- Can edit program details
- Authorization granted per policy configuration

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-AUTH-017: MC Affiliate Access to Affiliates Management
**Priority:** HIGH
**Prerequisites:** User with `mc_affiliate` role

**Test Steps:**
1. Login as mc_affiliate user
2. Navigate to `/admin/affiliates`
3. Attempt to view, create, edit affiliates

**Expected Result:**
- Access granted based on policy configuration
- Typically can manage affiliate organizations
- Can view affiliate users

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-AUTH-018: MC Affiliate Cannot Access User Management (if policy denies)
**Priority:** HIGH
**Prerequisites:** User with `mc_affiliate` role (not superuser)

**Test Steps:**
1. Login as mc_affiliate user
2. Attempt to navigate to `/admin/users`

**Expected Result:**
- If policy denies: Access denied, "Unauthorized" error
- If policy allows: Access granted
- Verify behavior matches `request_policy_configs.php`

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

## Section 6: Authorization - Standard Affiliate Role

### TC-AUTH-019: Affiliate Access to Assigned Programs Only
**Priority:** CRITICAL
**Prerequisites:** User with `affiliate` role assigned to specific affiliates

**Test Steps:**
1. Login as affiliate user
2. Navigate to `/admin/programs`
3. Verify only programs associated with user's affiliates are visible

**Expected Result:**
- Can only see programs belonging to associated affiliates
- Cannot see programs from other affiliates
- Program list filtered appropriately

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-AUTH-020: Affiliate Can Edit Assigned Programs
**Priority:** CRITICAL
**Prerequisites:** Affiliate user with program association

**Test Steps:**
1. Login as affiliate user
2. Navigate to program within their affiliate
3. Click "Edit Program"
4. Modify program details
5. Save changes

**Expected Result:**
- Can edit programs within assigned affiliates
- Changes saved successfully
- Authorization granted

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-AUTH-021: Affiliate Cannot Edit Programs Outside Their Affiliates
**Priority:** CRITICAL
**Prerequisites:** Affiliate user and program outside their affiliates

**Test Steps:**
1. Login as affiliate user
2. Attempt to navigate directly to edit page of program outside their affiliates:
   `/admin/programs/edit/[other_program_id]`

**Expected Result:**
- Access denied
- "Unauthorized" error displayed
- Redirected to authorization error page
- No access to other affiliates' programs

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-AUTH-022: Affiliate Access to Service Areas
**Priority:** HIGH
**Prerequisites:** Affiliate user

**Test Steps:**
1. Login as affiliate user
2. Navigate to `/admin/affiliates/service-areas`
3. Attempt to manage service areas

**Expected Result:**
- Access granted per policy
- Can manage service areas for assigned affiliates
- Cannot access service areas for other affiliates

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

## Section 7: Authorization - Program Role

### TC-AUTH-023: Program User Access to Assigned Program Only
**Priority:** CRITICAL
**Prerequisites:** User with `program` role assigned to specific program

**Test Steps:**
1. Login as program user
2. Navigate to `/admin/programs`
3. Verify only assigned program(s) visible

**Expected Result:**
- Can only see program(s) they are assigned to
- Cannot see other programs
- Program list restricted to their association

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-AUTH-024: Program User Can Edit Assigned Program
**Priority:** CRITICAL
**Prerequisites:** Program user assigned to specific program

**Test Steps:**
1. Login as program user
2. Navigate to their assigned program
3. Click "Edit Program"
4. Make changes and save

**Expected Result:**
- Can view and edit assigned program
- Changes save successfully
- Authorization granted for own program

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-AUTH-025: Program User Cannot Edit Other Programs
**Priority:** CRITICAL
**Prerequisites:** Program user and another program they're not assigned to

**Test Steps:**
1. Login as program user
2. Attempt to navigate to edit page of unassigned program:
   `/admin/programs/edit/[other_program_id]`

**Expected Result:**
- Access denied
- "Unauthorized" error
- Cannot view or edit other programs

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-AUTH-026: Program User Limited Access to Assessments
**Priority:** HIGH
**Prerequisites:** Program user assigned to program with assessments

**Test Steps:**
1. Login as program user
2. Navigate to assessments for their program
3. Verify access level matches policy (view, edit, create)

**Expected Result:**
- Access level matches configured policy
- Typically can manage assessments for own program
- Cannot access assessments for other programs

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

## Section 8: Authorization - NQMS Roles

### TC-AUTH-027: NQMS Affiliate Access to Assessment Questions
**Priority:** CRITICAL
**Prerequisites:** User with `nqms_affiliate` role

**Test Steps:**
1. Login as nqms_affiliate user
2. Navigate to `/admin/nqms/assessment-questions`
3. Verify access granted

**Expected Result:**
- Can access NQMS assessment questions
- Can view, edit, create, reorder questions
- Authorization granted per policy

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-AUTH-028: NQMS Affiliate Can Manage Sections
**Priority:** HIGH
**Prerequisites:** User with `nqms_affiliate` role

**Test Steps:**
1. Login as nqms_affiliate user
2. Navigate to NQMS sections management
3. Attempt to create, edit, delete sections

**Expected Result:**
- Can manage NQMS sections
- Can add new sections
- Can edit section details
- Authorization granted

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-AUTH-029: NQMS Affiliate Can Manage Goals
**Priority:** HIGH
**Prerequisites:** User with `nqms_affiliate` role

**Test Steps:**
1. Login as nqms_affiliate user
2. Navigate to assessment goals management
3. Verify can create/edit goals

**Expected Result:**
- Can access goals management
- Can create and edit goals
- Authorization matches policy

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-AUTH-030: NQMS Program User Limited to Assessments
**Priority:** HIGH
**Prerequisites:** User with `nqms_program` role

**Test Steps:**
1. Login as nqms_program user
2. Attempt to access `/admin/nqms/assessment-questions`
3. Attempt to access program assessments

**Expected Result:**
- Cannot access assessment question management (typically denied)
- Can access own program's assessments
- Authorization enforced per policy

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-AUTH-031: NQMS Limited Contractor Restrictions
**Priority:** HIGH
**Prerequisites:** User with `is_limited_contractor = true`

**Test Steps:**
1. Login as limited contractor user
2. Attempt to access various resources
3. Verify restricted access per policy

**Expected Result:**
- Access restricted compared to non-limited users
- Specific restrictions enforced per policy configuration
- Cannot access sensitive areas

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

## Section 9: Authorization - API Endpoints

### TC-AUTH-032: Authenticated API Access
**Priority:** CRITICAL
**Prerequisites:** Valid user session

**Test Steps:**
1. Login as valid user
2. Make API request to `/admin/api/programs`
3. Verify response

**Expected Result:**
- API request succeeds
- Returns JSON response
- Authorization header or session cookie recognized
- Data returned based on user's permissions

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-AUTH-033: Unauthenticated API Access Denied
**Priority:** CRITICAL
**Prerequisites:** No active session

**Test Steps:**
1. Ensure logged out
2. Make API request to `/admin/api/programs`
3. Observe response

**Expected Result:**
- API request denied
- 401 Unauthorized status code
- No data returned
- Appropriate error message

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-AUTH-034: API Authorization Based on User Role
**Priority:** CRITICAL
**Prerequisites:** Program user with limited permissions

**Test Steps:**
1. Login as program user (limited access)
2. Make API request to get all programs: `/admin/api/programs`
3. Verify response contains only authorized programs

**Expected Result:**
- API returns only programs user has access to
- Authorization enforced at API level
- No unauthorized data exposed

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-AUTH-035: API CSRF Protection Disabled for API Routes
**Priority:** HIGH
**Prerequisites:** API endpoint configured

**Test Steps:**
1. Make POST request to API endpoint without CSRF token
2. Verify request succeeds (CSRF should be disabled for API prefix)

**Expected Result:**
- API request succeeds without CSRF token
- CSRF middleware skipped for `/admin/api/*` routes
- Authentication still required

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

## Section 10: Authorization - Frontend Routes

### TC-AUTH-036: Public Access to Frontend Routes
**Priority:** HIGH
**Prerequisites:** None (logged out)

**Test Steps:**
1. Ensure logged out
2. Navigate to frontend routes (no `/admin` prefix)
3. Verify access granted

**Expected Result:**
- Frontend routes accessible without authentication
- No redirect to login
- Public pages display correctly

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-AUTH-037: Program Search Public Access
**Priority:** HIGH
**Prerequisites:** None (logged out)

**Test Steps:**
1. Navigate to public program search page
2. Perform search
3. View search results

**Expected Result:**
- Search page accessible without login
- Search functionality works
- Program details visible (public information only)

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-AUTH-038: Inquiry Submission Without Authentication
**Priority:** HIGH
**Prerequisites:** None (logged out)

**Test Steps:**
1. Navigate to public inquiry form
2. Fill out inquiry details
3. Submit inquiry

**Expected Result:**
- Inquiry form accessible without login
- Can submit inquiry anonymously
- Inquiry saved to database
- Confirmation message displayed

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

## Section 11: Authorization - Permission Boundaries

### TC-AUTH-039: User Cannot Access Resources Outside Their Scope
**Priority:** CRITICAL
**Prerequisites:** Affiliate user with specific affiliate associations

**Test Steps:**
1. Login as affiliate user
2. Note their assigned affiliate IDs
3. Attempt to access program from different affiliate:
   - Navigate to `/admin/programs`
   - Try direct URL: `/admin/programs/view/[other_program_id]`

**Expected Result:**
- Program not visible in list
- Direct URL access denied
- "Unauthorized" error
- Cannot bypass authorization through URL manipulation

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-AUTH-040: User Cannot Escalate Their Own Privileges
**Priority:** CRITICAL (Security)
**Prerequisites:** Non-superuser account

**Test Steps:**
1. Login as regular user
2. Navigate to account settings
3. Attempt to modify role or permissions (if form allows)
4. Check database for unauthorized changes

**Expected Result:**
- User cannot modify their own role
- `is_superuser` flag cannot be changed by user
- Role assignments require privileged user
- Authorization prevents privilege escalation

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-AUTH-041: Direct Object Reference - Program Edit
**Priority:** CRITICAL (Security)
**Prerequisites:** Program user assigned to Program A only

**Test Steps:**
1. Login as program user
2. Note URL of their program edit page: `/admin/programs/edit/[program_a_id]`
3. Modify URL to access different program: `/admin/programs/edit/[program_b_id]`
4. Attempt to access

**Expected Result:**
- Access denied to Program B
- "Unauthorized" error
- Authorization middleware blocks request
- Prevents Insecure Direct Object Reference (IDOR)

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-AUTH-042: API Direct Object Reference Protection
**Priority:** CRITICAL (Security)
**Prerequisites:** API access with limited permissions

**Test Steps:**
1. Login as program user
2. Make API request to get Program A (authorized): `/admin/api/programs/[program_a_id]`
3. Make API request to get Program B (not authorized): `/admin/api/programs/[program_b_id]`

**Expected Result:**
- API returns Program A data
- API denies Program B request
- 403 Forbidden or 404 Not Found for Program B
- Authorization enforced at API level

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

## Section 12: Request Policy Enforcement

### TC-AUTH-043: Policy Config Wildcard Matching - Controller Level
**Priority:** HIGH
**Prerequisites:** Policy config with controller wildcards

**Test Steps:**
1. Review `config/request_policy_configs.php` for wildcard rules
2. Login as user matching wildcard rule
3. Access route covered by wildcard
4. Verify access granted/denied per config

**Expected Result:**
- Wildcard rules (e.g., `controller: '*'`) apply correctly
- Authorization matches policy configuration
- No conflicts between specific and wildcard rules

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-AUTH-044: Policy Config Wildcard Matching - Action Level
**Priority:** HIGH
**Prerequisites:** Policy config with action wildcards

**Test Steps:**
1. Review policy config for action wildcard rules
2. Access route with action covered by wildcard (e.g., `action: '*'`)
3. Verify authorization behavior

**Expected Result:**
- Action wildcards apply correctly
- All actions in controller follow wildcard rule
- Specific action rules override wildcards when present

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-AUTH-045: Policy Config Plugin Prefix Matching
**Priority:** HIGH
**Prerequisites:** Multiple plugins configured

**Test Steps:**
1. Login as user with specific plugin access
2. Navigate to routes in allowed plugin
3. Attempt to access routes in denied plugin

**Expected Result:**
- Allowed plugin routes accessible
- Denied plugin routes blocked
- Plugin-level authorization enforced

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-AUTH-046: Policy Config NULL Prefix (Frontend) Handling
**Priority:** MEDIUM
**Prerequisites:** Frontend routes configured with %NULL_PREFIX_FLAG%

**Test Steps:**
1. Review policy for %NULL_PREFIX_FLAG% rules
2. Access frontend routes (no prefix)
3. Verify authorization per config

**Expected Result:**
- NULL prefix rules apply to frontend routes
- Typically allows public access
- Authorization handles null prefix correctly

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

## Section 13: Error Handling & User Experience

### TC-AUTH-047: Unauthorized Access Error Page
**Priority:** HIGH
**Prerequisites:** User with limited permissions

**Test Steps:**
1. Login as limited user
2. Attempt to access unauthorized resource
3. Observe error page

**Expected Result:**
- Friendly "Unauthorized" error page displays
- Error message explains lack of permissions
- Link to return to authorized area
- No stack trace or sensitive information exposed

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-AUTH-048: Unauthenticated Access Redirect
**Priority:** HIGH
**Prerequisites:** None (logged out)

**Test Steps:**
1. Ensure logged out
2. Attempt to access protected resource: `/admin/programs`
3. Observe redirect

**Expected Result:**
- Redirected to `/users/login?redirect=...`
- Original URL preserved in redirect parameter
- Login page displays
- After login, redirected to originally requested page

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-AUTH-049: Session Expired Message
**Priority:** MEDIUM
**Prerequisites:** Active session that can expire

**Test Steps:**
1. Login as user
2. Wait for session to expire (or manually clear session)
3. Attempt to perform action (e.g., save form)

**Expected Result:**
- User informed session expired
- Flash message: "Your session has expired. Please login again."
- Redirected to login page
- Form data preserved if possible

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

## Section 14: Security Best Practices

### TC-AUTH-050: Password Not Visible in Logs
**Priority:** CRITICAL (Security)
**Prerequisites:** Access to application logs

**Test Steps:**
1. Enable detailed logging (if not already enabled)
2. Perform login with valid credentials
3. Review application logs (PHP logs, CakePHP logs)
4. Search for password value

**Expected Result:**
- Password NOT visible in logs
- Request data sanitized
- Sensitive fields redacted
- Only hash stored in database

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-AUTH-051: Password Stored as Hash in Database
**Priority:** CRITICAL (Security)
**Prerequisites:** User account in database

**Test Steps:**
1. Query database: `SELECT password FROM users LIMIT 1`
2. Examine password value

**Expected Result:**
- Password stored as bcrypt hash
- Hash starts with `$2y$` or `$2a$` (bcrypt identifier)
- Password not stored in plain text
- Hash is 60 characters long (bcrypt format)

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-AUTH-052: No Enumeration of User Accounts
**Priority:** HIGH (Security)
**Prerequisites:** Known and unknown email addresses

**Test Steps:**
1. Attempt login with valid email, invalid password
2. Attempt login with invalid email, any password
3. Compare error messages

**Expected Result:**
- Error messages identical for both scenarios
- Generic message: "Invalid email or password"
- Cannot determine if email exists
- Prevents user enumeration attack

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-AUTH-053: Rate Limiting on Login Attempts (if implemented)
**Priority:** MEDIUM (Security)
**Prerequisites:** Rate limiting configured

**Test Steps:**
1. Attempt login with invalid credentials 5 times rapidly
2. Observe response

**Expected Result:**
- If rate limiting enabled: Temporarily blocked after threshold
- Error message: "Too many login attempts. Try again later."
- Prevents brute force attacks
- If not implemented, document as potential future enhancement

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-AUTH-054: HTTPS Enforced for Login (Production)
**Priority:** CRITICAL (Security - Production only)
**Prerequisites:** Production environment

**Test Steps:**
1. Attempt to access `http://[production-domain]/users/login`
2. Observe redirect

**Expected Result:**
- Redirected to `https://[production-domain]/users/login`
- HTTPS enforced
- Secure connection for authentication
- Certificate valid

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-AUTH-055: Secure Cookie Flags (Production)
**Priority:** HIGH (Security - Production only)
**Prerequisites:** Production environment with HTTPS

**Test Steps:**
1. Login to production environment
2. Inspect session cookie in browser dev tools
3. Check cookie attributes

**Expected Result:**
- `Secure` flag set (cookie only sent over HTTPS)
- `HttpOnly` flag set (prevents JavaScript access)
- `SameSite` attribute set (CSRF protection)
- Cookie not accessible to client-side scripts

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

## Section 15: Multi-User Scenarios

### TC-AUTH-056: User Role Change Takes Effect Immediately
**Priority:** HIGH
**Prerequisites:** Two users (admin and regular user)

**Test Steps:**
1. User A logs in with "program" role
2. Admin (User B) changes User A's role to "affiliate"
3. User A attempts to access resources requiring "affiliate" role
4. Verify access changed

**Expected Result:**
- If session-based authorization: May need logout/login for role change to take effect
- If DB-checked authorization: Role change effective immediately
- Behavior consistent with application design

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-AUTH-057: User Deactivation Blocks Access
**Priority:** HIGH
**Prerequisites:** Active user account

**Test Steps:**
1. User logs in
2. Admin deactivates user account (if functionality exists)
3. User attempts to access resources or login again

**Expected Result:**
- Current session invalidated (or blocks access)
- Cannot login with deactivated account
- Appropriate error message
- Access revoked immediately or on next request

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

### TC-AUTH-058: Affiliate Association Change Affects Access
**Priority:** HIGH
**Prerequisites:** User associated with Affiliate A

**Test Steps:**
1. User logs in, views programs for Affiliate A
2. Admin removes user from Affiliate A and adds to Affiliate B
3. User refreshes program list

**Expected Result:**
- User can no longer see Affiliate A programs
- User can now see Affiliate B programs
- Authorization updated based on current associations
- May require logout/login depending on implementation

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________
**Notes:**

---

## Summary

**Total Test Cases:** 58
**Critical Priority:** 32
**High Priority:** 22
**Medium Priority:** 4

**Completion Status:**
- Tests Passed: _____ / 58 (_____%)
- Tests Failed: _____ / 58 (_____%)
- Tests Blocked: _____ / 58 (_____%)
- Tests Skipped: _____ / 58 (_____%)

**Overall Status:** ☐ PASS ☐ FAIL ☐ BLOCKED

**Critical Issues Found:** _____

**Sign-Off:**
**Tester:** _______________________ **Date:** ___________
**Security Reviewer:** _______________________ **Date:** ___________

---

**Notes:**
