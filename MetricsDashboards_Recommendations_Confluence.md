# Metrics & Dashboards Recommendations for Mentor Connector

**Initiative Type:** Data Analytics & Visibility Enhancement
**Priority Level:** High Value / Strategic Foundation
**Status:** Recommendations - Planning Phase
**Created:** January 21, 2026
**Last Updated:** January 21, 2026

---

## Executive Summary

This document outlines comprehensive recommendations for metrics and dashboards across four core data entities in the Mentor Connector platform: **Programs**, **Affiliates**, **NQMS Assessments**, and **Accounts (Users)**. These recommendations are based on:

1. Detailed analysis of existing data models and relationships
2. Current reporting capabilities and gaps
3. Enhancement priorities identified in LowHangingFruit_SystemEnhancements.md
4. Best practices for data quality monitoring and operational dashboards

The recommendations are organized by entity, with each section including:
- **Operational Metrics** - Day-to-day monitoring and management
- **Data Quality Metrics** - Health and hygiene of data
- **Strategic/Analytics Metrics** - Long-term trends and insights
- **Dashboard Concepts** - Specific dashboard designs with visual components

---

## Table of Contents

1. [Programs Metrics & Dashboards](#1-programs-metrics--dashboards)
2. [Affiliates Metrics & Dashboards](#2-affiliates-metrics--dashboards)
3. [NQMS Assessments Metrics & Dashboards](#3-nqms-assessments-metrics--dashboards)
4. [Accounts/Users Metrics & Dashboards](#4-accountsusers-metrics--dashboards)
5. [Cross-Entity Dashboards](#5-cross-entity-dashboards)
6. [Implementation Priorities](#6-implementation-priorities)
7. [Technical Considerations](#7-technical-considerations)

---

## 1. Programs Metrics & Dashboards

### 1.1 Operational Metrics

#### Program Status & Health
- **Active Programs Count** - Total programs with status = 'approved'
- **Paused Programs Count** - Programs temporarily inactive
- **Pending Programs Count** - Awaiting approval
- **Deleted Programs Count** - Historical record
- **Programs by Status (%)** - Distribution pie chart

#### Program Capacity Tracking
- **Total Youth Served** - SUM(youth_served) across all active programs
- **Total Youth Waiting** - SUM(youth_waiting) across all active programs
- **Capacity Utilization Rate** - Served / (Served + Waiting) percentage
- **Programs Accepting Mentees** - COUNT where accepting_mentees = true
- **Programs Accepting Mentors** - COUNT where accepting_mentors = true
- **Average Youth Served per Program** - Mean, median, and mode
- **Average Waitlist per Program** - Mean, median, distribution

#### Program Activity & Engagement
- **Inquiry Conversion Rate** - Contacted / Total inquiries (%)
- **Average Inquiries per Program** - total_inquiry_count statistics
- **Programs with Uncontacted Inquiries** - COUNT where inquiry_uncontacted_count > 0
- **Top Programs by Inquiries** - Ranking of programs receiving most interest
- **Programs with No Recent Inquiries** - No inquiries in past 6/12 months

#### Program Profile Completeness
- **Profiles with Missing Data** - Key fields null (description, contact info, etc.)
- **Programs with Photos/Logos** - Percentage with visual assets
- **Programs with Complete Demographics** - All mentee/mentor age, gender fields populated
- **Programs with Service Locations** - COUNT with at least 1 program_location

#### Geographic Distribution
- **Programs by State** - Choropleth map or bar chart
- **Programs by City** - Top 20 cities
- **Programs by ZIP Code Coverage** - Heatmap
- **Geographic Gaps** - States/regions with low coverage

### 1.2 Data Quality Metrics

#### Stale Data Detection
- **Programs Not Updated in 6 Months** - COUNT where modified < 6 months ago
- **Programs Not Updated in 12 Months** - COUNT where modified < 12 months ago
- **Programs Never Logged Into** - Programs where all users have last_login IS NULL
- **Average Days Since Last Update** - Age distribution chart

#### Missing Critical Data
- **Programs Missing Affiliate Assignment** - COUNT where no affiliate service area match
- **Programs Missing Contact Information** - Email or phone null
- **Programs Missing Program Type** - No mentoring_types selected
- **Programs Missing Demographics** - No ages, genders, or categories selected
- **Programs with Incomplete Addresses** - Missing city, state, or ZIP

#### Data Consistency Issues
- **Programs with Youth Served = 0 and Accepting Mentees** - Logic inconsistency flag
- **Programs with Waitlist > Youth Served** - Possible data quality issue
- **Duplicate Program Names** - Similar or exact name matches
- **Programs with Conflicting Service Types** - Invalid combination flags

### 1.3 Strategic/Analytics Metrics

#### Program Type & Delivery Analysis
- **Programs by Delivery Type** - Community-based vs. Site-based vs. E-mentoring
  - **CRITICAL GAP**: Currently no filter or dashboard for Program Delivery type
  - E-mentoring programs get "lost" without this visibility
- **Programs by Mentoring Type** - 1-to-1, Group, Peer, Team, etc.
- **Programs by Focus Area** - Academic, career, social-emotional, etc.
- **Hybrid Service Models** - Programs offering multiple delivery types

#### Demographic Reach Analysis
- **Youth Demographics Served** - Aggregated mentee ages, genders, categories
- **Mentor Demographics** - Aggregated mentor ages, genders
- **Family Structures Served** - Single parent, two-parent, foster, etc.
- **Grade Levels Served** - Elementary, middle, high school distribution
- **Underserved Populations** - Special populations and categories

#### Capacity & Demand Trends
- **Capacity Growth Over Time** - Youth served trend line (monthly/quarterly)
- **Waitlist Trends** - Youth waiting trend line
- **Inquiry Trends** - Seasonal patterns (peak Aug-Oct)
- **Program Growth Rate** - New programs per month/quarter/year

#### Badge & Recognition Analytics
- **Programs by Badge Count** - Distribution histogram
- **Most Common Badges Earned** - Top badges across all programs
- **Programs with No Badges** - Opportunity for engagement
- **Badge Achievement Rate** - Percentage of NQMS-ready programs with badges

### 1.4 Dashboard Concepts

#### **Dashboard 1: Program Health & Status Overview**
**Audience:** Global Admins, Affiliate Admins
**Purpose:** At-a-glance operational status

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

#### **Dashboard 4: Inquiry & Engagement Tracking**
**Audience:** Program Admins, Affiliate Admins
**Purpose:** Monitor inquiry activity and conversion

**Components:**
1. **Inquiry Summary Cards**
   - Total Inquiries (All Time)
   - Inquiries This Month
   - Average Response Rate
   - Inquiries Pending Response

2. **Inquiry Trends**
   - Line chart: Inquiries per month (shows Aug-Oct seasonal peak)
   - Comparison to prior year

3. **Top Programs by Inquiries**
   - Ranked table: Program name, total inquiries, contacted %, uncontacted count
   - Action: Quick link to contact uncontacted inquiries

4. **Inquiry Response Performance**
   - Programs with 100% contact rate (highlight top performers)
   - Programs with uncontacted inquiries (needs attention)
   - Average days to first contact (if timestamp available)

5. **Inquiry Source Analysis** (if source tracking available)
   - Where inquiries originate (web search, referral, social media, etc.)

---

## 2. Affiliates Metrics & Dashboards

### 2.1 Operational Metrics

#### Affiliate Status & Coverage
- **Total Active Affiliates** - COUNT where active = true
- **Inactive Affiliates** - COUNT where active = false
- **Trained Affiliates** - COUNT where trained = true
- **Affiliates Needing Training** - COUNT where trained = false
- **Affiliates by Country** - Geographic distribution

#### Affiliate Capacity & Reach
- **Programs per Affiliate** - AVG, MIN, MAX, distribution
- **Geographic Service Area Coverage** - ZIP codes per affiliate
- **States Covered per Affiliate** - Multi-state affiliates identification
- **Affiliates with No Programs** - COUNT where 0 programs assigned

#### User Assignment Metrics
- **Users per Affiliate** - AVG, MIN, MAX
- **Affiliates with No Users** - Orphaned affiliates
- **User Access Level Distribution**
  - Full Access users count
  - MC-Only users count
  - NQMS-Only users count
- **Limited Contractor Count** - Users with is_limited_contractor flag

#### Program Access Scope Analysis
- **Affiliates Using "All Programs" Scope** - COUNT scope = 'all_programs'
- **Affiliates Using "Specific Programs" Scope** - COUNT scope = 'specific_programs'
- **Average Programs per Specific-Scope User** - From affiliates_users_programs

### 2.2 Data Quality Metrics

#### Missing Critical Data
- **Affiliates Missing Contact Information** - Phone, email, or address null
- **Affiliates Missing Programmatic Contact** - programmatic_contact_id IS NULL
- **Affiliates Missing Global Admin** - global_admin_user_id IS NULL
- **Affiliates with No Service Areas** - No ZIP codes assigned

#### Stale Affiliate Records
- **Affiliates Not Updated in 12 Months** - modified < 12 months
- **Affiliates with No Recent Program Activity** - All programs paused/deleted

#### Data Consistency Issues
- **Active Affiliates with No Active Programs** - All programs paused/deleted
- **Inactive Affiliates with Active Programs** - Status mismatch
- **Service Area Overlaps** - ZIP codes assigned to multiple affiliates

### 2.3 Strategic/Analytics Metrics

#### Affiliate Network Analysis
- **Affiliate Growth Over Time** - New affiliates per quarter/year
- **Geographic Expansion Trends** - New states/regions covered
- **Service Area Density** - ZIP codes per affiliate over time

#### Affiliate Performance & Engagement
- **Programs per Affiliate Trend** - Growth or decline in portfolio
- **Average NQMS Participation Rate** - % of affiliate programs in NQMS
- **Badge Achievement by Affiliate** - Total badges earned by affiliate programs
- **Assessment Completion Rate by Affiliate** - % of programs with completed assessments

#### User Engagement
- **Active User Rate** - % of affiliate users who logged in past 30 days
- **User Turnover** - New users vs. disabled users over time
- **Multi-Affiliate Users** - Users assigned to multiple affiliates

### 2.4 Dashboard Concepts

#### **Dashboard 5: Affiliate Network Overview**
**Audience:** Global Admins
**Purpose:** Monitor affiliate network health

**Components:**
1. **Network Summary Cards**
   - Total Active Affiliates
   - Total Inactive Affiliates
   - Affiliates Needing Training
   - Geographic Coverage (states count)

2. **Affiliate Status Distribution**
   - Pie chart: Active vs. Inactive
   - Bar chart: Trained vs. Not Trained

3. **Top Affiliates by Program Count**
   - Ranked table: Affiliate name, program count, active programs %
   - Click-through to affiliate detail

4. **Geographic Coverage Map**
   - USA map showing states with affiliate coverage
   - Identify states with no affiliate (gap analysis)

5. **Service Area Overlap Analysis**
   - Table showing ZIP codes assigned to multiple affiliates
   - Flag potential conflicts

---

#### **Dashboard 6: Affiliate Data Quality Monitor**
**Audience:** Global Admins, Data Stewards
**Purpose:** Identify affiliate records needing cleanup

**Components:**
1. **Data Completeness Summary**
   - % of affiliates with complete contact info
   - % with assigned programmatic contact
   - % with assigned global admin
   - % with service areas defined

2. **Affiliates Needing Attention (Table)**

| Affiliate Name | Missing Data | Last Updated | Action |
|----------------|--------------|--------------|--------|
| XYZ Affiliate | Contact info, Service areas | 18 months ago | [Edit] |

3. **Stale Affiliate Records**
   - Count not updated in 12+ months
   - List with last modified date

4. **Active Affiliates with No Active Programs**
   - List of affiliates with only paused/deleted programs
   - Recommendation: Deactivate or investigate

---

#### **Dashboard 7: Affiliate User Access Management**
**Audience:** Global Admins, Affiliate Admins
**Purpose:** Monitor user assignments and access levels

**Components:**
1. **User Assignment Summary**
   - Total users assigned to affiliates
   - Average users per affiliate
   - Affiliates with no users (alert)

2. **Access Level Distribution**
   - Stacked bar chart per affiliate:
     - Full Access users
     - MC-Only users
     - NQMS-Only users
     - Limited Contractors

3. **Program Access Scope Breakdown**
   - Pie chart: All Programs scope vs. Specific Programs scope
   - Table: Affiliates using specific programs with program count

4. **User Activity by Affiliate**
   - % of affiliate users who logged in past 30 days
   - Inactive user alert (no login in 90+ days)

5. **Cross-Affiliate User Analysis**
   - Users assigned to multiple affiliates (table)
   - Potential permission conflicts or consulting relationships

---

## 3. NQMS Assessments Metrics & Dashboards

### 3.1 Operational Metrics

#### Assessment Status & Completion
- **Total Assessments** - All assessments in system
- **In-Progress Assessments** - COUNT where status = 'in-progress'
- **Pending Review Assessments** - COUNT where status = 'pending-review'
- **Completed Assessments** - COUNT where status = 'completed'
- **Goals Completed Assessments** - COUNT where status = 'goal_completed'
- **Assessment Completion Rate** - Completed / Total (%)

#### Assessment Progress Tracking
- **Average Completion Percentage** - AVG(questions_answered / questions_total) across all assessments
- **Assessments Stuck in Progress** - In-progress for > 90 days
- **Assessments Awaiting Review** - Pending-review for > 30 days
- **Recently Submitted Assessments** - Submitted in past 7 days

#### Question Response Analytics
- **Questions with Highest N/A Rate** - % of programs marking as not applicable
- **Questions with Lowest Average Rating** - Identify common challenge areas
- **Questions with Highest Average Rating** - Identify strengths
- **Rating Distribution per Question** - Histogram (0-5 + N/A)

### 3.2 Data Quality Metrics

#### Assessment Data Completeness
- **Assessments with Incomplete Responses** - questions_answered < questions_total
- **Responses Missing Notes** - COUNT where notes IS NULL or empty
- **Approved Ratings Diverging from Self-Ratings** - approved_rating != rating_scale

#### Assessment Lifecycle Issues
- **Assessments Never Submitted** - Created > 6 months ago, still in-progress
- **Assessments Approved but No Goals Set** - Completed with 0 goals
- **Orphaned Assessments** - Program deleted but assessment remains

#### Goal Data Quality
- **Goals Missing Start Date** - COUNT where start_date IS NULL
- **Goals Missing Target Date** - COUNT where target_completion_date IS NULL
- **Goals with Target < Baseline** - Invalid target_score < score
- **Goals Overdue** - target_completion_date < today and not completed

### 3.3 Strategic/Analytics Metrics

#### Assessment Participation & Adoption
- **NQMS Participation Rate** - Programs with assessments / Total programs (%)
- **First-Time Assessment Programs** - Programs with 1 assessment
- **Repeat Assessment Programs** - Programs with 2+ assessments (historical cycles)
- **NQMS-Ready Programs Not Participating** - is_nqms_ready = true, no assessment

#### Assessment Performance Trends
- **Average Question Rating Over Time** - Trend line showing improvement
- **Rating Improvement by Section** - Comparison of baseline vs. follow-up assessments
- **Programs Improving Ratings** - COUNT where approved_rating increased in reassessment
- **Programs with Declining Ratings** - Alert for programs trending downward

#### Goal Achievement Analytics
- **Overall Goal Completion Rate** - Completed goals / Total goals (%)
- **Goal Completion Rate by Section** - Which NQMS sections have highest success
- **Average Achievement Score** - Mean achieved_score across all completed goals
- **Goals Exceeding Targets** - achieved_score > target_score (COUNT + %)
- **Goals Partially Achieved** - score < achieved_score < target_score
- **Goals Not Achieved** - achieved_score <= score

#### Time-Based Metrics
- **Average Days to Complete Assessment** - approved_on - created
- **Average Days in Review** - approved_on - submitted_for_review_date
- **Average Days to Achieve Goal** - Time from start_date to achieved goal
- **Assessment Age Distribution** - Histogram of assessment age

#### Badge Achievement Analytics
- **Badge Earn Rate** - Programs earning badges / Programs with assessments (%)
- **Most Common Badges Earned** - Ranking
- **Badges per Program** - AVG, distribution
- **Badge Trends Over Time** - New badges earned per quarter

### 3.4 Dashboard Concepts

#### **Dashboard 8: NQMS Assessment Status Overview**
**Audience:** Global Admins, Affiliate Admins, NQMS Staff
**Purpose:** Monitor assessment pipeline and completion

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

#### **Dashboard 9: NQMS Question & Rating Analysis**
**Audience:** NQMS Research Staff, Strategic Planning
**Purpose:** Identify trends and challenge areas across programs

**Components:**
1. **Overall Rating Summary**
   - Average rating across all questions: [X.XX / 5.0]
   - Trend: [↑ Improving | → Stable | ↓ Declining]

2. **Rating Distribution Histogram**
   - X-axis: Rating (0, 1, 2, 3, 4, 5, N/A)
   - Y-axis: Response count
   - Shows overall distribution pattern

3. **Top Challenge Areas**
   - Table: Questions with lowest average ratings
   - Columns: Section, Question, Avg Rating, % N/A, Programs Responding

4. **Top Strength Areas**
   - Table: Questions with highest average ratings
   - Opportunity to highlight best practices

5. **Rating Trends by Section**
   - Line chart: Average section ratings over time (if multiple assessment cycles)
   - Identify improving vs. declining sections

6. **N/A Response Analysis**
   - Questions with highest N/A rate (may indicate irrelevance or confusion)
   - Programs with high N/A count (may need guidance)

---

#### **Dashboard 10: Goals Tracking & Achievement**
**Audience:** Program Admins, Affiliate Admins, NQMS Staff
**Purpose:** Monitor goal-setting and achievement

**Components:**
1. **Goal Achievement Summary (Cards)**
   - Total Goals Set
   - Goals Completed (count + %)
   - Goals In Progress
   - Goals Overdue

2. **Goal Completion Rate by Section**
   - Bar chart: % of goals completed per NQMS section
   - Identify sections with high/low success rates

3. **Goal Achievement Funnel**
   - Goals Set → Started → Partially Achieved → Fully Achieved → Exceeded Target
   - Shows progression and success rates

4. **Goals Performance Table**

| Section | Question | Total Goals | Completed | Avg Baseline | Avg Target | Avg Achieved |
|---------|----------|-------------|-----------|--------------|------------|--------------|

5. **Overdue Goals Alert**
   - List of goals past target_completion_date
   - Filter by program, affiliate, section

6. **Goal Timeline View**
   - Gantt chart: Goals with start_date and target_completion_date
   - Color coding: Completed (green), In Progress (yellow), Overdue (red)

7. **Achievement Score Distribution**
   - Histogram showing achieved_score distribution
   - Comparison to baseline and target scores

---

#### **Dashboard 11: NQMS Impact & Outcomes** ⭐ **STRATEGIC - HIGH VALUE**
**Audience:** Funders, Executive Leadership, Research Teams
**Purpose:** Demonstrate measurable impact and improvement over time

**Components:**
1. **Program Improvement Summary**
   - % of programs improving ratings in reassessment
   - Average rating increase (percentage points)
   - Total goals achieved across network

2. **Longitudinal Rating Trends** (Requires Assessment History - Enhancement #24)
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

6. **Export for Research** (Enhancement #25 - CRITICAL)
   - Button: "Export All Assessment Data (Wide Format)"
   - Generates CSV with all assessment cycles, baseline/improved ratings
   - Includes data dictionary/codebook for researchers

---

## 4. Accounts/Users Metrics & Dashboards

### 4.1 Operational Metrics

#### User Account Status
- **Total User Accounts** - All users in system
- **Active User Accounts** - is_active = true
- **Inactive User Accounts** - is_active = false
- **Verified User Accounts** - is_verified = true
- **Unverified User Accounts** - is_verified = false
- **Superuser Accounts** - is_superuser = true

#### User Role Distribution
- **Program Admins** - Users with program assignments
- **Affiliate Admins** - Users with affiliate assignments
- **Full Access Users** - access_level = 1
- **MC-Only Users** - access_level = 2
- **NQMS-Only Users** - access_level = 3
- **Limited Contractors** - is_limited_contractor = true
- **Multi-Role Users** - Users with both program AND affiliate assignments

#### User Activity Metrics
- **Users Logged In Past 7 Days** - Active user count
- **Users Logged In Past 30 Days** - Monthly active users
- **Users Logged In Past 90 Days** - Quarterly active users
- **Users Never Logged In** - last_login IS NULL
- **Average Logins per User** (if login count tracked)

### 4.2 Data Quality Metrics

#### Account Data Completeness
- **Users Missing Profile Information** - UserProfiles NULL or incomplete
- **Users Missing ZIP Code** - zipcode IS NULL in profiles
- **Users Missing Phone Number** - phone_number IS NULL
- **Users with No Program or Affiliate Assignment** - Orphaned users

#### Inactive & Stale Accounts
- **Users Not Logged In for 90+ Days** - Inactive account threshold
- **Users Not Logged In for 180+ Days** - Likely abandoned accounts
- **Users Created but Never Logged In** - COUNT where last_login IS NULL
- **Accounts Older than 1 Year with No Activity** - Candidates for archival

#### Access & Permission Issues
- **Users with Conflicting Roles** - Logic conflicts in permissions
- **Users Assigned to Deleted Programs** - Orphaned program assignments
- **Users Assigned to Inactive Affiliates** - Orphaned affiliate assignments

### 4.3 Strategic/Analytics Metrics

#### User Growth & Turnover
- **New Users per Month/Quarter** - Growth trend
- **Disabled Users per Month/Quarter** - Turnover trend
- **User Churn Rate** - Disabled / Total (%)
- **User Retention Rate** - Active past 90 days / Total (%)

#### User Engagement Trends
- **Login Frequency Distribution** - Histogram of days since last login
- **User Engagement Score** - Composite metric (logins + updates + activity)
- **Peak Usage Times** - When users are most active (if timestamp data available)

#### Role & Permission Analytics
- **Role Distribution Over Time** - Stacked area chart showing role changes
- **Average Programs per Program Admin** - Workload distribution
- **Average Affiliates per Affiliate Admin** - Workload distribution
- **Scope Usage Trends** - All programs vs. Specific programs scope adoption

#### Training & Onboarding
- **Users Completing Onboarding** (if tracked) - Onboarding completion rate
- **Time to First Login** - Days from account creation to first login
- **Training Completion Rate** (if LMS integration exists - Enhancement #10)

### 4.4 Dashboard Concepts

#### **Dashboard 12: User Account Overview**
**Audience:** Global Admins
**Purpose:** Monitor user accounts and access

**Components:**
1. **Account Status Summary (Cards)**
   - Total Users
   - Active Users
   - Inactive Users
   - Unverified Users (needs action)

2. **User Role Distribution**
   - Pie chart: Program Admins / Affiliate Admins / Multi-Role / Superusers
   - Bar chart: Access level breakdown (Full / MC-Only / NQMS-Only)

3. **Recent User Activity**
   - Table: Last 20 user logins with timestamp
   - New user registrations (past 7 days)
   - Recently disabled accounts

4. **Users by Organization**
   - Stacked bar chart: Users per affiliate
   - Programs with no assigned users (alert)

---

#### **Dashboard 13: User Activity & Engagement**
**Audience:** Global Admins, Training Staff
**Purpose:** Monitor user engagement and identify inactive accounts

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

#### **Dashboard 14: User Data Quality Monitor**
**Audience:** Global Admins, Data Stewards
**Purpose:** Identify user records needing cleanup

**Components:**
1. **Data Completeness Summary**
   - % with complete profile (ZIP, phone)
   - % with notification preferences set
   - % with at least one program or affiliate assignment

2. **Users Needing Attention (Table)**

| User Name | Email | Issue | Last Login | Action |
|-----------|-------|-------|------------|--------|
| John Doe | john@example.com | Missing profile | Never | [Edit] |
| Jane Smith | jane@example.com | No program/affiliate | 180 days ago | [Assign] |

3. **Orphaned User Assignments**
   - Users assigned to deleted programs (COUNT)
   - Users assigned to inactive affiliates (COUNT)
   - Action: Reassign or disable

4. **Duplicate Email Detection**
   - Flag potential duplicate accounts (similar names + emails)

---

## 5. Cross-Entity Dashboards

These dashboards combine metrics from multiple entities for holistic views.

### **Dashboard 15: Executive Summary Dashboard**
**Audience:** Executive Leadership, Board
**Purpose:** High-level overview of platform health and impact

**Components:**
1. **Network Overview (Cards)**
   - Total Programs (Active)
   - Total Affiliates (Active)
   - Total Youth Served
   - Total Users

2. **Assessment Impact Summary**
   - Programs Participating in NQMS
   - Total Assessments Completed
   - Average Quality Rating Improvement
   - Total Goals Achieved

3. **Geographic Reach Map**
   - USA map showing program density by state
   - Overlay: Affiliate coverage

4. **Inquiry & Engagement Trends**
   - Line chart: Monthly inquiries
   - Line chart: Monthly active users

5. **Key Performance Indicators (KPIs)**
   - Assessment Completion Rate: [XX%]
   - Goal Achievement Rate: [XX%]
   - Program Profile Completeness: [XX%]
   - User Engagement Rate: [XX%]

---

### **Dashboard 16: Data Health Scorecard**
**Audience:** Global Admins, Data Stewards
**Purpose:** Comprehensive data quality monitoring

**Components:**
1. **Overall Data Health Score**
   - Large gauge: [0-100] score
   - Composite of all data quality metrics
   - Trend: Improving / Stable / Declining

2. **Entity-Level Health Scores**
   - Programs: [XX/100]
   - Affiliates: [XX/100]
   - Assessments: [XX/100]
   - Users: [XX/100]

3. **Critical Issues Summary**
   - Programs not updated in 12+ months: [count]
   - Assessments stuck in progress: [count]
   - Users never logged in: [count]
   - Missing affiliate assignments: [count]

4. **Automated Cleanup Recommendations**
   - Action items prioritized by impact
   - Estimated time to resolve
   - One-click bulk actions where appropriate

---

### **Dashboard 17: Affiliate Performance Scorecard**
**Audience:** Affiliate Admins, Global Admins
**Purpose:** Compare affiliate performance and identify best practices

**Components:**
1. **Affiliate Comparison Table**

| Affiliate | Programs | Active % | NQMS Participation | Avg Assessment Rating | Goals Achieved | Data Completeness |
|-----------|----------|----------|---------------------|------------------------|----------------|-------------------|

2. **Top Performing Affiliates**
   - Ranked by composite score
   - Highlight best practices

3. **Affiliates Needing Support**
   - Below-average performance indicators
   - Recommendations for improvement

4. **Benchmarking Charts**
   - Box plots: Programs per affiliate (identify outliers)
   - Box plots: Assessment ratings by affiliate
   - Box plots: Goal achievement rates

---

## 6. Implementation Priorities

### Tier 1: Critical / Quick Wins (Immediate Implementation)

**These align with "High Value / Quick Wins" from LowHangingFruit_SystemEnhancements.md**

1. **Dashboard 2: Data Quality Monitoring** (Programs)
   - **Why:** Addresses Enhancement #3 (Admin Dashboards) and #1 (User Activity Tracking)
   - **Impact:** Enables data cleanup initiative (Stream 2)
   - **Complexity:** Medium - Uses existing data, new aggregation queries
   - **Timeline:** 2-4 weeks

2. **Dashboard 3: Program Analytics & Discovery** - Delivery Type Component
   - **Why:** Addresses Enhancement #29 Phase 1 (Program Delivery filter)
   - **Impact:** Prevents e-mentoring programs from getting "lost"
   - **Complexity:** Low - Add filter to existing browse programs
   - **Timeline:** 1 week

3. **Dashboard 13: User Activity & Engagement**
   - **Why:** Addresses Enhancement #1 (User Activity Tracking, Export Capabilities)
   - **Impact:** Identifies inactive accounts for cleanup
   - **Complexity:** Low - last_login field already exists
   - **Timeline:** 1-2 weeks

4. **Dashboard 16: Data Health Scorecard** (Cross-Entity)
   - **Why:** Consolidates data quality metrics from all entities
   - **Impact:** Single pane of glass for data stewardship
   - **Complexity:** Medium - Aggregates from multiple dashboards
   - **Timeline:** 2-3 weeks

### Tier 2: High Value / Medium Complexity (Near-Term)

5. **Dashboard 1: Program Health & Status Overview**
   - **Why:** Landing page improvement (Enhancement #3)
   - **Impact:** Improved visibility for all admin users
   - **Complexity:** Medium - New UI design needed
   - **Timeline:** 3-4 weeks

6. **Dashboard 8: NQMS Assessment Status Overview**
   - **Why:** Assessment workflow visibility (Enhancement #18)
   - **Impact:** Monitors assessment pipeline
   - **Complexity:** Medium - Uses existing data
   - **Timeline:** 2-3 weeks

7. **Dashboard 10: Goals Tracking & Achievement**
   - **Why:** Goal management visibility
   - **Impact:** Operational monitoring for goal progress
   - **Complexity:** Medium - Goal data model already robust
   - **Timeline:** 2-3 weeks

8. **Dashboard 5: Affiliate Network Overview**
   - **Why:** Affiliate visibility and management
   - **Impact:** Identify coverage gaps
   - **Complexity:** Medium
   - **Timeline:** 2-3 weeks

### Tier 3: Strategic / Long-Term (Requires Enhancements)

9. **Dashboard 11: NQMS Impact & Outcomes** ⭐
   - **Why:** Critical for funders (Enhancement #28 - Strategic Initiative)
   - **Impact:** Demonstrates measurable impact
   - **Dependencies:**
     - Enhancement #24: Assessment History & Versioning
     - Enhancement #25: Full Data Export for Research
   - **Complexity:** HIGH - Requires assessment archival, longitudinal tracking
   - **Timeline:** 8-12 weeks after dependencies complete

10. **Dashboard 9: NQMS Question & Rating Analysis**
    - **Why:** Research and strategic planning
    - **Impact:** Identify trends and challenge areas
    - **Dependencies:** Multiple assessment cycles data
    - **Complexity:** Medium-High
    - **Timeline:** 4-6 weeks

11. **Dashboard 17: Affiliate Performance Scorecard**
    - **Why:** Benchmarking and best practice identification
    - **Impact:** Improve network performance
    - **Complexity:** Medium-High - Composite scoring logic
    - **Timeline:** 4-6 weeks

### Tier 4: Nice to Have / Lower Priority

12. **Dashboard 4: Inquiry & Engagement Tracking**
    - **Why:** Monitors inquiry conversion
    - **Impact:** Operational improvement
    - **Complexity:** Low-Medium
    - **Timeline:** 2-3 weeks

13. **Dashboard 6: Affiliate Data Quality Monitor**
    - **Why:** Affiliate record cleanup
    - **Impact:** Lower priority than program data quality
    - **Complexity:** Low-Medium
    - **Timeline:** 2 weeks

14. **Dashboard 7: Affiliate User Access Management**
    - **Why:** Permission management
    - **Impact:** Admin tool for user assignment review
    - **Complexity:** Medium
    - **Timeline:** 3 weeks

15. **Dashboard 12: User Account Overview**
    - **Why:** User management
    - **Impact:** Operational visibility
    - **Complexity:** Low
    - **Timeline:** 1-2 weeks

16. **Dashboard 14: User Data Quality Monitor**
    - **Why:** User record cleanup
    - **Impact:** Lower priority
    - **Complexity:** Low
    - **Timeline:** 1-2 weeks

17. **Dashboard 15: Executive Summary Dashboard**
    - **Why:** High-level KPIs
    - **Impact:** Executive visibility
    - **Complexity:** Medium - Aggregates from multiple sources
    - **Timeline:** 3-4 weeks

---

## 7. Technical Considerations

### 7.1 Data Aggregation & Performance

**Query Optimization:**
- Use counter cache fields where available (questions_total_count, questions_answered_count)
- Implement query caching for expensive aggregations (15-minute cache recommended)
- Consider materialized views for complex cross-entity metrics
- Use database indexing on frequently filtered columns (status, created, modified, last_login)

**Pagination & Limits:**
- Dashboard widgets should load incrementally (top 10, top 20, etc.)
- Implement "Load More" or pagination for detailed tables
- Use AJAX for drill-down views to avoid full page reloads

**Real-Time vs. Batch:**
- Real-time: Status counts, recent activity (lightweight queries)
- Batch/Scheduled: Aggregated analytics, trend calculations (heavy queries run nightly/hourly)

### 7.2 Filtering & Permissions

**Filter Persistence:**
- Use session storage for filter state (existing pattern in Reports plugin)
- Allow saving custom filter presets
- Global filters apply across related dashboards

**Permission-Based Data Access:**
- Superusers see all data
- Affiliate Admins filtered to their affiliate's programs/users
- Program Admins filtered to their assigned programs
- Respect access_level restrictions (MC-Only, NQMS-Only)

### 7.3 Export Capabilities

**CSV Export:**
- All dashboard tables should support CSV export
- Include filter criteria in export header (existing pattern)
- Auto-generate descriptive filenames with timestamps

**Scheduled Reports:**
- Email digest option (weekly/monthly summary reports)
- Subscribe to specific dashboards or metrics
- Alert notifications when thresholds exceeded

### 7.4 Visualization Libraries

**Recommended:**
- **Chart.js** - Lightweight, flexible, responsive charts
- **D3.js** - For complex custom visualizations (maps, network graphs)
- **DataTables** - For sortable, filterable data tables with export
- **Leaflet** - For interactive geographic maps

**Accessibility:**
- All charts must have alt text and data tables for screen readers
- Color schemes must meet WCAG AA contrast requirements
- Keyboard navigation support

### 7.5 Mobile Responsiveness

**Design Principles:**
- Mobile-first dashboard design
- Stack cards vertically on small screens
- Collapsible sections for detail views
- Touch-friendly controls (buttons, filters)

### 7.6 Alert & Notification System

**Threshold-Based Alerts:**
- Configure thresholds for each metric (e.g., programs not updated > 180 days)
- Visual indicators: Red (critical), Yellow (warning), Green (healthy)
- Email notifications when thresholds exceeded (optional, user preference)

**Alert Types:**
- **Critical:** Data quality issues requiring immediate attention
- **Warning:** Trends indicating potential issues
- **Info:** General status updates

---

## 8. Related Enhancements & Dependencies

### Enhances These Low-Hanging Fruit Items:

- **#3: Dashboard Improvements & Data Quality Monitoring** - PRIMARY
- **#1: User Account Management** - Export capabilities, last login tracking
- **#2: Export Capabilities** - CSV exports from all dashboards
- **#29: Program Analytics & Visibility Dashboard** - Phase 2-3 full analytics
- **#6: Program Search & Discovery Enhancements** - Filtering by delivery type

### Dependencies on Other Enhancements:

- **#24: Assessment History & Versioning** - Required for Dashboard 11 (Impact & Outcomes)
- **#25: Full Data Export for Research** - Required for comprehensive NQMS analytics
- **#5: QMS Multi-Assessment Support** - Enables longitudinal trend analysis
- **#10: LMS Integration** - Enables training completion metrics

### Supports These Strategic Initiatives:

- **Stream 2: Data Cleanup Strategy** - Dashboards enable identification of cleanup targets
- **Stream 3: Long-Term Vision** - Analytics demonstrate platform value and ROI
- **#28: Analytics Dashboard (Strategic Initiative)** - Foundation for advanced analytics

---

## 9. Success Metrics for Dashboards

### Adoption Metrics
- **Dashboard Usage Rate** - % of admin users accessing dashboards monthly
- **Time Spent on Dashboards** - Average session duration
- **Most Viewed Dashboards** - Identify high-value dashboards

### Data Quality Improvement
- **Programs with Complete Data** - % increase over 6 months
- **Stale Data Reduction** - % decrease in programs not updated > 6 months
- **User Account Cleanup** - Inactive accounts disabled

### Operational Efficiency
- **Time to Identify Data Issues** - Reduction in manual review time
- **Support Request Reduction** - Fewer "how do I find..." questions
- **Data Export Utilization** - Increase in CSV exports for analysis

### Strategic Impact
- **Funders Engaged with Impact Data** - Usage of Dashboard 11 for grant reporting
- **Affiliate Performance Benchmarking** - Affiliates using scorecard for improvement
- **Executive Visibility** - Board/leadership reviewing summary dashboard

---

## 10. Next Steps & Recommendations

### Immediate Actions (Week 1-2):
1. **Review & Prioritize:** Stakeholder meeting to validate priorities
2. **User Research:** Interview 5-10 users per role (Global Admin, Affiliate Admin, Program Admin) to validate dashboard concepts
3. **Technical Scoping:** Database performance testing for aggregation queries
4. **Design Mockups:** Create wireframes for Tier 1 dashboards

### Short-Term (Months 1-3):
1. **Implement Tier 1 Dashboards** (4 dashboards)
2. **User Testing:** Beta test with 10-15 users, gather feedback
3. **Iterate:** Refine based on feedback
4. **Training Materials:** Create help documentation and video tutorials

### Medium-Term (Months 4-6):
1. **Implement Tier 2 Dashboards** (4 dashboards)
2. **Export Enhancements:** Ensure all tables have CSV export
3. **Alert System:** Implement threshold-based notifications
4. **Performance Optimization:** Caching, indexing, query optimization

### Long-Term (Months 7-12):
1. **Assessment History Integration:** Complete Enhancement #24
2. **Implement Dashboard 11 (Impact & Outcomes):** Critical for funders
3. **Comprehensive Data Export:** Complete Enhancement #25
4. **Advanced Analytics:** Predictive analytics, trend forecasting

---

## Summary Statistics

**Total Dashboard Concepts Proposed:** 17
- **Programs:** 4 dashboards
- **Affiliates:** 3 dashboards
- **NQMS Assessments:** 4 dashboards
- **Users/Accounts:** 3 dashboards
- **Cross-Entity:** 3 dashboards

**Total Metrics Categories:** 12
- Operational Metrics: 4 categories
- Data Quality Metrics: 4 categories
- Strategic/Analytics Metrics: 4 categories

**Implementation Tiers:**
- **Tier 1 (Critical / Quick Wins):** 4 dashboards (2-4 weeks each)
- **Tier 2 (High Value / Medium):** 4 dashboards (2-4 weeks each)
- **Tier 3 (Strategic / Long-Term):** 3 dashboards (4-12 weeks each)
- **Tier 4 (Nice to Have):** 6 dashboards (1-4 weeks each)

**Alignment with Low-Hanging Fruit:**
- Directly addresses: #1, #2, #3, #6, #29
- Dependencies: #5, #10, #24, #25
- Supports Strategic Initiatives: #28

**Expected Impact:**
- **Data Quality:** Automated identification of stale, incomplete, or inconsistent data
- **Operational Efficiency:** Reduced time to find programs/users needing attention
- **Strategic Insights:** Demonstrates measurable impact for funders and stakeholders
- **User Empowerment:** Self-service analytics reduces support burden

---

**Change Log:**

| Date | Change | Author |
|------|--------|--------|
| January 21, 2026 | Initial document creation with 17 dashboard concepts and comprehensive metrics | Aksana Rahouski |

---

**Interactive Dashboard Demos:**

Live HTML demos have been created for the four Tier 1 priority dashboards:
- Dashboard 2: Data Quality Monitoring
- Dashboard 3: Program Analytics & Discovery
- Dashboard 13: User Activity & Engagement
- Dashboard 16: Data Health Scorecard

Location: `/Users/aksana/Documents/Projects/Mentor/2026ScopeAlignment/demos/`

---

**End of Document**
