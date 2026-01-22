# Low-Hanging Fruit / System Enhancements
**Initiative Type:** Quick Wins
**Priority Level:** Top 3 Focus Area
**Status:** In Planning
**Last Updated:** January 2026

---

## Overview

This document consolidates all identified low-hanging fruit and system enhancement opportunities for the Mentor Connector platform. The philosophy is to focus on improving existing functionality before major new builds, addressing immediate pain points and technical debt that can deliver quick value.

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

### 3. Dashboard Improvements & Data Quality Monitoring

**Current Issues:**
- No dashboards for data quality monitoring
- No visibility into stale or problematic data
- Cannot identify programs needing attention
- Difficult to track data cleanup progress
- Main dashboard needs cleanup for clarity and usability

**Proposed Solutions:**
- **Admin Data Quality Dashboards:**
  - Programs needing attention
  - Stale data indicators
  - Last update timestamps
  - Data quality metrics
  - Automated alerts for programs that haven't updated in 6 months
  - Ability to pause programs automatically if inactive
- **Landing Page Dashboard Cleanup:**
  - Clean up dashboard layout and organization
  - Ensure Assessment Status table matches Reports → NQMS Assessments format
  - Consistent data visualization across dashboard and reports
  - Improved landing page experience for all user types

**Note:** Consolidates admin data quality monitoring dashboards with general dashboard/landing page improvements.

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

### 5. NQMS Multi-Assessment Support

**Current Issues:**
- System currently doesn't support multiple assessments per program
- Programs approaching 3-year mark need to complete second assessments
- **Timeline:** This is a ticking clock item - needed soon as early adopters reach reassessment window

**Proposed Solutions:**
- Ability to archive old assessments
- Start new assessment while maintaining history
- Reports and dashboards should pull from latest assessment only
- Clear workflow for closing one assessment and opening another

**Note:** NQMS side has recently added an archiving feature that could serve as a model for other archival needs in the system.

**Related:** See also #24 (Assessment History & Versioning) which addresses viewing and comparing multiple completed assessment cycles over time.

---

### 6. Program Search & Discovery Enhancements

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
- **Create dashboard/report showing programs by delivery type**

**Related:** See #29 for expanded Program Delivery analytics and visibility dashboard

---

### 7. Duplicate Detection & Prevention

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

### 9. Automation & Engagement Features

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

### 10. Learning Management System (LMS) Integration

**Current Issues:**
- No standardized training; conducted ad-hoc through live sessions
- Extensive resources available on website but often overlooked by users
- High turnover requires constant retraining
- No way to verify training completion or skill checks
- Support bottlenecked through limited team members

**Proposed Solutions:**
- Integration with Learning Management System (LMS)
- Structured training program for new staff onboarding
- Resources available within Mentor Connector itself (not just external website)
- Training courses in Brightspace LMS (currently exploring with Jake)
- Skill checks and verification of training completion
- Potentially AI-powered help/chatbot for common questions
- Self-service training reduces support burden

**Impact:** Addresses recurring pain point of high-turnover requiring constant manual retraining.

---

### 11. Public-Facing Site Improvements

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

### 12. Data Field Enhancements

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

### 13. Program Admin Permission Enhancements

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

### 14. Form & Field Alignment Issues

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

### 15. Password Reset & Login UX

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

### 16. Navigation & Hyperlink Improvements

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

### 17. Program Status Visibility

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

### 18. NQMS Assessment Workflow Improvements

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

### 19. NQMS Assessment Question Management

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

### 20. NQMS Reviewer Progress Tracking

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

### 21. Affiliate Management UX Improvements

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

**Related:** See #29 for comprehensive Program Analytics & Visibility Dashboard that addresses Program Delivery filtering and e-mentoring program visibility issues.

---

### 22. Inquiries Module Cleanup

**Current Issues:**
- "ROLE" field still exists in Inquiries
- Only mentor inquiries are processed (mentees contact programs directly)
- Unnecessary data collection

**Proposed Solutions:**
- Remove "ROLE" field from Inquiries module
- Simplify inquiry form to reflect actual use case
- Reduce data collection overhead

