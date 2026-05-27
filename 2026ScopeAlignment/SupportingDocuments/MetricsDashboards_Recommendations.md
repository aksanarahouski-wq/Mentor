# Metrics & Dashboards Recommendations for Mentor Connector
**Initiative Type:** Data Analytics & Visibility Enhancement
**Priority Level:** High Value / Strategic Foundation
**Status:** Recommendations - Planning Phase (Tier 1 Demos Available)
**Created:** January 21, 2026
**Last Updated:** January 27, 2026

---

## Executive Summary

This document outlines **6 high-impact dashboards** for the Mentor Connector platform, prioritized for maximum business value and operational necessity.

**Selection Criteria:**
- Unblocks critical initiatives (Data Cleanup, NQMS operations)
- Demonstrates measurable impact to funders
- Enables immediate operational improvements
- High ROI relative to implementation effort

**Dashboards Included:**
1. **Program Health & Status Overview** - Landing page and operational visibility
2. **Data Quality Monitoring** - Unblocks Data Cleanup Initiative
3. **Program Analytics & Discovery** - Solves "lost e-mentoring programs" issue
4. **NQMS Assessment Status Overview** - Essential NQMS pipeline monitoring
5. **NQMS Impact & Outcomes** - Demonstrates ROI to funders (strategic)
6. **User Activity & Engagement** - Enables user account cleanup

### 🎯 Interactive Dashboard Demos Available

**All 6 high-impact dashboards have been prototyped as interactive HTML demos**, located in `/Users/aksana/Documents/Projects/Mentor/2026ScopeAlignment/demos/`:

- **Dashboard 1: Program Health & Status Overview** ([View Demo](demos/dashboard-program-health.html)) ✅
- **Dashboard 2: Data Quality Monitoring** ([View Demo](demos/dashboard-data-quality.html)) ✅
- **Dashboard 3: Program Analytics & Discovery** ([View Demo](demos/dashboard-program-analytics.html)) ✅
- **Dashboard 4: NQMS Assessment Status Overview** ([View Demo](demos/dashboard-nqms-status.html)) ✅
- **Dashboard 5: NQMS Impact & Outcomes** ([View Demo](demos/dashboard-nqms-impact.html)) ✅
- **Dashboard 6: User Activity & Engagement** ([View Demo](demos/dashboard-user-activity.html)) ✅

These demos showcase real-world scenarios, interactive filtering, data quality alerts, funnel visualizations, impact metrics, and export capabilities.

---

## Table of Contents

