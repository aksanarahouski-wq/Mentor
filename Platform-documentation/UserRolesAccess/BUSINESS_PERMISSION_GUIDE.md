# MENTOR Connector - Permission Guide for Business Users

**Version:** 1.0
**Last Updated:** December 3, 2025
**Audience:** Business Users, Product Owners, System Administrators

---

## Table of Contents

1. [Understanding User Roles](#understanding-user-roles)
2. [Access Levels Explained](#access-levels-explained)
3. [What Each Role Can Do](#what-each-role-can-do)
4. [Module-by-Module Permissions](#module-by-module-permissions)
5. [Common Scenarios](#common-scenarios)
6. [How to Assign Roles](#how-to-assign-roles)
7. [Important Business Rules](#important-business-rules)
8. [Troubleshooting Access Issues](#troubleshooting-access-issues)

---

## Understanding User Roles

The MENTOR Connector system has **8 different user roles** that determine what users can see and do. These roles are automatically assigned based on how you set up a user's access.

### The 8 User Roles

| Role Name | Who Gets This Role | What They Can Do |
|-----------|-------------------|------------------|
| **Global Admin** | System administrators | Everything - full access to entire system |
| **Affiliate User (Full Access)** | Affiliate staff managing both recruitment and quality | Both Mentoring Connector and NQMS features |
| **Affiliate User (MC-Only)** | Affiliate staff focused only on recruitment | Only Mentoring Connector features (inquiries, searches) |
| **Affiliate User (NQMS-Only)** | Affiliate staff focused only on quality assessment | Only NQMS features (assessments, goals) |
| **Affiliate Limited Contractor** | External consultants working on NQMS | Limited NQMS access (latest assessment only) |
| **Program User** | Program staff handling recruitment | Mentoring Connector features for their program |
| **Program User (NQMS-Only)** | Program staff working on assessments | NQMS features for their program |
| **Program Limited Contractor** | External consultants at program level | Limited NQMS access for their program |

### How Roles Are Determined

The system automatically gives users their roles based on:
1. **Assignment Level:** Are they assigned to an Affiliate or a Program?
2. **Access Level:** What access level did you select (Full, MC-Only, or NQMS-Only)?
3. **Contractor Flag:** Did you check the "Limited Contractor" box?

---

## Access Levels Explained

When you create or edit a user, you must choose one of three **Access Levels**:

### 1. Full Access
**When to use:** User needs to work with both volunteer recruitment AND quality assessments

**Gives access to:**
- Volunteer inquiries and searches
- Program and affiliate management
- NQMS assessments and goals
- Reports
- User management

**Example:** Jane is an affiliate coordinator who manages both volunteer inquiries and NQMS assessments for programs in her region.

---

### 2. MC-Access Only (Mentoring Connector Only)
**When to use:** User ONLY handles volunteer recruitment, not quality assessments

**Gives access to:**
- Volunteer inquiries and searches
- Program profiles
- Account management
- Reminders

**Does NOT give access to:**
- NQMS assessments
- NQMS goals
- Quality-related reports

**Example:** Wanda is a marketing associate who follows up with volunteer inquiries but doesn't work on quality assessments.

---

### 3. NQMS-Access Only
**When to use:** User ONLY works on quality assessments, not volunteer recruitment

**Gives access to:**
- NQMS assessments and goals
- Program profiles (view only)
- Quality reports
- Reminders

**Does NOT give access to:**
- Volunteer inquiries
- Searches
- Recruitment features

**Example:** Steve is a quality consultant who helps programs complete their NQMS assessments but doesn't handle volunteer inquiries.

---

## What Each Role Can Do

### Global Admin (System Administrator)
**How to create:** Check the "Is Superuser" box when creating the user

**Can do EVERYTHING:**
- Manage all programs and affiliates
- Access all NQMS assessments
- Manage partner organizations
- Configure NQMS question templates
- View all reports
- Manage all users
- Archive assessments
- Approve assessments

**Cannot do:** Nothing - full system access

---

### Affiliate User (Full Access)
**How to create:**
1. Go to user's Affiliates tab
2. Add affiliate assignment
3. Select "Full Access"
4. Leave "Limited Contractor" unchecked

**Can do:**
- Manage volunteer inquiries for programs in their service area
- Create and manage searches
- Edit program profiles in their service area
- Edit their affiliate profile
- Manage users
- View reports
- Create, edit, and view NQMS assessments
- **Approve NQMS assessments** (important!)
- Archive assessments
- Create and manage goals

**Cannot do:**
- Manage partner organizations
- Edit NQMS question templates
- Access programs outside their service area

**Key Benefit:** Complete access to both recruitment and quality features for their region.

---

### Affiliate User (MC-Only)
**How to create:**
1. Go to user's Affiliates tab
2. Add affiliate assignment
3. Select "MC-Access Only"
4. Leave "Limited Contractor" unchecked

**Can do:**
- Manage volunteer inquiries
- Create and manage searches
- Edit program profiles in their service area
- Edit their affiliate profile
- Manage users
- Set reminders

**Cannot do:**
- Access any NQMS features
- View quality reports
- Create or view assessments
- Manage goals

**Best for:** Staff focused solely on volunteer recruitment and program responsiveness.

---

### Affiliate User (NQMS-Only)
**How to create:**
1. Go to user's Affiliates tab
2. Add affiliate assignment
3. Select "NQMS-Access Only"
4. Leave "Limited Contractor" unchecked

**Can do:**
- Create, edit, and view NQMS assessments
- **Approve NQMS assessments** (important!)
- Archive assessments
- Create and manage goals
- View program profiles (read-only)
- View quality reports
- Set NQMS reminders

**Cannot do:**
- Access volunteer inquiries
- Create searches
- Edit program profiles (view only)
- Manage users

**Best for:** Quality consultants or staff who focus exclusively on NQMS assessments.

---

### Affiliate Limited Contractor
**How to create:**
1. Go to user's Affiliates tab
2. Add affiliate assignment
3. Select "NQMS-Access Only" (required)
4. Check "Limited Contractor" box

**Can do:**
- Edit NQMS assessments (latest one only)
- Create and manage goals
- View program profiles (read-only)
- Set reminders

**Cannot do:**
- Approve assessments
- Archive assessments
- Access old/historical assessments
- Access volunteer inquiries
- Manage users

**Key Restriction:** Can only access the MOST RECENT assessment per program, not historical data.

**Best for:** External consultants with temporary, limited access needs.

---

### Program User (Full Access or MC-Only)
**How to create:**
1. Go to user's Programs tab
2. Add program assignment
3. Select "Full Access" OR "MC-Access Only"
4. Leave "Limited Contractor" unchecked

**Note:** Both "Full Access" and "MC-Access Only" give the same permissions at the program level.

**Can do:**
- Manage volunteer inquiries for their program
- Create and manage searches
- Edit their program profile
- Manage users for their program
- Create, edit, and view NQMS assessments for their program
- Create and manage goals
- View reports for their program
- Set reminders

**Cannot do:**
- **Approve NQMS assessments** (critical limitation!)
- Archive assessments
- Access affiliate management
- Access other programs

**Important:** Program users can fill out assessments but CANNOT approve them. Only affiliate staff can approve.

---

### Program User (NQMS-Only)
**How to create:**
1. Go to user's Programs tab
2. Add program assignment
3. Select "NQMS-Access Only"
4. Leave "Limited Contractor" unchecked

**Can do:**
- Create, edit, and view NQMS assessments for their program
- Create and manage goals
- View their program profile (read-only)
- View quality reports
- Set NQMS reminders

**Cannot do:**
- Approve assessments
- Archive assessments
- Access volunteer inquiries
- Create searches
- Edit program profile (view only)

**Best for:** Program evaluation staff who focus on quality assessments.

---

### Program Limited Contractor
**How to create:**
1. Go to user's Programs tab
2. Add program assignment
3. Select "NQMS-Access Only" (required)
4. Check "Limited Contractor" box

**Can do:**
- Edit NQMS assessment (latest one only)
- Create and manage goals
- View program profile (read-only)
- Set reminders

**Cannot do:**
- Approve assessments
- Archive assessments
- Access old/historical assessments
- Access volunteer inquiries
- Manage users

**Best for:** External consultants helping with a single assessment cycle.

---

## Module-by-Module Permissions

### Reminders
**What it is:** Task reminders and notifications

| Role | Access Level |
|------|--------------|
| Global Admin | Can Edit |
| Affiliate (Full) | Can Edit |
| Affiliate (MC-Only) | Can Edit |
| Affiliate (NQMS-Only) | Can Edit |
| Affiliate (Contractor) | No Access |
| Program (Full/MC) | Can Edit |
| Program (NQMS-Only) | Can Edit |
| Program (Contractor) | No Access |

**Note:** Contractors cannot manage reminders.

---

### Searches
**What it is:** Saved searches for volunteers/mentors

| Role | Access Level |
|------|--------------|
| Global Admin | Can Edit |
| Affiliate (Full) | Can Edit |
| Affiliate (MC-Only) | Can Edit |
| Affiliate (NQMS-Only) | No Access |
| Affiliate (Contractor) | No Access |
| Program (Full/MC) | Can Edit |
| Program (NQMS-Only) | No Access |
| Program (Contractor) | No Access |

**Note:** NQMS-only users don't need search functionality.

---

### Inquiries
**What it is:** Volunteer/mentor inquiry management

| Role | Access Level |
|------|--------------|
| Global Admin | Can Edit |
| Affiliate (Full) | Can Edit |
| Affiliate (MC-Only) | Can Edit |
| Affiliate (NQMS-Only) | No Access |
| Affiliate (Contractor) | No Access |
| Program (Full/MC) | Can Edit |
| Program (NQMS-Only) | No Access |
| Program (Contractor) | No Access |

**Note:** Inquiries are part of Mentoring Connector, not NQMS.

---

### Programs
**What it is:** Program profile management (contact info, details, location)

| Role | Access Level |
|------|--------------|
| Global Admin | Can Edit |
| Affiliate (Full) | Can Edit |
| Affiliate (MC-Only) | Can Edit |
| Affiliate (NQMS-Only) | Can View Only |
| Affiliate (Contractor) | Can View Only |
| Program (Full/MC) | Can Edit |
| Program (NQMS-Only) | Can View Only |
| Program (Contractor) | Can View Only |

**Note:** NQMS-only users can view program details but cannot edit them.

---

### Affiliates
**What it is:** Affiliate organization management

| Role | Access Level |
|------|--------------|
| Global Admin | Can Edit |
| Affiliate (Full) | Can Edit |
| Affiliate (MC-Only) | Can Edit |
| Affiliate (NQMS-Only) | Can View Only |
| Affiliate (Contractor) | Can View Only |
| Program (Full/MC) | No Access |
| Program (NQMS-Only) | No Access |
| Program (Contractor) | No Access |

**Note:** Program users cannot access affiliate management.

---

### Accounts (User Management)
**What it is:** Managing user accounts and access

| Role | Access Level |
|------|--------------|
| Global Admin | Can Edit |
| Affiliate (Full) | Can Edit |
| Affiliate (MC-Only) | Can Edit |
| Affiliate (NQMS-Only) | No Access |
| Affiliate (Contractor) | No Access |
| Program (Full/MC) | Can Edit |
| Program (NQMS-Only) | No Access |
| Program (Contractor) | No Access |

**Note:** NQMS-only users and contractors cannot manage accounts.

---

### Partners
**What it is:** Managing partner organizations (system-wide)

| Role | Access Level |
|------|--------------|
| Global Admin | Can Edit |
| All Other Roles | No Access |

**Note:** Only Global Admins can manage partners.

---

### Reports
**What it is:** Reporting and analytics

| Role | Access Level |
|------|--------------|
| Global Admin | Can View |
| Affiliate (Full) | Can View |
| Affiliate (MC-Only) | No Access |
| Affiliate (NQMS-Only) | Can View |
| Affiliate (Contractor) | No Access |
| Program (Full/MC) | Can View |
| Program (NQMS-Only) | Can View |
| Program (Contractor) | No Access |

**Note:** MC-only users and contractors don't have report access.

---

### NQMS Assessments
**What it is:** Quality assessment creation, editing, and management

| Role | Access Level |
|------|--------------|
| Global Admin | Can Edit |
| Affiliate (Full) | Can Edit |
| Affiliate (MC-Only) | No Access |
| Affiliate (NQMS-Only) | Can Edit |
| Affiliate (Contractor) | Can Edit (latest only) |
| Program (Full/MC) | Can Edit |
| Program (NQMS-Only) | Can Edit |
| Program (Contractor) | Can Edit (latest only) |

**Special Actions:**
- **Approve Assessment:** Only Global Admin and Affiliate users (not Program users)
- **Archive Assessment:** Only Global Admin and Affiliate users (not Program users)

**Note:** Contractors can only access the most recent assessment.

---

### NQMS Admin (Question Templates)
**What it is:** Managing NQMS assessment question templates

| Role | Access Level |
|------|--------------|
| Global Admin | Can Edit |
| All Other Roles | No Access |

**Note:** Only Global Admins can manage question templates.

---

## Common Scenarios

### Scenario 1: New Affiliate Administrator
**Name:** Jane
**Role:** Affiliate coordinator managing both recruitment and quality

**Setup:**
1. Create user account
2. Go to Affiliates tab
3. Add affiliate assignment
4. Select: **Full Access**
5. Leave "Limited Contractor" unchecked

**Result:** Jane can manage volunteer inquiries AND NQMS assessments for all programs in her affiliate's service area. She can also approve assessments.

---

### Scenario 2: Program Volunteer Coordinator
**Name:** Vis
**Role:** Manages volunteer inquiries for his program only

**Setup:**
1. Create user account
2. Go to Programs tab
3. Add program assignment
4. Select: **Full Access** (or MC-Access Only - same result)
5. Leave "Limited Contractor" unchecked

**Result:** Vis can manage inquiries, searches, and assessments for his program. However, he CANNOT approve assessments - only affiliate staff can do that.

---

### Scenario 3: NQMS Quality Consultant
**Name:** Steve
**Role:** External consultant helping programs with NQMS assessments

**Setup:**
1. Create user account
2. Go to Affiliates tab (or Programs tab if program-specific)
3. Add assignment
4. Select: **NQMS-Access Only**
5. Leave "Limited Contractor" unchecked

**Result:** Steve can work on NQMS assessments but has no access to volunteer inquiries or recruitment features.

---

### Scenario 4: Limited Contractor
**Name:** Peggy
**Role:** External contractor with very restricted access

**Setup:**
1. Create user account
2. Go to Programs tab
3. Add program assignment
4. Select: **NQMS-Access Only**
5. Check: **Limited Contractor**

**Result:** Peggy can only access the LATEST assessment for her assigned program. She cannot see historical assessments, cannot approve, and cannot manage users.

---

### Scenario 5: Marketing Associate (MC-Only)
**Name:** Wanda
**Role:** Handles volunteer recruitment follow-up only

**Setup:**
1. Create user account
2. Go to Affiliates tab
3. Add affiliate assignment
4. Select: **MC-Access Only**
5. Leave "Limited Contractor" unchecked

**Result:** Wanda can manage inquiries and searches but has NO access to NQMS features.

---

### Scenario 6: Program Evaluation Staff (NQMS-Only)
**Name:** Thor
**Role:** Program staff member focused on quality assessment

**Setup:**
1. Create user account
2. Go to Programs tab
3. Add program assignment
4. Select: **NQMS-Access Only**
5. Leave "Limited Contractor" unchecked

**Result:** Thor can work on NQMS assessments and goals but cannot access volunteer inquiries or edit program details.

---

## How to Assign Roles

### Step-by-Step: Creating a New User

1. **Navigate to Users**
   - Click "Accounts" in the main menu
   - Click "Add User" button

2. **Fill Out Basic Information**
   - First Name
   - Last Name
   - Email (this will be their login)
   - Set a temporary password

3. **Determine if They Need Superuser Access**
   - Only check "Is Superuser" for system administrators
   - This gives complete access to everything

4. **Assign to Affiliate or Program (or both)**

   **For Affiliate Assignment:**
   - Click "Affiliates" tab
   - Click "Add Assignment"
   - Select the affiliate from dropdown
   - Choose Access Level (Full, MC-Only, or NQMS-Only)
   - Check "Limited Contractor" if applicable
   - Save

   **For Program Assignment:**
   - Click "Programs" tab
   - Click "Add Assignment"
   - Select the program from dropdown
   - Choose Access Level (Full, MC-Only, or NQMS-Only)
   - Check "Limited Contractor" if applicable
   - Save

5. **Save User**
   - Click "Save" button
   - System automatically assigns the appropriate role

6. **Notify User**
   - Send login credentials
   - Explain what they can access
   - Provide training if needed

---

### Decision Tree: Which Access Level?

```
Does the user need to manage NQMS question templates or multiple affiliates?
│
├─ YES → Make them a Global Admin (check "Is Superuser")
│
└─ NO → Continue...
    │
    Does the user work at an Affiliate or a specific Program?
    │
    ├─ AFFILIATE
    │   │
    │   Do they need BOTH volunteer inquiries AND NQMS assessments?
    │   │
    │   ├─ YES → Assign: Full Access
    │   │
    │   ├─ ONLY volunteer inquiries → Assign: MC-Access Only
    │   │
    │   └─ ONLY NQMS assessments → Assign: NQMS-Access Only
    │       │
    │       └─ Are they a contractor? → Check "Limited Contractor"
    │
    └─ PROGRAM
        │
        Do they need BOTH volunteer inquiries AND NQMS assessments?
        │
        ├─ YES → Assign: Full Access
        │
        ├─ ONLY volunteer inquiries → Assign: Full Access (or MC-Access Only)
        │
        └─ ONLY NQMS assessments → Assign: NQMS-Access Only
            │
            └─ Are they a contractor? → Check "Limited Contractor"
```

---

## Important Business Rules

### Rule 1: Assessment Approval Requires Affiliate Assignment

**THE MOST IMPORTANT RULE TO UNDERSTAND**

**What this means:**
- Program users can CREATE and EDIT assessments
- But they CANNOT APPROVE their own assessments
- Only affiliate staff can approve assessments

**Why this matters:**
This enforces oversight and quality control. Programs fill out their own assessments, but an affiliate staff member (who oversees multiple programs) must review and approve them.

**Example:**
- **Thor** is a Program User with Full Access
- He creates an assessment for his program
- He fills it out and submits it for review
- **Jane** (Affiliate User) reviews it
- **Jane** approves the assessment (Thor cannot approve it himself)

**How the system knows who can approve:**
- Affiliate users automatically have access to programs in their service area (based on ZIP codes)
- Program users only have access to their own program
- The system checks if you have an affiliate relationship before allowing approval

---

### Rule 2: Geographic Permissions for Affiliate Users

**What this means:**
- Affiliate users can access programs based on geographic service areas
- Programs and affiliates are linked by ZIP codes
- You don't need to manually assign each program to an affiliate user

**Example:**
- **Affiliate A** serves ZIP codes: 20001, 20002, 20003
- **Program X** is located in ZIP code 20002
- **Jane** is assigned to Affiliate A with Full Access
- **Jane** automatically gets access to Program X (and any other programs in those ZIP codes)

**Why this matters:**
When you assign someone to an affiliate, they automatically get access to ALL programs in that affiliate's service area.

---

### Rule 3: Limited Contractors Can Only See Latest Assessment

**What this means:**
- Contractors flagged as "Limited Contractor" can only access the most recent assessment
- They cannot view historical assessments

**Why this matters:**
- Protects historical quality data
- Gives contractors just enough access to do their job
- Prevents access to sensitive historical information

**Example:**
- **Program Y** has 3 assessments: 2020, 2023, and 2025 (latest)
- **Peggy** is a Limited Contractor
- **Peggy** can access the 2025 assessment only
- She cannot view or edit the 2020 or 2023 assessments

---

### Rule 4: MC-Only Users Cannot Access NQMS Features

**What this means:**
- Users with "MC-Access Only" have ZERO access to NQMS
- They cannot even see the NQMS tab in the navigation

**Why this matters:**
- Complete separation between recruitment (MC) and quality (NQMS) functions
- Some staff only need recruitment access

**Example:**
- **Wanda** has MC-Access Only
- She can manage volunteer inquiries and searches
- She cannot see assessments, goals, or quality reports
- The system completely hides NQMS features from her

---

### Rule 5: Contractors Must Have NQMS-Access Only

**What this means:**
- The "Limited Contractor" checkbox only works with NQMS-Access Only
- You cannot make a contractor with Full Access or MC-Access Only

**Why this matters:**
- Contractors are meant for limited NQMS work only
- If you check "Limited Contractor" but select "Full Access," the system ignores the contractor flag

**How to avoid mistakes:**
- Always select "NQMS-Access Only" when checking "Limited Contractor"
- The system should validate this (but may not currently)

---

### Rule 6: Users Can Have Multiple Roles

**What this means:**
- A single user can be assigned to multiple affiliates and/or programs
- They get the combined permissions from all assignments

**Example:**
- **Jane** is assigned to:
  - Affiliate A (Full Access)
  - Program B (NQMS-Only)
- **Jane** gets:
  - Full affiliate permissions (from Affiliate A assignment)
  - NQMS access to Program B (from Program B assignment)
- She can do everything an Affiliate Full Access user can do, PLUS work on Program B specifically

**Why this matters:**
- Flexibility for users who wear multiple hats
- Permissions are additive (you get the MOST permissive combination)

---

### Rule 7: Navigation Menu Adapts to Permissions

**What this means:**
- Users only see modules they have access to
- If you have no access to a module, it won't appear in your menu

**Example:**
- **Wanda** (MC-Only) sees: Programs, Affiliates, Inquiries, Searches, Accounts, Reports
- **Wanda** does NOT see: NQMS tab, NQMS Admin, Partners
- **Jane** (Full Access) sees: Everything except NQMS Admin and Partners

---

## Troubleshooting Access Issues

### Problem: User can't log in

**Check:**
1. Is the user account active?
   - Go to Users → Find user → Check "Active" status
2. Is the user verified?
   - Check "Verified" status
3. Is the password correct?
   - Reset password and try again

**Solution:**
- Make sure both "Active" and "Verified" are checked
- Reset password if needed

---

### Problem: User can't see a module they should have access to

**Check:**
1. What is their access level?
   - Full Access, MC-Only, or NQMS-Only?
2. Are they assigned to the right affiliate or program?
   - Check Affiliates/Programs tabs on user profile
3. Is the assignment saved?
   - Sometimes assignments don't save properly

**Solution:**
- Verify their access level matches their needs
- Re-save their affiliate/program assignment
- Log out and back in

---

### Problem: User can see a module but can't edit

**This is usually expected behavior.**

**Common scenarios:**
- NQMS-only users can VIEW programs but cannot EDIT them
- Program users can VIEW affiliate info but cannot EDIT it
- Limited contractors can VIEW old assessments but cannot EDIT them (actually, they can't even view them)

**Check the permission matrix** in this document to see if this is expected.

---

### Problem: Program user can't approve assessment

**This is expected behavior - not a bug!**

**Why:**
- Only affiliate staff can approve assessments
- Program users can create and edit, but not approve
- This enforces quality oversight

**Solution:**
- Have an affiliate user review and approve the assessment
- If the program user needs approval authority, assign them to the affiliate (not just the program)

---

### Problem: Affiliate user can't access a program

**Check:**
1. Does the affiliate have ZIP codes assigned?
   - Go to Affiliates → Edit → Check ZIP codes
2. Does the program have a matching ZIP code?
   - Go to Programs → Edit → Check ZIP code
3. Is the user's access level correct?
   - NQMS-only users can VIEW but not EDIT programs

**Solution:**
- Ensure affiliate has correct service area ZIP codes
- Ensure program has correct location ZIP code
- Match the two up

---

### Problem: Contractor can't access old assessments

**This is expected behavior!**

**Why:**
- Limited contractors can ONLY access the latest assessment
- This is a security feature to protect historical data

**Solution:**
- If contractor needs historical access, remove the "Limited Contractor" flag
- Or assign them as a regular NQMS-only user instead

---

### Problem: MC-Only user can't access NQMS features

**This is expected behavior!**

**Why:**
- MC-Access Only completely excludes NQMS
- Intentional separation of concerns

**Solution:**
- Change their access level to "Full Access" if they need both MC and NQMS
- Or add a second assignment with NQMS-Access Only

---

### Problem: User has too much access

**Check:**
1. Do they have multiple assignments?
   - Check both Affiliates and Programs tabs
2. Are they accidentally marked as Superuser?
   - Check "Is Superuser" checkbox

**Solution:**
- Remove unnecessary assignments
- Uncheck "Is Superuser" if appropriate
- Choose the most restrictive access level that meets their needs

---

## Quick Reference: Role Comparison

| Feature | Global Admin | Affiliate Full | Affiliate MC | Affiliate NQMS | Program Full | Program NQMS | Contractors |
|---------|--------------|----------------|--------------|----------------|--------------|--------------|-------------|
| **Volunteer Inquiries** | ✅ | ✅ | ✅ | ❌ | ✅ | ❌ | ❌ |
| **Searches** | ✅ | ✅ | ✅ | ❌ | ✅ | ❌ | ❌ |
| **Edit Programs** | ✅ | ✅ | ✅ | View Only | ✅ | View Only | View Only |
| **Edit Affiliates** | ✅ | ✅ | ✅ | View Only | ❌ | ❌ | ❌ |
| **User Management** | ✅ | ✅ | ✅ | ❌ | ✅ | ❌ | ❌ |
| **Reports** | ✅ | ✅ | ❌ | ✅ | ✅ | ✅ | ❌ |
| **NQMS Assessments** | ✅ | ✅ | ❌ | ✅ | ✅ | ✅ | ✅* |
| **Approve Assessments** | ✅ | ✅ | ❌ | ✅ | ❌ | ❌ | ❌ |
| **Archive Assessments** | ✅ | ✅ | ❌ | ✅ | ❌ | ❌ | ❌ |
| **NQMS Goals** | ✅ | ✅ | ❌ | ✅ | ✅ | ✅ | ✅ |
| **Partners** | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| **NQMS Admin** | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| **Old Assessments** | ✅ | ✅ | ❌ | ✅ | ✅ | ✅ | ❌ |

*Contractors can only access latest assessment

---

## Summary

### Key Takeaways

1. **Access Level determines what features you can use**
   - Full Access = Both MC and NQMS
   - MC-Only = Recruitment only
   - NQMS-Only = Quality assessments only

2. **Affiliate vs Program assignment determines your scope**
   - Affiliate users = Multiple programs in a service area
   - Program users = Single program only

3. **Only affiliate users can approve assessments**
   - Program users fill them out
   - Affiliate users approve them
   - This is intentional for quality oversight

4. **Limited Contractors have restricted access**
   - Latest assessment only
   - Cannot approve or archive
   - NQMS-only features

5. **Geographic permissions are automatic**
   - Affiliate users get access via ZIP codes
   - No need to assign each program individually

6. **Permissions are additive**
   - Multiple assignments = combined permissions
   - You get the most permissive access

---

**Need More Help?**
- See NQMS_ASSESSMENT_BUSINESS_GUIDE.md for detailed assessment workflow
- See QA_TESTING_GUIDE.md for testing scenarios
- Contact your system administrator for access issues

---

**END OF DOCUMENT**
