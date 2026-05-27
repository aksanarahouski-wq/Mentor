# Mentor: 2026 Strategic Opportunities & Recommendations

**Document Version:** 1.0
**Date:** December 17, 2025
**Status:** Recommendation
**Prepared For:** MENTOR/NQMS Leadership Team

---

## Executive Summary

This document synthesizes client feedback from 2024 wish lists, the customer interview analysis, and P2 implementation status to provide strategic recommendations for NQMS platform enhancements in 2026.

### Key Findings

**✅ Significant Progress in 2025 (P2 Implementation):**
- Assessment management workflows significantly improved
- New centralized assessment search and filtering capabilities
- Enhanced reporting with NQMS Aggregate Report and Goals Report
- Goal tracking with date fields and lifecycle management
- Assessment archiving and data cleanup capabilities

**❌ Critical Gaps Remaining:**
1. **Analytics & Dashboards** - Users desperately need visual dashboards to demonstrate program impact to stakeholders and funders (CRITICAL per customer interview)
2. **Full Data Export for Research** - Comprehensive data export for statistical analysis not yet implemented (CRITICAL priority)
3. **Assessment History & Versioning** - No way to complete an assessment and start a new cycle while maintaining access to historical data
4. **Cross-Affiliate Permissions** - Current workaround for out-of-state NQMS consulting needs improvement
5. **SharePoint Migration** - Migrate document storage from local file system to Microsoft SharePoint Online for improved scalability and collaboration

**📊 Customer Sentiment:**
- Cautiously optimistic with high engagement
- Users appreciate core functionality improvements
- Express **clear frustration** with reporting and analytics limitations
- Critical need to demonstrate measurable impact for funding justification

---

## What Was Delivered in P2 (2025)

### Assessment Enhancements ✅
- **Print Assessment** - Professional PDF-ready print view
- **Export Assessment** - CSV export of individual assessments with goals
- **Export Assessment Goals** - Dedicated goals export functionality
- **Archive Assessments** - Soft delete capability for data cleanup
- **Goal Date Tracking** - Start date and target completion date fields
- **Delete Goals** - Ability to remove erroneous goals
- **Remove Section Goals** - Eliminated problematic section goal feature

### Reporting & Search Enhancements ✅
- **NQMS Assessments Search Page** - Centralized view with comprehensive filtering by:
  - Affiliates, cities, state
  - Program types and populations served
  - Assessment dates and status
  - Youth served counts
- **NQMS Report** - Comprehensive assessment data with questions as rows (replaces 3 separate reports)
- **Goals Report** - Goals summary by question with completion tracking
- **Clickable drill-down** - Program lists in reports link to program details

### Document Management Enhancements ✅
- **Document Tagging System** - Categorize documents with predefined types (Training, Policies, etc.)
- **Document Browser Preview** - View PDFs and images in-browser without downloading
- **Edit Document Metadata** - Update document names and tags after upload
- **Batch Document Upload** - Upload multiple documents at once with drag-and-drop
- **Batch Document Export** - Download multiple documents as ZIP file
- **Global Document Search** - Search and filter documents across programs with access controls

### Enhanced Affiliate Access Control ✅
- **Specific Program Assignment** - Assign affiliate staff to specific programs outside their geographic service area
- **Scope Options** - Choose between "All programs in region" or "Specific programs only" access
- **Cross-Affiliate Consulting** - Enable NQMS consultants to support programs in other states while maintaining affiliate context
- **Maintained Approval Workflows** - Preserve affiliate relationships for assessment approvals and reporting
- **Flexible Access Levels** - Combine with existing Full Access/MC-Only/NQMS-Only permissions

### What This Solved
✅ Assessment-centric navigation and filtering (top customer pain point)
✅ Goal management flexibility
✅ Data cleanup capabilities
✅ Better assessment workflow management
✅ Efficient document review and organization
✅ Streamlined document upload and download workflows
✅ Cross-program document discovery and knowledge sharing
✅ Cross-affiliate NQMS consulting relationships with proper permissions and audit trails

---

## Critical Outstanding Requests

### Objective 1: Analytics Dashboard

**Business Impact:** HIGH - Critical for funding justification
**User Frustration:** 4/5 intensity
**Complexity:** High

**Problem:**
Users desperately need comprehensive dashboards and data visualization to demonstrate program effectiveness to stakeholders and funders. Currently forcing manual workarounds via Excel.

**Customer Quote:**
> "We don't have we haven't built that in in the new system here yet, but... our old system, actually had some really nice dashboard things"

**What's Needed:**
- Interactive dashboards with key metrics visualization
- Trend analysis showing program improvements over time
- Filtering capabilities (by affiliate, program type, date range)
- Export capability for dashboard views
- Longitudinal data visualization (baseline → improvement tracking)

