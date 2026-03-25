# Work Estimate: National Affiliate "Safety Net" Enhancement
**Project**: Item 21 - National Affiliate Implementation
**Date**: February 27, 2026
**Estimator**: Engineering Team

---

## Executive Summary

**Total Estimated Effort**: **96-120 hours** (12-15 business days)
**Complexity Level**: Medium-High
**Risk Level**: Medium

This feature introduces a "National Affiliate" safety net that automatically catches and assigns 750+ orphan programs. The work touches multiple system layers including database schema, business logic, UI, search/filtering, and permissions.

### Time Assumptions
- Based on 8-hour workdays
- Estimates include development, testing, and documentation
- Does not include meeting time, code review time, or context switching overhead

---

## Detailed Breakdown by Feature

### Feature 1: National Affiliate Configuration
**Estimated Effort**: 16-24 hours

#### Tasks
- Design and implement database schema changes
  - Add `is_national_affiliate` boolean flag to affiliates table
  - Add unique constraint/index to ensure only one National Affiliate
  - Create database migration
- Implement core business logic for automatic program assignment
  - Orphan detection logic (programs with no ZIP matches)
  - Automatic assignment to National Affiliate
  - Dynamic reassignment when ZIP matches change
- Build validation layer
  - Enforce single National Affiliate constraint
  - Handle edge cases (no National exists, inactive National, etc.)
- Create migration script for initial deployment
  - Identify and reassign 750+ existing orphan programs
  - Ensure idempotent and reversible migration
- Write comprehensive unit tests
  - Assignment logic tests
  - Validation tests
  - Edge case coverage

#### Complexity Drivers
- Migration of 750+ programs must be bulletproof and reversible
- Assignment logic must handle dynamic changes automatically
- Critical foundation for all other features

**Risk**: High (migration complexity, business logic criticality)

---

### Feature 2: Affiliate Management UI Support
**Estimated Effort**: 16-24 hours

#### Tasks
- **Add Affiliate Page**
  - Add "National Affiliate" checkbox field
  - Implement conditional field visibility (hide/disable service area when checked)
  - Add client-side and server-side validation
  - Display clear error messages for duplicate National attempts
- **Edit Affiliate Page**
  - Add "National Affiliate" checkbox (matching Add page)
  - Implement same conditional service area visibility
  - Build warning dialog for removing National designation
    - Query and display count of affected programs
    - Require explicit confirmation
  - Add validation to prevent duplicate National
- **Affiliate Index Page**
  - Add "National Affiliate" checkbox filter
  - Ensure filter works with existing search/filter combinations
  - Test search by name for National Affiliate
- **Affiliate View Page**
  - Hide Service Area tab when viewing National Affiliate
  - Modify Programs tab to display orphan programs (not ZIP-matched)
  - Ensure all other affiliate functionality works identically
- Write UI integration tests

#### Complexity Drivers
- Multiple UI touchpoints require consistent behavior
- Conditional logic across multiple forms
- Warning dialog requires program count query

**Risk**: Medium (UI consistency, conditional logic)

---

### Feature 3: Program Display and Assignment
**Estimated Effort**: 8-16 hours

#### Tasks
- **Browse Programs Table**
  - Display "Mentor National" in Affiliate column for orphan programs
  - Design and implement visual distinction (badge, icon, color, or italic styling)
  - Ensure styling is accessible and clear
- **Automatic Reassignment**
  - Implement listeners/triggers for ZIP code changes
  - Test automatic movement between National and regular affiliates
  - Verify no manual intervention required
- Write tests for dynamic reassignment scenarios
  - New orphan → National
  - Orphan gains match → Regular affiliate
  - Regular loses match → National

#### Complexity Drivers
- Visual design decisions (badge/icon design)
- Dynamic reassignment logic integration
- User experience clarity

**Risk**: Low-Medium (mostly display logic, core assignment handled in Feature 1)

---

### Feature 4: Program Search and Filtering
**Estimated Effort**: 16-24 hours

