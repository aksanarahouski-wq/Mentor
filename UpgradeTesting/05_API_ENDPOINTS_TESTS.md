# Test Suite 05: API Endpoints Tests

**Priority:** HIGH
**Total Test Cases:** 48
**Focus:** REST API functionality and data integrity

## Overview

Tests cover API endpoints for:
- Programs API
- Searches API
- Inquiries API
- Organizations API
- System Management API
- Authentication and authorization
- Request/response formats
- Error handling

---

## Section 1: Programs API - GET Endpoints

### TC-API-001: GET /admin/api/programs - List All Programs
**Priority:** CRITICAL

**Test Steps:**
1. Make authenticated GET request to `/admin/api/programs`
2. Verify response

**Expected Result:**
- 200 OK status
- JSON response with programs array
- Data filtered by user permissions
- Pagination metadata included

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-API-002: GET /admin/api/programs/{id} - Get Single Program
**Priority:** CRITICAL

**Test Steps:**
1. GET `/admin/api/programs/{valid_id}`
2. Verify response

**Expected Result:**
- 200 OK status
- Program data in JSON format
- All fields populated correctly
- Related data included (if requested)

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-API-003: GET /admin/api/programs - Filter by Status
**Priority:** HIGH

**Test Steps:**
1. GET `/admin/api/programs?status=approved`

**Expected Result:**
- Only approved programs returned
- Filtering works correctly

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-API-004: GET /admin/api/programs - Pagination
**Priority:** HIGH

**Test Steps:**
1. GET `/admin/api/programs?page=1&limit=25`
2. GET `/admin/api/programs?page=2&limit=25`

**Expected Result:**
- First page returns first 25 programs
- Second page returns next 25 programs
- Pagination metadata correct

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-API-005: GET /admin/api/programs/{invalid_id} - 404 Error
**Priority:** HIGH

**Test Steps:**
1. GET `/admin/api/programs/999999`

**Expected Result:**
- 404 Not Found status
- Error message in JSON format

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

---

## Section 2: Programs API - POST Endpoints

### TC-API-006: POST /admin/api/programs - Create Program
**Priority:** CRITICAL

**Test Steps:**
1. POST to `/admin/api/programs` with valid JSON body
2. Include required fields

**Expected Result:**
- 201 Created status
- Program created in database
- Response includes created program with ID
- Location header with new resource URL

**Test Data:**
```json
{
  "title": "Test Program",
  "organization_id": 1,
  "contact_email": "test@example.com"
}
```

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-API-007: POST /admin/api/programs - Validation Errors
**Priority:** HIGH

**Test Steps:**
1. POST with missing required fields

**Expected Result:**
- 422 Unprocessable Entity status
- Validation errors in response
- Error messages for each missing field

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-API-008: POST /admin/api/programs - Invalid Data Types
**Priority:** HIGH

**Test Steps:**
1. POST with invalid data types (e.g., string for integer field)

**Expected Result:**
- 422 or 400 error
- Clear error message
- Program not created

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

---

## Section 3: Programs API - PUT/PATCH Endpoints

### TC-API-009: PUT /admin/api/programs/{id} - Update Program
**Priority:** CRITICAL

**Test Steps:**
1. PUT to `/admin/api/programs/{id}` with updated data

**Expected Result:**
- 200 OK status
- Program updated in database
- Response includes updated program data
- Modified timestamp updated

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-API-010: PUT /admin/api/programs/{id} - Partial Update
**Priority:** HIGH

**Test Steps:**
1. PUT with only changed fields

**Expected Result:**
- Update succeeds
- Only specified fields changed
- Other fields remain unchanged

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-API-011: PUT /admin/api/programs/{invalid_id} - 404 Error
**Priority:** HIGH

**Test Steps:**
1. PUT to non-existent program ID

**Expected Result:**
- 404 Not Found status
- No database changes

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

---

## Section 4: Programs API - DELETE Endpoints

### TC-API-012: DELETE /admin/api/programs/{id}
**Priority:** HIGH

**Test Steps:**
1. DELETE `/admin/api/programs/{id}`