---

### Objective 2: Full Data Export for Research

**Business Impact:** CRITICAL - Essential for planned evaluation work
**User Need:** Research teams and data validation
**Complexity:** High

**Problem:**
No comprehensive export showing full assessment history, improvements/re-ratings over time, and longitudinal data. Current exports don't capture the complete picture needed for statistical analysis.

**What's Needed:**
- Wide-format CSV with one row per program
- All assessment cycles (Assessment 1, Assessment 2, etc.)
- Baseline and improved ratings for each question
- Goal tracking across assessments
- Mentor Connector program data included
- Data dictionary/codebook for researchers
- Format optimized for SPSS, R, Stata

---

### Objective 3: Assessment History & Versioning

**Business Impact:** HIGH - Critical for tracking program progress over time
**User Frustration:** High
**Complexity:** High

**Problem:**
Currently, there is no way to complete a program assessment and start a new one while maintaining access to all past assessments. Users cannot view historical assessment data to analyze progress, compare ratings over time, or reference previous goals when setting new assessment goals.

**What's Needed:**
- Ability to mark an assessment as "complete" and start a new assessment cycle
- Access to view all past assessments for a program
- Historical assessment data viewer/comparison tool
- Ability to reference past assessment data when setting new goals
- Timeline view showing all assessment cycles for a program
- Reports showing progress across multiple assessment cycles

---

### Objective 4: Cross-Affiliate NQMS Permissions

**Business Impact:** MEDIUM - Current workaround exists but not ideal
**User Frustration:** Medium
**Complexity:** Medium-High

**Problem:**
Affiliate staff (e.g., MENTOR Washington) cannot easily work with programs in other states (e.g., California) on NQMS because ZIP code-based permissions prevent cross-state access. While a workaround exists, it is not a perfect solution.

**Current Status:** Workaround in place but needs improvement

**What's Needed:**
- Rethink current solution approach
- Evaluate whether secondary affiliate assignment is the right model
- Consider alternative permission models that better support consulting relationships
- Ensure solution integrates with existing permission system
- Reports showing cross-affiliate program relationships

---

### Objective 5: SharePoint Migration

**Business Impact:** MEDIUM - Infrastructure improvement for scalability
**User Frustration:** Low (backend improvement)
**Complexity:** High

**Problem:**
MENTOR Connect currently stores all program documents and assessment attachments on the local file system. This approach limits scalability, collaboration capabilities, and creates backup/disaster recovery challenges.

**What's Needed:**
Migrate document storage from local file system to Microsoft SharePoint Online, including all program documents and NQMS assessment attachments. This migration will improve document management capabilities, enable better collaboration features, and provide enterprise-grade storage infrastructure.

---

### Objective 6: Global UI/UX Improvements

**Business Impact:** MEDIUM - Improved user experience and efficiency
**User Frustration:** Medium
**Complexity:** Low-Medium

**Problem:**
Inconsistent UI patterns across pages and filters below the fold reduce usability and efficiency.

**What's Needed:**
- Make all filter panels collapsible and move above page fold to maximize visible content
- Standardize filter and search UI across all pages (Searches, Inquiries, Affiliates, Programs, Accounts)
- Improve overall dashboard clarity and usability
- Ensure Assessment Status table matches Reports → NQMS Assessments format

---

### Objective 7: MENTOR Connector Enhancements

**Business Impact:** MEDIUM - Streamlined workflows and reduced confusion
**User Frustration:** Low-Medium
**Complexity:** Low-Medium

**Problem:**
Several workflow and UX inconsistencies in MENTOR Connector module create confusion and inefficiencies.

**What's Needed:**
- **Inquiries:** Remove "ROLE" field (only mentor inquiries processed)
- **Program Application:** Remove unused "Country" field, add confirmation emails, align front-end/back-end field order
- **Login:** Improve reset password UI and email templates
- **Users:** Allow Program Admins to access Affiliate module and NQMS as appropriate
- **Browse Programs:** Make Affiliate Region column clickable, use definitive status badges

---

### Objective 8: NQMS Module Refinements

**Business Impact:** LOW-MEDIUM - Quality of life improvements
**User Frustration:** Low-Medium
**Complexity:** Low

**Problem:**
Small UX issues and missing functionality in NQMS module impact assessment completion and review workflows.

**What's Needed:**
- Add ability to delete assessment questions
- Remove file upload help text (feature not supported)
- Update "Notes" field label for clarity: "Notes (Why did you rate yourself at the above score or give yourself an NA?)"
- Ensure all "Other" checkboxes require explanatory text
- Provide visual progress tracking for reviewers within assessments