#### Tasks
- **Dedicated National Affiliate Filter**
  - Add "National Affiliate" checkbox to program search/filter form
  - Implement orphan program query logic
  - Test filter works independently and with other filters
- **Affiliate Dropdown Integration**
  - Add "Mentor National" to affiliate selection dropdowns
  - Implement query logic switch (orphan detection vs ZIP matching)
  - Ensure dropdown works across all search contexts
- **Query Logic Implementation** (CRITICAL)
  - Create orphan program query (programs with NO ZIP matches)
  - Ensure clear separation from ZIP matching logic for regular affiliates
  - Optimize query performance for large program datasets
- **Integration Testing**
  - Test checkbox filter + all existing filters
  - Test dropdown selection + all existing filters
  - Test checkbox + dropdown together
  - Verify regular affiliate searches unaffected
- Performance testing with 750+ orphan programs

#### Complexity Drivers
- **Critical**: Query logic divergence (orphan vs ZIP matching)
- Multiple entry points (checkbox, dropdown, both)
- Must maintain performance with existing filters

**Risk**: High (query logic complexity, must not mix orphan and ZIP-matching logic)

---

### Feature 5: NQMS Assessments and Reporting
**Estimated Effort**: 12-16 hours

#### Tasks
- **NQMS Assessments Filter**
  - Add National Affiliate to affiliate filter dropdown
  - Implement orphan program logic for assessment queries
  - Add "National Affiliate" checkbox filter
  - Test filtering with all existing assessment filters
- **Other Search Forms**
  - Identify all forms that filter by affiliate
  - Add "National Affiliate" checkbox to each form
  - Apply consistent orphan program logic
- Integration testing across all forms
- Verify regular affiliate filtering unchanged

#### Complexity Drivers
- Similar to Feature 4 but narrower scope
- Must apply consistent orphan logic across multiple forms
- Assessment-specific query requirements

**Risk**: Medium (query logic consistency, multiple forms)

---

### Feature 6: User Access Control and Permissions
**Estimated Effort**: 16-24 hours

#### Tasks
- **Affiliate Selection**
  - Add National Affiliate to User Profile → Affiliate Access dropdown
  - Ensure searchable and selectable
- **Full Access Scope**
  - Implement access to ALL orphan programs dynamically
  - Ensure access automatically includes new orphans added later
  - Test full access works identically to regular affiliates
- **Limited Access Scope**
  - Modify program selection dropdown to show only orphan programs
  - Implement restriction to selected programs only
  - Test user cannot access non-selected orphans
- **Dynamic Access Management**
  - Implement access removal when program moves to regular affiliate
  - Test user loses access when their limited-access program moves
- **Multiple Affiliate Access**
  - Test National + regular affiliate access simultaneously
  - Verify permissions are additive (no conflicts)
- **Permission Enforcement**
  - Ensure permissions enforced across all program access points
  - Test view, edit, and other operations
  - Verify existing regular affiliate permissions unchanged
- Security testing and validation

#### Complexity Drivers
- Permission logic is security-critical
- Dynamic access (includes new orphans automatically)
- Access removal when programs move between affiliates
- Additive permissions with regular affiliates

**Risk**: High (security implications, dynamic access complexity)

---

## Testing and Quality Assurance
**Estimated Effort**: 16-24 hours

### Comprehensive Testing
- **Feature Testing**: End-to-end testing of all 6 features
- **Edge Case Testing**
  - No National Affiliate exists
  - Removing National designation
  - Inactive National Affiliate
  - Program has no locations or invalid ZIP
  - Regular affiliate becomes inactive
  - User access when program moves
- **Regression Testing**
  - All existing affiliate management functionality
  - Regular affiliate ZIP matching logic
  - User access permissions for regular affiliates
  - Program search and filtering
  - NQMS assessments
- **Performance Testing**
  - Migration of 750+ programs
  - Query performance with orphan program logic
  - Index optimization if needed
- **Integration Testing**
  - Cross-feature interactions
  - Multiple filter combinations
  - Multiple affiliate access scenarios
