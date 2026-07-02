# Group 6: Login & Onboarding
**Items:** #5, #8
**Estimated Effort:** 16-28 hours
**Confidence Level:** HIGH (#5), MEDIUM (#8 -- pending Mike/Sarah confirmation)
**Last Updated:** July 2026

---

## Scope Summary

Two smaller items touching user-facing account flows. #5 addresses the password reset UX confusion, and #8 fixes badge management. Grouped together because they're both small, user-facing, and don't fit naturally in the other groups.

---

## Item #5 -- Password Reset & Login UX

### Problem

New program admins have a confusing onboarding experience. After a program is submitted, the admin must go through a password reset workflow to access the system for the first time. Sandy reported ongoing user confusion despite the process being straightforward. A required mobile phone number field during the flow was questioned -- Hyun explained it was future-proofing for MFA, but Sandy confirmed MFA is unlikely. However, Beth demonstrated she could reset her password without being prompted for a phone number, suggesting the behavior may vary by role. The reset emails themselves also lack clarity.

### Solution

Investigate the current flow first (role-dependent behavior needs to be understood), then fix:

- **Remove mobile number requirement** from the password reset / profile completion flow if MFA is not planned
- **Improve password reset email** content and clarity (template exists at `Users/templates/email/html/reset_password.php`)
- **Streamline new program admin onboarding** -- clearer steps after program submission, reduce friction on first login

### Technical Context

- Password reset flow: `LoginController.php` -- `forgotPassword()` -> email with challenge (4-hour expiry) -> `resetPassword()`
- Phone number stored in `UserProfiles.phone_number` -- required field with regex validation for "(###) ###-####"
- Phone is NOT part of the reset flow itself -- it's required on the `UserProfile`, which may be encountered during profile completion after reset
- The confusion Sandy reported is likely about the profile completion step, not the reset flow

### Estimate: 10-16 hours

| Component | Low | High |
|---|---|---|
| Investigation (trace flow per role, document current UX) | 2h | 3h |
| Backend changes (phone field optional, email template improvements) | 3h | 5h |
| Frontend UX improvements (reset page, onboarding flow) | 3h | 5h |
| QA/testing (all user roles, end-to-end onboarding) | 2h | 3h |

---

## Item #8 -- Badge Management

### Problem

NQMS badges follow a tiered progression (bronze -> silver -> gold) and should be swapped as a program advances, not stacked. The current implementation uses a many-to-many relationship (`programs_badges` join table) allowing multiple badges per program, but the intended model is one badge at a time -- a tier/replacement system. Badges also can't be reordered, so the display order doesn't reflect the desired progression.

### Solution

- **Change badge assignment from multi-select to single-select** (radio buttons or dropdown) -- one badge per program at a time, replacing the previous badge
- **Add badge reordering** (drag-and-drop or numbering) so the badge list reflects the intended tier progression
- Pending: Mike to confirm the tier/replacement model with Sarah before implementation

### Technical Context

- Badge model: `plugins/NQMS/src/Model/Table/BadgesTable.php` -- fields: id, title, notes, image_id, is_deleted
- Programs-Badges: many-to-many via `ProgramsBadgesTable` join table -- currently allows multiple badges per program
- No `display_order` field exists on Badges table -- needs migration
- Change requires constraining the many-to-many to single assignment (replace strategy instead of add)

### Estimate: 8-14 hours

| Component | Low | High |
|---|---|---|
| Backend (single-select constraint, display_order migration, reorder endpoint) | 3h | 5h |
| Frontend (radio buttons for assignment, drag-and-drop for ordering) | 3h | 5h |
| QA/testing (assignment, reordering, existing data migration) | 2h | 4h |

**Note:** Estimate assumes single-badge-at-a-time model. If Mike/Sarah confirm stacking is needed in some cases, scope changes.

---

## Group Total

| Item | Hours (Low) | Hours (High) |
|------|-------------|--------------|
| #5 -- Password Reset & Login UX | 10 | 16 |
| #8 -- Badge Management | 8 | 14 |
| Bundling savings (minimal -- items don't share code) | -2 | -2 |
| **Group Total** | **16** | **28** |

---

## Implementation Order

1. **#5 -- Password Reset & Login UX** (investigation first, then fixes -- higher priority)
2. **#8 -- Badge Management** (blocked on Mike/Sarah confirmation of tier model)

---

## Risks

- **Low risk** overall.
- #5: Investigation may reveal the phone number issue is more nuanced than expected (role-dependent behavior). Small risk of scope creep if the onboarding flow needs broader rework.
- #8: Pending confirmation from Mike on badge usage model. If badges need to support both stacking and tiering depending on context, complexity increases.
