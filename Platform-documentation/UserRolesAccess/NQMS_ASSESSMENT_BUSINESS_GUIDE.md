# NQMS Assessment Workflow - Business Guide

**Version:** 1.0
**Last Updated:** December 3, 2025
**Audience:** Business Users, QA Testers, Program & Affiliate Staff

---

## Table of Contents

1. [What is an NQMS Assessment?](#what-is-an-nqms-assessment)
2. [Assessment Workflow Overview](#assessment-workflow-overview)
3. [Assessment Status Explained](#assessment-status-explained)
4. [Who Can Do What?](#who-can-do-what)
5. [Step-by-Step: Creating an Assessment](#step-by-step-creating-an-assessment)
6. [Step-by-Step: Filling Out an Assessment](#step-by-step-filling-out-an-assessment)
7. [Step-by-Step: Submitting for Review](#step-by-step-submitting-for-review)
8. [Step-by-Step: Approving an Assessment](#step-by-step-approving-an-assessment)
9. [Goals Management](#goals-management)
10. [Other Assessment Actions](#other-assessment-actions)
11. [Critical Business Rules](#critical-business-rules)
12. [Common Questions](#common-questions)
13. [Troubleshooting](#troubleshooting)

---

## What is an NQMS Assessment?

NQMS (National Quality Mentoring System) assessments are quality evaluations that programs complete every 3 years. They measure how well a mentoring program meets quality standards across various areas like program design, recruitment, training, and evaluation.

### Key Facts

- **Frequency:** Every 3 years
- **Duration:** Can take several weeks to complete
- **Participants:** Program staff fill it out, affiliate staff approve it
- **Outcome:** Identifies strengths and areas for improvement
- **Follow-up:** Programs set goals for improvement areas

---

## Assessment Workflow Overview

### Visual Workflow

```
START
  ↓
[1] CREATE ASSESSMENT
    Program staff click "Start Self Assessment"
  ↓
[2] IN-PROGRESS
    Program staff answer questions, upload evidence
    Can save and return multiple times
  ↓
[3] SUBMIT FOR REVIEW
    Program staff click "Submit for Review"
    Email sent to affiliate staff
  ↓
[4] PENDING REVIEW
    Affiliate staff review responses
    Can request changes (goes back to in-progress)
  ↓
[5] APPROVE ASSESSMENT
    Affiliate staff click "Approve Assessment"
    Email sent to program staff
    3-year reminder created
  ↓
[6] COMPLETED (APPROVED)
    Assessment is now read-only
    Can set improvement goals
  ↓
[7] GOALS SETTING
    Create goals for low-scoring areas
    Track progress over time
  ↓
[8] GOAL COMPLETED
    All goals achieved
    Assessment cycle complete
  ↓
END
```

---

## Assessment Status Explained

### Status 1: (No Status) or In-Progress
**What it means:** Assessment is actively being filled out

**Who can see it:**
- Program staff assigned to the program
- Affiliate staff for that service area
- NQMS consultants/contractors

**What you can do:**
- Edit all question responses
- Add comments and notes
- Upload evidence files
- Save draft and return later
- Submit for review

---

### Status 2: Pending Review
**What it means:** Program has submitted assessment for affiliate review

**How you get here:** Program staff clicks "Submit for Review"

**Who can see it:**
- Same as in-progress (program staff, affiliate staff, contractors)

**What you can do:**
- Program staff can STILL edit (in case changes are needed)
- Affiliate staff can approve
- Anyone can view

**Email notification:** Sent to affiliate staff when submitted

---

### Status 3: Completed (Approved)
**What it means:** Affiliate staff has approved the assessment

**How you get here:** Affiliate staff clicks "Approve Assessment"

**Who can see it:**
- Everyone who could see it before

**What you can do:**
- View assessment (read-only, no more edits)
- Print assessment
- Export assessment
- Create improvement goals
- Archive assessment (affiliate staff only)

**Email notification:** Sent to program staff when approved

**Automatic action:** System creates 3-year renewal reminder

---

### Status 4: Goals Completed
**What it means:** All improvement goals have been achieved

**How you get here:** Automatically when all goals reach their targets

**This is the final status** - assessment cycle is complete!

---

## Who Can Do What?

### Complete Permission Matrix

| Action | Global Admin | Affiliate Full | Affiliate NQMS | Program Full | Program NQMS | Contractors |
|--------|--------------|----------------|----------------|--------------|--------------|-------------|
| **Create Assessment** | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| **Edit In-Progress Assessment** | ✅ | ✅ | ✅ | ✅ | ✅ | ✅* |
| **Submit for Review** | ✅ | ✅ | ✅ | ✅ | ✅ | ✅* |
| **Edit Pending Assessment** | ✅ | ✅ | ✅ | ✅ | ✅ | ✅* |
| **Approve Assessment** | ✅ | ✅ | ✅ | ❌ | ❌ | ❌ |
| **View Approved Assessment** | ✅ | ✅ | ✅ | ✅ | ✅ | ✅* |
| **Edit Approved Assessment** | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| **Archive Assessment** | ✅ | ✅ | ✅ | ❌ | ❌ | ❌ |
| **Preview Assessment** | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| **Export to CSV** | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| **Print Assessment** | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| **Create Goal** | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| **Edit Goal** | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| **Delete Goal** | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| **View Old Assessments** | ✅ | ✅ | ✅ | ✅ | ✅ | ❌ |

*Contractors can only access the LATEST assessment

### Key Restrictions

1. **Program staff CANNOT approve their own assessments**
   - Only affiliate staff can approve
   - This enforces quality oversight

2. **Contractors can ONLY see the latest assessment**
   - Historical assessments are blocked
   - Protects past quality data

3. **Completed assessments CANNOT be edited**
   - Once approved, they're permanently read-only
   - Maintains assessment integrity

4. **Only affiliate staff can archive**
   - Program staff cannot archive even their own assessments
   - Requires affiliate oversight

---

## Step-by-Step: Creating an Assessment

### When to Create

- Program hasn't had an assessment in 3 years
- Starting a new assessment cycle
- Need to baseline current quality standards

### Who Can Create

- Program staff (full access or NQMS-only)
- Affiliate staff
- NQMS consultants/contractors
- Global admins

### How to Create

1. **Navigate to the Program**
   - Click "Programs" in main menu
   - Find your program in the list
   - Click the program name

2. **Go to NQMS Tab**
   - Click the "NQMS" tab on the program page
   - You'll see a list of past assessments (if any)

3. **Start New Assessment**
   - Click "Start Self Assessment" button
   - System creates a new assessment
   - Assessment title: "{Current Year} Self-Assessment"

4. **Automatic Setup**
   - System copies all current NQMS questions
   - Creates blank response fields
   - Sets status to "In-Progress"

5. **Ready to Fill Out**
   - You'll be redirected to the edit page
   - Can start answering questions immediately

---

## Step-by-Step: Filling Out an Assessment

### Before You Start

**Gather:**
- Program documentation
- Evidence of quality practices
- Data and metrics
- Input from staff

**Plan:**
- Assessment takes several hours to complete
- Can save and return multiple times
- Involve multiple staff members if needed

### How to Fill Out

1. **Open the Assessment**
   - Go to program → NQMS tab
   - Click the in-progress assessment

2. **Answer Questions by Section**
   - Questions organized by topic areas
   - Each question has:
     - Question text
     - Rating scale (usually 0-5 or N/A)
     - Comment box
     - File upload option

3. **Provide Ratings**
   - Select appropriate rating for each question
   - Be honest and accurate
   - Consider using N/A if question doesn't apply

4. **Add Comments**
   - Explain your rating
   - Provide context and examples
   - Describe your practices

5. **Upload Evidence**
   - Supporting documents
   - Policies and procedures
   - Training materials
   - Data reports
   - Click "Upload" next to each question

6. **Save Your Progress**
   - Click "Save" button at any time
   - Progress is saved automatically
   - Can log out and return later

7. **Review Before Submitting**
   - Check all sections are complete
   - Review ratings for consistency
   - Ensure comments are clear
   - Verify evidence files uploaded

---

## Step-by-Step: Submitting for Review

### When to Submit

- All questions answered
- Evidence uploaded
- Staff reviewed responses
- Ready for affiliate approval

### Who Can Submit

- Program staff (the ones filling it out)
- Affiliate staff (if helping)
- NQMS consultants

### How to Submit

1. **Open the Assessment**
   - Go to program → NQMS tab
   - Click the assessment

2. **Final Review**
   - Scroll through all sections
   - Check for completeness
   - Ensure quality of responses

3. **Submit**
   - Click "Submit for Review" button
   - Confirm submission
   - Status changes to "Pending Review"

4. **What Happens Next**
   - Email sent to affiliate staff
   - Affiliate staff will review
   - You can still edit if needed
   - Wait for affiliate approval

### Can You Still Edit After Submitting?

**Yes!** Even after submitting for review, you can still:
- Make changes if needed
- Fix typos
- Add more evidence
- Improve comments

The "Pending Review" status is not locked - it just signals to affiliate staff that you're ready for their review.

---

## Step-by-Step: Approving an Assessment

### Who Can Approve

**ONLY these roles:**
- Affiliate staff (Full Access or NQMS-Only)
- Global Admins

**CANNOT approve:**
- Program staff (even full access)
- Contractors
- This is intentional for quality oversight!

### How to Approve

1. **Receive Notification**
   - Email when assessment submitted
   - Or check program NQMS tabs regularly

2. **Open the Assessment**
   - Navigate to the program
   - Click NQMS tab
   - Click the pending assessment

3. **Review Responses**
   - Read through all sections
   - Check ratings for accuracy
   - Review comments and evidence
   - Note any concerns

4. **Request Changes (If Needed)**
   - Contact program staff
   - They can edit while pending
   - Review again after changes

5. **Approve the Assessment**
   - Once satisfied with quality
   - Click "Approve Assessment" button
   - Confirm approval

6. **What Happens After Approval**
   - Status changes to "Completed"
   - Email sent to program staff
   - Assessment becomes read-only
   - 3-year reminder created automatically
   - Program can now set improvement goals

### Why Can't Program Staff Approve?

This is a critical business rule:

**Reason:** Quality oversight and accountability
- Programs fill out their own assessments (self-assessment)
- But they shouldn't approve their own work
- Affiliate staff review and approve (external validation)
- This ensures quality standards are met
- Provides consistency across programs in the region

**Example:**
- Thor (Program Director) completes his program's assessment
- Jane (Affiliate Quality Coordinator) reviews and approves it
- Thor cannot approve his own assessment - only Jane can

---

## Goals Management

### What Are Goals?

Goals are improvement objectives set for areas where a program scored below their target. They help programs track progress toward higher quality standards.

### When to Create Goals

- After assessment is approved
- For questions with low ratings
- For areas needing improvement
- As part of quality improvement plan

### Who Can Create Goals

- Program staff (full or NQMS access)
- Affiliate staff
- NQMS consultants/contractors
- Same permissions as editing assessments

### How to Create a Goal

1. **Open Approved Assessment**
   - Go to program → NQMS tab
   - Click the approved assessment

2. **Find Low-Scoring Question**
   - Look for ratings below target
   - Example: Scored 2, but should be 4

3. **Click "Create Goal"**
   - Button next to the question
   - Opens goal creation form

4. **Fill Out Goal Details**

   **Name:** (Required)
   - Short title for the goal
   - Example: "Improve volunteer training program"

   **Baseline Score:** (Automatically filled)
   - Current rating from assessment
   - Example: 2

   **Target Score:** (Required)
   - What you want to achieve
   - Example: 4

   **Start Date:** (Required)
   - When you'll begin working on this
   - Example: Today or next month

   **Target Completion Date:** (Required)
   - When you plan to achieve target
   - Must be after start date
   - Example: 6 months from start

   **Action Plan / Notes:** (Required)
   - Describe what you'll do
   - Steps to take
   - Resources needed
   - Example: "Develop new training manual, conduct quarterly workshops, survey volunteers for feedback"

   **Documents:**
   - Upload supporting files
   - Plans, resources, templates

5. **Save Goal**
   - Click "Save"
   - Goal appears in assessment view
   - Status: "Incomplete"

### Goal Status

Goals have three statuses based on progress:

#### Incomplete
- No progress yet
- Achieved score = baseline score (or not set)
- Status displays as "Incomplete" (red)

#### Partially Complete
- Some progress made
- Achieved score > baseline but < target
- Example: Baseline 2, achieved 3, target 4
- Status displays as "Partially Complete" (yellow)

#### Completed
- Goal target met or exceeded
- Achieved score >= target score
- Example: Baseline 2, achieved 4, target 4
- Status displays as "Completed" (green)

### Tracking Goal Progress

1. **Update Regularly**
   - Review goals quarterly
   - Update achieved score as you improve
   - Add notes about progress

2. **Edit Goal**
   - Click "Edit" on the goal
   - Update "Achieved Score" field
   - Add "Achievement Notes"
   - Save

3. **Status Updates Automatically**
   - System calculates status based on scores
   - No need to set status manually

4. **When All Goals Complete**
   - Assessment status automatically changes to "Goals Completed"
   - If you add new goals or mark incomplete, reverts to "Completed"

### Deleting Goals

- Click "Delete" button on goal
- Confirm deletion
- Goal removed from assessment
- If this makes all remaining goals complete, assessment status updates

---

## Other Assessment Actions

### Preview Assessment

**Purpose:** See what the exported CSV will look like

**Who can do it:** Anyone who can view the assessment

**How:**
1. Open assessment
2. Click "Preview" button
3. View table format of all responses
4. Check before exporting

---

### Export Assessment to CSV

**Purpose:** Download assessment data for reporting or analysis

**Who can do it:** Anyone who can view the assessment

**How:**
1. Open assessment
2. Click "Export" button (or "Export" after preview)
3. CSV file downloads
4. Filename: `{Program Name}-Self-Assessment-{Date}.csv`

**Contains:**
- All sections
- All questions
- All ratings
- All comments
- Evidence file links

---

### Print Assessment

**Purpose:** Create physical copy for records or presentations

**Who can do it:** Anyone who can view the assessment

**How:**
1. Open assessment
2. Click "Print" button
3. Browser print dialog opens
4. Select printer or save as PDF
5. Print

---

### Archive Assessment

**Purpose:** Remove old/incorrect assessments from view

**Who can do it:** ONLY Affiliate staff and Global Admins

**When to use:**
- Assessment created by mistake
- Duplicate assessment
- Assessment no longer relevant
- Old assessment needs to be hidden

**How:**
1. Open the assessment
2. Click "Archive" button (affiliate staff only)
3. Confirm archival
4. Assessment marked as archived
5. No longer appears in assessment list

**Important:**
- Archived assessments are not deleted, just hidden
- Can be recovered by support team if needed
- Program staff cannot archive assessments

---

## Critical Business Rules

### Rule 1: Assessment Approval Requires Affiliate Staff

**THE MOST IMPORTANT RULE**

**What it means:**
- Program staff can CREATE and EDIT assessments
- But they CANNOT APPROVE their own assessments
- Only affiliate staff (who oversee multiple programs) can approve

**Why:**
- Ensures quality oversight
- Prevents programs from self-approving
- Provides consistency across the region
- External validation of quality standards

**Example:**
```
❌ WRONG:
Thor (Program User) creates assessment
Thor fills it out
Thor approves it himself ← NOT ALLOWED

✅ CORRECT:
Thor (Program User) creates assessment
Thor fills it out
Thor submits for review
Jane (Affiliate User) reviews it
Jane approves it ← ONLY Jane can approve
```

**How the system knows:**
- Affiliate users are assigned to affiliates
- Affiliates have service area ZIP codes
- Programs have location ZIP codes
- If affiliate's ZIP codes include the program's ZIP, they can approve
- Program users don't have this affiliate relationship

---

### Rule 2: Contractors Can Only Access Latest Assessment

**What it means:**
- Contractors flagged as "Limited Contractor" can only see the most recent assessment
- They cannot view or edit historical assessments

**Why:**
- Protects historical quality data
- Limits contractor access to current work only
- Security and privacy measure

**Example:**
```
Program has 3 assessments:
- 2020 Assessment (old)
- 2023 Assessment (old)
- 2025 Assessment (latest)

Contractor sees:
✅ 2025 Assessment (can view and edit)
❌ 2023 Assessment (blocked - "Not Authorized")
❌ 2020 Assessment (blocked - "Not Authorized")
```

---

### Rule 3: Completed Assessments Cannot Be Edited

**What it means:**
- Once an assessment is approved, it becomes permanently read-only
- NO ONE can edit it (not even Global Admins through the interface)

**Why:**
- Maintains assessment integrity
- Preserves historical record
- Prevents post-approval changes

**Workarounds:**
- If assessment approved by mistake → Archive it and create new one
- If small correction needed → Contact support team

---

### Rule 4: Goals Automatically Update Assessment Status

**What it means:**
- When ALL goals are completed → Status changes to "Goals Completed"
- When ANY goal is incomplete → Status reverts to "Completed"
- This happens automatically

**Why:**
- Tracks overall quality improvement
- Shows when improvement cycle is done
- Automated for accuracy

**Example:**
```
Assessment approved → Status: "Completed"
Create Goal 1 → Status: "Completed" (goal incomplete)
Create Goal 2 → Status: "Completed" (goals incomplete)
Complete Goal 1 → Status: "Completed" (Goal 2 still incomplete)
Complete Goal 2 → Status: "Goals Completed" ✅
Add Goal 3 (incomplete) → Status: "Completed" (reverted)
```

---

### Rule 5: MC-Only Users Cannot Access NQMS

**What it means:**
- Users with "MC-Access Only" have ZERO access to assessments
- Complete separation between recruitment and quality features

**Why:**
- Different staff roles
- Some users only handle volunteer recruitment
- Don't need quality assessment access

**Example:**
```
Wanda (MC-Access Only):
✅ Can manage volunteer inquiries
✅ Can create searches
❌ Cannot see NQMS tab
❌ Cannot view assessments
❌ Cannot access quality features
```

---

### Rule 6: Status Transitions Are One-Way

**What it means:**
- Assessments can only move forward through statuses
- Cannot roll back to previous status

**Status Flow:**
```
In-Progress → Pending Review → Completed → Goals Completed
     ↓              ↓              ↓              ↓
   (forward only - no going back)
```

**Implications:**
- Cannot move from "Completed" back to "Pending Review"
- Cannot move from "Pending Review" back to "In-Progress"
- If approval was mistake → Must archive and create new

---

### Rule 7: 3-Year Assessment Cycle

**What it means:**
- When assessment is approved, system creates reminder for 3 years later
- Reminds affiliate staff when next assessment is due

**Automatic Reminder Details:**
- **Title:** "{Program Name} - Self-Assessment Expires"
- **Due Date:** Approval date + 3 years
- **Assigned To:** Affiliate staff with NQMS access
- **Purpose:** Start next assessment cycle

**Example:**
```
Assessment approved: January 15, 2025
Reminder created with due date: January 15, 2028
Affiliate staff will be notified to start new assessment
```

---

## Common Questions

### Q1: Who should fill out the assessment - program or affiliate?

**Answer:** Program staff should fill it out (self-assessment), but affiliate staff must approve it.

- **Program staff:** Answer questions, upload evidence, know their program best
- **Affiliate staff:** Review responses, ensure quality, provide oversight

---

### Q2: Can we edit an assessment after submitting for review?

**Answer:** Yes! You can edit even after submission.

- "Pending Review" status is not locked
- Program can make changes if affiliate requests them
- Only becomes read-only after approval

---

### Q3: Why can't our Program Director approve our assessment?

**Answer:** This is intentional for quality oversight.

- Program users cannot approve their own assessments
- Only affiliate staff can approve
- Ensures external validation
- Prevents self-approval

---

### Q4: Can we delete an assessment if we made a mistake?

**Answer:** No, but you can archive it.

- No delete option (only archive)
- Archive is soft delete (hidden, not erased)
- Only affiliate staff can archive
- Contact support if you need help

---

### Q5: How do we access our 2023 assessment if we're working on 2025?

**Answer:** Depends on your role.

- **Regular staff:** Can access all past assessments
- **Contractors:** Can only access latest assessment
- Past assessments appear in the list on NQMS tab

---

### Q6: What happens if we don't complete all the goals?

**Answer:** Assessment status stays "Completed" instead of "Goals Completed".

- Goals are improvement objectives
- Not required to complete
- But tracked for quality improvement
- Status shows progress

---

### Q7: Can we have multiple assessments in progress at once?

**Answer:** Technically yes, but not recommended.

- System allows multiple assessments
- But confusing and not best practice
- Complete one before starting another
- Use the 3-year cycle

---

### Q8: Who gets notified when we submit for review?

**Answer:** Affiliate staff with NQMS access.

- Email sent automatically
- Includes link to assessment
- Notifies them to review and approve

---

### Q9: Can we export the assessment to share with our board?

**Answer:** Yes, multiple options.

- **Export to CSV:** Download data file
- **Print:** Create PDF via browser print
- **Preview:** View before exporting

---

### Q10: What if our affiliate staff person left - who approves now?

**Answer:** Any affiliate staff with NQMS access can approve.

- Not tied to specific person
- Any affiliate user with appropriate access
- Contact your affiliate to assign new reviewer

---

## Troubleshooting

### Problem: "Start Self Assessment" button not showing

**Possible Causes:**
1. You don't have NQMS access
   - Check your access level (should be Full Access or NQMS-Only, not MC-Only)
2. You're looking at the wrong program
   - Make sure you're on your assigned program

**Solution:**
- Contact your administrator to check your access level
- Verify you're assigned to the program

---

### Problem: Can't approve the assessment (no "Approve" button)

**Possible Causes:**
1. You're a program user (program users cannot approve)
2. You don't have affiliate assignment
3. Your affiliate's service area doesn't cover this program

**Solution:**
- If you're program staff: This is expected! Have affiliate staff approve
- If you're affiliate staff: Check your affiliate ZIP codes match program location
- Contact administrator if you should have affiliate access

---

### Problem: Can't see old assessments

**Possible Cause:**
- You're a Limited Contractor (only see latest assessment)

**Solution:**
- This is expected for contractors
- If you need historical access, contact administrator to remove contractor flag

---

### Problem: Assessment disappeared after archiving

**Possible Cause:**
- Assessment was archived (hidden, not deleted)

**Solution:**
- Archived assessments are hidden from normal view
- Contact support team if you need to recover it
- They can un-archive if needed

---

### Problem: Can't edit completed assessment

**Possible Cause:**
- This is expected behavior (approved assessments are read-only)

**Solution:**
- Cannot edit after approval
- If changes needed: Archive and create new assessment
- Or contact support for database update (not recommended)

---

### Problem: Status changed from "Goals Completed" back to "Completed"

**Possible Cause:**
- Someone added a new goal, or marked a goal as incomplete

**Solution:**
- This is automatic based on goal status
- Check all goals - make sure all are completed
- Once all goals complete again, status will update

---

### Problem: Email notifications not received

**Check:**
1. Email address correct in user profile?
2. Spam folder?
3. Email server issues?

**Solution:**
- Verify email in Accounts
- Check spam/junk folder
- Contact IT if ongoing issue

---

### Problem: Can't upload evidence files

**Possible Causes:**
1. File too large (check system limits)
2. File type not allowed
3. Browser issue

**Solution:**
- Try smaller file size
- Convert to PDF if needed
- Try different browser
- Contact support if persistent

---

## Summary

### Key Takeaways

1. **Assessment Lifecycle**
   - Create → Fill Out → Submit → Approve → Set Goals
   - Takes several weeks to complete
   - 3-year cycle

2. **Who Does What**
   - Program staff: Create and fill out
   - Affiliate staff: Review and approve
   - Contractors: Limited to latest assessment

3. **Critical Rule**
   - Program users CANNOT approve own assessments
   - Only affiliate staff can approve
   - This is intentional for quality oversight

4. **After Approval**
   - Assessment becomes read-only
   - Set improvement goals
   - Track progress over time

5. **Status Updates**
   - Manual: Submit for Review, Approve
   - Automatic: Goals Completed (based on goal progress)

---

**Need More Help?**
- See BUSINESS_PERMISSION_GUIDE.md for role details
- See QA_TESTING_GUIDE.md for testing scenarios
- Contact your affiliate coordinator or system administrator

---

**END OF DOCUMENT**
