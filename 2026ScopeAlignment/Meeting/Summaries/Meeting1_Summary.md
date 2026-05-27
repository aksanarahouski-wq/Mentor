# 2026 Alignment Meeting Summary
**Date:** January 2026
**Attendees:** Aksana Rahouski, Hyun Masiello (Orases), Sandy Martins, Beth Tallarico, Mike Garringer, Tim Wills, Abbie Evans (Mentor National)

---

## Executive Summary

This initial alignment meeting focused on understanding Mentor National's 2026 strategic priorities for the Mentor Connector system and related technology initiatives. The discussion revealed three major strategic themes: evolving Mentor Connector from a volunteer recruitment tool into a comprehensive CRM platform, implementing data quality and cleanup initiatives, and establishing system integrations across the organization's technology ecosystem.

---

## Key Discussion Topics

### 1. Current Technology Landscape

**Systems in Use:**
- **Mentor Connector** - Program directory and volunteer matching
- **QMS** - Quality assessment tool
- **Dynamics** - CRM for individual/organization records (National only)
- **Salesforce** - Used for NMRC TA requests
- **Alchemer** - Survey/training evaluation tool
- **Mentor Hub** - Affiliate communication platform
- Additional affiliate-specific systems (monday.com, Excel spreadsheets, various Salesforce instances)

**Key Challenge:** Systems are siloed and don't communicate with each other, leading to data inconsistency and duplicated effort.

### 2. Mentor Connector Vision & Strategy

**Current State:**
- Originally built as a volunteer recruitment tool to connect potential mentors with programs
- Limited functionality beyond initial matching
- Programs have ~2,920 records, but affiliates collectively have access to ~6,000 programs not in the system
- Data quickly becomes outdated with no automated refresh mechanisms

**Desired Future State:**
- Evolve into a comprehensive national database and source of truth for mentoring programs
- Become an interactive CRM platform supporting full relationship lifecycle
- Support multiple use cases beyond volunteer recruitment (research, marketing, policy, training tracking, TA tracking)
- Enable affiliates to track all interactions with programs in one place
- Integrate with or replace affiliate-specific program databases

**Barriers to Adoption:**
- Affiliates maintain their own databases because that's where their work/services are tracked
- Mentor Connector only handles volunteer recruitment, not the full scope of affiliate work
- No incentive for programs to keep data current if they're not actively recruiting
- Turnover requires constant retraining on system usage

### 3. Data Quality & Cleanup Initiative

**Phase 1 (Q1 2026):**
- Focus on cleanup of approved programs only
- Affiliate-assisted review and validation
- Paused, pending, and deleted programs will be addressed in Phase 2

**Challenges Identified:**
- Manual effort required across multiple resources
- Can't control program admin turnover
- No visibility into who last logged in or updated records
- Export capabilities are limited on certain data sets
- No dashboards to identify stale or problematic data

**Proposed Solutions:**
- Automated reminders for programs that haven't updated in 6 months
- Admin dashboards showing programs needing attention
- Ability to pause programs automatically if inactive
- Enhanced export capabilities across all data types
- Tracking of user activity (last login, update history)

### 4. API & System Integration

**Integration Needs:**
- Connect Dynamics CRM with Mentor Connector
- Sync data with affiliate systems (primarily Salesforce, monday.com, Excel)
- Pull training data from Alchemer
- Connect Salesforce (NMRC) technical assistance tracking

**Technical Constraints:**
- Affiliates lack IT resources to build integration bridges on their end
- Most affiliates use off-the-shelf products (Salesforce, monday.com)
- Data structure varies across affiliate systems
- Majority of affiliates use Salesforce, some use monday.com, many use Excel

**Potential Approaches:**
- Build import/export functionality for standard formats
- API layer for pushing/pulling data where feasible
- Focus on one-way sync (affiliate systems → Mentor Connector) initially
- Leverage existing export capabilities from off-the-shelf tools

### 5. People vs. Programs Data

**Key Insight:**
- Mentor Connector is organizationally driven (program-centric)
- Much of Mentor's work is people-driven (training attendance, consulting with individuals)
- Need to bridge program and people data

**Ideal State:**
- Click on a program and see all staff members
- Click on a person and see their program affiliation, training history, TA requests
- May require separate systems that communicate via API rather than one mega-system

### 6. QMS Enhancements

**Immediate Need:**
- Programs approaching 3-year mark need to complete second assessments
- System currently doesn't support multiple assessments per program

**Requirements:**
- Ability to archive old assessments
- Start new assessment while maintaining history
- Reports and dashboards should pull from latest assessment only
- Clear workflow for closing one assessment and opening another

**Timeline:** This is a ticking clock item - needed soon as early adopters reach reassessment window

### 7. Training & Support

**Current Challenges:**
- Training is manual and inconsistent (quarterly, bi-annual, or ad-hoc)
- Resources exist on external website, not within system
- Users often need hands-on support rather than reading documentation
- Turnover requires constant retraining
- Support is bottlenecked through limited team members

