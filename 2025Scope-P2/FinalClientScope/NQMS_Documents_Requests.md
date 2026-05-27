# NQMS Document Management Feature Requests

## Overview

This SOW covers 6 enhancement requests to the NQMS Document Management system that address usability gaps, efficiency improvements, and advanced document discovery capabilities.

**Requests Included:**

- Document Tagging System (Request 2) - Required for other requests
- Document Preview in Browser (Request 1A)
- Edit Document Metadata (Request 1D) - Missing basic functionality
- Batch Document Upload (Request 1C) - Major pain point
- Bulk Document Export (Request 1B)
- Global Document Search (Request 3) - Depends on Request 2

**Implementation Approach:** Requests have dependencies. Recommended phased approach:

- **Phase 1:** Request 2 (Tagging) + Request 1D (Edit) + Request 1A (Preview)
- **Phase 2:** Request 1C (Batch Upload) + Request 1B (Bulk Export)
- **Phase 3:** Request 3 (Global Search)

---

## Request 2: Document Tagging System

### Problem Statement

**Current State:**

Documents are only identified by their filename. There is no standardized way to categorize or classify documents:

- No ability to tag documents by type (e.g., "Training Curriculum", "Policies Manual", "Mentor Application")
- One document file may contain multiple document types
- Cannot search documents by type
- Cannot filter documents by category
- Reviewers must open files to understand their contents

### Business Impact

- Difficult for reviewers to find specific document types
- Cannot search across programs for documents of a certain type
- No standardization in document categorization
- Time wasted opening files to identify contents
- Cannot leverage existing documents as resources/templates

### Proposed Solution

**Approach:** Many-to-many tagging system with predefined document types

**How It Works:**

1. Create standardized list of document type tags
2. Add document type checkboxes to upload form (multi-select)
3. Display document types as badges/chips in document lists
4. Add filter capability by document type on program Documents tab
5. Enable tag editing in Edit Document form (Request 1D)

**Document Type Tags (Examples):**

- Theory of Change
- Logic Model
- Policies & Procedures Manual
- Mentee Recruitment Plan
- Mentee Eligibility Requirements
- Mentee Application
- Mentee &/or Family Interview Questions or Protocol
- Mentor Recruitment Plan
- Mentor Eligibility Requirements
- Mentor Application
- Mentor Orientation Materials
- Mentor Training Materials
- Mentor Interview Questions or Protocol
- Mentor Agreement Form
- Mentor "Job Description"
- Reference Check Questions
- Relationship Commitment Agreement
- Relationship Support Protocol
- Ongoing Training Materials or Calendar
- Matching Protocol
- Criteria for Re-Matching
- Summary or Example of Check-in Data
- Ending of Mentoring Relationships Protocol
- Exit Interview Questions or Protocol
- Organization Chart
- Staff Onboarding Materials
- Training Curriculum

### Acceptance Criteria

**Database & Model**

- [ ] Database created with predefined document type tags (25+ tags)
- [ ] Saving document with tags creates proper associations
- [ ] Deleting document removes tag associations

**Document Upload/Create Form**

- [ ] Document upload form includes document type checkboxes
- [ ] Checkboxes display all available document type tags
- [ ] Checkboxes organized in 2-3 columns for readability
- [ ] Multiple tags can be selected per document (multi-select)
- [ ] Tags are optional (not required) when uploading
- [ ] Section labeled "Document Type (check all that apply)"
- [ ] Tags save correctly when document is uploaded

**Document Display**

- [ ] Document list displays tags as badges/chips below document name
- [ ] Tags visually distinct (colored badges or pills)
- [ ] Multiple tags per document display correctly
- [ ] Documents without tags still display normally

**Document Filtering**

- [ ] "Filter by Document Type" accordion/dropdown added to Documents tab
- [ ] Filter shows all tag options as checkboxes
- [ ] Multiple tag filters can be selected (OR logic - show docs with ANY selected tag)
- [ ] Filter updates document list dynamically when selections change
- [ ] Filter accordion is collapsible/expandable
- [ ] Document count updates when filters applied (e.g., "Showing 6 of 20 documents")
- [ ] Filter persists during session
- [ ] Unselecting all filters shows all documents

