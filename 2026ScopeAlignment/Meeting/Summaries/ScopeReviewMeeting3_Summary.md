# Scope Review Meeting 3 — Summary
**Date:** May 20, 2026
**Attendees:** Aksana Rahouski, Hyun Masiello (Orases), Mike Garringer, Sandy Martins, Beth Tallarico, Tim Wills (MENTOR)
**Duration:** ~2 hours 7 minutes
**Reference Document:** [System Enhancements — With Client Feedback](../LowHangingFruit_SystemEnhancements_WithClientFeedback.md) | [Meeting 2 Summary](ScopeReviewMeeting2_Summary.md)

---

## Purpose

Final wrap-up meeting to review all remaining items from the 2026 system enhancements list. This was the third and final meeting in the series (following March 25 and April 9). The goal was to cover the 11+ items not yet reviewed, discuss solutions, and begin moving toward estimates and prioritization.

---

## What Was Accomplished

- Reviewed **all remaining items** from the enhancements list (#7, #10, #16, #17, #18, #19, #20, #21, #22, #23, #24, #25, #26)
- Significant discussion on **program status display**, **automation/engagement**, **affiliate management**, **form alignment**, and **search improvements**
- **Deferred items identified:** public search redesign (pending internal strategy), inquiry masking redesign (substantial lift), organization field (too complex for now), SharePoint migration (heavy lift, current state acceptable)
- Agreed that **estimates can begin** for items with clear scope; prioritization to follow after MENTOR completes data analysis
- **Mike departed early** (~1h45m); remaining discussion covered search, export, form alignment, and next steps with Sandy and Beth

---

## Item-by-Item Discussion Summary

### #7 — Program Status Visibility
**Client Priority:** Low | **Status:** Reviewed — straightforward enhancement

**Discussion:**
- Current program statuses (Approved, Paused, Pending, Deleted) are visually indistinguishable in the program list and detail views — they blend in and are hard to spot at a glance
- Aksana demoed a prototype with visual badges/tiling similar to what was done for NQMS assessment statuses (progress, goals, completed)
- Both list view and individual program detail view need visual enhancement

**Decisions made:**
- Add visual badges or tiling to program statuses in list and detail views
- Change "Deleted" status label to **"Archived"** throughout the system — consistent with Meeting 2 decision
- Archived programs should remain **searchable and filterable by admins** on the back end but excluded from public search results
- Add a **notes/reason field** for archival — Sandy: "There should be a note somewhere why... a lot of times I'm not even sure why it is in deleted status"
- Archival should be a **dedicated action** (not just a status flip) — prompt for reason, then save
- Programs must be **restorable** from archived status back to active — the action is reversible
- Archive reason is valuable for auditing and also for NQMS side (Mike: programs that go out of business mid-assessment)

**Next Step:** Estimate. Scope is: visual status badges, rename Deleted to Archived, add archive reason field, ensure archived programs are admin-searchable.

---

### #10 — Public-Facing Site Improvements (Search Page)
**Client Priority:** Medium | **Status:** Reviewed — deferred pending internal strategy

**Discussion:**
- The public search page conflates two distinct user needs: "become a mentor" vs. "find a mentor/mentee for me or someone else"
- Sandy: the second option was added as a hack because people were using the system for both purposes, but it was never an intentional strategic decision
- Mike shared a longer-term vision: Mentor Connector as a **multi-use directory** serving mentors, caregivers/parents, funders, researchers, and potentially young people directly
- Mike raised **liability concerns** about minors accessing the system to find mentors
- Sandy proposed a **landing page** before search that routes users by intent (volunteer, caregiver, young person, funder/researcher) with different guidance for each
- Group agreed this requires an **internal MENTOR strategy conversation** before any technical changes

**Decisions made:**
- **Defer search page redesign** until MENTOR internally aligns on the scope and audiences the search should serve
- No technical changes to the search experience until strategy is clarified
- Search algorithm changes (separate item) will proceed independently

**Next Step:** MENTOR to hold internal strategy discussion on search page audiences and purpose. Revisit after alignment.

---

### #16 — Automation & Engagement Features
**Client Priority:** Critical | **Status:** Reviewed — scope defined, multiple components

**Discussion — Inquiry Reminders:**
- Currently, programs receive **only one email** when someone inquires — if that email bounces or is ignored, the inquiry sits pending indefinitely
- Sandy: "A lot of time I'm not even sure why... I've reached out on behalf multiple times because of that reason, only to find out that someone no longer is in the organization"
- Mike: the inquiry follow-up is the **highest priority automation** — "if someone's got an inquiry from a volunteer sitting there for weeks on end... I would love the system to be like, 'Hey, you had someone want to volunteer. Could you please address this?'"
- Agreed on **automated reminder emails** for pending inquiries (cadence TBD — likely after X days/weeks of no response)

**Discussion — Profile Update Prompts:**
- Mike: at least once a year, ping programs to review and update their profiles; could be talked into quarterly
- Sandy compared it to Amazon cart abandonment emails — programs should be reminded to log in and check inquiries, update staff changes, etc.
- Mike: profile update prompts can be **less frequent** (annually or semi-annually) than inquiry reminders; may not even need to be automated — could be a manual mass email blast

**Discussion — Automated Status Changes:**
- Sandy proposed: if a program has **no login and no activity for 6 months**, automatically change status to inactive/pending so it drops from public search
- Mike cautioned: some programs legitimately don't log in because nothing has changed and they're not accepting volunteers — inactivity alone isn't always a red flag
- Aksana proposed two approaches: (1) fully automated status reset based on staleness criteria, or (2) system generates a **report of stale programs** for admin to take manual action
- Group leaned toward **automated with notification** — send reminders first, then auto-change status if no response

**Decisions made:**
- **Inquiry reminders:** Implement automated follow-up emails for pending inquiries (frequency TBD)
- **Profile update prompts:** Lower priority; could be automated or manual blast once or twice a year
- **Auto-status change:** Programs with no activity (no login + no profile changes) for 6 months should be flagged and eventually moved to inactive/pending status
- Bounced emails from automated sends would serve as a signal of dead accounts

**Next Step:** Estimate. Define specific trigger conditions, email cadences, and the automated-vs-report approach for status changes.

---

### #18 — Program Admin Permission Enhancements
**Client Priority:** High | **Status:** Reviewed — narrowed significantly

**Discussion:**
- Original request: program admins should be able to self-pause their programs without contacting support
- Sandy: this was driven by support requests where programs wanted to pause but had to go through Sandy or affiliates
- Aksana clarified current capabilities: program admins can already **toggle the mentor/mentee checkboxes** to stop receiving inquiries — this achieves the same practical result as pausing
- With the agreed search algorithm change (removing mentor/mentee checkbox as a search requirement), toggling those boxes will control inquiry availability while keeping the program visible in search
- Mike: "I'm not sure I want them to go in and delete their program or archive it" — status changes should remain with affiliates/global admins
- Tim raised **data integrity concern**: if program admins can toggle back to approved after pausing, no one reviews whether their profile still meets inclusion criteria
- Mike's preference: **affiliates should own status changes**; program admins should be empowered to toggle inquiry acceptance and edit their profiles
- Sandy ultimately agreed: "I'm not married to this at all... if it's nothing that we think doesn't bring value, then I'm okay with scratching it off"

**Decisions made:**
- **Program admins should NOT have access to change program status** (approved/paused/archived/pending)
- Program admins **can and should** toggle the mentor/mentee acceptance checkboxes to control inquiry flow
- Program admins can continue to edit their own profiles
- Status changes remain the responsibility of **affiliate admins and global admins**
- The original "self-pause" request was likely about stopping inquiries, which is already possible via the checkboxes
- Follow up with original requesters to confirm their actual need was inquiry-related

**Next Step:** No development needed for self-pause. Ensure training communicates how program admins can toggle inquiry acceptance. May need minor UX improvement to make the toggle more discoverable.

---

### #19 — Affiliate Management UX Improvements
**Client Priority:** High | **Status:** Reviewed — multiple sub-items scoped

**Discussion — ZIP Code / Service Area Management:**
- Current interface for managing service area ZIP codes is cumbersome and confusing, especially for editing
- Sandy: "It was a very complicated process"; editing is essentially "start over every time"
- Aksana demoed a **prototype** with improved UX: select state, optionally drill into county, see ZIP codes listed, select/deselect with checkboxes, bulk select all
- Mike confirmed: need to support **multiple counties** within one service area and **cross-state affiliates** (e.g., Georgia/Florida combo)
- Current system does support multi-county service areas (select one county, then switch to another — both remain selected), but the UX is unintuitive
- Sandy noted that service area creation/editing requests are **rare** — most were set up during migration; the bigger pain point is decoupling programs from inactive affiliates
- Group agreed the prototype approach is better but the priority is moderate given low frequency of use

**Discussion — Global Admin Field on Affiliate Page:**
- A "Global Administrator" field appears on the affiliate edit page with no clear purpose
- No one could recall why it exists; confirmed it should be **removed**

**Discussion — Programmatic Contact Field:**
- "Programmatic Contact" field on affiliates is underutilized — spot-checking production showed most affiliates have it empty
- Purpose was to identify the main point of contact vs. system admins
- Tim suggested: instead of a separate field, allow **marking one of the existing admins as "primary contact"** via a radio button
- Group agreed this eliminates redundancy (no need to enter the same person twice)
- Rename or replace "Programmatic Contact" with a primary designation on the admin list

**Discussion — "Trained" Checkbox:**
- Every affiliate has a "Trained in Mentor Connector/QMS" checkbox; only 9 of all affiliates have it checked in production
- No one is sure what it means or who uses it
- Sandy: "I don't think that thing means anything"
- Decision: **remove the Trained checkbox**

**Discussion — Program Delivery Filter:**
- Internal program search has fewer filters than the NQMS assessment search — "seems backwards"
- Aksana showed that NQMS search has detailed filters (program characteristics, categories) that the general program browse does not
- Mike: "I would like to see this applied to the general program search... people are like, 'I need to see all the programs in my state that are working with immigrant and refugee youth'"
- Sandy requested: add **ZIP code search** to the internal program search — currently can search by state/city but not ZIP code, despite the system being ZIP-code-based
- Sandy: "So crazy that a system based on ZIP codes, I can't search by ZIP code"

**Decisions made:**
- Improve service area management UX per Aksana's prototype (state/county drill-down with visible ZIP code lists)
- Remove "Global Administrator" field from affiliate edit page
- Replace "Programmatic Contact" with a **primary contact toggle** on the admin list
- Remove "Trained" checkbox from affiliates
- Add program characteristic filters to the general program search (match NQMS search capabilities)
- Add **ZIP code search** to internal program search
- Affiliate status: keep as active/inactive only (no additional statuses needed)

**Next Step:** Estimate. Sandy to provide cleanup data for programmatic contact. Aksana to scope the service area UX rework and filter enhancements.

---

### #20 — Affiliate Deletion & Inactivation Management
**Client Priority:** High | **Status:** Reviewed — solution agreed

**Discussion:**
- Currently, marking an affiliate as inactive **does nothing** — service areas and program associations remain
- Tim: "There are two or three affiliates in here right now that still... who knows where those inquiries are going anymore"
- Sandy showed a production affiliate she marked inactive a year ago — service areas and programs are still assigned
- Programs are auto-assigned to affiliates via ZIP code overlap; the only way to unassign is to remove ZIP codes from service areas, which is difficult

**Decisions made:**
- When an affiliate is marked inactive, **unlink all programs** from that affiliate but **preserve service areas** (for potential reactivation)
- No hard delete of affiliates — inactive status is sufficient
- Unlinked programs should automatically move to the **national affiliate** (safety net)
- Show a **warning message** when deactivating an affiliate: "This will unlink X programs from this affiliate"

**Next Step:** Estimate. Implement unlinking logic tied to inactive status change.

---

### #21 — National Affiliate for Orphan Programs
**Client Priority:** High | **Status:** Reviewed — requirements confirmed

**Discussion:**
- Aksana demoed the prototype for the national affiliate concept
- One and only one affiliate can be designated as the **national affiliate**
- National affiliate has the same data structure as regular affiliates but **no service areas** — it acts as a catch-all
- All orphan programs (those not matched to any active affiliate's service area) are automatically listed under the national affiliate
- When an active affiliate is deactivated, its programs automatically shift to the national affiliate

**Decisions made:**
- Proceed with national affiliate as designed in the existing requirements document
- National affiliate will not have service areas tab
- Serves as a **safety net** for orphaned programs
- Already has robust requirements written — ready for estimation

**Next Step:** Estimate based on existing requirements document.

---

### #22 — Form & Field Alignment Issues
**Client Priority:** High | **Status:** Reviewed — homework assigned to MENTOR

**Discussion:**
- The public program application form and the internal admin program form are **misaligned** — different field labels, different fields collected, some public form data never saved to the database
- Sandy: "This form wasn't touched when we went over to the new system a few years ago"
- Aksana walked through both forms side by side:
  - Labels differ: "Program Title" vs "Program Name", "Physical Address" vs "Program Address", "Program Contact Information" vs "Program Point of Contact"
  - The public form has "Other" options with text boxes for context, but the internal model only stores "Other" as a checkbox — **context text is never saved**
  - Organization field exists on internal form but not on public form (and is not populated in production anyway)
  - Country field on public form is unnecessary (US-only programs)
- Public form is **better organized** with clear section headers; internal form is one long continuous page
- Sandy noted there's an existing spreadsheet of program fields she shared with Mike for reporting purposes — can use it as the baseline

**Sub-topics discussed:**

**Program Name Duplicate Checking:**
- Current duplicate detection on the public form only matches **exact case-sensitive names**
- Sandy: adding "the" or changing capitalization bypasses the check entirely
- Need **case-insensitive matching** and potentially additional fields for duplicate detection

**Organization Field:**
- Exists in the internal form as a dropdown but has **zero organizations created in production**
- Sandy and Mike agreed: **defer organization field work** — too complex, would require defining parent-child relationships, data cleanup, and potentially tax ID validation
- Leave the field as-is on the internal form for now; do not add to public form

**Rich Text for Descriptions:**
- Program descriptions do not support any text formatting — submitted with line breaks and formatting that gets stripped, appearing as a "big blob" in search results
- Agreed to add **rich text formatting** for program description fields

**Logo Upload:**
- Both forms accept logos but with no size/dimension guidance or validation
- Sandy: "I hate how the logos appear on the search screen... people upload various different types of logos, and it's either super tiny or too big"
- Need to add **file size/dimension recommendations** and potentially a crop/resize tool

**"Other" Options Cleanup:**
- Several program characteristic fields have "Other" options with text boxes on the public form, but the data is never stored
- Mike: for age ranges, there's no legitimate "other" — can be removed
- For "youth served" categories, "other" is valuable and should be **captured in the database**
- Group agreed: review each "Other" field — remove where not needed, add database storage where it is

**Form Validation Issues:**
- Number fields (e.g., youth served count) allow **negative numbers** — needs validation fix
- Age range toggle allows going below zero

**Decisions made:**
- MENTOR to review program fields and provide the definitive field list (using Sandy's existing spreadsheet as baseline)
- Align labels and fields between public and internal forms
- Improve internal form layout to match the public form's sectioned organization
- Add case-insensitive duplicate name checking
- Defer organization field
- Add rich text support for descriptions
- Add logo upload guidance/validation
- Fix form validation (no negative numbers)
- Review all "Other" options for retention or removal

**Next Step:** MENTOR to complete program field inventory and mark which fields should appear on public search results. Aksana to estimate form alignment work once field list is finalized.

---

### #23 — Inquiries Module Cleanup
**Client Priority:** Low | **Status:** Reviewed — deferred as substantial redesign

**Discussion:**
- Current inquiry masking feature: admin sees masked email/phone until they click "Contacted" button, which reveals the information
- Intent was to incentivize programs to log in and engage with the system
- Sandy: "A lot of times people are confused. They can't find that information."
- Aksana: "It could be that it's just over-engineered for what it is"
- Group agreed this needs a redesign but it's a **substantial lift** and should be discussed separately

**Decisions made:**
- The inquiry masking/reveal process needs **redesign** — current UX is confusing
- Defer detailed scoping to a **separate focused discussion**

**Next Step:** Schedule a follow-up session to map out the inquiry workflow redesign.

---

### #24 — SharePoint Migration
**Client Priority:** High | **Status:** Reviewed — deferred, current state acceptable

**Discussion:**
- NQMS document uploads currently stored in the application database
- Sandy confirmed they can access and download documents from the front end, including bulk download
- Tim asked about tagging — system tags are application-specific; SharePoint has its own tagging that could be configured to match
- Aksana: this is a **heavy lift**; not much can be done quickly

**Decisions made:**
- **Defer for now** — current document access is functional
- If/when SharePoint migration happens, tags would need to be replicated

**Next Step:** Revisit when other higher-priority items are completed.

---

### #25 — Public Search Iframe & Rich Text
**Client Priority:** High | **Status:** Reviewed — combined with #22 and search improvements

**Discussion:**
- Search results display is "pretty dry" — only shows program title with minimal information
- Sandy: clicking a result should **expand inline** (accordion-style) rather than navigating to a separate page
- Sandy: expanded view should show key program details and include a **direct inquiry button**
- Aksana: when MENTOR defines which fields to display, both the detail page and the search result expansion can be built to match
- This overlaps with the form/field alignment work (#22) — the field inventory will determine what's displayed

**Decisions made:**
- Add more program information to search result listings
- Implement **inline expansion** (accordion) for search results instead of navigating away
- Include a **direct inquiry button** in the expanded search result view
- Field display determined by MENTOR's program data inventory (tied to #22)

**Next Step:** Dependent on MENTOR's field inventory. Estimate after field list is finalized.

---

### #26 — Public Program Search & Mentee Discovery
**Client Priority:** Not yet rated | **Status:** Reviewed — deferred with #10

**Discussion:**
- Tied directly to the #10 discussion about public search page audiences
- Cannot scope technical changes until MENTOR defines the strategy for serving different audiences (mentors, caregivers, funders, researchers)

**Decisions made:**
- **Deferred** alongside #10 pending internal MENTOR strategy discussion

**Next Step:** Revisit after MENTOR's internal alignment on search audiences.

---

### Additional Topics — Search Algorithm Changes

**Discussion:**
- Currently, three conditions must be met for a program to appear in public search results: (1) mentor/mentee checkbox selected, (2) delivery method set, (3) program location defined
- Mike: if a program exists and isn't archived, it should show up in search regardless of whether it's accepting volunteers — "There should be an icon that says, 'We're accepting volunteers,' and if you don't see that icon, they're not accepting volunteers, and there's no inquiry button"
- Group agreed: **remove the mentor/mentee checkbox as a search requirement** — programs appear in results based on status + delivery method + location only
- Mentor/mentee checkbox toggles determine whether the **inquiry button** is displayed, not whether the program is found
- Delivery method should **remain required** — at least one must be selected
- Tim asked about e-mentoring and ZIP codes — confirmed that e-mentoring programs can select "national" (no ZIP needed) or "limited" (with ZIP codes)

**Decisions made:**
- Loosen search algorithm: remove mentor/mentee checkbox from search criteria
- Keep delivery method as a required program field and search condition
- Programs with incomplete profiles (no delivery method) will still not appear in search — this is acceptable
- Inquiry button visibility tied to mentor/mentee checkbox status

---

### Additional Topics — Data Export & Reporting

**Discussion:**
- Sandy: current program export is limited — does not include program detail fields (characteristics, youth served, etc.)
- Had to go through Orases to get a full data extract for reporting purposes
- Sandy: "I definitely don't want to be restricted, because I think we shouldn't have to go through you all to get additional data"
- Aksana: either export everything (let users trim what they need) or build a **centralized report section** where MC and NQMS data can be pulled together
- Sandy advocated for a centralized report section
- Mike: research partners are "super-duper interested" in correlating program characteristics with NQMS assessment data (e.g., school-based vs. non-school-based program outcomes)
- Individual program export (from the program detail view) is also needed, not just bulk export from search

**Decisions made:**
- Program export needs to be **comprehensive** — include all program detail fields, not just basic info
- Consider building a **centralized report/export section** rather than scattered export buttons
- Individual program data export should be available from the program detail page
- Export scope to be defined alongside the field inventory from #22

---

### Additional Topics — Assessment Goals Status

**Discussion (brief — Mike had departed):**
- Currently, goals can exist or be hard-deleted — no intermediate status
- Mike previously raised the need for an "Abandoned" or "Not Pursued" status for goals that will never be completed but have evaluation value
- Aksana wanted to discuss further with Mike but he had left the meeting

**Decision:** Schedule a **follow-up with Mike** to scope assessment goal status options (archive vs. delete vs. abandoned).

---

## Key Themes & Decisions

1. **"Archived" replaces "Deleted" — with context.** Consistent theme finalized: archived status everywhere, with a mandatory reason field for auditing. Programs, users, goals all follow this soft-delete pattern. Archival must be reversible.

2. **Empower through toggles, not status access.** Program admins should control their inquiry acceptance (mentor/mentee toggles) but not their program's lifecycle status. Status changes remain with affiliates and global admins to preserve data integrity.

3. **Automation is the #1 engagement driver.** Automated inquiry reminders are the highest-priority automation. Profile update prompts and auto-inactivation for dormant programs are secondary but agreed upon. Sandy: "This is probably one of the major changes that will help us to further improve the system and its traffic."

4. **Forms must align.** Public and internal program forms have drifted apart. MENTOR to define the canonical field set; Orases to align both forms. This is foundational work that feeds into export, search results, and reporting.

5. **Search needs to serve a broader mission.** The long-term vision is a multi-use directory for funders, researchers, and caregivers — not just volunteer recruitment. But this requires internal strategic alignment before any technical changes.

6. **Affiliate lifecycle needs teeth.** Inactive affiliates currently have no functional impact. The agreed fix — unlinking programs and routing them to a national affiliate — is a clear, scoped improvement.

7. **Export and reporting capabilities are insufficient.** Multiple participants expressed frustration at needing to go through Orases for data. A centralized report section with comprehensive export capabilities is a recurring and growing need.

---

## Decisions Made

| Decision | Related Item |
|----------|-------------|
| Rename "Deleted" to "Archived" with mandatory reason field | #7 |
| Add visual badges/tiling for program statuses | #7 |
| Archived programs searchable by admins, hidden from public | #7 |
| Defer public search redesign pending MENTOR internal strategy | #10, #26 |
| Automate inquiry reminder emails (cadence TBD) | #16 |
| Auto-inactivate programs with no activity for 6 months | #16 |
| Profile update prompts: lower priority, annual or semi-annual | #16 |
| Program admins cannot change program status | #18 |
| Program admins control inquiry toggles (mentor/mentee checkboxes) | #18 |
| Improve service area ZIP code management UX | #19 |
| Remove Global Administrator field from affiliate edit page | #19 |
| Replace Programmatic Contact with primary contact toggle on admin list | #19 |
| Remove "Trained" checkbox from affiliates | #19 |
| Add program characteristic filters and ZIP code search to internal program search | #19 |
| Inactive affiliates: unlink programs, preserve service areas | #20 |
| No hard delete of affiliates — inactive status only | #20 |
| Proceed with national affiliate as designed | #21 |
| Align public and internal program forms | #22 |
| Case-insensitive duplicate name checking | #22 |
| Defer organization field | #22, #17 |
| Add rich text formatting for program descriptions | #22, #25 |
| Defer inquiry masking redesign to separate discussion | #23 |
| Defer SharePoint migration | #24 |
| Search results: inline expansion with direct inquiry button | #25 |
| Loosen search algorithm: remove mentor/mentee checkbox requirement | Search |
| Comprehensive program export; centralized report section | Export |

---

## Action Items

### Aksana (Orases)
| Action | Related Item | Timeline |
|--------|-------------|----------|
| Begin estimates for items with clear scope | All reviewed items | Ongoing |
| Identify items needing further discussion before estimating | All | Immediate |
| Schedule follow-up with Mike on assessment goal statuses | #11 (Goals) | Soon |
| Investigate form validation issues (negative numbers, etc.) | #22 | With form work |

### Sandy (MENTOR)
| Action | Related Item | Timeline |
|--------|-------------|----------|
| Complete program field inventory using existing spreadsheet | #22 | Before estimation |
| Mark which fields should display in public search results | #22, #25 | With field inventory |
| Review "Other" options on program forms — keep or remove per field | #22 | With field inventory |

### Mike (MENTOR)
| Action | Related Item | Timeline |
|--------|-------------|----------|
| Follow up on assessment goal status requirements (archive vs. abandoned vs. delete) | #11 | Schedule with Aksana |
| Collaborate on program field inventory with Sandy | #22 | Ongoing |

### MENTOR (Internal)
| Action | Related Item | Timeline |
|--------|-------------|----------|
| Hold internal strategy discussion on public search page audiences and purpose | #10, #26 | Before next scope session |
| Survey affiliates on what program data fields they track | #22 | Ongoing |

### Hyun (Orases)
| Action | Related Item | Timeline |
|--------|-------------|----------|
| Coordinate with MENTOR on prioritization after estimates are ready | All | After estimates |

---

## Items Deferred

| Item | Reason | Revisit When |
|------|--------|-------------|
| #10 — Public search redesign | Needs internal MENTOR strategy alignment | After MENTOR internal discussion |
| #17 — Organization field | Too complex; no current usage; requires data cleanup and architecture decisions | Future phase |
| #23 — Inquiry masking redesign | Substantial lift; needs dedicated design session | Separate follow-up meeting |
| #24 — SharePoint migration | Heavy lift; current state is functional | After higher-priority items |
| #26 — Public program search & mentee discovery | Dependent on #10 strategy decision | After MENTOR internal discussion |

---

## Next Steps

1. **Orases begins estimating** all items with clear scope (does not need to wait for MENTOR's field inventory for items like status badges, automation, affiliate management, national affiliate, search algorithm changes)
2. **MENTOR completes program field inventory** — this unlocks estimation for form alignment (#22), search result display (#25), and export enhancements
3. **Aksana schedules a follow-up with Mike** to finalize assessment goal status requirements
4. **MENTOR holds internal strategy discussion** on public search audiences before #10 and #26 can proceed
5. **Prioritization session** after estimates are ready and MENTOR's data analysis is complete — determine sequencing for 2026 development
