
# File 07: Email & Webhooks
# Test Suite 07: Email & Webhooks Tests

**Priority:** HIGH
**Total Test Cases:** 28
**Focus:** Email notifications, SendGrid webhook integration, inquiry relay

## Overview
Tests cover email delivery, SendGrid webhook for inquiry relay, notification system, and reminder emails.

## Section 1: SendGrid Webhook - Inquiry Relay

### TC-EMAIL-001: Webhook Receives SendGrid Event
**Priority:** CRITICAL
**Test Steps:**
1. Configure SendGrid to send webhook to `/webhooks/sendgrid/add`
2. Send test email to inquiry relay address
3. Verify webhook received

**Expected Result:**
- Webhook endpoint receives POST request
- Request contains email data (to, from, subject, body)
- No authentication required (CSRF skipped for webhooks)

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-EMAIL-002: Webhook Parses Inquiry ID from Email
**Priority:** CRITICAL
**Expected Result:**
- Inquiry ID extracted from email "to" field
- Format: {inquiry_id}@domain.com
- Inquiry looked up in database

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-EMAIL-003: Webhook Relays Email to Original Inquirer
**Priority:** CRITICAL
**Test Steps:**
1. Webhook receives email for Inquiry #123
2. System looks up original inquirer's email
3. Email relayed to inquirer

**Expected Result:**
- Email sent to original inquirer
- Subject and body preserved
- Sender information included

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-EMAIL-004: Webhook Updates Inquiry Status to "Contacted"
**Priority:** CRITICAL
**Expected Result:**
- Inquiry status changed to "contacted"
- contacted_at timestamp set
- Status persists in database

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-EMAIL-005: Webhook Returns Success Response
**Priority:** HIGH
**Expected Result:**
- 200 OK status returned to SendGrid
- JSON response with relay details

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-EMAIL-006: Webhook Handles Invalid Inquiry ID
**Priority:** HIGH
**Expected Result:**
- Error logged
- Graceful failure
- SendGrid receives appropriate response

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-EMAIL-007: Webhook Handles Malformed Email Data
**Priority:** HIGH
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

## Section 2: Email Notifications - General

### TC-EMAIL-008: Email Configuration Valid
**Priority:** HIGH
**Test Steps:**
1. Verify email configuration in app_local.php
2. Test SMTP/SendGrid connection

**Expected Result:**
- Email transport configured
- Credentials valid
- Connection successful

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-EMAIL-009: Send Test Email
**Priority:** HIGH
**Expected Result:** Test email delivers successfully
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-EMAIL-010: Email Template Rendering
**Priority:** MEDIUM
**Expected Result:** Email templates render with correct data
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

## Section 3: Assessment Notifications

### TC-EMAIL-011: Assessment Submitted Notification
**Priority:** HIGH
**Test Steps:**
1. Submit assessment
2. Verify notification sent to reviewers

**Expected Result:**
- Email sent to NQMS reviewers
- Contains program and assessment details
- Link to review assessment

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-EMAIL-012: Assessment Approved Notification
**Priority:** HIGH
**Expected Result:** Program notified of approval
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-EMAIL-013: Assessment Rejected Notification
**Priority:** HIGH
**Expected Result:** Program notified with rejection reason
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

## Section 4: Program Reminder Notifications

### TC-EMAIL-014: Reminder Notification Scheduled
**Priority:** MEDIUM
**Test Steps:**
1. Configure program reminder
2. Run reminder command: `bin/cake programs.reminder_notifications`

**Expected Result:**
- Reminders identified
- Emails queued/sent
- Reminder log updated

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-EMAIL-015: Unresponded Inquiry Notification
**Priority:** MEDIUM
**Test Steps:**
1. Run: `bin/cake inquiries.unresponded_inquiry_notification`

**Expected Result:**
- Unresponded inquiries identified
- Notifications sent to appropriate users

**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

## Section 5: User Account Notifications

### TC-EMAIL-016: New User Account Notification
**Priority:** MEDIUM
**Expected Result:** New user receives welcome email (if configured)
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-EMAIL-017: Password Reset Email (if feature exists)
**Priority:** HIGH
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-EMAIL-018: Account Activation Email (if feature exists)
**Priority:** MEDIUM
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

## Section 6: Email Delivery & Reliability

### TC-EMAIL-019: Email Delivery Success Tracking
**Priority:** MEDIUM
**Expected Result:** Email delivery status logged
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-EMAIL-020: Email Delivery Failure Handling
**Priority:** HIGH
**Expected Result:** Failures logged, retry attempted
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-EMAIL-021: Bulk Email Sending
**Priority:** MEDIUM
**Expected Result:** Multiple emails sent efficiently
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

## Section 7: Email Content & Formatting

### TC-EMAIL-022: HTML Email Rendering
**Priority:** MEDIUM
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-EMAIL-023: Plain Text Email Alternative
**Priority:** LOW
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-EMAIL-024: Email Links Functional
**Priority:** HIGH
**Expected Result:** All links in emails work correctly
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

## Section 8: Email Security

### TC-EMAIL-025: Email Sender Address Verified
**Priority:** HIGH (Security)
**Expected Result:** From address is verified domain
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-EMAIL-026: No Sensitive Data in Email Logs
**Priority:** CRITICAL (Security)
**Expected Result:** Email content not logged, only metadata
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

### TC-EMAIL-027: SPF/DKIM/DMARC Records (Production)
**Priority:** HIGH (Production)
**Expected Result:** Email authentication records configured
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

## Section 9: Email Error Scenarios

### TC-EMAIL-028: Invalid Recipient Email Handling
**Priority:** MEDIUM
**Expected Result:** Invalid emails rejected, error logged
**Result:** ☐ Pass ☐ Fail ☐ Blocked ☐ Skip

---

## Summary
**Total:** 28 | **Critical:** 4 | **High:** 12 | **Medium:** 10 | **Low:** 2
**Completion:** _____ / 28 (_____%)

**Sign-Off:** _______________________ **Date:** ___________
