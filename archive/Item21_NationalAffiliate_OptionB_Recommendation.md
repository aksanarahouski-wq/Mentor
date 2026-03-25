# Item #21: National Affiliate for Orphan Programs
## Recommendation: Option B - Programmatic Safety Net Approach

**Document Type:** Technical Recommendation & Business Analysis
**Prepared By:** Aksana Rahouski
**Date:** January 28, 2026
**Status:** Recommended for Client Approval

---

## Executive Summary

We recommend implementing **Option B: Programmatic Safety Net Approach** for managing orphan programs (programs not assigned to any affiliate). This recommendation is based on analysis of the current data volume, maintenance complexity, and long-term scalability requirements.

**Key Decision Factors:**
- **750+ orphan programs** identified across multiple states and zip codes
- **High variability** in geographic distribution requiring complex manual maintenance
- **Option A (Manual/Script Approach)** creates unsustainable ongoing maintenance burden
- **Option B (Programmatic Approach)** provides automated, self-healing solution with zero ongoing maintenance

---

## Background: The Orphan Program Challenge

### What Are Orphan Programs?

"Orphan programs" are programs that exist in the system but are not assigned to any affiliate because their ZIP codes don't match any affiliate's service area coverage.

### Current State Analysis

**Program Volume:**
- **750+ programs** currently identified as orphan programs
- High geographic diversity across multiple states
- Each program may have multiple locations with different ZIP codes

**Current Assignment Logic:**
- Programs are assigned to affiliates by matching program location ZIP codes with affiliate service area ZIP codes
- If no match is found, program remains "orphaned" (unassigned)
- New scoped/limited affiliate access feature cannot work for orphan programs (requires parent affiliate)

**Business Impact:**
- No clear ownership or management responsibility for orphan programs
- New affiliate permission features cannot be utilized for 750+ programs
- Data quality visibility is reduced
- Manual workarounds required for affiliate user access

---

## Option A: Manual/Script Approach - Analysis & Concerns

### Proposed Approach (Option A)

1. Create "Mentor National" affiliate in system
2. Run SQL script to identify all 750+ orphan programs
3. Extract all unique ZIP codes from all 750+ program locations
4. Manually add these ZIP codes to National affiliate's service area coverage
5. Repeat maintenance process monthly or quarterly as programs change

### Why Option A Is Not Recommended

#### 1. Initial Setup Complexity

**Data Extraction Challenge:**
```
750 programs → Multiple locations per program → Unique ZIP codes per location
```

To implement Option A, we must:
- Query all 750+ orphan programs
- Identify all program locations for each program
- Extract all unique ZIP codes across all locations
- Identify the state for each ZIP code
- Organize data by state
- Manually add every State:ZIP Code combination to the National Affiliate's service area

**Estimated Data Points:**
- 750 programs × average 2-3 locations per program = **~1,500-2,250 location records**
- Each location has 1 ZIP code
- ZIP codes span multiple states (high variability)
- Estimated **500-1,000+ unique ZIP codes** to manage

**Time Investment:**
- SQL query development and testing: 2-4 hours
- Data extraction and organization: 4-8 hours
- Manual entry into system (State + ZIP codes): 8-16 hours
- Testing and validation: 4-6 hours
- **Total Initial Setup: 18-34 hours**

#### 2. Ongoing Maintenance Burden

Option A requires **continuous manual maintenance** for multiple scenarios:

**Scenario 1: New Programs Added**
- New programs submitted without affiliate coverage
- Must run script to identify new orphans
- Extract their ZIP codes
- Manually add to National affiliate service area
- **Frequency:** Weekly or bi-weekly
- **Time per update:** 2-4 hours

**Scenario 2: Program Location Changes**
- Programs update their locations or add new sites
- New ZIP codes may not be in National affiliate service area
- Must identify changes and add new ZIP codes
- **Frequency:** Ongoing (as programs update)
- **Time per update:** 1-2 hours

**Scenario 3: Affiliate Coverage Changes**
- When affiliates expand or reduce service areas
- Programs may move from orphan → affiliated or affiliated → orphan
- Must recalculate which programs are orphans
- Must add/remove ZIP codes from National affiliate
- **Frequency:** Quarterly (or when affiliates change)
- **Time per update:** 4-8 hours

**Scenario 4: Affiliate Inactivation**
- When affiliate becomes inactive, all their programs become orphans
- Must identify all affected programs
- Extract all their ZIP codes
- Add to National affiliate service area
- **Frequency:** As needed (2-4 times per year)
- **Time per update:** 4-8 hours per inactive affiliate

**Scenario 5: Data Cleanup Efforts**
- As mentor team "cleans up" programs (fixing incorrect data, updating locations)
- ZIP codes may change, requiring service area updates
- Must manually track and update National affiliate coverage
- **Frequency:** Ongoing during data cleanup initiatives
- **Time:** Variable, unpredictable