**Document Edit Form**

- [ ] Edit document form includes tag checkboxes (requires Request 1D)
- [ ] Currently selected tags pre-checked when form loads
- [ ] Can add or remove tags when editing
- [ ] Tag changes save correctly

---

## Request 1A: Document Preview in Browser

### Problem Statement

**Current State:**

Users must download documents to view them. There is no in-browser preview capability:

- Only "Download" and "Delete" options available
- Must download every document to see contents
- Reviewers examining 30-50 documents must download each individually
- Downloads folder becomes cluttered with files
- Need to manually manage downloaded files

### Business Impact

- Slow review process for NQMS reviewers
- Poor user experience examining multiple documents
- Time wasted downloading, opening, and deleting files
- Cannot quickly scan document contents
- Reviewers may download same document multiple times

### Proposed Solution

**Approach:** Browser-native preview with inline content display

**How It Works:**

1. Add "Preview" button to document list (eye icon)
2. Opens document in new browser tab for native preview
3. Different file types handled by browser's built-in viewers
4. Uses same authorization as download

**Supported File Types:**

- **Natively previewable:** PDF, images (PNG, JPG, GIF), text files
- **Browser-dependent:** Office documents (depends on browser plugins/extensions)
- **Not previewable:** ZIP, executables (show message, offer download instead)

**User Experience:**

- User clicks "Preview" button (eye icon)
- New browser tab opens with document displayed
- User can view, zoom, print from browser
- User can close tab and return to document list
- Download still available as separate option

### Acceptance Criteria

- [ ] "Preview" button appears in document list Actions column
- [ ] Preview button uses eye icon
- [ ] Preview button visible to all users who can view documents
- [ ] Clicking preview opens document in new browser tab
- [ ] PDF files display in browser PDF viewer
- [ ] Image files (PNG, JPG, GIF) display in browser
- [ ] Text files display in browser
- [ ] Non-previewable files show message with download option
- [ ] Preview respects existing document permissions
- [ ] Preview action uses same authorization as download
- [ ] Preview does not trigger download
- [ ] Original filename preserved in preview
- [ ] Download button still available separately
- [ ] Preview works in Chrome, Firefox, Safari, Edge
- [ ] Large files (>10MB) display without timeout errors

---

## Request 1D: Edit Document Metadata

### Problem Statement

**Current State:**

Once a document is uploaded, there is no way to edit its metadata. This is a critical missing feature:

- Cannot edit document name after upload
- Cannot add or change document tags (once Request 2 implemented)
- Only option is to delete and re-upload the document
- Re-uploading loses upload history and metadata

### Business Impact

- Cannot correct typos or mistakes in document names
- Cannot update document information as needs change
- Forced to delete and re-upload to fix simple mistakes
- Time wasted re-uploading large files
- Loss of upload history and audit trail
- Poor user experience - basic CRUD functionality missing

### Proposed Solution

**Approach:** Standard edit form with metadata fields

**How It Works:**

1. Add "Edit" button to document list (pencil icon)
2. Create edit form/page showing editable fields:
   - Document name (text input, required)
   - Document type tags (checkboxes, requires Request 2)
   - Show current filename (read-only, not editable)
3. Save button updates metadata in database
4. File itself is not changed (metadata only)
5. Modified timestamp and user updated automatically

**What Can Be Edited:**

- ✅ Document name
- ✅ Document type tags (requires Request 2)
- ❌ Physical file (not in this request - consider separate versioning feature)
- ❌ Uploaded date (preserved)
- ❌ Uploaded by (preserved)

**Who Can Edit:**

- NQMS staff (affiliates/reviewers) can edit
- Program users: TBD based on client requirements (likely yes)

### Acceptance Criteria