---

### 23. Badge Management

**Current Issues:**
- Cannot reorder badges
- Fixed badge order may not reflect desired priority

**Proposed Solutions:**
- Enable ability to reorder badges
- Drag-and-drop or numbering system for badge ordering
- Flexible badge display priority

---

### 24. Assessment History & Versioning

**Current Issues:**
- No way to complete an assessment and start a new cycle while maintaining access to all historical data
- Cannot view past assessments to analyze progress over time
- Unable to compare ratings across assessment cycles
- Cannot reference previous goals when setting new assessment goals
- No timeline view of all assessment cycles for a program

**Proposed Solutions:**
- Mark assessment as "complete" and start new assessment cycle
- Access to view all past assessments for a program
- Historical assessment data viewer/comparison tool
- Reference past assessment data when setting new goals
- Timeline view showing all assessment cycles
- Reports showing progress across multiple assessment cycles
- Side-by-side assessment comparison
- Progress charts showing improvement over time

**Business Impact:** HIGH - Critical for tracking program progress over time and demonstrating measurable improvements to funders

**Note:** Different from #5 (QMS Multi-Assessment Support) which focuses on the mechanics of creating new assessments. This enhancement (#22) is about viewing, comparing, and analyzing completed historical assessments.

---

### 25. Full Data Export for Research

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

### 26. Cross-Affiliate NQMS Permissions Enhancement

**Current Issues:**
- Affiliate staff cannot easily work with programs in other states on NQMS
- ZIP code-based permissions prevent cross-state access
- Current workaround exists but is not ideal
- Secondary affiliate assignment model may not be the right approach
- Consulting relationships not well-supported by current permission model

**Proposed Solutions:**
- Rethink current solution approach
- Evaluate alternative permission models for consulting relationships
- Better integration with existing permission system
- Reports showing cross-affiliate program relationships
- Maintain proper audit trails for cross-affiliate work

**Business Impact:** MEDIUM - Current workaround exists but needs improvement

**Status:** P2 delivered a workaround with specific program assignment, but users report it's not ideal. Needs refinement.

---

### 27. SharePoint Migration for Document Storage

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

## Strategic Enhancements (Beyond Low-Hanging Fruit)

The following item was identified in the Orases Strategic Opportunities document but is considered a larger strategic initiative rather than a quick enhancement. It's included here for completeness but should be evaluated as part of long-term roadmap planning.

### 28. Analytics Dashboard (STRATEGIC INITIATIVE)

**Current Issues:**
- No interactive dashboards or data visualization
- Users cannot demonstrate program effectiveness to stakeholders and funders
- Forcing manual workarounds via Excel
- Cannot track trends or show improvements over time
- Old system had "really nice dashboard things" that are now missing

**Proposed Solutions:**
- Interactive dashboards with key metrics visualization
- Trend analysis showing program improvements over time
- Filtering capabilities (by affiliate, program type, date range)
- Export capability for dashboard views
- Longitudinal data visualization (baseline → improvement tracking)
- Shareable views for funders and stakeholders

**Business Impact:** HIGH - Critical for funding justification

**User Frustration:** 4/5 intensity (per customer interviews)

**Complexity:** HIGH - Significant development effort

**Customer Quote:** _"We don't have we haven't built that in in the new system here yet, but... our old system, actually had some really nice dashboard things"_

**Note:** This is a major strategic initiative that goes beyond system enhancements. While critical for user needs, it represents a significant investment and should be planned as a dedicated project rather than grouped with quick wins.

**Related:** See #29 for Program-focused analytics dashboard (complementary to NQMS assessment analytics)

---

### 29. Program Analytics & Visibility Dashboard

**Current Issues:**
- No dashboard to view programs by different attributes (program type, status, affiliate, state, delivery type)
- E-mentoring only programs get "lost" because they don't fit geographic affiliate model
- Programs without affiliate assignment lack visibility
- Global Admins cannot easily see programs by Program Delivery type
- No way to identify patterns or gaps in program coverage
- Difficult to answer questions like:
  - How many e-mentoring programs do we have?
  - Which states have no affiliate coverage?
  - What program types are most common by region?
  - Which programs are pending vs. approved by affiliate?

