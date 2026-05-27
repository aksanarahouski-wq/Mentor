# Test Suite 04: NQMS Assessment Tests

**Priority:** CRITICAL
**Total Test Cases:** 64
**Focus:** NQMS (National Quality Mentoring Standards) assessment system functionality

## Overview

This test suite validates the NQMS assessment system including:
1. Assessment creation and submission
2. Assessment questions and responses
3. Assessment goals and scoring
4. Assessment approval workflow
5. Badges and achievements
6. Section management
7. Checkbox groups and items

All NQMS tests are CRITICAL for programs pursuing national quality standards certification.

---

## Section 1: Assessment Questions Management

### TC-NQMS-001: View Assessment Questions List
**Priority:** CRITICAL
**Prerequisites:** Logged in as NQMS affiliate or superuser

**Test Steps:**
1. Navigate to `/admin/nqms/assessment-questions`
2. View questions organized by sections

**Expected Result:**
- Questions display grouped by section
- Section names visible
- Question titles and types shown
- Display order correct

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip
**Tested By:** _____________ **Date:** _____________ **Environment:** _____________

### TC-NQMS-002: Create New Assessment Question
**Priority:** CRITICAL

**Test Steps:**
1. Navigate to NQMS questions
2. Click "Add Question"
3. Fill in:
   - Title
   - Description
   - Section
   - Question type (checkbox/select/text)
   - Display order
4. Save question

**Expected Result:**
- Question created successfully
- Appears in correct section
- Display order respected

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-NQMS-003: Edit Assessment Question
**Priority:** HIGH

**Test Steps:**
1. Open existing question
2. Modify title and description
3. Save changes

**Expected Result:**
- Changes saved
- Modified timestamp updated

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-NQMS-004: Reorder Assessment Questions (CRITICAL UPGRADE TEST)
**Priority:** CRITICAL

**Test Steps:**
1. Navigate to assessment questions
2. Drag question from position 3 to position 1
3. Release drag
4. Refresh page

**Expected Result:**
- Questions reorder successfully
- NO 500 errors (was broken before upgrade)
- Order persists after refresh
- Transaction handling works correctly

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-NQMS-005: Delete Assessment Question
**Priority:** HIGH

**Test Steps:**
1. Select question without responses
2. Delete question
3. Confirm deletion

**Expected Result:**
- Question deleted if no responses exist
- Or error if responses exist

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

---

## Section 2: Assessment Sections

### TC-NQMS-006: View Assessment Sections
**Priority:** HIGH

**Test Steps:**
1. Navigate to NQMS sections management
2. View section list

**Expected Result:**
- All sections display
- Display order correct
- Section names visible

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-NQMS-007: Create New Section
**Priority:** HIGH

**Test Steps:**
1. Click "Add Section"
2. Enter section title
3. Set display order
4. Save section

**Expected Result:**
- Section created
- Appears in section list
- Available for question assignment

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-NQMS-008: Edit Section
**Priority:** MEDIUM

**Test Steps:**
1. Open existing section
2. Modify title
3. Save changes

**Expected Result:**
- Section updated
- Questions remain associated

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-NQMS-009: Reorder Sections
**Priority:** MEDIUM

**Test Steps:**
1. Change display_order of sections
2. Save changes
3. Verify new order

**Expected Result:**
- Sections display in new order
- Questions follow section order

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

---

## Section 3: Checkbox Groups and Items

### TC-NQMS-010: Create Checkbox Group for Question
**Priority:** HIGH

**Test Steps:**
1. Navigate to checkbox question
2. Add checkbox group
3. Enter group title
4. Save group

**Expected Result:**
- Checkbox group created
- Associated with question
- Ready for checkbox items

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-NQMS-011: Add Checkbox Items to Group
**Priority:** HIGH

**Test Steps:**
1. Open checkbox group
2. Add multiple checkbox items
3. Set titles and values
4. Save items

**Expected Result:**
- All items created
- Display in correct order
- Available in assessment forms

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-NQMS-012: Edit Checkbox Item
**Priority:** MEDIUM

**Test Steps:**
1. Open existing checkbox item
2. Modify title
3. Save changes

**Expected Result:**
- Item updated
- Changes reflected in assessments

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