**Expected Result:**
- 204 No Content or 200 OK status
- Program deleted or status changed
- Appropriate response per business rules

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-API-013: DELETE /admin/api/programs/{id} - Cannot Delete with Associations
**Priority:** HIGH

**Test Steps:**
1. Attempt to delete program with active assessments

**Expected Result:**
- 409 Conflict or 422 error
- Error message explains constraint
- Program not deleted

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

---

## Section 5: API Authentication

### TC-API-014: API Request Without Authentication
**Priority:** CRITICAL

**Test Steps:**
1. Make API request without session/auth token

**Expected Result:**
- 401 Unauthorized status
- No data returned
- Clear authentication error message

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-API-015: API Request With Valid Session
**Priority:** CRITICAL

**Test Steps:**
1. Login to create session
2. Make API request with session cookie

**Expected Result:**
- Request succeeds
- Session recognized
- Data returned

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-API-016: API Request With Expired Session
**Priority:** HIGH

**Test Steps:**
1. Use expired session cookie
2. Make API request

**Expected Result:**
- 401 Unauthorized
- Session expired error

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

---

## Section 6: API Authorization

### TC-API-017: API Authorization - Limited User Access
**Priority:** CRITICAL

**Test Steps:**
1. Login as program user (limited access)
2. Attempt to GET all programs via API

**Expected Result:**
- Only authorized programs returned
- Authorization enforced at API level
- Cannot access unauthorized data

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-API-018: API Authorization - Create Permission Check
**Priority:** CRITICAL

**Test Steps:**
1. Login as user without create permission
2. POST to create new program

**Expected Result:**
- 403 Forbidden status
- Program not created
- Authorization error message

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

---

## Section 7: Content-Type & Accept Headers

### TC-API-019: Request with application/json Content-Type
**Priority:** HIGH

**Test Steps:**
1. POST with `Content-Type: application/json`

**Expected Result:**
- Request processed correctly
- JSON body parsed

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-API-020: Request with application/vnd.api+json
**Priority:** MEDIUM

**Test Steps:**
1. POST with `Content-Type: application/vnd.api+json`

**Expected Result:**
- Request processed (custom body parser)
- JSON:API format handled

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-API-021: Request with Invalid Content-Type
**Priority:** MEDIUM

**Test Steps:**
1. POST with `Content-Type: text/plain`

**Expected Result:**
- 415 Unsupported Media Type
- Clear error message

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

---

## Section 8: CORS Headers

### TC-API-022: CORS Preflight Request (OPTIONS)
**Priority:** HIGH

**Test Steps:**
1. Send OPTIONS request to API endpoint
2. Check CORS headers

**Expected Result:**
- 200 OK or 204 No Content
- CORS headers present:
  - Access-Control-Allow-Origin
  - Access-Control-Allow-Methods
  - Access-Control-Allow-Headers

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-API-023: CORS Headers on GET Request
**Priority:** MEDIUM

**Test Steps:**
1. GET API endpoint
2. Verify CORS headers in response

**Expected Result:**
- CORS headers present per configuration
- Cross-origin requests allowed (if configured)

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

---

## Section 9: Error Handling

### TC-API-024: API Internal Server Error Handling
**Priority:** HIGH

**Test Steps:**
1. Trigger 500 error (if possible in test environment)
2. Observe error response

**Expected Result:**
- 500 Internal Server Error status
- JSON error response
- No stack trace exposed to client (production)
- Error logged server-side

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-API-025: API Validation Error Format
**Priority:** HIGH

**Test Steps:**
1. Submit invalid data to API
2. Review error response format

**Expected Result:**
- 422 Unprocessable Entity
- Errors in consistent JSON format
- Field names and error messages clear
- Example: `{"errors": {"email": ["Invalid email format"]}}`

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

---

## Section 10: Response Data Integrity

### TC-API-026: API Response Matches Database Data
**Priority:** CRITICAL

**Test Steps:**
1. GET program via API
2. Query same program from database
3. Compare data

**Expected Result:**
- API response matches database
- All fields accurate
- Data types correct
- No data transformation errors

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-API-027: API Response Date Format
**Priority:** MEDIUM

**Test Steps:**
1. GET resource with date fields
2. Verify date format