- [ ] "Edit" button appears in document list Actions column
- [ ] Edit button uses pencil icon
- [ ] Edit button visible to users with edit permissions
- [ ] Clicking edit opens edit form (page or modal)
- [ ] Edit form shows current document name (editable)
- [ ] Edit form shows current document type tags (editable checkboxes, requires Request 2)
- [ ] Edit form shows current filename (read-only, not editable)
- [ ] Edit form has "Save Changes" and "Cancel" buttons
- [ ] Clicking Cancel returns to document list without saving
- [ ] Clicking Save validates form fields
- [ ] Document name is required (validation error if empty)
- [ ] Tags are optional (can be none selected)
- [ ] Saving updates document record in database
- [ ] Modified timestamp automatically updated
- [ ] Modified by field updated with current user
- [ ] Success message displayed after save
- [ ] User redirected back to document list after save
- [ ] Updated metadata immediately visible in document list
- [ ] Physical file is not changed
- [ ] Upload date and uploaded by are preserved
- [ ] Edit respects document permissions

---

## Request 1C: Batch Document Upload

### Problem Statement

**Current State:**

Programs can only upload one document at a time. This is a major pain point:

- Programs need to upload 30-50 documents to support assessments
- Each document requires separate upload action
- Must click "Upload", select file, enter name, select tags, save - 30 to 50 times
- Extremely tedious and time-consuming process
- Users may abandon uploads before completing all documents

### Business Impact

- Significant time waste for program staff
- Poor user experience discourages document uploads
- Programs may not upload all necessary documentation
- Delays in assessment completion
- User frustration with repetitive single-file process

### Proposed Solution

**Approach:** HTML5 multi-file upload with drag-and-drop and progress tracking

**How It Works:**

1. Add "+ Upload New Document" button on Documents tab
2. Opens modal with multi-file upload interface
3. Drag-and-drop zone: "DRAG & DROP HERE OR CLICK"
4. User selects/drops multiple files (2 or more)
5. Files appear in queue with file names and sizes
6. User can remove files from queue before upload
7. Filenames automatically used as document names (not editable in batch mode)
8. User selects document type tags to apply to ALL documents in the batch (optional)
9. "Save" button uploads all files with progress tracking
10. All selected tags applied to every document in the batch
11. Success message shows count of uploaded documents

**Metadata Handling for Batch Uploads:**

- **Document name:** Automatically derived from filename (e.g., "training-2024.pdf" → "Training 2024")
- Names are NOT editable during batch upload (to keep process efficient)
- Users can edit names after upload using Request 1D (Edit Document)
- **Document types (tags):** Tags selected before upload are applied to ALL documents in the batch
- Same tags applied to every document uploaded
- Requires Request 2 (Tagging System)
- Tags are optional (can upload without tags)

**Upload Processing:**

- Files uploaded sequentially (one at a time) for simplicity
- Progress bar shows overall upload progress
- Each file validated individually (file type, size, permissions)
- If one file fails, others continue uploading
- Summary at end: "25 files uploaded successfully, 2 failed"

**Batch Limits:**

- Max files per batch: 50 files
- Max individual file size: Same as current single upload limit (e.g., 10MB)
- Max total batch size: 100MB
- Limits displayed clearly in UI

### Acceptance Criteria