**Real-World Issue (January 2026):**
During testing, a Program was not showing an Affiliate even though the Affiliate had the Program's zip code assigned. The issue: the Program had "e-mentoring only" vs. "community-based" or "site-based." There's no way to filter by Program Delivery in Browse Programs, so these programs effectively get lost in the system.

**Proposed Solutions:**

**Phase 1: Basic Filtering**
- Add Program Delivery filter to Browse Programs page (Community-based, Site-based, E-mentoring)
- Add filter for programs missing Affiliate assignment
- Enhance existing filters for better program discovery

**Phase 2: Analytics Dashboard**
- Dashboard showing program counts by:
  - Program Type (1-to-1, group, peer, etc.)
  - Program Status (Approved, Pending, Paused, Deleted)
  - Affiliate assignment
  - State/Geographic distribution
  - Program Delivery type (Community, Site, E-mentoring, Hybrid)
  - Population served
  - Youth served ranges
- Visual charts (bar charts, maps, pie charts)
- Drill-down capability to see program lists
- Export dashboard views

**Phase 3: Gap Analysis**
- Identify states/regions with no programs
- Show affiliate coverage gaps
- Highlight programs that need affiliate assignment
- E-mentoring program inventory and management

**Business Impact:** MEDIUM-HIGH - Improves program visibility, admin efficiency, and strategic planning

**Use Cases:**
- Global Admins managing programs that don't fit geographic model
- Identifying affiliate coverage gaps
- Strategic planning for program recruitment
- Understanding program portfolio composition
- Managing e-mentoring programs that serve multiple states

**Related Issues:**
- Programs with e-mentoring only delivery may need different affiliate assignment model
- Need to decide: Should e-mentoring programs always go under MENTOR National?
- How to handle affiliates that only do e-mentoring?

**Complexity:** MEDIUM - Builds on existing Browse Programs functionality

**Quick Win Component:** Adding Program Delivery filter to Browse Programs (Phase 1) is relatively straightforward

**Strategic Component:** Full analytics dashboard (Phase 2-3) requires more planning and development

---

## Priority Recommendations