---

## Section 4: Program Assessment Creation

### TC-NQMS-013: Create New Assessment for Program
**Priority:** CRITICAL

**Test Steps:**
1. Navigate to program details
2. Click "Create Assessment"
3. Verify assessment form loads
4. Fill in required fields
5. Save as draft

**Expected Result:**
- Assessment created with status "draft"
- Linked to program
- latest_assessment_id updated on program
- Can return to edit later

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-NQMS-014: Assessment Form Displays All Questions
**Priority:** CRITICAL

**Test Steps:**
1. Open assessment form
2. Verify all NQMS questions display
3. Check questions grouped by section

**Expected Result:**
- All questions present
- Sections display in correct order
- Questions within sections ordered correctly
- Question types render correctly (checkbox/select/text)

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-NQMS-015: Save Assessment as Draft
**Priority:** HIGH

**Test Steps:**
1. Start new assessment
2. Answer some questions (not all)
3. Save as draft

**Expected Result:**
- Assessment saved with status "draft"
- Partial responses saved
- Can return to complete later

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-NQMS-016: Edit Draft Assessment
**Priority:** HIGH

**Test Steps:**
1. Open draft assessment
2. Modify existing responses
3. Add new responses
4. Save changes

**Expected Result:**
- Changes saved to draft
- All responses updated correctly
- Status remains "draft"

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

---

## Section 5: Assessment Responses

### TC-NQMS-017: Answer Rating Scale Question
**Priority:** CRITICAL

**Test Steps:**
1. Open assessment form
2. Find rating scale question
3. Select rating (1-5 or similar)
4. Save response

**Expected Result:**
- Rating saved to program_assessment_responses
- rating_scale field populated
- Response displays on review

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-NQMS-018: Answer Checkbox Question
**Priority:** CRITICAL

**Test Steps:**
1. Open assessment form
2. Find checkbox question
3. Select multiple checkboxes
4. Save responses

**Expected Result:**
- Checkboxes saved to program_assessment_checkbox_responses
- Multiple selections preserved
- Responses display correctly

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-NQMS-019: Answer Text Question
**Priority:** HIGH

**Test Steps:**
1. Open assessment form
2. Find text/textarea question
3. Enter text response
4. Save response

**Expected Result:**
- Text saved to program_assessment_responses
- Full text preserved
- Response displays on review

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-NQMS-020: Answer Select/Dropdown Question
**Priority:** HIGH

**Test Steps:**
1. Open assessment form
2. Find select question
3. Choose option from dropdown
4. Save response

**Expected Result:**
- Selected value saved
- Response displays correctly

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-NQMS-021: Modify Existing Response
**Priority:** HIGH

**Test Steps:**
1. Open assessment with existing responses
2. Change response to question
3. Save changes

**Expected Result:**
- Response updated in database
- New value displays
- Old value overwritten

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

---

## Section 6: Assessment Submission

### TC-NQMS-022: Submit Complete Assessment
**Priority:** CRITICAL

**Test Steps:**
1. Complete all required questions in draft assessment
2. Click "Submit Assessment"
3. Confirm submission

**Expected Result:**
- Status changes from "draft" to "submitted"
- submitted_at timestamp recorded
- Program's latest_assessment_id updated
- Cannot edit after submission (or edit lock enforced)
- Notification sent (if configured)

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-NQMS-023: Cannot Submit Incomplete Assessment
**Priority:** HIGH

**Test Steps:**
1. Leave required questions unanswered
2. Attempt to submit assessment
3. Observe validation

**Expected Result:**
- Submission blocked
- Error message: "Please answer all required questions"
- Status remains "draft"
- Missing questions highlighted

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-NQMS-024: Submission Confirmation
**Priority:** MEDIUM

**Test Steps:**
1. Complete assessment
2. Click submit
3. Observe confirmation modal/message

**Expected Result:**
- Confirmation dialog appears
- User must confirm submission
- Can cancel if needed

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

---

## Section 7: Assessment Approval Workflow

### TC-NQMS-025: View Submitted Assessments (Reviewer)
**Priority:** CRITICAL

**Test Steps:**
1. Login as NQMS affiliate/reviewer
2. Navigate to assessments pending review
3. View list of submitted assessments

