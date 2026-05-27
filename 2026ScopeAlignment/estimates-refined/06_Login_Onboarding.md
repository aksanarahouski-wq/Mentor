# Group 6: Login & Onboarding
**Items:** #5, #8
**Estimated Effort:** 16-28 hours

---

## Scope Summary

Two smaller items touching user-facing account flows. #5 addresses the password reset UX confusion, and #8 fixes badge management. They're grouped together because they're both small, user-facing, and don't fit naturally in the other groups.

---

## Item #5 — Password Reset & Login UX

**What:** Investigate and fix the password reset flow — remove unnecessary phone number requirement, improve reset emails, streamline new program admin onboarding.

**Technical Context:**
- Password reset controller: `plugins/Users/src/Controller/LoginController.php`
- Flow: `forgotPassword()` → user enters email → `resetPasswordEmail()` → generates challenge + 4-hour expiry → sends email via `UserMailer::resetPassword()` → `resetPassword($userId, $challenge)` → validates and allows reset
- Phone number: stored in `UserProfiles.phone_number` — **required field** with regex validation for "(###) ###-####"
- Phone is NOT part of the password reset flow itself — it's required on the UserProfile, which may be encountered during profile completion after reset
- Email template: `plugins/Users/templates/email/html/reset_password.php`
- The confusion Sandy reported may be about the profile completion step after first login, not the reset flow itself

**Work:**

### Investigation (required first)
- Trace the exact flow a new program admin goes through: program submission → account creation → password reset email → first login → profile completion
- Determine exactly when/where the phone number is prompted
- Check if the requirement varies by role (Beth didn't see it, Sandy's users do)

### Backend (CakePHP)
- Remove phone number as a required field on UserProfile (make optional) — if MFA is not planned
- Or: move phone number prompt to a separate, optional step
- Review and improve password reset email template content and clarity
- Ensure reset link expiration (4 hours) is appropriate

### Frontend
- Improve the reset password page UX (clear instructions, no unnecessary fields)
- Improve new user onboarding flow (clearer steps after program submission)

### QA/Testing
- Test reset flow for all user roles
- Test new program admin onboarding end-to-end
- Verify phone number is no longer blocking

**Estimate:** 10-16 hours
- Investigation: 2-3 hours
- Backend changes (phone field, email template): 3-5 hours
- Frontend UX improvements: 3-5 hours
- QA/testing: 2-3 hours

---

## Item #8 — Badge Management

**What:** Fix badge management to support tier/replacement model (one badge at a time, not stacking). Enable badge reordering.

**Technical Context:**
- Badge model: `plugins/NQMS/src/Model/Table/BadgesTable.php`
- Badge fields: id, title, notes, image_id, is_deleted, created_by, modified_by
- Programs-Badges relationship: many-to-many via `ProgramsBadgesTable` join table
- This is NOT checkboxes as initially assumed — it's a many-to-many association
- Badges have: title (unique), notes, and an image (via image_id FK)
- Current implementation allows multiple badges per program

**Work:**

### Backend (CakePHP)
- Determine if badge assignment should be single-select (radio button / tier system) or if the many-to-many relationship should be constrained
- If single badge at a time: modify program badge assignment to replace rather than add
- Add `display_order` field to Badges table (migration) for reordering
- Add badge reordering endpoint (update display_order)

### Frontend
- Change badge assignment UI from multi-select to single-select (radio buttons or dropdown)
- Add drag-and-drop or numbering interface for badge ordering in badge management
- Update program display to show single badge

### QA/Testing
- Test badge assignment (replace existing badge)
- Test badge reordering
- Verify existing badge data is handled correctly during migration
- Pending: Mike to confirm badge tier model with Sarah

**Estimate:** 8-14 hours
- Backend changes: 3-5 hours
- Frontend UI changes: 3-5 hours
- QA/testing: 2-4 hours

**Note:** Estimate assumes single-badge-at-a-time model. If Mike/Sarah confirm stacking is needed in some cases, the scope changes.

---

## Group Total

| Item | Hours (Low) | Hours (High) |
|------|-------------|--------------|
| #5 — Password Reset & Login UX | 10 | 16 |
| #8 — Badge Management | 8 | 14 |
| **Group Total** | **18** | **30** |

**Bundling Savings:** ~2 hours (minimal — these items don't share much code). Grouped mainly for organizational convenience.

**Adjusted Group Estimate: 16-28 hours**

---

## Risks

- **Low risk** overall.
- #5: Investigation may reveal the phone number issue is more nuanced than expected (role-dependent behavior). Small risk of scope creep if the onboarding flow needs broader rework.
- #8: Pending confirmation from Mike on badge usage model. If badges need to support both stacking and tiering depending on context, complexity increases.