**Desired State:**
- Automated learning management system (LMS) integration
- Resources available within Mentor Connector itself
- Potentially AI-powered help/chatbot for common questions
- Training courses in Brightspace LMS (currently exploring with Jake)
- Skill checks and verification of training completion

### 8. Low-Hanging Fruit / System Enhancements

**Section 9 Items Discussed:**
- Unable to delete old user accounts
- Can't export user account data with last login timestamps
- Limited export options across various data types
- No dashboards for data quality monitoring
- Missing activity tracking (who updated what, when)
- Inconsistent UI patterns (filters should be collapsible accordions)
- Missing breadcrumb navigation in some areas

**Philosophy:** Focus on improving existing functionality before major new builds

---

## Priority Areas Identified

### Top 3 Focus Areas (No particular order):

1. **Data Cleanup & Quality**
   - Critical foundation for positioning system as reliable source of truth
   - Needed regardless of future direction

2. **System Direction & Vision**
   - Decide: Build Mentor Connector into full CRM vs. integrate with existing systems
   - Determine scope of interactive engagement features
   - Define relationship between program data and people data

3. **Low-Hanging Fruit / Quick Wins**
   - QMS multi-assessment support (time-sensitive)
   - Enhanced exports and admin dashboards
   - UI consistency improvements
   - User account management improvements

---

## Next Steps

### Immediate Actions:

1. **Orases Team:**
   - Compile comprehensive list of identified system improvements
   - Combine Orases backlog with Mentor's Section 9 requirements
   - Provide database reports (total programs, data quality metrics)
   - Prepare proposal for low-hanging fruit enhancements

2. **Mentor National:**
   - Sandy to export teamwork requirements list by Friday
   - Form internal committee for ongoing technology initiatives
   - Determine budget allocation and grant funding opportunities
   - Identify priorities among low-hanging fruit items

3. **Collaborative:**
   - Schedule follow-up alignment meeting to review combined requirements list
   - Plan hands-on shadowing sessions for Orases to understand workflows
   - Establish parallel work streams:
     - Stream 1: Quick wins / system enhancements (can start immediately)
     - Stream 2: Data cleanup strategy (requires dashboard/reporting tools)
     - Stream 3: Long-term vision (requires committee formation and deeper discovery)

### Future Discovery Needs:

- **Shadowing Sessions:** Orases needs to observe actual user workflows to understand:
  - How staff navigate across multiple systems
  - What data is needed and where they find it
  - Pain points in current processes
  - Real-world use cases for program and people data

- **Data Mapping:** Understand data structures in:
  - Dynamics CRM
  - Salesforce (NMRC)
  - Common affiliate systems
  - Identify overlap and gaps

- **Committee Formation:** Mentor to establish technology committee for:
  - Long-term strategic decisions
  - Representing diverse organizational needs
  - Ongoing governance and prioritization

---

## Strategic Considerations

### Build vs. Integrate Decision:
- Building comprehensive CRM from scratch would be expensive
- Off-the-shelf products already exist with these features
- API integration may be more cost-effective approach
- Need to balance "one mega-system" vs. "connected ecosystem" approaches

### Affiliate Adoption Factors:
- Affiliates need comprehensive feature set to justify migration
- Current Mentor Connector doesn't offer enough value beyond volunteer recruitment
- Some affiliates expressed willingness to abandon custom systems if shared solution is better
- Standardization across network is organizational goal, with some affiliate support

### Data as Strategic Asset:
- Reliable program database supports research, marketing, policy, and fundraising
- Quality data can be sold as value proposition to funders and stakeholders
- Programs more likely to keep data current if they see benefits (funders access it, etc.)
- Annual refresh cadence with affiliate validation could maintain quality

### Realistic Expectations:
- Cannot fully automate data quality (programs must maintain own records)
- Cannot force affiliate technical capacity where none exists
- Should focus on reducing manual burden through targeted tooling
- Phase approach allows learning and adjustment

---

## Open Questions for Future Discussion

1. What is realistic budget range for 2026 technology initiatives?
2. Which grants could fund specific enhancements?
3. What is composition and charter for technology committee?
4. What is timeline for affiliate database audit/crosswalk project?
5. Should volunteer recruitment functionality be deprecated or maintained?
6. What are must-have vs. nice-to-have features for affiliate adoption?
7. How do we measure success for data quality initiatives?

---

## Meeting Reflection

This was an effective listening session that surfaced the complexity of Mentor National's technology ecosystem and the ambitious vision for evolution. The conversation revealed both immediate tactical needs (QMS multi-assessments, data cleanup tools) and longer-term strategic questions (system architecture, integration vs. consolidation).

The three-stream approach (quick wins, data cleanup, long-term vision) provides a framework for making progress while deeper discovery and planning continues. Critical success factors will be forming the internal committee, securing appropriate budget, and maintaining realistic scope given resource constraints.