**Expected Result:**
- All submitted assessments visible
- Assessment details accessible
- Program information shown

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-NQMS-026: Review Assessment Responses
**Priority:** CRITICAL

**Test Steps:**
1. Open submitted assessment
2. Review all responses
3. Navigate through sections

**Expected Result:**
- All responses display correctly
- Can view by section
- Responses readonly (if submission locked)

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-NQMS-027: Add Approved Ratings
**Priority:** CRITICAL

**Test Steps:**
1. Open submitted assessment as reviewer
2. For each response, enter approved_rating
3. Add reviewer notes if needed
4. Save ratings

**Expected Result:**
- Approved ratings saved to program_assessment_responses
- approved_rating field populated
- Notes saved
- Assessment still in "submitted" status

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-NQMS-028: Approve Assessment
**Priority:** CRITICAL

**Test Steps:**
1. Complete review with approved ratings
2. Click "Approve Assessment"
3. Confirm approval

**Expected Result:**
- Status changes to "approved"
- approved_at timestamp recorded
- Program notified (if configured)
- Assessment locked for editing

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-NQMS-029: Reject Assessment
**Priority:** HIGH

**Test Steps:**
1. Review submitted assessment
2. Click "Reject Assessment"
3. Enter rejection reason
4. Confirm rejection

**Expected Result:**
- Status changes to "rejected"
- Rejection reason saved
- Program notified with reason
- Program can revise and resubmit (if workflow allows)

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-NQMS-030: Request Assessment Revision
**Priority:** MEDIUM

**Test Steps:**
1. Review assessment
2. Request revision with comments
3. Return to program

**Expected Result:**
- Assessment marked for revision
- Program can edit responses
- Comments visible to program

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

---

## Section 8: Assessment Goals

### TC-NQMS-031: View Assessment Goals
**Priority:** HIGH

**Test Steps:**
1. Navigate to assessment goals section
2. View goals for each section

**Expected Result:**
- Goals display by section
- Goal descriptions visible
- Scoring criteria shown

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-NQMS-032: Set Goal Achievement Status
**Priority:** HIGH

**Test Steps:**
1. Open assessment goals
2. Mark goal as achieved or not achieved
3. Enter achieved_score
4. Add notes
5. Save goal status

**Expected Result:**
- Goal status saved to program_assessment_goals
- achieved_score recorded
- Notes saved
- Goal displays with status

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-NQMS-033: Calculate Assessment Score from Goals
**Priority:** HIGH

**Test Steps:**
1. Complete assessment with goal scoring
2. Review total assessment score
3. Verify score calculation

**Expected Result:**
- Total score calculated from achieved goals
- Score displayed on assessment summary
- Score calculation accurate

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-NQMS-034: Edit Goal Notes
**Priority:** MEDIUM

**Test Steps:**
1. Open assessment goals
2. Modify notes for a goal
3. Save changes

**Expected Result:**
- Notes updated
- Changes persist

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

---

## Section 9: NQMS Badges

### TC-NQMS-035: View Available Badges
**Priority:** MEDIUM

**Test Steps:**
1. Navigate to NQMS badges
2. View badge list

**Expected Result:**
- All badges display
- Badge descriptions visible
- Criteria for earning shown

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-NQMS-036: Award Badge to Program
**Priority:** HIGH

**Test Steps:**
1. Complete assessment meeting badge criteria
2. Award badge to program
3. Verify badge association

**Expected Result:**
- Badge linked to program in program_badges table
- Badge displays on program page
- Award date recorded

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-NQMS-037: Multiple Badges per Program
**Priority:** MEDIUM

**Test Steps:**
1. Award multiple badges to same program
2. Verify all display

**Expected Result:**
- All earned badges display on program
- Many-to-many relationship works
- Badge icons/images show

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-NQMS-038: Remove Badge from Program
**Priority:** MEDIUM

**Test Steps:**
1. Remove earned badge from program
2. Confirm removal

**Expected Result:**
- Badge association removed
- Badge no longer displays on program
- Record deleted from program_badges

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

---

## Section 10: Assessment Versioning

### TC-NQMS-039: Create New Assessment Version
**Priority:** HIGH

