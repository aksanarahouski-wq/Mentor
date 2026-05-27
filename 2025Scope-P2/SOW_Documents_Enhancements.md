# Scope of Work: NQMS Document Management Enhancements

**Project:** NQMS Document Management System Improvements
**Prepared By:** Aksana Rahouski, Senior Product Manager
**Date:** 2025-01-28
**Status:** Ready for Developer Estimation

---

## Overview

This SOW covers **6 enhancement requests** to the NQMS Document Management system that address usability gaps, efficiency improvements, and advanced document discovery capabilities.

**Requests Included:**
1. Document Tagging System (Request 2) - Required for other requests
2. Document Preview in Browser (Request 1A)
3. Edit Document Metadata (Request 1D) - Missing basic functionality
4. Batch Document Upload (Request 1C) - Major pain point
5. Bulk Document Export (Request 1B)
6. Global Document Search (Request 3) - Depends on Request 2

**Implementation Approach:** Requests have dependencies. Recommended phased approach:
- **Phase 1**: Request 2 (Tagging) + Request 1D (Edit) + Request 1A (Preview)
- **Phase 2**: Request 1C (Batch Upload) + Request 1B (Bulk Export)
- **Phase 3**: Request 3 (Global Search)

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

**Business Impact:**
- Difficult for reviewers to find specific document types
- Cannot search across programs for documents of a certain type
- No standardization in document categorization
- Time wasted opening files to identify contents
- Cannot leverage existing documents as resources/templates

**User Need:**
Programs and reviewers need to categorize documents by type using standardized tags, enabling better organization, filtering, and cross-program document discovery.

### Proposed Solution

**Approach:** Many-to-many tagging system with predefined document types

**How It Works:**
1. Create database tables for document tags (`document_tags`) and document-tag relationships (`documents_tags`)
2. Seed database with predefined document type tags provided by client
3. **Update document upload/create form to include document type checkboxes (multi-select)** - This replaces or supplements the current single-file upload interface
4. Display document types as badges/chips in document lists
5. Add filter capability by document type on program Documents tab
6. Enable tag editing in Edit Document form (Request 1D)

**Document Type Tags (Examples from Screenshots):**
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

**Database Schema:**
```sql
CREATE TABLE document_tags (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT NULL,
    sort_order INT DEFAULT 0,
    created DATETIME DEFAULT CURRENT_TIMESTAMP,
    modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE documents_tags (
    document_id INT NOT NULL,
    tag_id INT NOT NULL,
    PRIMARY KEY (document_id, tag_id),
    FOREIGN KEY (document_id) REFERENCES documents(id) ON DELETE CASCADE,
    FOREIGN KEY (tag_id) REFERENCES document_tags(id) ON DELETE CASCADE,
    INDEX idx_document_id (document_id),
    INDEX idx_tag_id (tag_id)
);
```

**Files to Modify/Create:**
- `config/Migrations/[TIMESTAMP]_CreateDocumentTagsSystem.php` (NEW)
- `config/Seeds/DocumentTagsSeed.php` (NEW)
- `plugins/Programs/src/Model/Table/DocumentsTable.php` (MODIFY) - Add Tags association
- `plugins/Programs/src/Model/Table/DocumentTagsTable.php` (NEW)
- `plugins/Programs/src/Model/Entity/Document.php` (MODIFY)
- `plugins/Programs/src/Model/Entity/DocumentTag.php` (NEW)
- `plugins/Programs/templates/Admin/Documents/add.twig` (MODIFY) - **Add tag checkboxes to upload form**
- `plugins/Programs/templates/Admin/Documents/edit.twig` (MODIFY) - Add tag checkboxes to edit form
- `plugins/Programs/templates/Admin/Documents/index.twig` (MODIFY) - Display tags as badges, add filter accordion
- `plugins/Programs/src/Controller/Admin/DocumentsController.php` (MODIFY) - Handle tag associations in add() and edit() actions

### Acceptance Criteria

#### Database & Model
- [ ] `document_tags` table created with columns: id, name, description, sort_order, created, modified
- [ ] `documents_tags` junction table created with cascade delete
- [ ] Database seeded with client-provided document type tags (25+ tags)
- [ ] `DocumentsTable` has `belongsToMany` association with `DocumentTags`
- [ ] Saving document with tags creates junction table records
- [ ] Deleting document removes junction table records (cascade)

#### Document Upload/Create Form
- [ ] **Document upload form (add.twig) updated with document type checkboxes**
- [ ] Checkboxes display all available document type tags
- [ ] Checkboxes organized in 2-3 columns for readability
- [ ] Multiple tags can be selected per document (multi-select)
- [ ] Tags are optional (not required) when uploading
- [ ] Section labeled "Document Type (check all that apply)"
- [ ] Tags save correctly when document is uploaded

#### Document Display
- [ ] Document list displays tags as badges/chips below document name
- [ ] Tags visually distinct (colored badges or pills)
- [ ] Multiple tags per document display correctly (comma-separated or as separate badges)
- [ ] Documents without tags still display normally (no error or blank space)