- [ ] "+ Upload New Document" button opens upload interface (modal or inline section)
- [ ] Upload interface shows drag-and-drop zone with message "DRAG & DROP HERE OR CLICK"
- [ ] User can drag multiple files onto drop zone
- [ ] User can click zone to open file picker (supports multi-select)
- [ ] Selected files appear in queue/list showing filename and file size
- [ ] User can remove individual files from queue before upload
- [ ] "Clear All" option to remove all files from queue
- [ ] Queue shows count: "5 files selected"
- [ ] When 2+ files selected: Document names automatically derived from filenames (NOT editable)
- [ ] Filename conversion shown in queue preview
- [ ] Document type checkboxes shown with label: "Apply these tags to ALL documents"
- [ ] Selected tags will be applied to every document in the batch
- [ ] Upload button disabled until at least 1 file selected
- [ ] "Save" button starts batch upload
- [ ] Progress bar shows overall upload progress (e.g., "Uploading 3 of 10 files...")
- [ ] Each file shows status: queued → uploading → success/failed
- [ ] If file fails, error message shown but others continue
- [ ] Success message shows count: "25 documents uploaded successfully"
- [ ] Failed uploads show error details
- [ ] Batch upload respects file size limits (per file and total)
- [ ] Batch upload respects file type restrictions
- [ ] Max 50 files per batch enforced
- [ ] Limits displayed in UI: "Max 50 files, 10MB per file"
- [ ] After successful upload, modal closes and document list refreshes
- [ ] Uploaded documents immediately visible in document list
- [ ] All documents in batch have the same selected tags applied
- [ ] All documents have names derived from their filenames

---

## Request 1B: Bulk Document Export

### Problem Statement

**Current State:**

Users can only download documents one at a time:

- Each document requires separate download action
- Reviewers examining 30-50 documents must download each individually
- No way to select multiple documents for download
- No "Export All" option

### Business Impact

- Time-consuming process for reviewers downloading many documents
- Poor user experience with repetitive downloading
- Cannot efficiently download entire document sets
- Reviewers waste time on repetitive clicks

### Proposed Solution

**Approach:** On-demand ZIP generation with checkbox selection

**How It Works:**

1. Add checkbox to each row in document list
2. Checkbox in table header for "Select All"
3. "Download Selected (X)" button appears when documents selected
4. Button shows count of selected documents
5. Clicking button generates ZIP file with all selected documents
6. ZIP downloads immediately to browser
7. "Clear Selection" button to deselect all

**ZIP File Details:**

- Filename format: {program_name}_documents_{YYYY-MM-DD}.zip
- Contains all selected documents with original filenames
- Generated on-demand (not pre-generated or stored)
- Streamed directly to browser download

### Acceptance Criteria