**Test Steps:**
1. Program with approved assessment
2. Create new assessment for same program
3. Submit new assessment

**Expected Result:**
- New assessment created
- Both assessments retained in database
- latest_assessment_id points to newest
- Can view previous assessments

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-NQMS-040: View Assessment History
**Priority:** MEDIUM

**Test Steps:**
1. Navigate to program with multiple assessments
2. View assessment history/list

**Expected Result:**
- All assessments display in chronological order
- Status and dates visible
- Can open any previous assessment

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-NQMS-041: Compare Assessment Versions
**Priority:** LOW

**Test Steps:**
1. Select two assessment versions
2. Compare responses (if feature exists)

**Expected Result:**
- Can view differences between assessments
- Changes highlighted
- Easy to track progress

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

---

## Section 11: Assessment Documents

### TC-NQMS-042: Attach Document to Assessment
**Priority:** HIGH

**Test Steps:**
1. Open assessment
2. Navigate to documents section
3. Upload supporting document
4. Associate with assessment

**Expected Result:**
- Document uploaded to S3/storage
- Linked to assessment in program_documents
- Document visible from assessment view

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-NQMS-043: View Assessment Documents
**Priority:** MEDIUM

**Test Steps:**
1. Open assessment with documents
2. View document list
3. Download document

**Expected Result:**
- All assessment documents display
- Can download each document
- Files open correctly

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-NQMS-044: Delete Assessment Document
**Priority:** MEDIUM

**Test Steps:**
1. Select document attached to assessment
2. Delete document
3. Confirm deletion

**Expected Result:**
- Document removed from list
- File removed from storage
- Association deleted

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

---

## Section 12: Authorization - NQMS Roles

### TC-NQMS-045: NQMS Affiliate Can Manage Questions
**Priority:** CRITICAL

**Test Steps:**
1. Login as nqms_affiliate
2. Navigate to assessment questions
3. Verify can create, edit, delete questions

**Expected Result:**
- Full access to question management
- Can modify assessment structure
- Authorization granted

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-NQMS-046: NQMS Program Cannot Manage Questions
**Priority:** HIGH

**Test Steps:**
1. Login as nqms_program user
2. Attempt to access `/admin/nqms/assessment-questions`

**Expected Result:**
- Access denied
- Unauthorized error
- Cannot modify assessment structure

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-NQMS-047: NQMS Program Can Complete Own Assessment
**Priority:** CRITICAL

**Test Steps:**
1. Login as nqms_program user
2. Navigate to their program's assessment
3. Complete and submit assessment

**Expected Result:**
- Can access own program's assessment
- Can create, edit draft assessments
- Can submit assessment
- Cannot access other programs' assessments

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-NQMS-048: NQMS Limited Contractor Restrictions
**Priority:** HIGH

**Test Steps:**
1. Login as nqms_affiliate_limited or nqms_program_limited
2. Verify restricted access

**Expected Result:**
- Access restricted per policy
- Cannot perform certain actions
- Read-only or limited edit access

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

---

## Section 13: Assessment Data Integrity

### TC-NQMS-049: Assessment Responses Referential Integrity
**Priority:** HIGH

**Test Steps:**
1. Query program_assessment_responses table
2. Verify all records have valid program_assessment_id
3. Check foreign keys

**Expected Result:**
- All responses linked to valid assessments
- No orphaned response records
- Referential integrity maintained

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-NQMS-050: Checkbox Responses Integrity
**Priority:** MEDIUM

**Test Steps:**
1. Query program_assessment_checkbox_responses
2. Verify all records valid

**Expected Result:**
- All checkbox responses linked to valid assessments
- Checkbox item IDs valid
- No orphaned records

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-NQMS-051: Assessment Goals Integrity
**Priority:** MEDIUM

**Test Steps:**
1. Query program_assessment_goals
2. Verify all records valid

**Expected Result:**
- All goals linked to valid assessments
- Section IDs valid
- No NULL foreign keys

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

---

## Section 14: Assessment Reporting

### TC-NQMS-052: Generate Assessment Summary Report
**Priority:** MEDIUM

**Test Steps:**
1. Navigate to approved assessment
2. Generate summary report
3. View or download report