- **User Acceptance Testing (UAT)**
  - Administrator workflows
  - User access workflows
  - Search and filtering scenarios

### Quality Gates
- Zero regressions in existing functionality
- All acceptance criteria met
- Performance benchmarks met
- Security review passed
- UAT sign-off obtained

---

## Risk Assessment

### High Risk Areas

**1. Migration of 750+ Programs**
- **Risk**: Data loss, incorrect assignments, system downtime
- **Mitigation**:
  - Thoroughly test migration in staging
  - Create rollback plan
  - Make migration idempotent and reversible
  - Validate all assignments post-migration
  - Schedule during low-usage window

**2. Query Logic Divergence**
- **Risk**: Mixing orphan and ZIP-matching logic, incorrect program lists
- **Mitigation**:
  - Clear separation of concerns in code
  - Comprehensive test coverage
  - Code review focused on query logic
  - Integration tests for all query contexts

**3. Permission Enforcement**
- **Risk**: Security vulnerabilities, unauthorized access
- **Mitigation**:
  - Security-focused code review
  - Extensive permission testing
  - Test negative cases (should NOT have access)
  - Security team validation

### Medium Risk Areas

**4. UI Conditional Logic**
- **Risk**: Inconsistent behavior across forms, user confusion
- **Mitigation**:
  - UI component consistency checks
  - UX review
  - Integration testing across all forms

**5. Dynamic Reassignment**
- **Risk**: Programs assigned incorrectly, performance issues
- **Mitigation**:
  - Thorough testing of reassignment triggers
  - Performance monitoring
  - Clear logging for troubleshooting

---

## Dependencies and Assumptions

### Technical Dependencies
- Existing affiliate data model supports boolean flags
- Current ZIP code matching logic is stable and well-documented
- User access control system supports affiliate-level scoping
- NQMS assessment data model allows affiliate filtering
- Database supports required migrations without downtime

### Business Assumptions
- "Mentor National" is the approved naming convention
- 750+ orphan programs is current accurate count
- No major changes to affiliate structure during implementation
- Stakeholders available for UAT
- Visual distinction design can be decided during implementation

### Team Assumptions
- Team has access to staging environment matching production
- Team has necessary permissions to modify affiliates and permissions
- Designer available for visual distinction consultation if needed
- QA resources available for comprehensive testing

---

## Recommended Implementation Approach

### Phase 1: Foundation (32 hours / 4 days)
**Focus**: Core logic and data migration

- **Feature 1**: National Affiliate Configuration (16-24 hours)
  - Database schema and migration (6-8 hours)
  - Core business logic (6-8 hours)
  - Assignment automation (4-6 hours)
  - Unit testing (8 hours)
- **Milestone**: Migration successfully tested in staging, 750+ programs correctly assigned

### Phase 2: Management UI (32 hours / 4 days)
**Focus**: Affiliate management and program display

- **Feature 2**: Affiliate Management UI Support (16-24 hours)
  - Add/Edit/View pages (8-12 hours)
  - Index page filtering (4-6 hours)
  - Validation and warnings (4-6 hours)
- **Feature 3**: Program Display and Assignment (8-16 hours)
  - Visual distinction in Browse Programs (4-8 hours)
  - Reassignment testing (4-8 hours)
- **Milestone**: Administrators can create, manage, and view National Affiliate

### Phase 3: Search and Access (32 hours / 4 days)
**Focus**: Search, filtering, and permissions

- **Feature 4**: Program Search and Filtering (16-24 hours)
  - Checkbox filter and dropdown (6-8 hours)
  - Orphan query logic implementation (6-10 hours)
  - Integration testing (4-6 hours)
- **Feature 5**: NQMS Assessments and Reporting (12-16 hours)
  - Assessment filtering (6-8 hours)
  - Other search forms (4-6 hours)
  - Integration testing (2-4 hours)
- **Feature 6**: User Access Control (16-24 hours)
  - Full and limited access scopes (6-8 hours)
  - Dynamic access management (4-6 hours)
  - Permission enforcement (4-6 hours)
  - Security testing (2-4 hours)