**Estimated Annual Maintenance:**
- Monthly updates: 12 × 3 hours = 36 hours/year
- Quarterly recalculations: 4 × 6 hours = 24 hours/year
- Affiliate inactivations: 3 × 6 hours = 18 hours/year
- Ad-hoc updates: ~20 hours/year
- **Total Annual Maintenance: ~98 hours/year (2.5 weeks of work)**

#### 3. Data Quality & Synchronization Risks

**Manual Entry Errors:**
- Risk of typos when manually entering ZIP codes
- Risk of missing ZIP codes during data extraction
- No automated validation of ZIP code accuracy
- Errors compound over time

**Synchronization Drift:**
- National affiliate service area becomes static snapshot
- Real program locations continue to change
- Gap widens between actual program coverage and National affiliate service area
- Programs may appear assigned when they shouldn't be (or vice versa)
- Requires constant monitoring and reconciliation

**Scalability Issues:**
- As more programs are added, maintenance burden grows linearly
- 750 programs today → potentially 1,000+ programs in future
- Manual process does not scale with program growth
- Increasing risk of errors and omissions

#### 4. User Experience Impact

**For Mentor Team:**
- Must remember to run scripts regularly
- Manual tracking of what's been updated
- Cognitive load of maintaining static service area list
- Time diverted from strategic work to maintenance tasks

**For System Users:**
- Potential for incorrect program assignments if service area not updated
- Confusion when programs appear unassigned despite being in "National" affiliate
- Support requests when assignment doesn't match expectations

---

## Option B: Programmatic Safety Net Approach - Recommended Solution

### How Option B Works

**Conceptual Model:**
- Create "Mentor National" (or "Global") affiliate with special "safety net" behavior
- System treats this as a "unicorn" affiliate - exception to normal matching rules
- **Does NOT match on ZIP code coverage** like regular affiliates
- Automatically captures any program that doesn't match any other affiliate's service area
- Acts as true "safety net" - "everybody who didn't get a home will land in the safety net"

**Technical Implementation:**

```
FOR EACH Program:
  1. System checks program location ZIP codes against all ACTIVE affiliates' service areas
  2. IF match found with regular affiliate → assign to that affiliate(s) (existing behavior)
  3. IF NO match found with any regular affiliate → automatically assign to National affiliate (NEW behavior)
  4. Programs can still be assigned to multiple affiliates if ZIP codes match multiple service areas
```

**Key Feature:**
- National affiliate requires **NO service area configuration**
- No ZIP codes to maintain
- No states to track
- System automatically routes unmatched programs to safety net

### Why Option B Is Recommended

#### 1. Zero Initial Setup Time

**No Data Extraction Required:**
- No scripts to write
- No ZIP codes to identify
- No manual data entry
- No state-by-state organization

**Setup Steps:**
1. Create "Mentor National" affiliate in system (5 minutes)
2. Flag affiliate as "safety net" type in database (1 field update)
3. Deploy updated matching logic to production (standard deployment process)
4. Validate assignment logic (testing)

**Estimated Initial Setup: 8-12 hours** (development + testing + deployment)
- vs. 18-34 hours for Option A

#### 2. Zero Ongoing Maintenance

**Automatic Assignment:**
- No scripts to run monthly/quarterly
- No ZIP codes to add when programs change
- No updates needed when affiliates expand/contract
- No manual tracking required

**Self-Healing System:**
- Programs automatically assigned on creation
- Location changes automatically trigger reassignment
- Affiliate status changes automatically handled
- Data cleanup efforts automatically reflected

**Maintenance Time:**
- **Monthly:** 0 hours
- **Quarterly:** 0 hours
- **Annual:** 0 hours
- **Total Ongoing Maintenance: 0 hours**

#### 3. Scales Automatically

**Growth Handling:**
- Works for 750 programs today
- Works for 1,000 programs next year
- Works for 10,000 programs in future
- **No additional maintenance regardless of volume**

**Geographic Coverage:**
- Automatically handles all states
- Automatically handles all ZIP codes
- Automatically handles international ZIP codes (if needed)
- No manual tracking of geographic expansion

#### 4. Improved Data Quality

**Automatic Data Quality Visibility:**
- Programs in National affiliate may indicate data quality issues
  - Invalid ZIP codes
  - Incorrect ZIP codes
  - Missing location data
- Provides clear "exception report" for data cleanup priorities
- Makes data quality issues visible and actionable

**Automatic Correction:**
- When incorrect ZIP codes are fixed, program automatically reassigns to correct affiliate
- No manual intervention required
- Incentivizes data quality improvements (programs will "graduate" from National affiliate)

#### 5. Enables New Features

**Scoped Affiliate Access:**
- Every program has a parent affiliate (no orphans)
- New permission features work for 100% of programs
- Consistent user experience across all programs