**Expected Result:**
- Dates in ISO 8601 format (or configured format)
- Timezone handled correctly
- Dates parseable by clients

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

---

## Section 11: Searches API

### TC-API-028: GET /admin/api/searches
**Priority:** HIGH

**Test Steps:**
1. GET search list from API

**Expected Result:**
- 200 OK
- Searches returned in JSON
- Pagination works

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-API-029: POST /admin/api/searches - Create Search
**Priority:** HIGH

**Test Steps:**
1. POST search data to API

**Expected Result:**
- 201 Created
- Search saved to database
- Search query logged

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

---

## Section 12: Inquiries API

### TC-API-030: GET /admin/api/inquiries
**Priority:** HIGH

**Test Steps:**
1. GET inquiries list

**Expected Result:**
- 200 OK
- Inquiries returned
- Filtered by permissions

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-API-031: PUT /admin/api/inquiries/{id} - Update Status
**Priority:** HIGH

**Test Steps:**
1. Update inquiry status via API

**Expected Result:**
- Status updated
- Timestamps updated correctly

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

---

## Section 13: System Management API

### TC-API-032: GET System Enumerations (Focus Types, Grades, etc.)
**Priority:** HIGH

**Test Steps:**
1. GET `/admin/api/system-management/focus-types`

**Expected Result:**
- 200 OK
- All focus types returned
- Display order respected

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-API-033: GET States/Countries
**Priority:** MEDIUM

**Test Steps:**
1. GET states and countries data

**Expected Result:**
- Geographic data returned
- Hierarchical data correct

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

---

## Section 14: API Performance

### TC-API-034: API Response Time - Simple GET
**Priority:** MEDIUM

**Test Steps:**
1. GET single program
2. Measure response time

**Expected Result:**
- Response < 200ms (simple query)
- No performance degradation

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-API-035: API Response Time - Complex Query
**Priority:** MEDIUM

**Test Steps:**
1. GET programs with filters and includes
2. Measure response time

**Expected Result:**
- Response < 1000ms
- Query optimized
- No N+1 query issues

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

---

## Section 15: API Rate Limiting (if implemented)

### TC-API-036: Rate Limiting Enforcement
**Priority:** LOW

**Test Steps:**
1. Make rapid API requests exceeding rate limit

**Expected Result:**
- 429 Too Many Requests after threshold
- Rate limit headers present
- Clear error message

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

---

## Section 16: API CSRF Protection

### TC-API-037: CSRF Protection Disabled for API Routes
**Priority:** CRITICAL

**Test Steps:**
1. POST to API endpoint without CSRF token

**Expected Result:**
- Request succeeds (CSRF skipped for API prefix)
- Authentication still required

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

---

## Section 17: API Includes/Relationships

### TC-API-038: GET Program with Related Data
**Priority:** HIGH

**Test Steps:**
1. GET `/admin/api/programs/{id}?include=organization,assessments`

**Expected Result:**
- Program data returned
- Related organization included
- Related assessments included
- Nested data correct

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

---

## Section 18: API Batch Operations (if supported)

### TC-API-039: Batch Create Programs
**Priority:** MEDIUM

**Test Steps:**
1. POST array of programs to API

**Expected Result:**
- All programs created
- OR partial success with error details
- Batch operations handled correctly

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

---

## Remaining Test Cases (TC-API-040 to TC-API-048)

Additional API endpoint tests for:
- Affiliates API
- Organizations API
- API versioning (if applicable)
- API documentation accuracy
- API error logging
- API cache headers
- API conditional requests (ETag, If-Modified-Since)
- API OPTIONS method
- API security headers

---

## Summary

**Total Test Cases:** 48
**Critical Priority:** 12
**High Priority:** 24
**Medium Priority:** 10
**Low Priority:** 2

**Completion Status:**
- Tests Passed: _____ / 48 (_____%)
- Tests Failed: _____ / 48 (_____%)
- Tests Blocked: _____ / 48 (_____%)
- Tests Skipped: _____ / 48 (_____%)

**Overall Status:** ☐ PASS ☐ FAIL ☐ BLOCKED

**Sign-Off:**
**Tester:** _______________________ **Date:** ___________