### CRITICAL / Must-Have (Per Orases Strategic Analysis):
1. **Full Data Export for Research** (#25) - CRITICAL for evaluation work and demonstrating impact to funders
2. **Assessment History & Versioning** (#24) - HIGH priority for tracking program progress over time

### Immediate / Time-Sensitive:
3. **QMS Multi-Assessment Support** (#5) - Early adopters reaching reassessment window
4. **User Activity Tracking** (#1) - Foundational for data cleanup initiatives
5. **User Account Deletion** (#1) - System hygiene issue causing database clutter

### High Value / Quick Wins:
6. **Admin Dashboards** (#3) - Enables data quality monitoring and cleanup
7. **Enhanced Export Capabilities** (#2) - Supports multiple use cases and analysis
8. **Program Delivery Filter** (#29 Phase 1) - Add to Browse Programs, prevents e-mentoring programs from getting "lost"
9. **Filter Panel Improvements** (#4) - Collapsible filters, above fold placement (affects all major pages)
10. **Program Admin Self-Service** (#13) - Self-pause capability, reduces support burden
11. **Automated Reminders** (#9) - Drives profile updates with minimal manual effort
12. **Duplicate Detection** (#7) - Improves data quality and reduces confusion
13. **Dashboard Cleanup** (#3) - Consistent presentation, improved usability
14. **Navigation Hyperlinks** (#16) - Clickable Affiliate Region, hyperlinked program names

### Quality of Life Improvements - UI/UX:
15. **Filter UI Standardization** (#4) - Consistent experience across all pages
16. **Program Status Badges** (#17) - More definitive visual indicators
17. **Form Field Alignment** (#14) - Front-end/back-end consistency
18. **Password Reset UX** (#15) - Improved onboarding for new program admins
19. **Breadcrumb Navigation** (#4) - Improves navigation and orientation
20. **Search Functionality** (#6) - Better user experience for finding programs
21. **Public-Facing Site** (#11) - Better mentee experience and clearer messaging

### Quality of Life Improvements - NQMS Specific:
22. **NQMS Workflow Consistency** (#18) - Remove Edit Assessment from Program Details
23. **Assessment Question Management** (#19) - Add delete capability, fix help text
24. **NQMS Reviewer Progress** (#20) - Visual tracking, remember last position
25. **Assessment Field Labels** (#18) - Clearer "Notes" field purpose
26. **"Other" Checkbox Consistency** (#19) - Always require explanatory text

### System Cleanup / Data Hygiene:
27. **Inquiries ROLE Field** (#22) - Remove unused field
28. **Form Field Cleanup** (#14) - Remove Country field if not used on front-end
29. **Confirmation Emails** (#14) - Add for program submissions
30. **User Account Management** (#1) - System hygiene and security

### Affiliate & Admin Experience:
31. **Affiliate Management UX** (#21) - Postal code selection, Global Admin field review
32. **Affiliate Record Creation** (#21) - Decide permissions model
33. **Cross-Affiliate NQMS Permissions** (#26) - Improve workaround, refine permission model

### Infrastructure & Backend:
34. **SharePoint Migration** (#27) - Document storage scalability and reliability (HIGH complexity)

### Foundation for Long-Term Strategy:
35. **LMS Integration** (#10) - Reduces training burden, scales support
36. **MC & NQMS Integration** (#8) - Unified system experience
37. **Data Field Review** (#12) - Organization/affiliation structure clarification
38. **Program Analytics Dashboard** (#29 Phase 2-3) - Visual analytics, gap analysis, portfolio insights

### Nice to Have:
39. **Badge Reordering** (#23) - Flexible badge display priority
40. **Export Assessment Goals** (#18) - Reevaluate necessity for approved assessments

### Strategic Initiatives (Not Quick Wins):
41. **NQMS Analytics Dashboard** (#28) - Assessment analytics, major initiative, HIGH complexity, HIGH user need

### Consider for Future Discussion:
- **AI-Powered Features** (#9) - Chatbot support, automated engagement
- **Mentee Search Support** (#6, #11) - Evaluate workaround vs. full implementation
- **E-mentoring Affiliate Model** (#29) - How to handle programs that don't fit geographic model

---

## Strategic Rationale

**Why Focus on Low-Hanging Fruit:**
- Delivers immediate value to current users
- Builds credibility and trust in the platform
- Reduces manual burden on staff
- Creates foundation for larger initiatives
- Can often be completed in parallel with strategic planning
- Lower risk, faster ROI than major new features

**Connection to Broader Strategy:**
- Admin dashboards and export capabilities directly support **Data Cleanup Initiative**
- User activity tracking is foundational for positioning system as **source of truth**
- UI improvements reduce **training burden** caused by turnover
- QMS enhancements maintain **quality assessment credibility**

---

## Next Steps

### For Orases Team:
- [ ] Compile comprehensive list of identified system improvements
- [ ] Combine Orases backlog with Mentor's Section 9 requirements
- [ ] Provide effort estimates for each enhancement
- [ ] Prepare proposal for low-hanging fruit enhancements
- [ ] Identify dependencies and logical groupings

### For Mentor National:
- [ ] Sandy to export teamwork requirements list by Friday
- [ ] Identify priorities among low-hanging fruit items
- [ ] Determine budget allocation for quick wins work stream
- [ ] Provide access to Section 9 requirements documentation

### Collaborative:
- [ ] Review combined requirements list in follow-up meeting
- [ ] Establish Stream 1: Quick wins / system enhancements work stream
- [ ] Define acceptance criteria for each enhancement
- [ ] Plan phased rollout approach

---

## Work Stream Approach

This initiative represents **Stream 1** in the three-stream parallel approach:

- **Stream 1: Quick Wins / System Enhancements** (This Document)
  - Can start immediately
  - Focused on existing functionality improvements
  - Delivers tangible value quickly

- **Stream 2: Data Cleanup Strategy**
  - Requires dashboard/reporting tools from Stream 1
  - Affiliate-assisted review and validation

- **Stream 3: Long-Term Vision**
  - Requires committee formation and deeper discovery
  - CRM evolution and integration decisions

---

## Success Metrics

**How We'll Measure Success:**
- Reduction in manual support requests
- Improved data export utilization
- Dashboard adoption rates among admins
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

---

## Summary Statistics

**Total Enhancement Areas Identified:** 29 (plus 1 Strategic Initiative)
- **User Account & Data Management:** 3 items (#1, #2, #7)
- **Admin Tools & Dashboards:** 1 item (#3 - consolidated)
- **UI/UX Improvements:** 6 items (#4 - consolidated, #15, #16, #17, #22, #23)
- **Search & Discovery:** 2 items (#6, #11)
- **Program Analytics & Visibility:** 1 item (#29)
- **NQMS Enhancements:** 7 items (#5, #18, #19, #20, #24, #25)
- **Automation & Engagement:** 2 items (#9, #10)
- **System Integration:** 2 items (#8, #12)
- **Permissions & Access:** 3 items (#13, #21, #26)
- **Forms & Data Collection:** 2 items (#14, #22)
- **Infrastructure:** 1 item (#27)
- **Strategic Initiatives:** 1 item (#28 - NQMS Analytics Dashboard)

**Priority Breakdown:**
- **CRITICAL:** 2 items (Full Data Export, Assessment History & Versioning)
- **Immediate/Time-Sensitive:** 3 items
- **High Value Quick Wins:** 9 items (includes Program Delivery filter)
- **Quality of Life (UI/UX):** 7 items
- **Quality of Life (NQMS):** 5 items
- **System Cleanup:** 4 items
- **Affiliate/Admin Experience:** 3 items
- **Infrastructure:** 1 item
- **Strategic Foundation:** 4 items (includes Program Analytics Dashboard Phase 2-3)
- **Nice to Have:** 2 items
- **Strategic Initiatives:** 1 item (NQMS Analytics Dashboard)

**Sources:**
- Meeting 1 Summary: 5 items
- Internal Strategy Meeting (Jan 8): 7 items
- MC Strategy Initiation Plan: overlapping items
- Orases Recommended Enhancements List: 13 items
- Orases 2026 Strategic Opportunities: 5 items (4 enhancements + 1 strategic initiative)
- Real-world testing feedback (Jan 2026): 1 item (#31 - Program Analytics & Visibility)

**Key Insights from Orases Strategic Analysis:**
- P2 (2025) delivered significant improvements to assessment management, reporting, and document management
- Critical gaps remain in analytics/dashboards and comprehensive data export
- Customer frustration level: 4/5 on analytics gap
- Customer quote emphasis on demonstrating measurable impact to funders

---

## Change Log

| Date | Change | Updated By |
|------|--------|------------|
| January 2026 | Initial document creation with 5 enhancement areas | Aksana Rahouski |
| January 21, 2026 | Added 7 new enhancement areas from internal meeting minutes and MC strategy plan | Aksana Rahouski |
| January 21, 2026 | Added 13 new enhancement areas from Orases Confluence Recommended Enhancements List | Aksana Rahouski |
| January 21, 2026 | Added 5 items from Orases 2026 Strategic Opportunities document (Assessment History, Full Data Export, Cross-Affiliate Permissions, SharePoint Migration, Analytics Dashboard) | Aksana Rahouski |
| January 21, 2026 | Added #29 Program Analytics & Visibility Dashboard based on real-world testing feedback - e-mentoring programs getting "lost" without Program Delivery filter | Aksana Rahouski |
| January 21, 2026 | Consolidated duplicates: merged #4 & #13 (UI/UX & Filter Panels), merged #3 & #14 (Dashboards). Reduced from 31 to 29 enhancement areas. Renumbered all items and updated cross-references. | Aksana Rahouski |
