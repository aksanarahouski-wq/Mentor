# File 06: File Management
# Test Suite 06: File Management Tests

**Priority:** HIGH
**Total Test Cases:** 36
**Focus:** File upload, download, storage (S3/Orases Files plugin)

## Overview
Tests cover file operations including uploads, downloads, thumbnails, S3 integration, and the Orases/Files plugin functionality after upgrade to version ^2.3.

## Section 1: File Upload - Program Logo

### TC-FILE-001: Upload PNG Logo
**Priority:** CRITICAL
**Test Steps:**
1. Navigate to program edit
2. Upload PNG logo (< 5MB)
3. Save program

**Expected Result:**
- File uploads to S3/storage
- Record created in ofiles table
- logo_id field updated on program
- Logo displays on program page

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-FILE-002: Upload JPG Logo
**Priority:** HIGH
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-FILE-003: Upload Invalid File Type (EXE, ZIP)
**Priority:** HIGH
**Expected Result:** Validation error, upload rejected
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-FILE-004: Upload Oversized File
**Priority:** HIGH
**Expected Result:** Size validation error
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-FILE-005: Replace Existing Logo
**Priority:** HIGH
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

## Section 2: File Upload - Program Documents

### TC-FILE-006: Upload PDF Document
**Priority:** CRITICAL
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-FILE-007: Upload DOCX Document
**Priority:** HIGH
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-FILE-008: Upload Multiple Documents
**Priority:** HIGH
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-FILE-009: Associate Document with Assessment
**Priority:** HIGH
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

## Section 3: Dropzone Integration

### TC-FILE-010: Dropzone Drag and Drop
**Priority:** HIGH
**Expected Result:** Dropzone interface works, files upload
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-FILE-011: Dropzone Progress Indicators
**Priority:** MEDIUM
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-FILE-012: Dropzone Multiple File Upload
**Priority:** HIGH
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-FILE-013: Dropzone Upload Cancellation
**Priority:** MEDIUM
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

## Section 4: File Download

### TC-FILE-014: Download Program Document
**Priority:** CRITICAL
**Test Steps:**
1. Click download link on program document
2. Verify file downloads

**Expected Result:**
- File downloads successfully
- Correct filename
- Content intact
- Opens in appropriate application

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-FILE-015: Download Large File (>10MB)
**Priority:** MEDIUM
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-FILE-016: Download File - Direct URL Access
**Priority:** HIGH (Security)
**Expected Result:** Authorization checked before download
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

## Section 5: Thumbnail Generation

### TC-FILE-017: Thumbnail Generated for Image
**Priority:** HIGH
**Expected Result:** Thumbnail auto-generated, correct size
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-FILE-018: Thumbnail Display in File List
**Priority:** MEDIUM
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-FILE-019: No Thumbnail for Non-Image Files
**Priority:** MEDIUM
**Expected Result:** Generic icon displayed for PDFs, docs
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

## Section 6: File Deletion

### TC-FILE-020: Delete Program Logo
**Priority:** HIGH
**Expected Result:** Logo removed from program, file deleted/marked
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-FILE-021: Delete Program Document
**Priority:** HIGH
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-FILE-022: Cannot Delete File in Use
**Priority:** MEDIUM
**Expected Result:** Warning or prevention if file referenced elsewhere
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

## Section 7: S3 Integration

### TC-FILE-023: Files Stored in S3
**Priority:** CRITICAL
**Test Steps:**
1. Upload file
2. Verify file in S3 bucket

**Expected Result:**
- File present in S3
- Correct bucket and path
- File accessible

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-FILE-024: S3 Connection Failure Handling
**Priority:** HIGH
**Expected Result:** Graceful error, user notified
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-FILE-025: S3 File Permissions
**Priority:** HIGH (Security)
**Expected Result:** Files not publicly accessible, signed URLs used
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

## Section 8: File Metadata

### TC-FILE-026: File Metadata Stored Correctly
**Priority:** HIGH
**Test Steps:**
1. Upload file
2. Query ofiles table
3. Verify metadata

**Expected Result:**
- Filename, size, mime_type stored
- Upload timestamp recorded
- User association tracked

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-FILE-027: File Size Calculation Accurate
**Priority:** MEDIUM
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-FILE-028: MIME Type Detection Accurate
**Priority:** HIGH
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

## Section 9: File Validation

### TC-FILE-029: Filename Sanitization
**Priority:** HIGH (Security)
**Expected Result:** Special characters removed/escaped
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-FILE-030: File Extension Validation
**Priority:** HIGH (Security)
**Expected Result:** Only allowed extensions accepted
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-FILE-031: File Content Type Verification
**Priority:** HIGH (Security)
**Expected Result:** MIME type matches extension
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

## Section 10: File Performance

### TC-FILE-032: Upload Performance - 5MB File
**Priority:** MEDIUM
**Expected Result:** Uploads in reasonable time (<30 seconds)
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-FILE-033: Download Performance - 10MB File
**Priority:** MEDIUM
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-FILE-034: Concurrent File Uploads
**Priority:** MEDIUM
**Expected Result:** Multiple uploads handled correctly
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

## Section 11: File Error Handling

### TC-FILE-035: Upload Interrupted - Network Error
**Priority:** MEDIUM
**Expected Result:** User notified, can retry
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-FILE-036: Corrupt File Upload Handling
**Priority:** MEDIUM
**Expected Result:** Error detected, upload rejected
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

---

## Summary
**Total:** 36 | **Critical:** 5 | **High:** 22 | **Medium:** 9
**Completion:** _____ / 36 (_____%)

**Sign-Off:** _______________________ **Date:** ___________