**Affiliate Management:**
- Clear visibility into which programs lack geographic coverage
- Easy identification of gaps in affiliate network
- Strategic planning for affiliate expansion

**Reporting & Analytics:**
- Complete affiliate assignment data for all programs
- Clear metrics on orphan program volume
- Trend analysis: Are orphan programs increasing or decreasing?

#### 6. Business Continuity

**Affiliate Lifecycle Management:**
- When affiliate becomes inactive → programs automatically move to National affiliate
- When affiliate reactivates → programs automatically reassign back
- When affiliate expands coverage → programs automatically reassign from National to regular affiliate
- **Zero manual intervention for affiliate status changes**

**Resilience:**
- System continues to function correctly regardless of affiliate changes
- No risk of programs becoming "lost" in the system
- Every program always has clear ownership/visibility

---

## Cost-Benefit Analysis

### Option A: Manual/Script Approach

**Costs:**
- Initial setup: 18-34 hours (~$2,700 - $5,100 @ $150/hr)
- Annual maintenance: 98 hours (~$14,700/year @ $150/hr)
- **Year 1 Total: $17,400 - $19,800**
- **Year 2 Total: $14,700**
- **Year 3 Total: $14,700**
- **3-Year Total: $46,800 - $49,200**

**Risks:**
- Data synchronization errors
- Manual entry mistakes
- Staff turnover (knowledge transfer)
- Increasing maintenance burden as program volume grows
- Time diverted from strategic initiatives

**Benefits:**
- Can be implemented immediately with existing functionality
- Familiar approach (manual data management)

### Option B: Programmatic Safety Net Approach

**Costs:**
- Initial development: 12-16 hours analysis + design (~$2,400 @ $150/hr)
- Development: 20-30 hours implementation (~$4,000 @ $150/hr)
- Testing: 8-12 hours (~$1,500 @ $150/hr)
- **One-Time Total: $7,900 - $11,900**
- **Annual maintenance: $0**
- **3-Year Total: $7,900 - $11,900**

**Risks:**
- Development complexity (MEDIUM)
- Testing required to ensure matching logic works correctly
- Requires code deployment

**Benefits:**
- Zero ongoing maintenance forever
- Automatic, self-healing system
- Scales infinitely with program growth
- Improved data quality visibility
- Enables new permission features
- Better user experience
- Long-term sustainable solution
- **3-year savings: $34,900 - $37,300 compared to Option A**

---

## Implementation Complexity Assessment

### Option A: LOW Complexity, HIGH Ongoing Burden
- Familiar SQL queries
- Standard data entry processes
- No code changes required
- **BUT: Requires continuous manual work forever**

### Option B: MEDIUM Complexity, ZERO Ongoing Burden
- Requires code changes to matching logic
- Requires testing of assignment rules
- Requires database schema minor update (1 field)
- **BUT: Once deployed, works automatically forever**

---

## Risk Analysis

### Option A Risks

| Risk | Likelihood | Impact | Mitigation |
|------|-----------|--------|------------|
| Manual entry errors | HIGH | MEDIUM | Double-check data, validation scripts |
| Synchronization drift | HIGH | HIGH | Frequent updates, monitoring |
| Staff turnover | MEDIUM | HIGH | Documentation, training |
| Scaling issues | HIGH | HIGH | Process optimization (limited effectiveness) |
| Maintenance neglect | MEDIUM | HIGH | Calendar reminders, ownership assignment |

**Overall Risk: HIGH** - Multiple high-likelihood, high-impact risks with limited mitigation options.

### Option B Risks

| Risk | Likelihood | Impact | Mitigation |
|------|-----------|--------|------------|
| Development bugs | LOW | MEDIUM | Thorough testing, staged rollout |
| Logic errors | LOW | HIGH | Code review, comprehensive test scenarios |
| Performance impact | LOW | LOW | Query optimization, monitoring |
| Unintended side effects | LOW | MEDIUM | Regression testing, rollback plan |

**Overall Risk: LOW** - All risks are low-likelihood and have strong mitigation strategies.

---

## Timeline Comparison

### Option A Timeline

**Initial Setup:** 2-3 weeks
- Week 1: SQL development, data extraction
- Week 2: Data organization, manual entry
- Week 3: Testing, validation

**Ongoing:** Never ends
- Monthly updates required
- Quarterly recalculations required
- Ad-hoc updates as needed

### Option B Timeline

**Initial Development:** 4-6 weeks
- Week 1: Requirements analysis, design
- Week 2-3: Development
- Week 4: Testing
- Week 5: User acceptance testing
- Week 6: Deployment to production

**Ongoing:** Nothing required (automatic)

---

## Recommendation Summary

We strongly recommend **Option B: Programmatic Safety Net Approach** for the following reasons:

### Primary Reasons

1. **Sustainability:** Option B eliminates 98 hours/year of ongoing maintenance work
2. **Scalability:** Works for 750 programs today, 10,000 programs tomorrow
3. **Cost:** 3-year savings of $35,000+ compared to Option A
4. **Data Quality:** Automatic visibility into data quality issues
5. **Feature Enablement:** Allows new permission features to work for all programs
6. **Business Continuity:** Self-healing system handles affiliate lifecycle changes automatically

### Secondary Reasons

7. **User Experience:** Transparent to end users, better system reliability
8. **Strategic Value:** Frees mentor team to focus on strategic work, not maintenance
9. **Risk Reduction:** Eliminates manual entry errors and synchronization issues
10. **Future-Proof:** Solution scales infinitely without additional investment

### Why NOT Option A

Given the scale (750+ programs), geographic diversity (multiple states), and ongoing maintenance burden (~98 hours/year), **Option A creates an unsustainable long-term dependency on manual processes** that will:
- Consume significant staff time perpetually
- Scale poorly as program volume grows
- Introduce data quality risks through manual entry
- Divert resources from strategic initiatives to maintenance tasks

---

## Next Steps

If Option B is approved:

1. **Week 1-2:** Detailed technical specification and design
2. **Week 3-4:** Development of matching logic updates
3. **Week 5:** Testing and quality assurance
4. **Week 6:** User acceptance testing and deployment
5. **Week 7:** Monitoring and validation in production

**Estimated Go-Live:** 6-7 weeks from approval

---

## Appendix A: Technical Implementation Notes

### Database Changes Required

**affiliates table:**
- Add field: `is_safety_net` (boolean, default: false)
- Set `is_safety_net = true` for "Mentor National" affiliate

**No changes required to:**
- programs table
- program_locations table
- service_areas table
- postal_codes_service_areas table

### Matching Logic Pseudo-Code

```
FUNCTION assignProgramToAffiliates(program_id):
    matched_affiliates = []

    // Get all active regular affiliates
    regular_affiliates = SELECT * FROM affiliates
                         WHERE active = true
                         AND is_safety_net = false

    // Get all program location ZIP codes
    program_zips = SELECT zip_code FROM program_locations
                   WHERE program_id = program_id

    // Check each regular affiliate for ZIP code matches
    FOR EACH regular_affiliate IN regular_affiliates:
        affiliate_zips = SELECT postal_code.code
                        FROM service_areas sa
                        JOIN postal_codes_service_areas pcsa ON sa.id = pcsa.service_area_id
                        JOIN sam_postal_codes pc ON pcsa.postal_code_id = pc.id
                        WHERE sa.affiliate_id = regular_affiliate.id

        IF program_zips INTERSECTS affiliate_zips:
            matched_affiliates.append(regular_affiliate)

    // If no matches found, assign to safety net
    IF matched_affiliates.isEmpty():
        safety_net_affiliate = SELECT * FROM affiliates
                               WHERE active = true
                               AND is_safety_net = true
                               LIMIT 1
        matched_affiliates.append(safety_net_affiliate)

    RETURN matched_affiliates
```

### Query Performance Considerations

- Matching logic runs when:
  - New program is created
  - Program location is added/updated
  - Affiliate service area is updated
  - Affiliate active status changes
- Query should be optimized with proper indexes:
  - Index on `affiliates.active`
  - Index on `affiliates.is_safety_net`
  - Index on `program_locations.program_id`
  - Index on `program_locations.zip_code`
  - Index on `postal_codes_service_areas.postal_code_id`
  - Index on `postal_codes_service_areas.service_area_id`

---

## Appendix B: SQL Query for Current Orphan Program Count

**Query to identify current orphan programs:**
```sql
-- Query from: /Users/aksana/Documents/Projects/Mentor/SQL/programs_without_affiliate_mapping.sql

SELECT
    p.id,
    p.title,
    p.status,
    COUNT(DISTINCT pl.id) AS location_count,
    COUNT(DISTINCT pl.zip_code) AS unique_zipcodes
FROM programs p
LEFT JOIN program_locations pl ON p.id = pl.program_id
LEFT JOIN sam_postal_codes pc ON pl.zip_code = pc.code
LEFT JOIN postal_codes_service_areas pcsa ON pc.id = pcsa.postal_code_id
LEFT JOIN service_areas sa ON pcsa.service_area_id = sa.id
WHERE p.status = 'approved'
GROUP BY p.id, p.title, p.status
HAVING COUNT(DISTINCT pcsa.id) = 0
ORDER BY p.title;
```

**Result:** ~750 orphan programs identified (as of January 2026)

---

## Document History

| Date | Version | Change | Author |
|------|---------|--------|--------|
| January 28, 2026 | 1.0 | Initial recommendation document | Aksana Rahouski |