---

### Objective 9: Program & Affiliate Management Improvements

**Business Impact:** LOW-MEDIUM - Improved administrative workflows
**User Frustration:** Low
**Complexity:** Low-Medium

**Problem:**
Administrative workflows for programs and affiliates have minor inefficiencies and unclear permissions.

**What's Needed:**
- **Program Details:** Remove "Edit Assessment" button, show only "View Assessment" for consistent flow
- Reevaluate need for "Export Assessment Goals" button on approved assessments
- Allow Program Admins to self-pause (require Affiliate/Global Admin to unpause)
- **Affiliate Management:** Consider removing "Global Admin" field, improve postal code UX, hyperlink program names
- Decide if Affiliates should create their own records

---

### Objective 10: Badges Management

**Business Impact:** LOW - Administrative convenience
**User Frustration:** Low
**Complexity:** Low

**Problem:**
Unable to reorder badges for better organization.

**What's Needed:**
- Enable ability to reorder badges

---

## Success Metrics

### Data Export & Validation
- Research team successfully analyzes full dataset
- Data export used for evaluation study
- Zero critical data integrity issues reported

### Analytics & Dashboards
- 75% of users generate reports from dashboards (vs. Excel)
- User satisfaction with analytics increases by 50%
- Dashboard views shared with funders and stakeholders

### Assessment History & Cross-Affiliate Workflows
- Programs actively using assessment history/versioning features
- Users can access and compare multiple assessment cycles
- Cross-affiliate workflows improved with updated permission model
- Overall platform satisfaction score >8/10

### SharePoint Migration
- All documents successfully migrated to SharePoint with zero data loss
- Document upload and download performance maintained or improved
- SharePoint integration operational and stable

---

## Appendix A: Original 2024 Wish List Summary

### Assessment Features (Mostly Delivered in P2)
- ✅ Print assessment
- ✅ Export assessment
- ✅ Delete assessments (archive)
- ✅ Delete/manage goals
- ✅ Goal date tracking
- ✅ Remove section goals

### Document Features (Delivered)
- ✅ Document preview
- ✅ Bulk document export
- ✅ Document tagging
- ✅ Global document search

### Reporting Features (Partially Delivered)
- ✅ Assessment search page with filtering (NEW in P2)
- ✅ NQMS Report (consolidated report - NEW in P2)
- ✅ Goals Report (NEW in P2)
- ✅ Program name filter and search
- ❌ Full data export for research (CRITICAL)
- ❌ Analytics dashboards (CRITICAL)

### Assessment Lifecycle Features (Not Yet Delivered)
- ❌ Assessment history and versioning (HIGH)
- ❌ Multi-cycle assessment tracking
- ❌ Historical assessment comparison tools

### Permission Features (Needs Improvement)
- ⚠️ Cross-affiliate NQMS access (workaround exists but not ideal)

---

## Appendix B: Customer Interview Key Quotes

**On Analytics Gap:**
> "We don't have we haven't built that in in the new system here yet, but... our old system, actually had some really nice dashboard things"

**On Assessment Management:**
> "There is no page where like here all the assessment, you can see all assessment in this status... this is the meat of what they do"
*(This was addressed with the new NQMS Assessments page in P2)*

**On Data Export:**
> "We don't have an export all button so I can't give you that... external researchers... were like, Oh could we just do an export of the data?"

**On Impact Demonstration:**
> "The entire premise of this entire body of work is dependent on us being able to track those changes... we're then building up, you know, this is data that kind of shows our services are leading to tangible and measurable improvements"

---

## Appendix C: Recommended Discovery Questions for 2026

### Analytics Dashboard Discovery
1. What specific metrics are most important for funder reports?
2. How often do users need to generate reports?
3. What visualizations would be most useful? (bar charts, trend lines, heat maps?)
4. What filtering capabilities are essential?
5. What export formats are needed? (PDF, PNG, CSV?)

### Full Data Export Discovery
1. What statistical software do researchers use? (SPSS, R, Stata, Excel?)
2. What is the preferred data structure? (wide vs. long format)
3. How many assessment cycles need to be captured?
4. What Mentor Connector fields should be included?
5. What is the acceptable export generation time for large datasets?

### Assessment History & Versioning Discovery
1. How frequently do programs complete assessment cycles?
2. What information from past assessments do users need to reference?
3. How should assessment versions be labeled/numbered?
4. What comparison tools would be most useful? (side-by-side view, progress charts, delta reports?)
5. Should past assessments be editable or locked once completed?
6. How should goal progression be tracked across assessment cycles?

---

**END OF DOCUMENT**