#### Document Filtering
- [ ] "Filter by Document Type" accordion/dropdown added to Documents tab
- [ ] Filter shows all tag options as checkboxes (same list as upload form)
- [ ] Multiple tag filters can be selected (OR logic - show docs with ANY selected tag)
- [ ] Filter updates document list dynamically when selections change
- [ ] Filter accordion is collapsible/expandable
- [ ] Document count updates when filters applied (e.g., "Showing 6 of 20 documents")
- [ ] Filter persists during session (doesn't reset when page refreshes)
- [ ] Unselecting all filters shows all documents

#### Document Edit Form
- [ ] Edit document form includes tag checkboxes (requires Request 1D)
- [ ] Currently selected tags pre-checked when form loads
- [ ] Can add or remove tags when editing
- [ ] Tag changes save correctly

### Test Cases

#### Test: Create document tags table
```
Given: Migration executed
When: Check database schema
Then: document_tags table exists
  And: Contains columns: id, name, description, sort_order, created, modified
  And: name column has UNIQUE constraint
```

#### Test: Seed document tags
```
Given: Seed file executed
When: Query document_tags table
Then: Contains 25+ predefined document type tags
  And: Tags ordered by sort_order
  And: Each tag has name and optional description
```

#### Test: Upload document with tags
```
Given: User on Add Document page
When: User selects file
  And: User enters document name
  And: User checks "Theory of Change" and "Logic Model" tags
  And: User clicks Save
Then: Document saved successfully
  And: 2 records created in documents_tags junction table
  And: Document list shows both tags as badges under document name
```

#### Test: Upload document without tags
```
Given: User on Add Document page
When: User selects file
  And: User enters document name
  And: User does NOT check any tags
  And: User clicks Save
Then: Document saved successfully
  And: No records in documents_tags for this document
  And: Document displays normally without tags
```

#### Test: Display tags in document list
```
Given: Document has tags "Mentor Training Materials" and "Mentor Orientation Materials"
When: User views document list
Then: Tags display as badges/chips below document name
  And: Tags are visually distinct (colored or styled)
  And: Tags are comma-separated or shown as separate badges
```

#### Test: Filter documents by tag
```
Given: 10 documents exist
  And: 5 documents tagged "Training Curriculum"
  And: 3 documents tagged "Policies & Procedures Manual"
  And: 2 documents tagged both
When: User clicks "Filter by Document Type"
  And: User checks "Training Curriculum"
Then: Document list shows 5 documents
  And: Count shows "Showing 5 of 10 documents"
When: User also checks "Policies & Procedures Manual"
Then: Document list shows 8 documents (OR logic)
  And: Count shows "Showing 8 of 10 documents"
```

#### Test: Clear tag filter
```
Given: User has filter applied showing 5 of 10 documents
When: User clicks "Clear Selection" or unchecks all tags
Then: Document list shows all 10 documents
  And: Count shows "Showing 10 of 10 documents"
```

#### Test: Multiple tags per document
```
Given: User uploading document
When: User checks 5 different document type tags
  And: User saves document
Then: Document saved successfully
  And: 5 records created in documents_tags junction table
  And: All 5 tags display in document list
```

#### Test: Association cascade delete
```
Given: Document has 3 tags assigned
When: User deletes document
Then: Document deleted successfully
  And: 3 junction table records automatically deleted (cascade)
  And: Tag records remain in document_tags table (not deleted)
```

### Definition of Done

- [ ] Database migration created and tested
- [ ] Document tags seeded with client-provided list
- [ ] Model associations created (`belongsToMany`)
- [ ] Upload form includes tag checkboxes (multi-select)
- [ ] Edit form includes tag checkboxes (requires Request 1D)
- [ ] Document list displays tags as badges
- [ ] Filter by document type functionality implemented
- [ ] Multiple tag selection supported (OR logic)
- [ ] Clear filter functionality implemented
- [ ] Document count updates with filters
- [ ] All acceptance criteria met
- [ ] All test cases pass
- [ ] Code review completed and approved
- [ ] Tested with 0 tags, 1 tag, multiple tags per document
- [ ] Cascade delete tested
- [ ] Works on staging environment
- [ ] PM/client UAT approved
- [ ] No critical or high bugs

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

**Business Impact:**
- Slow review process for NQMS reviewers
- Poor user experience examining multiple documents
- Time wasted downloading, opening, and deleting files
- Cannot quickly scan document contents
- Reviewers may download same document multiple times

**User Need:**
Reviewers and program staff need to view/preview documents in the browser without downloading, enabling quick document review and reducing file management overhead.

### Proposed Solution

**Approach:** Browser-native preview with inline content disposition

**How It Works:**
1. Add "Preview" button to document list (eye icon)
2. New `preview($id)` action in DocumentsController
3. Serve file with `Content-Disposition: inline` header
4. Browser opens document in new tab for native preview
5. Different file types handled by browser's built-in viewers

**Supported File Types:**
- **Natively previewable**: PDF, images (PNG, JPG, GIF), text files
- **Browser-dependent**: Office documents (depends on browser plugins/extensions)
- **Not previewable**: ZIP, executables (show message, offer download instead)

**User Experience:**
- User clicks "Preview" button (eye icon)
- New browser tab opens with document displayed
- User can view, zoom, print from browser
- User can close tab and return to document list
- Download still available as separate option

**Files to Modify:**
- `plugins/Programs/src/Controller/Admin/DocumentsController.php` - Add `preview($id)` action
- `plugins/Programs/templates/Admin/Documents/index.twig` - Add preview button
- `config/request_policy_configs.php` - Add preview permission (same as download)

**Technical Implementation:**
```php
// In DocumentsController.php
public function preview(int $id): Response
{
    // Get document with authorization check
    $document = $this->Documents->get($id);

    // Check authorization (same as download)
    if (!$this->canAccessDocument($document)) {
        throw new ForbiddenException();
    }

    // Get file from storage
    $filePath = $document->file_path; // or however files are stored

    // Set response headers for inline display
    $this->response = $this->response->withFile(
        $filePath,
        ['download' => false, 'name' => $document->filename]
    );

    // Set Content-Disposition to inline
    $this->response = $this->response->withHeader(
        'Content-Disposition',
        'inline; filename="' . $document->filename . '"'
    );

    return $this->response;
}
```

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
- [ ] Preview does not trigger download (Content-Disposition: inline)
- [ ] Original filename preserved in preview
- [ ] Download button still available separately
- [ ] Preview works in Chrome, Firefox, Safari, Edge
- [ ] Large files (>10MB) display without timeout errors

### Test Cases

#### Test: Preview PDF document
```
Given: Document is a PDF file
When: User clicks Preview button
Then: New browser tab opens
  And: PDF displays in browser's PDF viewer
  And: User can scroll, zoom, print
  And: File does not download to computer
```

#### Test: Preview image document
```
Given: Document is a PNG image
When: User clicks Preview button
Then: New browser tab opens
  And: Image displays in browser
  And: User can zoom in/out
  And: File does not download
```

#### Test: Preview non-previewable file
```
Given: Document is a ZIP file
When: User clicks Preview button
Then: New tab opens with message
  And: Message says "This file type cannot be previewed"
  And: Download button provided as alternative
```

#### Test: Preview permissions
```
Given: User has permission to view document
When: User clicks Preview button
Then: Preview opens successfully

Given: User does NOT have permission to view document
When: User attempts to access preview URL directly
Then: 403 Forbidden error displayed
  And: Preview does not open
```

#### Test: Preview large file
```
Given: Document is a 15MB PDF
When: User clicks Preview button
Then: Preview loads within 5 seconds
  And: PDF displays successfully
  And: No timeout errors
```

#### Test: Preview maintains separate download option
```
Given: User viewing document list
When: User looks at Actions column
Then: Both "Preview" and "Download" buttons visible
  And: Buttons are distinct actions
When: User clicks Preview
Then: File previews in browser
When: User clicks Download
Then: File downloads to computer
```

#### Test: Preview in different browsers
```
Given: Document is a PDF
When: User previews in Chrome
Then: PDF displays correctly
When: User previews in Firefox
Then: PDF displays correctly
When: User previews in Safari
Then: PDF displays correctly
When: User previews in Edge
Then: PDF displays correctly
```

### Definition of Done

- [ ] Preview action implemented in DocumentsController
- [ ] Preview button added to document list
- [ ] Preview uses Content-Disposition: inline header
- [ ] Preview opens in new tab
- [ ] PDF files preview correctly
- [ ] Image files preview correctly
- [ ] Non-previewable files show appropriate message
- [ ] Preview respects document permissions
- [ ] All acceptance criteria met
- [ ] All test cases pass
- [ ] Code review completed and approved
- [ ] Tested with PDF, images, Office docs, ZIP files
- [ ] Tested in Chrome, Firefox, Safari, Edge
- [ ] Large files (10MB+) tested
- [ ] Works on staging environment
- [ ] PM/client UAT approved
- [ ] No critical or high bugs

---

## Request 1D: Edit Document Metadata (CRITICAL)

### Problem Statement

**Current State:**
Once a document is uploaded, there is no way to edit its metadata. This is a **critical missing feature**:
- Cannot edit document name after upload
- Cannot add or change document tags (once Request 2 implemented)
- Only option is to delete and re-upload the document
- Re-uploading loses upload history and metadata

**Business Impact:**
- Cannot correct typos or mistakes in document names
- Cannot update document information as needs change
- Forced to delete and re-upload to fix simple mistakes
- Time wasted re-uploading large files
- Loss of upload history and audit trail
- Poor user experience - basic CRUD functionality missing

**User Need:**
Users need ability to edit document metadata (name and tags) after upload, enabling corrections and updates without deleting and re-uploading files.

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
5. `modified` timestamp and `modified_by` updated automatically

**What Can Be Edited:**
- ✅ Document name
- ✅ Document type tags (requires Request 2)
- ❌ Physical file (not in this request - consider separate versioning feature)
- ❌ Uploaded date (preserved)
- ❌ Uploaded by (preserved)

**Files to Modify/Create:**
- `plugins/Programs/src/Controller/Admin/DocumentsController.php` - Add `edit($id)` and `update($id)` actions
- `plugins/Programs/templates/Admin/Documents/edit.twig` (NEW) - Edit form
- `plugins/Programs/templates/Admin/Documents/index.twig` (MODIFY) - Add edit button
- `config/request_policy_configs.php` - Add edit permission
- Optional: `config/Migrations/` - Add `modified_by` field for audit trail

**Permissions:**
- Same access level as delete
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
- [ ] `modified` timestamp automatically updated
- [ ] `modified_by` field updated with current user ID (if field exists)
- [ ] Success message displayed after save
- [ ] User redirected back to document list after save
- [ ] Updated metadata immediately visible in document list
- [ ] Physical file is not changed
- [ ] Upload date and uploaded by are preserved
- [ ] Edit respects document permissions (same as delete)

### Test Cases

#### Test: Edit document name
```
Given: Document named "Old Name.pdf"
When: User clicks Edit button
  And: Edit form opens
  And: User changes name to "New Name.pdf"
  And: User clicks Save Changes
Then: Document saved successfully
  And: Success message displayed
  And: Document list shows "New Name.pdf"
  And: Physical file unchanged
  And: Upload date unchanged
```

#### Test: Edit document tags
```
Given: Document with tags "Theory of Change", "Logic Model"
  And: Request 2 (tagging) is implemented
When: User clicks Edit button
  And: User unchecks "Logic Model"
  And: User checks "Policies & Procedures Manual"
  And: User clicks Save Changes
Then: Document saved successfully
  And: Document now has tags "Theory of Change", "Policies & Procedures Manual"
  And: Junction table updated (old removed, new added)
```

#### Test: Validation - empty name
```
Given: User editing document
When: User clears document name field (makes it empty)
  And: User clicks Save Changes
Then: Validation error displayed: "Document name is required"
  And: Form does not save
  And: User remains on edit form
```

#### Test: Cancel edit
```
Given: User editing document
When: User changes document name
  And: User clicks Cancel button
Then: Changes discarded
  And: User redirected to document list
  And: Document name unchanged
```

#### Test: Edit permissions
```
Given: User has edit permission for documents
When: User views document list
Then: Edit button visible and clickable

Given: User does NOT have edit permission
When: User views document list
Then: Edit button not visible or disabled
When: User attempts to access edit URL directly
Then: 403 Forbidden error displayed
```

#### Test: Audit trail (if implemented)
```
Given: User "Sarah" edits document
When: Sarah changes document name
  And: Sarah clicks Save Changes
Then: modified timestamp updated to current time
  And: modified_by field set to Sarah's user ID
When: Admin views document details
Then: Shows "Last modified by Sarah on [date/time]"
```

#### Test: Physical file unchanged
```
Given: Document "example.pdf" uploaded
When: User edits document name to "new-name.pdf"
  And: User saves changes
Then: Metadata updated in database
  And: Physical file on server still named "example.pdf" (or whatever storage scheme uses)
  And: File path/storage unchanged
  And: Download still works correctly
```

### Definition of Done

- [ ] Edit button added to document list
- [ ] Edit form/page created with all fields
- [ ] edit() and update() actions implemented
- [ ] Form validation implemented (name required)
- [ ] Permissions implemented (same as delete)
- [ ] Metadata updates correctly (name and tags)
- [ ] modified timestamp automatically updated
- [ ] modified_by field updated (if implemented)
- [ ] Cancel functionality works
- [ ] Success message displayed after save
- [ ] All acceptance criteria met
- [ ] All test cases pass
- [ ] Code review completed and approved
- [ ] Tested with various field combinations
- [ ] Tested with no tags selected
- [ ] Tested cancel functionality
- [ ] Works on staging environment
- [ ] PM/client UAT approved
- [ ] No critical or high bugs

---

## Request 1C: Batch Document Upload

### Problem Statement

**Current State:**
Programs can only upload one document at a time. This is a **major pain point**:
- Programs need to upload 30-50 documents to support assessments
- Each document requires separate upload action
- Must click "Upload", select file, enter name, select tags, save - 30 to 50 times
- Extremely tedious and time-consuming process
- Users may abandon uploads before completing all documents

**Business Impact:**
- Significant time waste for program staff
- Poor user experience discourages document uploads
- Programs may not upload all necessary documentation
- Delays in assessment completion
- User frustration with repetitive single-file process

**User Need:**
Programs need to upload multiple documents at once (batch upload), significantly reducing time and effort required to upload 30-50 documents.

### Proposed Solution

**Approach:** HTML5 multi-file upload with drag-and-drop and progress tracking

**How It Works:**
1. Add "+ Upload New Document" button on Documents tab
2. Opens modal with multi-file upload interface
3. Drag-and-drop zone: "DRAG & DROP HERE OR CLICK" (as shown in screenshot)
4. User selects/drops multiple files (2 or more)
5. Files appear in queue with file names and sizes
6. User can remove files from queue before upload
7. **When multiple files selected: Filenames automatically used as document names** (not editable in batch mode)
8. User selects document type tags to apply to **ALL documents** in the batch (optional)
9. "Save" button uploads all files with progress tracking
10. All selected tags applied to every document in the batch
11. Success message shows count of uploaded documents

**Metadata Handling for Batch Uploads:**
- **Document name**: **Automatically derived from filename** (e.g., "training-2024.pdf" → "Training 2024")
  - Names are NOT editable during batch upload (to keep process efficient)
  - Users can edit names after upload using Request 1D (Edit Document)
- **Document types (tags)**: Tags selected before upload are applied to **ALL documents** in the batch
  - Same tags applied to every document uploaded
  - Requires Request 2 (Tagging System)
  - Tags are optional (can upload without tags)
- Each file saved individually on backend for proper authorization and validation

**Upload Processing:**
- Files uploaded sequentially (one at a time) for simplicity
- Progress bar shows overall upload progress
- Each file validated individually (file type, size, permissions)
- If one file fails, others continue uploading
- Summary at end: "25 files uploaded successfully, 2 failed"

**Batch Limits:**
- Max files per batch: 50 files (adjustable via config)
- Max individual file size: Same as current single upload limit (e.g., 10MB)
- Max total batch size: 100MB (adjustable based on server limits)
- Limits displayed clearly in UI

**Files to Modify/Create:**
- `plugins/Programs/templates/Admin/Documents/index.twig` (MODIFY) - Change upload button to open modal
- `plugins/Programs/templates/Admin/Documents/add.twig` (MODIFY) - Add multi-file interface
- `plugins/Programs/webroot/js/documents-batch-upload.js` (NEW) - JavaScript for batch upload logic
- `plugins/Programs/src/Controller/Admin/DocumentsController.php` (MODIFY) - Handle AJAX uploads
- `plugins/ThemeAdmin/webroot/assets/css/documents.css` (MODIFY) - Styling for drag-and-drop

### Acceptance Criteria

- [ ] "+ Upload New Document" button opens upload interface (modal or inline section)
- [ ] Upload interface shows drag-and-drop zone with message "DRAG & DROP HERE OR CLICK"
- [ ] User can drag multiple files onto drop zone
- [ ] User can click zone to open file picker (supports multi-select)
- [ ] Selected files appear in queue/list showing filename and file size
- [ ] User can remove individual files from queue before upload
- [ ] "Clear All" option to remove all files from queue
- [ ] Queue shows count: "5 files selected"
- [ ] **When 2+ files selected: Document names automatically derived from filenames (NOT editable)**
- [ ] Filename conversion shown in queue preview (e.g., "training-2024.pdf" → "Training 2024")
- [ ] **Document type checkboxes shown with label: "Apply these tags to ALL documents"**
- [ ] Selected tags will be applied to every document in the batch
- [ ] Upload button disabled until at least 1 file selected
- [ ] "Save" button starts batch upload
- [ ] Progress bar shows overall upload progress (e.g., "Uploading 3 of 10 files...")
- [ ] Each file shows status: queued → uploading → success/failed
- [ ] If file fails, error message shown but others continue
- [ ] Success message shows count: "25 documents uploaded successfully"
- [ ] Failed uploads show error details (file size too large, invalid type, etc.)
- [ ] Batch upload respects file size limits (per file and total)
- [ ] Batch upload respects file type restrictions
- [ ] Max 50 files per batch enforced
- [ ] Limits displayed in UI: "Max 50 files, 10MB per file"
- [ ] After successful upload, modal closes and document list refreshes
- [ ] Uploaded documents immediately visible in document list
- [ ] **All documents in batch have the same selected tags applied**
- [ ] **All documents have names derived from their filenames**

### Test Cases

#### Test: Drag and drop multiple files
```
Given: User on Documents tab
When: User clicks "+ Upload New Document"
  And: Upload interface opens
  And: User drags 5 PDF files onto drop zone
Then: All 5 files appear in queue
  And: Each file shows name and size
  And: Count shows "5 files selected"
  And: Upload button enabled
```

#### Test: Click to select multiple files
```
Given: User on upload interface
When: User clicks "DRAG & DROP HERE OR CLICK"
  And: File picker opens
  And: User selects 10 files (using Ctrl+click or Shift+click)
Then: All 10 files appear in queue
  And: Count shows "10 files selected"
```

#### Test: Remove file from queue
```
Given: User has 5 files in queue
When: User clicks remove/X button next to file #3
Then: File #3 removed from queue
  And: Count shows "4 files selected"
  And: Remaining 4 files still in queue
```

#### Test: Upload batch successfully
```
Given: User has 10 files in queue
  And: User selects tags "Training Curriculum", "Mentor Training Materials"
When: User clicks Save button
Then: Progress bar appears showing "Uploading 1 of 10 files..."
  And: Progress updates as each file uploads
  And: Success message appears: "10 documents uploaded successfully"
  And: Modal closes
  And: Document list refreshes showing 10 new documents
  And: **All 10 documents have both selected tags applied**
  And: **All 10 documents have names derived from their filenames**
```

#### Test: Batch upload with failures
```
Given: User has 5 files in queue
  And: File #3 is 15MB (exceeds 10MB limit)
When: User clicks Save button
Then: Files 1, 2 upload successfully
  And: File 3 fails with error "File size exceeds 10MB limit"
  And: Files 4, 5 continue and upload successfully
  And: Summary shows "4 documents uploaded successfully, 1 failed"
  And: Failed file details shown in error message
```

#### Test: Auto-populate document names from filenames
```
Given: User uploads files: "training-2024.pdf", "mentor_handbook.docx", "policies.pdf"
When: Files added to queue
Then: Queue shows filenames will become document names:
  - "training-2024.pdf" → "Training 2024"
  - "mentor_handbook.docx" → "Mentor Handbook"
  - "policies.pdf" → "Policies"
  And: **Names are NOT editable in batch mode**
When: User completes upload
Then: Documents saved with converted names
  And: Users can edit names later via Edit Document feature (Request 1D)
```

#### Test: Batch size limit
```
Given: User attempting to select files
When: User tries to select 60 files
Then: Warning message appears: "Maximum 50 files per batch"
  And: Only first 50 files added to queue
  Or: User can select 60 but warning shown before upload
```

#### Test: File type validation
```
Given: User has 3 files in queue: 2 PDFs, 1 EXE file
When: User clicks Save button
Then: 2 PDFs upload successfully
  And: EXE file fails with error "File type not allowed"
  And: Summary shows "2 documents uploaded successfully, 1 failed"
```

#### Test: Cancel batch upload
```
Given: User has 10 files in queue
When: User clicks Cancel or X to close modal
Then: Modal closes without uploading
  And: No documents saved
  And: Document list unchanged
```

#### Test: Progress tracking
```
Given: User uploading 20 files
When: Upload in progress
Then: Progress bar shows percentage completed
  And: Shows "Uploading 5 of 20 files..." (or current file number)
  And: Individual file status visible (uploading, success, failed)
```

### Definition of Done

- [ ] Upload button opens modal with batch upload interface
- [ ] Drag-and-drop zone implemented and styled
- [ ] Multi-file selection via click works
- [ ] File queue displays with name, size, remove button
- [ ] **Filenames automatically converted to document names (not editable during upload)**
- [ ] Filename-to-name conversion logic implemented (remove extension, title case, replace underscores/hyphens with spaces)
- [ ] **Document type tags apply to ALL documents in batch**
- [ ] Tag selection labeled clearly: "Apply these tags to ALL documents"
- [ ] Upload button disabled until files selected
- [ ] Progress tracking implemented (overall and per-file)
- [ ] Sequential upload processing (one file at a time)
- [ ] Error handling for failed uploads (others continue)
- [ ] Success/failure summary displayed
- [ ] **All uploaded documents have same selected tags**
- [ ] **All uploaded documents have names from filenames**
- [ ] Batch size limits enforced (50 files max)
- [ ] File size limits enforced (per file and total)
- [ ] File type validation enforced
- [ ] All acceptance criteria met
- [ ] All test cases pass
- [ ] Code review completed and approved
- [ ] Tested with small batches (5 files), medium (25 files), large (50 files)
- [ ] Tested with various file types and sizes
- [ ] Tested with intentional failures (oversized files, wrong types)
- [ ] Tested that all documents get same tags
- [ ] Tested that document names correctly derived from filenames
- [ ] Tested in Chrome, Firefox, Safari, Edge
- [ ] Works on staging environment
- [ ] PM/client UAT approved
- [ ] No critical or high bugs

---

## Request 1B: Bulk Document Export

### Problem Statement

**Current State:**
Users can only download documents one at a time:
- Each document requires separate download action
- Reviewers examining 30-50 documents must download each individually
- No way to select multiple documents for download
- No "Export All" option

**Business Impact:**
- Time-consuming process for reviewers downloading many documents
- Poor user experience with repetitive downloading
- Cannot efficiently download entire document sets
- Reviewers waste time on repetitive clicks

**User Need:**
Users (especially NQMS reviewers) need to download multiple documents at once in a ZIP file, enabling efficient bulk document export.

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
- Filename format: `{program_name}_documents_{YYYY-MM-DD}.zip`
- Contains all selected documents with original filenames
- Generated on-demand (not pre-generated or stored)
- Streamed directly to browser download

**Technical Implementation:**
- Use PHP's built-in ZipArchive class (no external dependencies)
- Generate ZIP in memory and stream to browser
- Check authorization for each document before including
- Skip documents user doesn't have permission to access

**Files to Modify:**
- `plugins/Programs/src/Controller/Admin/DocumentsController.php` (MODIFY) - Add exportDocuments() action
- `plugins/Programs/templates/Admin/Documents/index.twig` (MODIFY) - Add checkboxes and buttons
- `plugins/Programs/webroot/js/documents-bulk-export.js` (NEW) - JavaScript for checkbox logic
- `config/request_policy_configs.php` (MODIFY) - Add export permission

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
- [ ] ZIP filename format: `{program_name}_documents_{date}.zip`
- [ ] ZIP contains all selected documents with original filenames
- [ ] If filename conflicts exist, files numbered (e.g., "doc.pdf", "doc(1).pdf")
- [ ] Export respects document permissions (only includes accessible documents)
- [ ] If user can't access some selected documents, those skipped with notice
- [ ] Success message after export: "Downloaded 8 documents"
- [ ] Checkboxes remain selected after export (don't auto-deselect)
- [ ] Export works with 1 document, 10 documents, 50 documents
- [ ] Large exports (50+ documents, 100MB+) complete without timeout

### Test Cases

#### Test: Select and export single document
```
Given: User viewing document list with 10 documents
When: User checks checkbox for document #5
Then: "Download Selected (1)" button enabled
When: User clicks "Download Selected (1)"
Then: ZIP file downloads: "{program_name}_documents_2025-01-28.zip"
  And: ZIP contains 1 document
  And: Checkbox remains selected
```

#### Test: Select all and export
```
Given: User viewing document list with 20 documents
When: User clicks "Select All" checkbox in header
Then: All 20 checkboxes checked
  And: "Download Selected (20)" button enabled
When: User clicks "Download Selected (20)"
Then: ZIP file downloads with all 20 documents
  And: ZIP filename includes program name and date
```

#### Test: Clear selection
```
Given: User has 5 documents selected
  And: "Download Selected (5)" button visible
When: User clicks "Clear Selection" button
Then: All checkboxes unchecked
  And: "Download Selected" button disabled/hidden
  And: "Clear Selection" button hidden
```

#### Test: Export with filename conflicts
```
Given: User has 2 documents both named "policies.pdf"
When: User selects both and clicks export
Then: ZIP contains:
  - policies.pdf
  - policies(1).pdf
  And: Both files download correctly
```

#### Test: Export respects permissions
```
Given: User can access documents 1-5
  And: User cannot access documents 6-7
When: User selects documents 1-7 (all 7 checked)
  And: User clicks "Download Selected (7)"
Then: ZIP contains only documents 1-5
  And: Notice shown: "2 documents skipped (no permission)"
  And: Export succeeds with 5 documents
```

#### Test: Large batch export
```
Given: User selects 50 documents (total 120MB)
When: User clicks "Download Selected (50)"
Then: ZIP generation starts
  And: ZIP downloads within 30 seconds
  And: All 50 documents included
  And: No timeout or memory errors
```

#### Test: Export persists selection
```
Given: User has 10 documents selected
When: User clicks "Download Selected (10)"
  And: ZIP downloads successfully
Then: All 10 checkboxes remain checked
  And: User can click "Download Selected (10)" again if needed
```

#### Test: Select/deselect individual documents
```
Given: User viewing document list
When: User checks documents 1, 3, 5, 7
Then: "Download Selected (4)" button enabled
When: User unchecks document 3
Then: "Download Selected (3)" button updates
When: User unchecks all documents manually
Then: "Download Selected" button disabled/hidden
```

### Definition of Done

- [ ] Checkboxes added to document list (per row and header)
- [ ] "Select All" functionality implemented
- [ ] "Download Selected" button implemented with count
- [ ] "Clear Selection" button implemented
- [ ] exportDocuments() action created in controller
- [ ] ZIP generation using PHP ZipArchive
- [ ] ZIP filename includes program name and date
- [ ] Filename conflict handling implemented
- [ ] Permission checking for each document
- [ ] Notice for skipped documents (no permission)
- [ ] All acceptance criteria met
- [ ] All test cases pass
- [ ] Code review completed and approved
- [ ] Tested with 1, 10, 50 documents
- [ ] Tested with large file sizes (100MB+ total)
- [ ] Tested with permission restrictions
- [ ] Tested in Chrome, Firefox, Safari, Edge
- [ ] Works on staging environment
- [ ] Performance acceptable (<30 seconds for 50 docs)
- [ ] PM/client UAT approved
- [ ] No critical or high bugs

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

**Business Impact:**
- Affiliates cannot access or learn from documents in their service area
- National staff cannot find examples for resources (e.g., marketing plans)
- Researchers cannot access document samples
- Missed opportunities for sharing best practices
- Cannot build resource libraries from existing content

**User Need:**
Affiliate and national staff need ability to search and access documents across multiple programs, filtered by document type and other criteria, enabling resource sharing and knowledge transfer.

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
- **Global admins**: See all documents from all programs
- **Affiliate admins**: See only documents from programs in their service area
- **NQMS reviewers**: See documents from programs they can access
- Respects existing document permissions

**Filters Available:**
- Program name search (text input, searches as you type)
- Document type tags (multi-select checkboxes)
- Additional filters (future): Affiliate, upload date range, keyword in document name

**Files to Create/Modify:**
- `plugins/Reports/src/Controller/Admin/DocumentsController.php` (NEW)
- `plugins/Reports/templates/Admin/Documents/index.twig` (NEW)
- `config/request_policy_configs.php` (MODIFY) - Add document search permissions
- `config/navigation.php` (MODIFY) - Add "Program Documents" to Reports menu

### Acceptance Criteria

#### Search Interface
- [ ] "Program Documents" link appears in Reports menu
- [ ] Link visible to global admins, affiliate admins, NQMS reviewers
- [ ] Search page displays with title "Program Documents"
- [ ] "Search by Program Name" text input field with placeholder
- [ ] "Filter by Document Types" accordion/dropdown with checkboxes
- [ ] Document type checkboxes match tags from Request 2
- [ ] Multiple document types can be selected (OR logic)
- [ ] Search updates results dynamically (or with Search button)
- [ ] Results count displayed (e.g., "Showing 8 of 8 documents")

#### Results Display
- [ ] Results table with columns: Checkbox, Document Name, Document Type, Program Name, Uploaded Date, Actions
- [ ] Document types displayed as badges/chips (matching program document display)
- [ ] Program name is clickable link to program details page
- [ ] Uploaded date formatted consistently
- [ ] Actions column shows Preview and Download buttons
- [ ] Results sortable by column (optional enhancement)
- [ ] Pagination if more than 50-100 results
- [ ] "No documents found" message if no results

#### Bulk Export
- [ ] Checkbox in each result row
- [ ] "Select All" checkbox in header row
- [ ] "Download Selected (X)" button when documents selected
- [ ] "Clear Selection" button when documents selected
- [ ] Clicking "Download Selected" generates ZIP file
- [ ] ZIP filename: `documents_export_{date}.zip`
- [ ] ZIP contains selected documents organized by program folders
- [ ] Folder structure: `Program_Name/document_name.pdf`

#### Access Control
- [ ] Global admins see documents from all programs
- [ ] Affiliate admins see only documents from their affiliate's programs
- [ ] NQMS reviewers see only documents from programs they can access
- [ ] Document permissions enforced (users only see documents they can normally access)
- [ ] Unauthorized users cannot access document search page

### Test Cases

#### Test: Search by program name
```
Given: User on Program Documents search page
  And: 3 programs exist: "Test Program", "Youth Program", "Community Program"
When: User types "Youth" in program name search
Then: Results show only documents from "Youth Program"
  And: Count updates to show filtered total
```

#### Test: Filter by document types
```
Given: User on search page
  And: 20 documents exist across programs
  And: 8 documents tagged "Training Curriculum"
  And: 5 documents tagged "Policies & Procedures Manual"
  And: 3 documents tagged both
When: User clicks "Filter by Document Types"
  And: User checks "Training Curriculum"
Then: Results show 8 documents
When: User also checks "Policies & Procedures Manual"
Then: Results show 13 documents (OR logic: 8 + 5, minus 3 duplicates = 10... wait, 8+5 with 3 overlap = 10)
Actually: OR logic means any document with either tag = 8 + 5 - 3 overlaps = 10 unique documents
Correction: If 3 have both tags, then:
- Only Training: 5 documents
- Only Policies: 2 documents
- Both: 3 documents
- Total: 10 documents shown
```

#### Test: Global admin sees all documents
```
Given: User is global admin
  And: Documents exist in programs across multiple affiliates
When: User navigates to Program Documents search
Then: Search shows all documents from all programs
  And: No affiliate-based filtering applied
```

#### Test: Affiliate admin sees only their programs
```
Given: User is admin for "MENTOR Colorado"
  And: MENTOR Colorado serves 10 programs
  And: MENTOR California serves 8 programs
When: User navigates to Program Documents search
Then: Search shows only documents from 10 Colorado programs
  And: California program documents not visible
```

#### Test: Preview document from search results
```
Given: User viewing search results
When: User clicks Preview button for document
Then: Document opens in new tab for preview
  And: Preview works same as program-level document preview
```

#### Test: Download document from search results
```
Given: User viewing search results
When: User clicks Download button for document
Then: Document downloads immediately
  And: Same as program-level document download
```

#### Test: Bulk export from search results
```
Given: User has searched and filtered to 12 documents
  And: Documents from 4 different programs
When: User selects all 12 documents
  And: User clicks "Download Selected (12)"
Then: ZIP file downloads: `documents_export_2025-01-28.zip`
  And: ZIP contains 4 folders (one per program)
  And: Each folder named after program
  And: Documents organized in respective program folders
```

#### Test: No documents found
```
Given: User on search page
When: User searches for program "NonexistentProgram"
Then: Results show message "No documents found"
  And: Empty state with helpful text
  And: Suggestion to try different filters
```

#### Test: Permissions enforced
```
Given: User can access Programs 1-5 but not Programs 6-10
When: User searches without filters (show all)
Then: Results show only documents from Programs 1-5
  And: Documents from Programs 6-10 not visible
  And: User cannot access those documents even with direct URL
```

### Definition of Done

- [ ] "Program Documents" added to Reports menu
- [ ] Search page created with filters
- [ ] Program name search implemented
- [ ] Document type filter implemented
- [ ] Results table displays correctly with all columns
- [ ] Preview and Download buttons functional
- [ ] Bulk export with checkboxes implemented
- [ ] ZIP export organized by program folders
- [ ] Access control enforced (global vs affiliate vs reviewer)
- [ ] Document permissions respected
- [ ] All acceptance criteria met
- [ ] All test cases pass
- [ ] Code review completed and approved
- [ ] Tested with global admin, affiliate admin, reviewer roles
- [ ] Tested with various filter combinations
- [ ] Tested bulk export with multi-program selection
- [ ] Tested with 100+ documents (performance)
- [ ] Works on staging environment
- [ ] PM/client UAT approved
- [ ] No critical or high bugs

---

## Dependencies Between Requests

### Required Order:
1. **Request 2 (Tagging)** must be implemented first
   - Required for: Request 1D (editing tags), Request 3 (filtering by tags)
   - Enhances: Request 1C (tagging during batch upload)

2. **Request 1A (Preview)** and **Request 1D (Edit)** can be implemented independently after Request 2

3. **Request 1C (Batch Upload)** and **Request 1B (Bulk Export)** can be implemented in parallel
   - Both benefit from Request 2 (tagging) but can work without it

4. **Request 3 (Global Search)** should be implemented last
   - Depends on: Request 2 (tagging system for filtering)
   - Benefits from: Request 1A (preview), Request 1B (bulk export from search results)

### Recommended Phased Approach:

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

The following are explicitly **OUT OF SCOPE** for this SOW:

- ❌ Document versioning (uploading new version of existing document)
- ❌ Document approval workflows
- ❌ Document sharing via external links
- ❌ Document comments or annotations
- ❌ Document templates or libraries
- ❌ OCR or automatic document content extraction
- ❌ Document conversion (Word to PDF, etc.)
- ❌ Document collaboration (real-time editing)
- ❌ Document expiration dates or reminders
- ❌ Advanced search (full-text search within document contents)
- ❌ Bulk edit of document metadata
- ❌ Document access audit logs (beyond basic modified_by)
- ❌ Custom document types/tags per program
- ❌ Document folder organization within program
- ❌ Email notifications for document uploads

---

## Technical Considerations

### File Storage
- Existing file storage system (S3 via Orases/Files plugin) remains unchanged
- ZIP generation uses PHP's built-in ZipArchive (no new dependencies)
- Preview serves files with inline content disposition (no storage changes)

### Performance
- Batch upload: Sequential processing (one file at a time) to avoid server overload
- Bulk export: On-demand ZIP generation, streamed to browser (no server storage)
- Global search: Add database indexes on documents.program_id and documents_tags.tag_id for query performance
- Consider pagination for large result sets (50-100 results per page)

### Browser Compatibility
- Target browsers: Chrome, Firefox, Safari, Edge (latest 2 versions)
- HTML5 File API used for batch upload (widely supported)
- Drag-and-drop API for file upload (graceful degradation to click-to-upload)

### Security
- All document actions respect existing permission system
- Authorization checks for preview, edit, download, export
- CSRF protection for all forms
- File upload validation (type, size, malware scanning if available)

### Database Performance
- Add indexes:
  - `documents.program_id`
  - `documents_tags.document_id`
  - `documents_tags.tag_id`
  - `document_tags.name`

---

## Estimated Complexity Summary

| Request | Complexity | Est. Days |
|---------|------------|-----------|
| Request 2: Document Tagging | Medium | 3-5 days |
| Request 1A: Document Preview | Low | 1-2 days |
| Request 1D: Edit Metadata | Low-Medium | 2-3 days |
| Request 1C: Batch Upload | Medium-High | 4-6 days |
| Request 1B: Bulk Export | Medium | 3-4 days |
| Request 3: Global Search | Medium-High | 4-6 days |

**Total Estimated Range:** 17-26 development days

**Recommended Phases:**
- **Phase 1**: 6-10 days (Tagging + Edit + Preview)
- **Phase 2**: 7-10 days (Batch Upload + Bulk Export)
- **Phase 3**: 4-6 days (Global Search)

---

**Status:** ✅ Ready for Developer Estimation
