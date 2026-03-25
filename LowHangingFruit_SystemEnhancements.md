# Low-Hanging Fruit / System Enhancements
**Initiative Type:** Quick Wins
**Priority Level:** Top 3 Focus Area
**Status:** In Planning
**Last Updated:** January 2026

---

## Overview

This document consolidates all identified low-hanging fruit and system enhancement opportunities for the Mentor Connector platform. The philosophy is to focus on improving existing functionality before major new builds, addressing immediate pain points and technical debt that can deliver quick value.

---

## Summary Statistics

**Total Enhancement Areas Identified:** 25
- **User Account & Data Management:** 3 items (#1, #2, #3)
- **UI/UX Improvements:** 5 items (#4 - consolidated, #5, #6, #7, #8)
- **Search & Discovery:** 3 items (#9, #10, #25)
- **NQMS Enhancements:** 5 items (#11, #12, #13, #14, #15)
- **Automation & Engagement:** 1 item (#16)
- **Data Field Management:** 1 item (#17)
- **Permissions & Access:** 4 items (#18, #19, #20, #21)
- **Forms & Data Collection:** 2 items (#22, #23)
- **Infrastructure:** 1 item (#24)

**Priority Breakdown:**
- **CRITICAL:** 2 items (Full Data Export, Assessment History & Multi-Assessment Support)
- **Immediate/Time-Sensitive:** 3 items
- **High Value Quick Wins:** 7 items
- **Quality of Life (UI/UX):** 7 items
- **Quality of Life (NQMS):** 5 items
- **System Cleanup:** 4 items
- **Affiliate/Admin Experience:** 5 items
- **Infrastructure:** 1 item
- **Strategic Foundation:** 2 items
- **Nice to Have:** 2 items

---

## Identified Enhancement Areas

### 1. User Account Management


**Current Issues:**
- Unable to delete old user accounts
- Can't export user account data with last login timestamps
- No visibility into who last logged in or updated records
- No tracking of user activity (who updated what, when)

**Proposed Solutions:**
- Enable deletion/archival of old user accounts
- Add export capabilities for user account data including:
  - Last login timestamps
  - Update history
  - Activity logs
- Implement user activity tracking across the system

---

### 2. Export Capabilities


**Current Issues:**
- Limited export options across various data types
- Export capabilities are limited on certain data sets
- Cannot effectively extract data for analysis and reporting

**Proposed Solutions:**
- Enhanced export capabilities across all data types
- Standardized export formats
- Bulk export functionality where needed

---

### 3. Duplicate Detection & Prevention


**Current Issues:**
- Duplicate program entries exist in the system (though not exact name matches)
- Examples: "Academic Mentoring from Be A Mentor" / "Academic Mentoring with Be A Mentor"
- Programs missing Affiliate Region assignment (65 programs identified)
- Data inconsistency from similar but not identical entries

**Proposed Solutions:**
- Flag duplicate names in new program forms (implemented in 2023, but only for exact matches)
- Enhanced duplicate detection for similar names
- Tools to identify and merge potential duplicates
- Validation rules to prevent duplicate creation

**Note:** A change was implemented last year to flag duplicate names in new program forms, reducing future duplications for exact matches.

---

### 4. UI/UX Consistency & Page Layout Improvements


**Current Issues:**
- Inconsistent UI patterns across the platform
- Filter panels are not collapsible across all pages
- Filters sometimes positioned below page fold, reducing visible content
- Inconsistent filter UI across different pages (Searches, Inquiries, Affiliates, Programs, Accounts)
- Missing breadcrumb navigation in some areas
- Users must scroll to see content when filters take up screen space
- Usability friction in workflows

**Proposed Solutions:**
- Make all filter panels collapsible
- Move filter panels above the page fold to maximize visible content
- Standardize filter and search UI across all relevant pages (Searches, Inquiries, Affiliates, Programs, Accounts)
- Add breadcrumb navigation consistently across all sections
- Review and standardize UI components
- Improve navigation flow
- Consistent user experience for filtering data

**Pages Affected:** Searches, Inquiries, Affiliates, Programs, Accounts

**Note:** This consolidates general UI/UX consistency improvements with specific filter panel layout enhancements.

---

### 5. Password Reset & Login UX


**Current Issues:**
- Password reset process UI needs improvement
- Related emails have poor UX
- When new Program is submitted, admin must go through reset password workflow to access system
- Confusing onboarding experience for new program admins

**Proposed Solutions:**
- Improve UI for reset password process
- Enhance password reset emails for clarity
- Streamline new program admin account creation workflow
- Better onboarding experience for first-time users

**User Impact:** New program administrators, users who need password resets

---

### 6. Navigation & Hyperlink Improvements


**Current Issues:**
- "Affiliate Region" column in Browse Programs is not clickable
- Program names in Affiliate Program Service Areas are not hyperlinked
- Users cannot quickly navigate to related records
- Extra clicks required to view related information

**Proposed Solutions:**
- Make "Affiliate Region" column a clickable link to Affiliate Region page
- Hyperlink program names in Program Service Areas for direct navigation
- Add hyperlinks throughout system where contextually appropriate
- Reduce navigation friction

---

### 7. Program Status Visibility


**Current Issues:**
- Program status badges not definitive enough
- Difficult to quickly identify program status at a glance
- Visual hierarchy could be improved

**Proposed Solutions:**
- Use more definitive UI status badges for program status
- Color coding and visual indicators for different statuses
- Clear visual distinction between Approved, Paused, Pending, Deleted
- Improved at-a-glance program status identification

---

### 8. Badge Management


**Current Issues:**
- Cannot reorder badges
- Fixed badge order may not reflect desired priority

**Proposed Solutions:**
- Enable ability to reorder badges
- Drag-and-drop or numbering system for badge ordering
- Flexible badge display priority

---

### 9. Program Search & Discovery Enhancements


**Current Issues:**
- Search functionality has known gaps and limitations
- Mentee search is currently a workaround (directs to contact programs directly)
- System doesn't fully support mentee requests as originally intended
- Limited search capabilities for finding specific data
- **Cannot filter by Program Delivery type (Community-based, Site-based, E-mentoring)**
- E-mentoring only programs get "lost" in the system
- No visibility into programs by delivery type for Global Admins
- Difficult to identify and manage programs that don't fit traditional geographic affiliate model

**Proposed Solutions:**
- Improve search functionality across the platform
- Consider proper mentee search support vs. continuing workaround
- Enhanced search filters and parameters
- Better search results presentation
- **Add Program Delivery filter to Browse Programs page**

---

### 10. Public-Facing Site Improvements


**Current Issues:**
- Public site promoted for families to find mentoring opportunities
- Focus primarily on adult mentor recruitment
- Mentee functionality is limited (workaround directs to contact programs)
- Doesn't fully address mentee discovery needs
- Programs with long waitlists may hesitate to be listed

**Proposed Solutions:**
- Make public site more inclusive for mentees
- Clearer communication about volunteer vs. mentee pathways
- Address program concerns about waitlists and capacity
- Leverage unmet needs data for capacity building and advocacy
- Improve messaging about what the tool offers to different audiences

---

### 11. Assessment History & Multi-Assessment Support


**Current Issues:**
- System currently doesn't support multiple assessments per program
- Programs approaching 3-year mark need to complete second assessments
- No way to complete an assessment and start a new cycle while maintaining access to all historical data
- Cannot view past assessments to analyze progress over time
- Unable to compare ratings across assessment cycles
- Cannot reference previous goals when setting new assessment goals
- No timeline view of all assessment cycles for a program
- No clear distinction between active and closed assessments
- **Timeline:** This is a ticking clock item - needed soon as early adopters reach reassessment window

**Proposed Solutions:**
- **Multiple Assessments Per Program:** Support many assessments per program, with only 1 active at a time
- **Close and Open Assessments:** Clear workflow for closing an assessment and opening a new one
- **Visibility:** Dashboard/list view showing Active and Closed assessments for each program
- **Historical Access:** Access to view all past assessments for a program
- **Comparison Tools:**
  - Historical assessment data viewer/comparison tool
  - Side-by-side assessment comparison
  - Progress charts showing improvement over time
- **Goal Reference:** Ability to reference past assessment data when setting new goals
- **Reporting:** Reports should pull from active assessment only, with option to view historical reports
- **Timeline View:** Timeline showing all assessment cycles for a program

**Business Impact:** HIGH - Critical for tracking program progress over time and demonstrating measurable improvements to funders

**Note:** NQMS side has recently added an archiving feature that could serve as a model for other archival needs in the system.

---

### 12. NQMS Assessment Workflow Improvements


**Current Issues:**
- "Edit Assessment" button on Program Details page disrupts consistent workflow
- Should follow: Program → View Assessment → Delete/Edit/View goals
- "Export Assessment Goals" button for approved assessments may not be needed
- "Notes" field label unclear about purpose

**Proposed Solutions:**
- Remove "Edit Assessment" button from Program Details; only display "View Assessment"
- Ensure consistent user flow throughout assessment process
- Reevaluate need for "Export Assessment Goals" button for approved assessments
- Update "Notes" field label to: "Notes (Why did you rate yourself at the above score or give yourself an NA?)"
- Clear guidance on purpose of each field

---

### 13. NQMS Assessment Question Management


**Current Issues:**
- No ability to delete assessment questions
- File upload help text appears in NQMS assessments, but file uploads not supported
- All "Other" checkboxes don't consistently require explanatory text in comments

**Proposed Solutions:**
- Add ability to delete assessment questions
- Remove "file upload help text" from NQMS assessments
- Ensure all "Other" checkboxes require explanatory text in comments for consistency
- Cleaner question management interface

---

### 14. NQMS Reviewer Progress Tracking


**Current Issues:**
- No way for reviewers to visually track changes or progress within assessment
- Cannot remember last completed section/question
- Difficult to resume review where left off
- No visual indicators of review progress

**Proposed Solutions:**
- Provide visual progress tracking for reviewers
- Remember last completed section/question
- Show which sections/questions have been reviewed
- Visual indicators for completed vs. pending review items
- Improve reviewer efficiency and reduce duplicate work

---

### 15. Full Data Export for Research


**Current Issues:**
- No comprehensive export showing full assessment history
- Cannot export improvements/re-ratings over time
- Current exports don't capture complete picture for statistical analysis
- No longitudinal data export capability
- External researchers cannot access data in format needed for analysis
- Missing data dictionary/codebook for researchers

**Proposed Solutions:**
- Wide-format CSV with one row per program
- All assessment cycles (Assessment 1, Assessment 2, etc.)
- Baseline and improved ratings for each question
- Goal tracking across assessments
- Mentor Connector program data included
- Data dictionary/codebook for researchers
- Format optimized for SPSS, R, Stata
- "Export All" button for comprehensive data extraction

**Business Impact:** CRITICAL - Essential for planned evaluation work, research teams, and demonstrating measurable impact to funders

**Customer Quote:** _"We don't have an export all button so I can't give you that... external researchers... were like, Oh could we just do an export of the data?"_

---

### 16. Automation & Engagement Features


**Current Issues:**
- No automated reminders for programs to update profiles
- Manual effort required for all data maintenance outreach
- No automated engagement to drive profile currency
- Heavy reliance on manual intervention for routine tasks

**Proposed Solutions:**
- Automated email reminders (similar to e-commerce cart abandonment emails):
  - Programs that haven't updated in 6 months
  - Incomplete profile completion prompts
  - Seasonal engagement (peak search season: August-October)
- Automated status changes for inactive programs
- AI-powered reminders and engagement
- Reduced manual intervention where possible

**Context:** Peak searches and inquiries occur between August and October (start of school year), presenting opportunity for targeted automated campaigns.

---

### 17. Data Field Enhancements


**Current Issues:**
- Organization field ("BBBS concept") was discontinued in 2023 launch
  - Originally intended for overarching organization structure
  - Led to confusion and underutilization
  - Users listed national affiliations instead of local ones
- Missing field for national affiliation tracking
- Need for separate field to track affiliate membership vs. program details

**Proposed Solutions:**
- Document historical decision about organization field removal
- Determine if/how to track organizational hierarchies
- Add dedicated field for national affiliation if needed
- Clarify data structure to prevent future confusion
- Consider implications if data merging occurs

**Historical Context:** The organization field was removed from program forms during 2023 relaunch due to confusion and data quality issues. Need to document this decision for future reference.

---

### 18. Program Admin Permission Enhancements


**Current Issues:**
- Program Admins cannot self-pause their programs (must contact support)
- Program Admins cannot access Affiliate module or NQMS when appropriate
- Limited self-service capabilities create support bottleneck

**Proposed Solutions:**
- Allow Program Admins to self-pause programs
- Require Affiliate or Global Admin to unpause (prevents accidental activation)
- Grant Program Admins access to Affiliate module and NQMS as appropriate
- Reduce dependency on support for routine actions

**Impact:** Reduces support requests and empowers program administrators.

---

### 19. Affiliate Management UX Improvements


**Current Issues:**
- "Global Admin" field appears on Affiliate edit page (may not be needed)
- Unclear if Affiliates should be able to create their own Affiliate records
- Updating postal codes has cumbersome UX (difficult deselection process)
- Program Delivery filter not available to Affiliates and Global Admin

**Proposed Solutions:**
- Consider removing "Global Admin" field from Affiliate edit page
- Decide if Affiliates should be able to create their own Affiliate records
- Improve UX for updating postal codes (simplify deselection process)
- Add ability for Affiliates and Global Admin to filter by Program Delivery
- Streamline affiliate administration workflows

---

### 20. Affiliate Deletion & Inactivation Management


**Current Issues:**
- Affiliate can be marked "inactive" but behavior is unclear and inconsistent
- When Affiliate is marked inactive but still has zip codes assigned under Service Area, programs remain assigned to that Affiliate
- No clear way to delete an Affiliate
- No automated handling of program assignments when Affiliate is inactivated
- Users must manually uncheck all zip codes to detach programs from inactive Affiliate
- "Inactive" status doesn't prevent program-to-affiliate matching via Service Area zip codes
- Confusion about what "inactive" should do vs. what it actually does
- No clear workflow for decommissioning an Affiliate

**Real-World User Feedback:**
- _"What is the function of marking an Affiliate 'inactive'? It looks like when it is marked inactive but still has zip codes assigned under Service Area, the programs are still assigned to that Affiliate. Should we be removing the Service Area zip codes in addition to marking it 'inactive'?"_
- _"I set it to inactive and the program still show it was affiliated. To remove from it, I had to uncheck the zip code (02861). Where exactly can you delete an affiliate region, is that a new button or process?"_

**Decision Points:**
Need to determine the desired behavior and implementation approach:

**Option 1: Auto-Remove Service Areas on Inactivation**
- When Affiliate is marked inactive, automatically remove all Service Area zip codes
- This detaches all programs from the Affiliate immediately
- Pros: Clear separation, no orphaned assignments
- Cons: Data loss if Affiliate needs to be reactivated

**Option 2: Change Matching Logic**
- Keep Service Area zip codes intact when Affiliate marked inactive
- Update program-to-affiliate matching logic to only match active Affiliates
- Programs would no longer show affiliation to inactive Affiliates
- Pros: Preserves Service Area configuration for potential reactivation
- Cons: More complex logic, potential for confusion about why programs aren't matching

**Option 3: Add Hard Delete Capability**
- Add ability to permanently delete an Affiliate
- Require confirmation and handling of dependent data
- Determine what happens to programs assigned to deleted Affiliate
- Consider soft delete vs. hard delete implications

**Proposed Solutions:**
- **Clarify "Inactive" Status Behavior:**
  - Define and document what "inactive" should do
  - Update UI to clearly communicate the effects of marking Affiliate inactive
  - Add warning/confirmation when marking Affiliate inactive

- **Implement Consistent Logic:**
  - Choose and implement one of the three options above
  - Update program-to-affiliate matching logic accordingly
  - Ensure Browse Programs reflects correct affiliations based on active status

- **Add Delete Capability (if needed):**
  - Determine if hard delete is required or if inactive status is sufficient
  - If delete is needed, add "Delete Affiliate" functionality
  - Implement safeguards (confirmation, check for dependent data)
  - Document impact on programs and Service Areas

- **Improve User Experience:**
  - Add confirmation dialogs explaining what will happen to programs
  - Provide clear workflow for decommissioning an Affiliate
  - Consider bulk Service Area removal option if Option 1 is not implemented
  - Add audit trail for Affiliate status changes

**Business Impact:** MEDIUM - Affects Affiliate lifecycle management and data integrity

**User Impact:** Affiliate Admins, Global Admins managing Affiliate records

**Pages Affected:** Browse Affiliates, Edit Affiliate, Program assignment logic

**Related:** See #1 (User Account Management) for similar deletion/inactivation needs for user accounts.

---

### 21. National Affiliate for Orphan Programs (Safety Net Approach)


**Current Issues:**
- "Orphan programs" exist - programs not assigned to any affiliate because their zip codes don't match any affiliate's service area coverage
- Programs are currently assigned to affiliates by matching program zip codes with affiliate service area zip codes
- New capability to give affiliate users scoped/limited access to single programs doesn't work for orphan programs (no parent affiliate)
- Approximately 750 orphan programs identified (as of January 2026)
- No easy way to search/filter for programs without affiliate assignment
- Current workaround requires manually creating affiliate and adding all orphan program zip codes to affiliate's service area
- Maintaining orphan program assignments is time-consuming when affiliates change or new programs are added
- When affiliates become inactive or zip codes need to be transferred, requires unchecking/rechecking potentially hundreds of zip codes
- Quarterly zip code updates require manual maintenance for orphan programs

**Proposed Solutions:**

**Option A: Manual/Script Approach (Temporary)**
- Create "Mentor National" affiliate
- Run script to identify all orphan programs
- Manually add their zip codes to the national affiliate's service area coverage
- Requires ongoing maintenance: monthly/quarterly updates as programs change
- Time-consuming to maintain when affiliates deactivate or programs move

**Option B: Programmatic Safety Net Approach (Recommended)**
- Create "Mentor National" or "Global" affiliate with special behavior
- Treat this affiliate as a "unicorn" - system exception with different matching logic
- **Key Feature:** Does not match on zip code coverage at all
- Automatically captures any program that doesn't match any other affiliate's service area
- Acts as a "safety net" - "everybody who didn't get a home will land in the safety net"
- No need to specify or maintain service areas for this affiliate
- Automatically handles:
  - Programs with invalid/incorrect zip codes
  - Programs in states without affiliate coverage
  - Programs when affiliates become inactive
  - New programs in unaffiliated areas
- Eliminates need for constant manual zip code updates
- Provides visibility into programs that may have data quality issues (wrong zip codes)

**Implementation Details (Option B):**
- System checks program zip code against all active affiliates' service areas
- If match found → assign to that affiliate(s) (existing behavior)
- If no match found → automatically assign to National/Global affiliate (new behavior)
- Programs can still be assigned to multiple affiliates if zip codes match multiple service areas
- National affiliate acts as catch-all for unmatched programs

**Benefits of Safety Net Approach:**
- Ensures every program has an affiliate (no orphans)
- Enables scoped affiliate access feature to work for all programs
- Reduces manual administrative burden
- Self-healing: catches programs with data entry errors automatically
- No need to update zip codes when affiliates change status
- Provides data quality visibility (programs in National affiliate may indicate zip code issues)
- Scales automatically as new programs are added

**Business Impact:** MEDIUM-HIGH - Enables new affiliate permission features, reduces administrative burden, improves data quality

**User Impact:** Affiliate Admins, Global Admins, Program Admins

**Pages Affected:** Browse Programs, Affiliate service area management, Program assignment logic

**Related:**
- See #20 (Affiliate Deletion & Inactivation Management) for related affiliate lifecycle issues
- See #9 (Program Search & Discovery Enhancements) for filtering by affiliate status

**Implementation Complexity:** MEDIUM - Requires changes to affiliate-to-program matching logic

**Quick Win Component:** Option A can be implemented immediately via script

**Strategic Component:** Option B provides long-term sustainable solution with reduced maintenance

---

### 22. Form & Field Alignment Issues


**Current Issues:**
- Backend program application form doesn't match front-end
- "Country" field in backend may not be displayed on front-end
- Field order and naming inconsistent between front-end and back-end forms
- "Other" option handling inconsistent (sometimes collects explanatory text, sometimes doesn't)
- No confirmation email sent to users upon program submission

**Proposed Solutions:**
- Align field order and naming between front-end and back-end forms
- Remove "Country" field if not displayed on front-end
- When "Other" is selected for program specifics, add conditional text field to collect explanation
- Send confirmation email upon program submission for consistency
- Review all form fields for front/back-end alignment

**Areas Affected:** Program application, program specifics, general form consistency

---

### 23. Inquiries Module Cleanup


**Current Issues:**
- "ROLE" field still exists in Inquiries
- Only mentor inquiries are processed (mentees contact programs directly)
- Unnecessary data collection

**Proposed Solutions:**
- Remove "ROLE" field from Inquiries module
- Simplify inquiry form to reflect actual use case
- Reduce data collection overhead

---

### 24. SharePoint Migration for Document Storage


**Current Issues:**
- Documents stored on local file system
- Limited scalability and collaboration capabilities
- Backup/disaster recovery challenges
- Cannot leverage enterprise-grade storage features

**Proposed Solutions:**
- Migrate all program documents to Microsoft SharePoint Online
- Migrate NQMS assessment attachments to SharePoint
- Improve document management capabilities
- Enable better collaboration features
- Enterprise-grade storage infrastructure
- Maintain or improve upload/download performance

**Business Impact:** MEDIUM - Infrastructure improvement for scalability and reliability

**Complexity:** HIGH - Significant backend migration effort

**User Impact:** LOW (backend improvement, transparent to users if done correctly)

---

### 25. Public Search Iframe & Rich Text Support


**Current Issues:**
- **Public Search Iframe (Embedded Program Profile):**
  - Search iframe embedded in external sites is missing critical program data
  - 'The mentor role description' field not included in search API response
  - Logo size is not displaying correctly in iframe
  - Limited program information available to public searchers

- **Rich Text Formatting:**
  - Text areas throughout the site do not support enriched formatting
  - Program description and other text fields cannot display formatted text
  - No support for bold, italic, lists, links, or other formatting in text areas
  - Content is displayed as plain text only, reducing readability and engagement

**Proposed Solutions:**

**Phase 1: Search Iframe Data Completeness**
- Add 'The mentor role description' to public search API response
- Fix logo sizing issues in iframe display
- Ensure all relevant program fields are included in search results
- Test iframe display across different embedding sites

**Phase 2: Rich Text Editor Implementation**
- Implement rich text editor (e.g., CKEditor, TinyMCE, Quill) for program forms
- Add rich text support for relevant text areas:
  - Program description
  - Mentor role description
  - Other program detail fields that would benefit from formatting
- Support common formatting: bold, italic, underline, lists (ordered/unordered), hyperlinks
- Editor saves content as HTML to database
- Backend HTML sanitization for security (prevent XSS attacks)

**Phase 3: Display & Testing**
- Update display components to render HTML content properly
- Ensure iframe displays formatted HTML correctly
- Test formatting across all display contexts:
  - Program edit forms
  - Public search iframe display
  - Browse Programs view
  - Program detail pages
- Verify HTML sanitization is working correctly

**Business Impact:** MEDIUM - Improves public-facing program visibility and content richness

**User Impact:**
- External site visitors see more complete program information
- Program administrators can create more engaging, readable content
- Better presentation of program details to potential mentors

**Pages Affected:**
- Public search iframe (embedded on external sites)
- Program edit forms
- Browse Programs
- Program detail pages
- Public-facing program profiles

**Complexity:** MEDIUM - Requires both frontend (rich text editor) and backend (API updates) changes

**Quick Win Component:** Adding missing 'mentor role description' to API response (Phase 1)

**Strategic Component:** Full rich text support implementation (Phase 2-3)

---

## Work Stream Approach

This initiative represents **Stream 1** in the three-stream parallel approach:

- **Stream 1: Quick Wins / System Enhancements** (This Document)
  - Can start immediately
  - Focused on existing functionality improvements
  - Delivers tangible value quickly

- **Stream 2: Data Cleanup Strategy**
  - Requires reporting tools from Stream 1
  - Affiliate-assisted review and validation

- **Stream 3: Long-Term Vision**
  - Requires committee formation and deeper discovery
  - CRM evolution and integration decisions

---

## Success Metrics

**How We'll Measure Success:**
- Reduction in manual support requests
- Improved data export utilization
- Time savings in data quality monitoring
- User satisfaction with UI improvements
- QMS reassessment completion rates

---

## Related Documents

- [Meeting 1 Summary](Meeting/Meeting1_Summary.md) - Initial alignment discussion (Jan 2026)
- [Internal Strategy Meeting Minutes](2026-01-08 - MENTOR System Strategy (MC+NQMS) - Internal - Minutes.pdf) - Internal discussion (Jan 8, 2026)
- [MC Strategy Initiation Plan](Initiation - MC Strategy_2026_Orases.pdf) - Working document for Orases discussion
- [Orases Recommended Enhancements List](https://orases.atlassian.net/wiki/spaces/MTR/pages/2649292801/Recommended+Enhancements+List) - Confluence page with Orases-identified enhancements
- [Mentor 2026 Strategic Opportunities & Recommendations](https://orases.atlassian.net/wiki/spaces/MTR/pages/2648145923/Mentor+2026+Strategic+Opportunities+Recommendations) - Strategic analysis based on P2 implementation and customer interviews (Dec 17, 2025)
- Section 9 Requirements (TBD - pending export from Sandy)
- Orases Backlog (TBD - to be compiled)
- MC Backlog in Teamwork Governance space (requires review and prioritization)

## Change Log

| Date | Change | Updated By |
|------|--------|------------|
| January 2026 | Initial document creation with 5 enhancement areas | Aksana Rahouski |
| January 21, 2026 | Added 7 new enhancement areas from internal meeting minutes and MC strategy plan | Aksana Rahouski |
| January 21, 2026 | Added 13 new enhancement areas from Orases Confluence Recommended Enhancements List | Aksana Rahouski |
| January 21, 2026 | Added 5 items from Orases 2026 Strategic Opportunities document (Assessment History, Full Data Export, Cross-Affiliate Permissions, SharePoint Migration, Analytics Dashboard) | Aksana Rahouski |
| January 21, 2026 | Added #30 Program Analytics & Visibility Dashboard based on real-world testing feedback - e-mentoring programs getting "lost" without Program Delivery filter | Aksana Rahouski |
| January 21, 2026 | Consolidated duplicates: merged #5 & #24 (UI/UX & Filter Panels), merged #4 & #6 (Dashboards). Reduced from 31 to 29 enhancement areas. Renumbered all items and updated cross-references. | Aksana Rahouski |
| January 21, 2026 | Removed #11 Learning Management System (LMS) Integration. Reduced from 29 to 28 enhancement areas. Renumbered sections 11-29 and updated all cross-references. | Aksana Rahouski |
| January 21, 2026 | Added source documentation to all 28 enhancement items, indicating which source documents contributed to each item (Meeting 1 Summary, Internal Strategy Meeting, Orases Recommended Enhancements List, Orases 2026 Strategic Opportunities, Real-world testing feedback). | Aksana Rahouski |
| January 21, 2026 | MAJOR REORGANIZATION: Reordered all 28 enhancement sections to follow the grouping structure defined in Summary Statistics. All sections renumbered sequentially (1-28) according to new order. Updated all cross-references throughout document. New grouping order: User Account & Data Management (1-3), Admin Tools & Dashboards (4), UI/UX Improvements (5-9), Search & Discovery (10-11), NQMS Enhancements (12-17), Automation & Engagement (18), System Integration (19-20), Permissions & Access (21-23), Forms & Data Collection (24-25), Infrastructure (26), Strategic Initiatives (27-28). | Aksana Rahouski |
| January 21, 2026 | Moved Summary Statistics section to the top of the document (after Overview section) for better visibility and easier reference to enhancement categories and priorities. | Aksana Rahouski |
| January 22, 2026 | Added #23 Affiliate Deletion & Inactivation Management based on real-world testing feedback - unclear behavior when marking Affiliate inactive, programs remain assigned, no clear delete option. Increased total from 28 to 29 enhancement areas. Renumbered sections 23-28 to 24-29 and updated all cross-references throughout document. Updated Permissions & Access category from 3 to 4 items and Affiliate/Admin Experience from 3 to 4 items. | Aksana Rahouski |
| January 22, 2026 | Added #25 National Affiliate for Orphan Programs (Safety Net Approach) from Meeting 2 (NQMS Launch Planning) - programmatic solution to automatically assign orphan programs (programs without affiliate) to a National/Global affiliate that acts as safety net. Increased total from 29 to 30 enhancement areas. Renumbered sections 25-29 to 26-30 and updated all cross-references throughout document. Updated Permissions & Access category from 4 to 5 items and Affiliate/Admin Experience from 4 to 5 items. | Aksana Rahouski |
| January 27, 2026 | Removed all dashboard-related items (#4 Dashboard Improvements, #29 Analytics Dashboard, #30 Program Analytics & Visibility Dashboard) as dashboards are now tracked in a separate file. Reduced total from 30 to 27 enhancement areas. Removed "Admin Tools & Dashboards" category and "Strategic Initiatives" category. Renumbered sections 5-28 to 4-27 and updated all cross-references, priority recommendations, sources, and related sections throughout document. | Aksana Rahouski |
| January 27, 2026 | Added #28 Public Search Iframe & Rich Text Support based on client feedback - missing mentor role description in public search iframe API response, incorrect logo sizing, and need for rich text formatting support in text areas (program description, mentor role description). Increased total from 27 to 28 enhancement areas. Updated Search & Discovery category from 2 to 3 items. Added to Priority Recommendations under Quality of Life Improvements - UI/UX. | Aksana Rahouski |
| January 27, 2026 | Removed Sources section and all source references from enhancement items. Removed Key Insights from Orases Strategic Analysis section. Removed #18 Integration of MC & NQMS Tools. Reduced total from 28 to 27 enhancement areas. Renumbered sections 19-28 to 18-27 and updated all cross-references throughout document. Updated System Integration category to Data Field Management with 1 item. | Aksana Rahouski |
| January 27, 2026 | Removed #21 Cross-Affiliate NQMS Permissions Enhancement. Reduced total from 26 to 25 enhancement areas. Renumbered sections 22-26 to 21-25 and updated all cross-references throughout document. Updated Permissions & Access category from 5 to 4 items. | Aksana Rahouski |