1. [High-Impact Dashboard Specifications](#high-impact-dashboard-specifications)
   - Dashboard 1: Program Health & Status Overview
   - Dashboard 2: Data Quality Monitoring
   - Dashboard 3: Program Analytics & Discovery
   - Dashboard 4: NQMS Assessment Status Overview
   - Dashboard 5: NQMS Impact & Outcomes
   - Dashboard 6: User Activity & Engagement
2. [Supporting Metrics Reference](#supporting-metrics-reference)

---

## High-Impact Dashboard Specifications

#### **Dashboard 1: Program Health & Status Overview**
**Audience:** Global Admins, Affiliate Admins
**Purpose:** At-a-glance operational status
**🎯 Interactive Demo:** [View Dashboard 1 Demo](demos/dashboard-program-health.html)

**Components:**
1. **Status Summary Cards** (Top row)
   - Total Active Programs (large number with trend arrow)
   - Total Paused Programs
   - Pending Approval Count (with alert if > threshold)
   - Total Youth Served (with trend)

2. **Status Distribution Pie Chart**
   - Approved (green)
   - Paused (yellow)
   - Pending (orange)
   - Deleted (gray)

3. **Geographic Heat Map**
   - USA map with state-level program density
   - Click-through to state detail

4. **Recent Activity Timeline**
   - Last 10 program updates
   - New program submissions
   - Status changes

5. **Quick Filters**
   - By Affiliate
   - By State
   - By Program Delivery Type (Community/Site/E-mentoring)
   - By Status

---

#### **Dashboard 2: Data Quality Monitoring**
**Audience:** Global Admins, Data Stewards
**Purpose:** Identify programs needing attention
**🎯 Interactive Demo:** [View Dashboard 2 Demo](demos/dashboard-data-quality.html)

**Components:**
1. **Stale Data Alerts** (Top cards with red/yellow/green indicators)
   - Programs not updated in 6+ months (count + %)
   - Programs not updated in 12+ months (count + %)
   - Programs with no user logins ever (count)

2. **Missing Data Summary Table**
   | Data Gap | Count | % of Total | Action |
   |----------|-------|------------|--------|
   | Missing Affiliate | XX | XX% | [Assign] |
   | Missing Contact Info | XX | XX% | [Review] |
   | Missing Demographics | XX | XX% | [Update] |
   | Incomplete Profile | XX | XX% | [Complete] |

3. **Programs Needing Attention (List View)**
   - Sortable/filterable table
   - Columns: Program Name, Last Updated, Missing Data Flags, Action Buttons
   - Click to edit program directly
   - Bulk action: Send reminder email

4. **Data Quality Score Trend**
   - Line chart showing improvement over time
   - Metric: % of programs with complete, current data
   - Monthly tracking

5. **Automated Alerts Configuration**
   - Toggle: Auto-email programs not updated in 6 months
   - Toggle: Auto-pause programs inactive for 12 months
   - Last alert sent timestamp

---

#### **Dashboard 3: Program Analytics & Discovery**
**Audience:** Global Admins, Strategic Planning
**Purpose:** Understand program portfolio and identify gaps
**🎯 Interactive Demo:** [View Dashboard 3 Demo](demos/dashboard-program-analytics.html)

**Components:**
1. **Program Type Distribution**
   - Bar chart: Programs by Mentoring Type (1-to-1, Group, Peer, etc.)
   - Drill-down to program list

2. **Delivery Type Breakdown** ⭐ **NEW - HIGH PRIORITY**
   - Pie chart: Community-based / Site-based / E-mentoring / Hybrid
   - Shows visibility for e-mentoring programs currently "lost" in system
   - Filter programs by delivery type
   - Shows programs missing delivery type classification

3. **Geographic Coverage Analysis**
   - Map: States with programs vs. without
   - Table: Top 20 cities by program count
   - Gap identification: Underserved regions

4. **Capacity & Demand Summary**
   - Gauge chart: Total capacity utilization (youth served vs. waiting)
   - Trend line: Youth served over time
   - Trend line: Waitlist growth/decline

5. **Demographics Reach**
   - Stacked bar charts:
     - Mentee age ranges served (aggregate)
     - Mentee categories (at-risk, foster, immigrant, etc.)
     - Grade levels served

6. **Focus Area Coverage**
   - Horizontal bar chart: Programs by focus type
   - Identify popular vs. underserved focus areas

---

## NQMS Assessment Dashboards

#### **Dashboard 4: NQMS Assessment Status Overview**
**Audience:** Global Admins, Affiliate Admins, NQMS Staff
**Purpose:** Monitor assessment pipeline and completion
**🎯 Interactive Demo:** [View Dashboard 4 Demo](demos/dashboard-nqms-status.html)

**Components:**
1. **Assessment Pipeline Summary (Cards)**
   - In Progress (count + %)
   - Pending Review (count + %)
   - Completed (count + %)
   - Goals Completed (count + %)

2. **Assessment Status Funnel**
   - Visual funnel showing progression:
     - Started → In Progress → Submitted → Approved → Goals Completed
   - Drop-off rates at each stage

3. **Assessments Needing Attention (Table)**
   | Program | Status | Days in Status | Completion % | Action |
   |---------|--------|----------------|--------------|--------|
   | ABC Program | In Progress | 120 days | 45% | [Remind] |
   | XYZ Program | Pending Review | 45 days | 100% | [Review] |

4. **Recent Assessment Activity**
   - Timeline: Recent submissions, approvals, goal completions
   - Filter by date range

5. **Average Completion Time Metrics**
   - Gauge: Days to complete (target vs. actual)
   - Gauge: Days in review (target vs. actual)

---

#### **Dashboard 5: NQMS Impact & Outcomes** ⭐ **STRATEGIC - CRITICAL FOR FUNDERS**
**Audience:** Funders, Executive Leadership, Research Teams
**Purpose:** Demonstrate measurable impact and improvement over time
**🎯 Interactive Demo:** [View Dashboard 5 Demo](demos/dashboard-nqms-impact.html)

**Components:**
1. **Program Improvement Summary**
   - % of programs improving ratings in reassessment
   - Average rating increase (percentage points)
   - Total goals achieved across network

2. **Longitudinal Rating Trends** (Requires Assessment History - Enhancement #11)
   - Line chart: Average ratings across assessment cycles (Baseline → Cycle 2 → Cycle 3)
   - Shows network-wide improvement trajectory

3. **Goal Achievement Impact**
   - Scatter plot: Baseline score vs. Achieved score
   - Programs above diagonal = improvement
   - Programs below diagonal = decline (needs support)

4. **Badge Achievement Trends**
   - Bar chart: New badges earned per quarter/year
   - Total badge count trend line

5. **Section-Level Improvement Analysis**
   - Heatmap: Sections (rows) x Assessment Cycles (columns)
   - Color intensity = Average rating (darker = higher)
   - Visualizes which quality areas are improving most

6. **Export for Research** (Enhancement #15 - CRITICAL)
   - Button: "Export All Assessment Data (Wide Format)"
   - Generates CSV with all assessment cycles, baseline/improved ratings
   - Includes data dictionary/codebook for researchers

---

## User Engagement Dashboard

#### **Dashboard 6: User Activity & Engagement**
**Audience:** Global Admins, Training Staff
**Purpose:** Monitor user engagement and identify inactive accounts
**🎯 Interactive Demo:** [View Dashboard 6 Demo](demos/dashboard-user-activity.html)

**Components:**
1. **Activity Summary (Cards)**
   - Active Users (7 days)
   - Active Users (30 days)
   - Active Users (90 days)
   - Never Logged In (alert)

2. **Login Frequency Distribution**
   - Histogram: Days since last login
   - Color coding: Green (< 7 days), Yellow (7-30 days), Orange (30-90 days), Red (90+ days)

3. **Inactive Accounts Alert**
   - Table: Users not logged in for 90+ days
   - Columns: Name, Email, Role, Last Login, Action [Send Reminder | Disable]

4. **Users Never Logged In**
   - List of accounts created but never activated
   - Days since creation
   - Action: Resend verification email or delete

5. **Engagement Trend Line**
   - Monthly active users over time
   - Compare to total user count

---

## Dashboard Demos Overview

### Available Interactive Demos

**All 6 high-impact dashboards have been prototyped as fully interactive HTML demos.** These showcase the recommended UI, data visualizations, filtering, and interactive features for immediate stakeholder review.

**Demo Location:** `/Users/aksana/Documents/Projects/Mentor/2026ScopeAlignment/demos/`

#### Dashboard 1: Program Health & Status Overview
**File:** [dashboard-program-health.html](demos/dashboard-program-health.html)

**Key Features:**
- Status summary cards with trends
- Program status distribution pie chart
- Geographic heat map visualization
- Recent activity timeline
- Multi-dimensional quick filters (Affiliate, State, Delivery Type, Status)

**Use Cases:** Daily operational monitoring, at-a-glance program health, landing page dashboard

#### Dashboard 2: Data Quality Monitoring
**File:** [dashboard-data-quality.html](demos/dashboard-data-quality.html)

**Key Features:**
- Stale data alerts (6+ and 12+ months)
- Missing data summary with actionable buttons
- Sortable/filterable programs needing attention
- Data quality score trends
- Bulk action capabilities
- CSV export

**Use Cases:** Data cleanup campaigns, identifying incomplete records

#### Dashboard 3: Program Analytics & Discovery
**File:** [dashboard-program-analytics.html](demos/dashboard-program-analytics.html)

**Key Features:**
- Program delivery type filter (solves "lost e-mentoring" issue)
- Multi-dimensional filtering
- Geographic coverage map
- Capacity & demand metrics
- Demographics reach analysis
- Export filtered results

**Use Cases:** Finding e-mentoring programs, gap analysis, underserved regions

#### Dashboard 4: NQMS Assessment Status Overview
**File:** [dashboard-nqms-status.html](demos/dashboard-nqms-status.html)

**Key Features:**
- Assessment pipeline summary cards
- Visual funnel showing progression and drop-off rates
- Assessments needing attention with sortable table
- Progress bars and status badges
- Average completion time gauges
- Action buttons for reminders and reviews

**Use Cases:** NQMS pipeline monitoring, identifying stuck assessments, reviewer workload management

#### Dashboard 5: NQMS Impact & Outcomes
**File:** [dashboard-nqms-impact.html](demos/dashboard-nqms-impact.html)

**Key Features:**
- Program improvement summary metrics
- Longitudinal rating trends line chart
- Goal achievement scatter plot (improving vs. declining programs)
- Badge achievement trends over time
- Section-level improvement heatmap
- Export for research button with data dictionary

**Use Cases:** Demonstrating ROI to funders, strategic planning, research data export

#### Dashboard 6: User Activity & Engagement
**File:** [dashboard-user-activity.html](demos/dashboard-user-activity.html)

**Key Features:**
- Activity summary cards (7/30/90-day active users)
- Login frequency distribution histogram
- Inactive accounts alert table
- Never-logged-in users tracking
- Bulk account management actions
- CSV export

**Use Cases:** Account cleanup, re-engagement campaigns, post-training tracking

---

## Supporting Metrics Reference

### Key Metrics by Dashboard

**Dashboard 1: Program Health & Status**
- Active/Paused/Pending program counts
- Total youth served
- Geographic distribution
- Recent activity timeline

**Dashboard 2: Data Quality Monitoring**
- Programs not updated in 6/12 months
- Missing contact info, demographics, affiliates
- Logic inconsistencies (youth served = 0 + accepting mentees)
- Duplicate detection

**Dashboard 3: Program Analytics & Discovery**
- Programs by delivery type (Community/Site/E-mentoring)
- Programs by mentoring type and focus area
- Capacity utilization rate
- Geographic coverage gaps

**Dashboard 4: NQMS Assessment Status**
- Assessments by status (in-progress, pending review, completed)
- Average completion percentage
- Assessments stuck in progress (90+ days)
- Recent submissions

**Dashboard 5: NQMS Impact & Outcomes**
- % programs improving ratings in reassessment
- Average rating increase (percentage points)
- Goal achievement rate by section
- Longitudinal trends across assessment cycles

**Dashboard 6: User Activity & Engagement**
- Active users (7/30/90 days)
- Users never logged in
- Users inactive 90+ days
- Monthly active user trends

---

## Summary Statistics

**Total High-Impact Dashboards:** 6
- **Programs:** 3 dashboards (Health Overview, Data Quality, Analytics & Discovery)
- **NQMS Assessments:** 2 dashboards (Status Overview, Impact & Outcomes)
- **Users/Accounts:** 1 dashboard (Activity & Engagement)

**Interactive Demos Available:** 6 dashboards (100% coverage)
- Dashboard 1: Program Health & Status Overview ✅
- Dashboard 2: Data Quality Monitoring ✅
- Dashboard 3: Program Analytics & Discovery ✅
- Dashboard 4: NQMS Assessment Status Overview ✅
- Dashboard 5: NQMS Impact & Outcomes ✅
- Dashboard 6: User Activity & Engagement ✅

**Expected Impact:**
- **Data Quality:** Unblocks Data Cleanup Initiative, identifies stale/incomplete data
- **Visibility Gaps:** Solves "lost e-mentoring programs" issue (750+ programs)
- **Strategic Value:** Demonstrates measurable ROI to funders (Dashboard 5)
- **Operational Efficiency:** Enables user account cleanup, NQMS pipeline monitoring

---

## Change Log

| Date | Change | Author |
|------|--------|--------|
| January 21, 2026 | Initial document with 17 dashboard concepts | Aksana Rahouski |
| January 22, 2026 | Added interactive demos for Dashboards 2, 3, 13, 16 | Aksana Rahouski |
| January 27, 2026 | Ruthlessly prioritized to 6 high-impact dashboards based on business value and operational necessity. Removed 11 lower-priority dashboards. | Aksana Rahouski |
| January 27, 2026 | Created interactive demos for remaining dashboards (1, 4, 5). All 6 high-impact dashboards now have full interactive HTML demos (100% coverage). | Aksana Rahouski |
| January 28, 2026 | Renumbered dashboards sequentially 1-6 for clarity (Dashboard 8→4, Dashboard 11→5, Dashboard 13→6). | Aksana Rahouski |

---

**End of Document**
