# Group 5: Automation & Engagement
**Items:** #16
**Estimated Effort:** 34-50 hours

---

## Scope Summary

This is a standalone group — email automation infrastructure, cron jobs, and notification logic don't overlap much with other groups. Three components with decreasing priority: inquiry reminders (highest), profile update prompts, and automated status changes.

---

## Item #16 — Automation & Engagement Features

**What:** Automated inquiry reminder emails, profile update prompts, and auto-inactivation for dormant programs.

**Technical Context:**
- Email system: Multiple mailers already exist:
  - `UserMailer` (`plugins/Users/src/Mailer/UserMailer.php`) — password reset, email verification
  - `ProgramMailer` (`plugins/Programs/src/Mailer/ProgramMailer.php`) — new program notifications
  - `NotificationsMailer` (`plugins/Programs/src/Mailer/Admin/NotificationsMailer.php`) — program reminders, assessment status
  - `InquiryMailer` (`plugins/Inquiries/src/Mailer/InquiryMailer.php`) — new inquiry emails, **inquiry reminder emails already exist**
- **Cron infrastructure already exists:**
  - `ReminderNotificationsCommand` (`plugins/Programs/src/Command/`) — runs at 4am UTC via `bin/cake Programs.reminder_notifications`
  - `UnrespondedInquiryNotificationCommand` (`plugins/Inquiries/src/Command/`) — sends reminders for unresponded inquiries
  - Email templates exist: `plugins/Inquiries/templates/email/html/inquiry_reminder_notification.php`
- User `last_login` field exists on Users table
- `UserProfiles.receive_reminder_notifications` boolean controls opt-in
- Program status: `approved`, `paused`, `pending`, `deleted` (soon `archived`)

---

### 16a: Inquiry Reminder Emails (Highest Priority)

**What:** When an inquiry sits pending for X days with no response, send a reminder email to the program contact. Cadence TBD (e.g., after 7 days, then again after 14 days).

**Work:**

#### Backend
- **Cron framework and inquiry reminder command already exist:**
  - `UnrespondedInquiryNotificationCommand` in `plugins/Inquiries/src/Command/`
  - `InquiryMailer::sendInquiryReminderEmailToProgramAdmin()` already exists
  - Email template exists: `plugins/Inquiries/templates/email/html/inquiry_reminder_notification.php`
- **Work is primarily enhancement of existing infrastructure:**
  - Review current reminder logic — does it already support cadence (multiple reminders)?
  - Add configurable cadence if not present (e.g., remind after 7 days, again after 14 days, stop after 3 reminders)
  - Add reminder tracking table if needed (`inquiry_reminders` with inquiry_id, sent_at, reminder_number)
  - Improve email template content if needed
  - Handle bounced emails: log bounced reminders as signals of dead accounts

#### Frontend
- Inquiry list view: show reminder status (how many sent, last sent date)
- Admin settings page for configuring reminder cadence (or hardcode initially)

#### QA/Testing
- Test reminder cadence logic
- Test that responded-to inquiries stop receiving reminders
- Test bounce handling
- Test edge cases: program with no contact email, inquiry older than max window

**Estimate:** 12-18 hours (reduced — infrastructure already exists)
- Enhance existing command + add cadence logic: 4-6 hours
- Email template updates + reminder tracking: 3-4 hours
- Frontend indicators: 3-4 hours
- QA/testing: 2-4 hours

---

### 16b: Profile Update Prompts (Lower Priority)

**What:** Annual or semi-annual nudge to programs to review and update their profiles. Could be automated or a manual mass email capability.

**Work:**

#### Option A: Automated (leverages existing cron infrastructure)
- Create `ProfileUpdateReminderCommand` (follows same pattern as existing `ReminderNotificationsCommand`)
- Query programs where `modified` > 6 months (or 12 months) ago
- Send profile update reminder email
- Track when reminders were sent
- Create email template with link to program edit page

#### Option B: Manual mass email (simpler)
- Add "Send Update Reminder" bulk action on Browse Programs page
- Filter programs by last updated date
- Send mass email to selected programs

**Recommend Option A** since cron infrastructure already exists and pattern is established.

**Estimate (Option A):** 10-14 hours
- Command + logic (follows existing pattern): 3-5 hours
- Email template + tracking: 3-5 hours
- QA/testing: 4 hours

---

### 16c: Automated Status Changes for Dormant Programs

**What:** Programs with no login and no activity for 6 months get flagged, then auto-changed to inactive/paused after warnings.

**Work:**

#### Backend
- Define "activity" criteria: last_login of any user associated with the program, last profile update, last inquiry response
- Create `DormantProgramCommand`:
  - Phase 1: Identify dormant programs (no activity for X months)
  - Phase 2: Send warning email ("Your program will be marked inactive in 30 days unless you log in or update your profile")
  - Phase 3: After grace period, auto-change status to `paused`
  - Track warning history per program
- Need to aggregate activity signals across multiple tables (users.last_login, programs.modified, inquiries.modified)
- Handle bounced warning emails as dead account signal

#### Frontend
- Admin view: show dormancy status / warning state on program list
- Admin override: ability to exempt a program from auto-inactivation

#### QA/Testing
- Test full lifecycle: dormant → warning → auto-paused
- Test that activity resets the timer
- Test admin exemption
- Test edge cases: program with no users, program with multiple users (any login counts)

**Estimate:** 16-24 hours
- Backend command + activity aggregation: 8-12 hours
- Email templates + tracking: 4-6 hours
- Frontend indicators + admin override: 2-4 hours
- QA/testing: 4-6 hours

---

## Group Total

| Component | Hours (Low) | Hours (High) |
|-----------|-------------|--------------|
| 16a — Inquiry Reminders | 12 | 18 |
| 16b — Profile Update Prompts | 10 | 14 |
| 16c — Auto-Inactivation | 16 | 24 |
| **Group Total** | **38** | **56** |

**Bundling Savings:** ~4-6 hours. The existing cron infrastructure and mailer patterns reduce setup time across all three components. Email template patterns and tracking tables share the same design.

**Adjusted Group Estimate: 34-50 hours**

---

## Implementation Order

1. **16a — Inquiry Reminders** (highest priority, establishes cron and email infrastructure)
2. **16b — Profile Update Prompts** (leverages infrastructure from 16a)
3. **16c — Auto-Inactivation** (most complex, can be deferred if budget is tight)

---

## Risks

- **Low-Medium risk.** Reduced from original assessment — cron infrastructure and inquiry reminder framework already exist.
- Email deliverability: increased volume of automated emails may trigger spam filters. May need to work with hosting on SPF/DKIM records.
- Activity aggregation for 16c is the most complex query — joining across users, programs, and inquiries to determine "last activity" per program.
- Auto-inactivation (16c) has business risk: Mike cautioned that some programs legitimately don't log in. Need careful criteria definition.