**Expected Result:**
- Report generates successfully
- Contains assessment responses and scores
- Formatted for readability

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-NQMS-053: Export Assessment Data
**Priority:** MEDIUM

**Test Steps:**
1. Select assessment
2. Export to CSV/Excel
3. Download file

**Expected Result:**
- Export file contains all assessment data
- Data accurate
- File opens correctly

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-NQMS-054: Assessment Progress Tracking
**Priority:** MEDIUM

**Test Steps:**
1. View list of assessments
2. Check completion status indicators

**Expected Result:**
- Can see which assessments are draft/submitted/approved
- Progress percentages shown (if feature exists)
- Status clearly indicated

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

---

## Section 15: Assessment Validation

### TC-NQMS-055: Required Questions Validation
**Priority:** HIGH

**Test Steps:**
1. Leave required question unanswered
2. Attempt to submit assessment

**Expected Result:**
- Validation error displayed
- Submission blocked
- Required question highlighted

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-NQMS-056: Rating Scale Range Validation
**Priority:** MEDIUM

**Test Steps:**
1. Attempt to enter rating outside valid range
2. Observe validation

**Expected Result:**
- Invalid rating rejected
- Validation message shown
- Must enter rating within range

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-NQMS-057: Text Response Length Validation
**Priority:** LOW

**Test Steps:**
1. Enter very long text response
2. Save assessment

**Expected Result:**
- Text saved if within field limits
- Or validation error if exceeds limit
- No data truncation

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

---

## Section 16: Assessment UI/UX

### TC-NQMS-058: Assessment Form Navigation
**Priority:** MEDIUM

**Test Steps:**
1. Open long assessment form
2. Navigate between sections
3. Use "Save and Continue" buttons

**Expected Result:**
- Can navigate between sections easily
- Progress saved automatically or on button click
- Current section highlighted

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-NQMS-059: Helper Text Display
**Priority:** LOW

**Test Steps:**
1. View questions with helper text
2. Verify helper text displays

**Expected Result:**
- Helper text visible below or near question
- Provides guidance for answering
- Formatted correctly

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-NQMS-060: Question Type Icons/Indicators
**Priority:** LOW

**Test Steps:**
1. View assessment form
2. Observe visual indicators for question types

**Expected Result:**
- Different question types visually distinct
- Icons or labels indicate type
- User understands expected input

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

---

## Section 17: Assessment Notifications

### TC-NQMS-061: Assessment Submission Notification
**Priority:** MEDIUM

**Test Steps:**
1. Submit assessment
2. Check if notification sent to reviewers

**Expected Result:**
- Email notification sent to NQMS reviewers
- Notification includes program and assessment details
- Reviewers can access assessment from email

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-NQMS-062: Assessment Approval Notification
**Priority:** MEDIUM

**Test Steps:**
1. Approve assessment
2. Check if notification sent to program

**Expected Result:**
- Program notified of approval
- Email contains approval details
- Program can view approved assessment

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-NQMS-063: Assessment Rejection Notification
**Priority:** MEDIUM

**Test Steps:**
1. Reject assessment with reason
2. Check if notification sent to program

**Expected Result:**
- Program notified of rejection
- Rejection reason included in notification
- Program knows next steps

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

---

## Section 18: Assessment Performance

### TC-NQMS-064: Assessment Form Load with 50+ Questions
**Priority:** MEDIUM

**Test Steps:**
1. Open assessment with many questions
2. Observe load time
3. Test form responsiveness

**Expected Result:**
- Form loads in reasonable time (<5 seconds)
- All questions render correctly
- Form remains usable
- No timeout errors

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

---

## Summary

**Total Test Cases:** 64
**Critical Priority:** 18
**High Priority:** 24
**Medium Priority:** 19
**Low Priority:** 3

**Completion Status:**
- Tests Passed: _____ / 64 (_____%)
- Tests Failed: _____ / 64 (_____%)
- Tests Blocked: _____ / 64 (_____%)
- Tests Skipped: _____ / 64 (_____%)

**Overall Status:** ☐ PASS ☐ FAIL ☐ BLOCKED

**Sign-Off:**
**Tester:** _______________________ **Date:** ___________
**NQMS Reviewer:** _______________________ **Date:** ___________