- [ ] Checkbox appears in each row of document list (first column)
- [ ] Checkbox in table header row for "Select All"
- [ ] Clicking header checkbox selects/deselects all visible documents
- [ ] "Download Selected (X)" button appears when at least 1 document selected
- [ ] Button shows count of selected documents (e.g., "Download Selected (8)")
- [ ] Button disabled when no documents selected
- [ ] "Clear Selection" button appears when documents selected
- [ ] Clicking "Clear Selection" unchecks all checkboxes
- [ ] Clicking "Download Selected" generates ZIP file
- [ ] ZIP downloads immediately to browser
- [ ] ZIP filename format: {program_name}_documents_{date}.zip
- [ ] ZIP contains all selected documents with original filenames
- [ ] If filename conflicts exist, files numbered (e.g., "doc.pdf", "doc(1).pdf")
- [ ] Export respects document permissions (only includes accessible documents)
- [ ] If user can't access some selected documents, those skipped with notice
- [ ] Success message after export: "Downloaded 8 documents"
- [ ] Checkboxes remain selected after export (don't auto-deselect)
- [ ] Export works with 1 document, 10 documents, 50 documents
- [ ] Large exports (50+ documents, 100MB+) complete without timeout

---

## Request 3: Global Document Search

### Problem Statement

**Current State:**

Documents are only accessible within their individual programs:

- No cross-program document search
- No way to filter documents by type across programs
- Affiliates cannot search documents across their service area
- National staff cannot search documents across the country
- Cannot leverage existing documents as resources or templates

### Business Impact

- Affiliates cannot access or learn from documents in their service area
- National staff cannot find examples for resources (e.g., marketing plans)
- Researchers cannot access document samples
- Missed opportunities for sharing best practices
- Cannot build resource libraries from existing content

### Proposed Solution

**Approach:** Reports-based document search with filtering

**How It Works:**

1. Add "Program Documents" report in Reports menu
2. Search interface with filters:
   - Search by program name (text input)
   - Filter by document types (checkbox multi-select)
3. Results table showing:
   - Document name
   - Document type (tags)
   - Program name
   - Uploaded date
   - Actions (Preview, Download)
4. Checkbox selection for bulk export
5. "Download Selected" button to export multiple documents as ZIP

**Access Control:**

- **Global admins:** See all documents from all programs
- **Affiliate admins:** See only documents from programs in their service area
- **NQMS reviewers:** See documents from programs they can access
- Respects existing document permissions

**Filters Available:**

- Program name search (text input, searches as you type)
- Document type tags (multi-select checkboxes)

### Acceptance Criteria

**Search Interface**

- [ ] "Program Documents" link appears in Reports menu
- [ ] Link visible to global admins, affiliate admins, NQMS reviewers
- [ ] Search page displays with title "Program Documents"
- [ ] "Search by Program Name" text input field with placeholder
- [ ] "Filter by Document Types" accordion/dropdown with checkboxes
- [ ] Document type checkboxes match tags from Request 2
- [ ] Multiple document types can be selected (OR logic)
- [ ] Search updates results dynamically (or with Search button)
- [ ] Results count displayed (e.g., "Showing 8 of 8 documents")

**Results Display**

- [ ] Results table with columns: Checkbox, Document Name, Document Type, Program Name, Uploaded Date, Actions
- [ ] Document types displayed as badges/chips
- [ ] Program name is clickable link to program details page
- [ ] Uploaded date formatted consistently
- [ ] Actions column shows Preview and Download buttons
- [ ] Pagination if more than 50-100 results
- [ ] "No documents found" message if no results

**Bulk Export**

- [ ] Checkbox in each result row
- [ ] "Select All" checkbox in header row
- [ ] "Download Selected (X)" button when documents selected
- [ ] "Clear Selection" button when documents selected
- [ ] Clicking "Download Selected" generates ZIP file
- [ ] ZIP filename: documents_export_{date}.zip
- [ ] ZIP contains selected documents organized by program folders
- [ ] Folder structure: Program_Name/document_name.pdf

**Access Control**

- [ ] Global admins see documents from all programs
- [ ] Affiliate admins see only documents from their affiliate's programs
- [ ] NQMS reviewers see only documents from programs they can access
- [ ] Document permissions enforced
- [ ] Unauthorized users cannot access document search page

---

## Dependencies Between Requests

### Required Order

**Request 2 (Tagging) must be implemented first**
- Required for: Request 1D (editing tags), Request 3 (filtering by tags)
- Enhances: Request 1C (tagging during batch upload)

**Request 1A (Preview) and Request 1D (Edit) can be implemented independently after Request 2**

**Request 1C (Batch Upload) and Request 1B (Bulk Export) can be implemented in parallel**
- Both benefit from Request 2 (tagging) but can work without it

**Request 3 (Global Search) should be implemented last**
- Depends on: Request 2 (tagging system for filtering)
- Benefits from: Request 1A (preview), Request 1B (bulk export from search results)

### Recommended Phased Approach

**Phase 1 (Foundation + Critical Fixes):**
- Request 2: Document Tagging System
- Request 1D: Edit Document Metadata
- Request 1A: Document Preview

**Phase 2 (Efficiency Improvements):**
- Request 1C: Batch Document Upload
- Request 1B: Bulk Document Export

**Phase 3 (Advanced Features):**
- Request 3: Global Document Search

---

## Out of Scope

The following are explicitly OUT OF SCOPE for this SOW:

❌ Document versioning (uploading new version of existing document)
❌ Document approval workflows
❌ Document sharing via external links
❌ Document comments or annotations
❌ Document templates or libraries
❌ OCR or automatic document content extraction
❌ Document conversion (Word to PDF, etc.)
❌ Document collaboration (real-time editing)
❌ Document expiration dates or reminders
❌ Advanced search (full-text search within document contents)
❌ Bulk edit of document metadata
❌ Document access audit logs (beyond basic modified_by)
❌ Custom document types/tags per program
❌ Document folder organization within program
❌ Email notifications for document uploads
