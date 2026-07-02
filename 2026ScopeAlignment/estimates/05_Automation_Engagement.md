# Group 5: Automation & Engagement
**Items:** #16
**Estimated Effort:** 34-50 hours
**Confidence Level:** HIGH
**Last Updated:** July 2026

---

## Scope Summary

This is a standalone group -- email automation infrastructure, cron jobs, and notification logic don't overlap much with other groups. Three components with decreasing priority: inquiry reminders (highest), profile update prompts, and automated status changes.

---

## Item #16 -- Automation & Engagement Features

### Problem

The platform relies heavily on manual intervention for routine engagement tasks. When a prospective mentor or mentee submits an inquiry, the program receives one email notification -- if ignored or the email bounces, the inquiry sits pending indefinitely with no follow-up. Mike: "If someone's got an inquiry from a volunteer sitting there for weeks on end... I would love the system to be like, 'Hey, you had someone want to volunteer. Could you please address this?'"

Programs also have no automated nudges to keep their profiles current. Sandy compared the need to Amazon cart-abandonment emails -- at minimum, an annual ping to review and update. Additionally, dormant programs (no login, no activity for months) remain listed as active with no automatic flagging or status change.

### Solution

Three automated engagement capabilities, in priority order:

**16a: Inquiry Reminder Emails (Highest Priority)**
Automated reminder emails when an inquiry sits pending with no response. Configurable cadence (e.g., after 7 days, again after 14 days). Bounced reminder emails serve as a signal of dead program accounts.

**16b: Profile Update Prompts**
Annual or semi-annual automated email to programs prompting them to review and update their profiles. Programs that haven't been modified in 6+ months are targeted.

**16c: Automated Status Changes for Dormant Programs**
Programs with no login and no activity for 6 months get a warning email, then auto-change to paused after a grace period. Mike cautioned that some programs legitimately don't log in -- so the system warns first, then acts only if there's no response.

### Technical Context

The cron infrastructure and email framework already exist:
- `ReminderNotificationsCommand` runs at 4am UTC via `bin/cake Programs.reminder_notifications`
- `UnrespondedInquiryNotificationCommand` already sends reminders for unresponded inquiries
- `InquiryMailer::sendInquiryReminderEmailToProgramAdmin()` already exists with email template
- Multiple mailer classes established (`UserMailer`, `ProgramMailer`, `NotificationsMailer`, `InquiryMailer`)
- User `last_login` field exists; `UserProfiles.receive_reminder_notifications` boolean controls opt-in

The main work is enhancing existing infrastructure (cadence logic, tracking tables) rather than building from scratch.

---

### 16a: Inquiry Reminders

| Component | Low | High |
|---|---|---|
| Enhance existing command + add cadence logic | 4h | 6h |
| Email template updates + reminder tracking | 3h | 4h |
| Frontend indicators (reminder status on inquiry list) | 3h | 4h |
| QA/testing | 2h | 4h |
| **Subtotal** | **12h** | **18h** |

### 16b: Profile Update Prompts

| Component | Low | High |
|---|---|---|
| New command (follows existing ReminderNotifications pattern) | 3h | 5h |
| Email template + tracking | 3h | 5h |
| QA/testing | 4h | 4h |
| **Subtotal** | **10h** | **14h** |

### 16c: Auto-Inactivation for Dormant Programs

| Component | Low | High |
|---|---|---|
| Backend command + activity aggregation (users, programs, inquiries) | 8h | 12h |
| Email templates (warning + final notice) + tracking | 4h | 6h |
| Frontend indicators + admin exemption override | 2h | 4h |
| QA/testing | 4h | 6h |
| **Subtotal** | **16h** | **24h** |

---

## Group Total

| Component | Hours (Low) | Hours (High) |
|-----------|-------------|--------------|
| 16a -- Inquiry Reminders | 12 | 18 |
| 16b -- Profile Update Prompts | 10 | 14 |
| 16c -- Auto-Inactivation | 16 | 24 |
| Bundling savings (shared cron/mailer patterns, shared tracking table design) | -4 | -6 |
| **Group Total** | **34** | **50** |

---

## Implementation Order

1. **16a -- Inquiry Reminders** (highest priority, establishes enhanced cron and email patterns)
2. **16b -- Profile Update Prompts** (leverages infrastructure from 16a)
3. **16c -- Auto-Inactivation** (most complex, can be deferred if budget is tight)

---

## Risks

- **Low-Medium risk.** Reduced from original assessment -- cron infrastructure and inquiry reminder framework already exist.
- Email deliverability: increased volume of automated emails may trigger spam filters. May need to work with hosting on SPF/DKIM records.
- Activity aggregation for 16c is the most complex query -- joining across users, programs, and inquiries to determine "last activity" per program.
- Auto-inactivation (16c) has business risk: Mike cautioned that some programs legitimately don't log in. Need careful criteria definition and a warning-first approach.