- **Milestone**: Users can search, filter, and access National Affiliate programs

### Phase 4: Testing and Refinement (24 hours / 3 days)
**Focus**: Quality assurance and production readiness

- Comprehensive QA testing (8 hours)
- Edge case validation (4 hours)
- Regression testing (6 hours)
- Performance testing (2 hours)
- UAT with administrators (4 hours)
- Bug fixes and refinements (estimated, variable)
- **Milestone**: Production-ready, all acceptance criteria met

---

## Potential Extensions Beyond Estimate

The following could extend the timeline if encountered:

- **Database performance issues** requiring index optimization: +8-16 hours
- **Complex permission model** requiring refactoring: +16-24 hours
- **Major UI/UX design changes** after initial implementation: +8-16 hours
- **Unexpected regressions** in existing functionality: +8-24 hours
- **Additional stakeholder requirements** discovered during UAT: +8-40 hours

---

## Success Metrics

### Deployment Success
- ✅ All 750+ orphan programs successfully migrated to National Affiliate
- ✅ Zero data loss during migration
- ✅ No downtime or errors during deployment
- ✅ Rollback plan tested and ready if needed

### Functional Success
- ✅ All 41 acceptance criteria met (from PRD)
- ✅ Zero orphan programs after deployment
- ✅ Automatic assignment working for new programs
- ✅ All search/filter contexts using correct query logic
- ✅ Permission enforcement working correctly

### Quality Success
- ✅ Zero regressions in existing functionality
- ✅ All tests passing (unit, integration, regression)
- ✅ Performance benchmarks met
- ✅ UAT sign-off obtained
- ✅ Security review passed

### Business Success
- ✅ New scoped affiliate access features unblocked for 100% of programs
- ✅ Zero ongoing maintenance required for orphan program management
- ✅ Clear visibility into orphan programs (visual distinction working)

---

## Confidence Level

**Overall Confidence**: Medium-High (75-80%)

### High Confidence Areas (90%+)
- Feature 2 (UI changes)
- Feature 3 (display logic)
- Feature 5 (reporting, similar patterns)

### Medium Confidence Areas (70-80%)
- Feature 1 (migration complexity manageable but critical)
- Feature 4 (query logic divergence requires careful implementation)
- Feature 6 (permissions well-understood but dynamic access adds complexity)

### Risk Factors for Estimate
- Unknown complexity in existing codebase
- Potential performance issues with orphan queries
- Stakeholder feedback during UAT may require changes
- Edge cases discovered during implementation

---

## Recommendation

**Proceed with 96-120 hour estimate (12-15 business days) with the following provisions:**

1. **Allocate 24-hour buffer** for unforeseen complexity (total 120-144 hours / 15-18 days)
2. **Prioritize Phase 1** (Foundation) for thorough testing before building dependent features
3. **Schedule UAT early** in Phase 3 to catch requirements gaps
4. **Plan migration during low-usage window** (evening/weekend)
5. **Prepare rollback plan** before deployment
6. **Consider pair programming** for high-risk areas (query logic, permissions) - adds ~10-15% time overhead but reduces risk

### Summary Table

| Feature | Hours | Complexity | Risk |
|---------|-------|------------|------|
| Feature 1: Core Configuration | 16-24 | High | High |
| Feature 2: Management UI | 16-24 | Medium | Medium |
| Feature 3: Display & Assignment | 8-16 | Low-Medium | Low |
| Feature 4: Search & Filtering | 16-24 | High | High |
| Feature 5: NQMS Reporting | 12-16 | Medium | Medium |
| Feature 6: User Access Control | 16-24 | High | High |
| Testing & QA | 16-24 | Medium | High |
| **Total Development Time** | **96-120** | - | - |
| **Recommended Buffer** | **24** | - | - |
| **Total with Buffer** | **120-144** | - | - |

This is a **well-scoped, high-value feature** that eliminates 750+ orphan programs and unblocks new functionality. The estimate is realistic with appropriate risk management and phased approach.
