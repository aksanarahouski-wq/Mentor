# NQMS Document Management Feature Requests

## Document Purpose
This document consolidates client requests for enhancements to the NQMS Document Management system. The goal is to conduct discovery to identify scope and requirements, which will inform the solution proposal and estimation.

---

## Discovery Session Summary

### Requests Overview: 7 Total Requests

**Request 1A: Document Preview/View in Browser** - HIGH Priority
- Status: Needs discovery
- Allow users to view documents in-browser without downloading

**Request 1B: Bulk Document Export/Download** - MEDIUM Priority
- Status: Needs discovery
- Export/download multiple documents at once in ZIP file

**Request 1C: Batch/Bulk Document Upload** - MEDIUM-HIGH Priority
- Status: NEW - Requirements to be confirmed
- Upload multiple documents at once (30-50 files typical)
- Major pain point for programs uploading many documents

**Request 1D: Document Editing Capability** - HIGH Priority
- Status: MISSING FEATURE - Critical usability gap
- Edit document metadata (name, description, tags) after upload
- Currently can only add or delete, not edit
- Major usability issue

**Request 2: Document Tagging System** - Required for Request 3
- Status: Needs discovery
- Add tagging/categorization system for documents by type
- Foundation for global document search
- Enables editing tags in Request 1D

**Request 3: Global Document Search and Access** - Depends on Request 2
- Status: Needs discovery
- Allow affiliate/global admins to search documents across programs
- Filter by tags, affiliate, program, upload date

### Dependencies:
- Request 3 requires Request 2 (tagging) to be implemented first
- Request 3 benefits from Request 1A (preview) and 1B (bulk export)
- Request 1C (batch upload) complements Request 1B (bulk download)
- Request 1D (editing) benefits from Request 2 (tagging) to enable tag editing
- Request 1D works independently but enhanced by Request 2

### Recommended Implementation Order:
1. **Phase 1 (Critical)**: Request 1D (Edit Documents) + Request 1A (Preview) - Fix critical usability gaps
2. **Phase 2 (High Value)**: Request 1C (Batch Upload) + Request 2 (Tagging) - Major efficiency improvements
3. **Phase 3 (Enhanced Ops)**: Request 1B (Bulk Export) + Request 3 (Global Search) - Advanced features

---

## Request 1A: Add Document Preview/View in Browser

### Description
Add a "preview" or "view" option to view documents in-browser without needing to download them.

### Priority
HIGH

### Problem Statement
Currently, users must download documents to view them. A program may upload 30-50 documents, and NQMS reviewers need to view multiple documents without downloading each one separately.

### Addresses
- Inability to view documents without downloading
- Time-consuming process of downloading, viewing, and re-downloading documents
- Cluttered downloads folder for reviewers examining many documents
- Need for quick document review without file management overhead

### Current Issues
- Only "Download" and "Delete" options available
- Must download every document to see contents
- Reviewers may download documents multiple times
- No way to quickly scan document contents

### Discovery Questions

1. **Preview Functionality:**
   - What file types should support in-browser preview? (PDF, images, Word docs, Excel, etc.)
   - Should preview open in a modal/lightbox or new tab?
   - Should preview show full document or just first page?
   - What should happen for file types that can't be previewed (ZIP, etc.)?

2. **Preview vs. View:**
   - Is "preview" the same as "view" or are they different features?
   - Should users still be able to download from the preview screen?
   - Should there be print functionality from preview?

3. **Access & Permissions:**
   - Should preview respect the same permissions as download?
   - Can NQMS-limited contractors access preview if download is restricted?
   - Should there be audit logging for document previews?

4. **Technical Requirements:**
   - Should documents be converted to PDF for preview (for consistency)?
   - Are there file size limits for preview?
   - Should preview use existing file storage or generate preview versions?

5. **UI/UX:**
   - Where should the preview button be located? (next to Download button?)
   - What icon/text should be used? ("Preview", "View", eye icon?)
   - Should clicking the document name trigger preview or download?

### Recommended Solution (Budget-Friendly)

**Approach: Browser-Native Preview with PDF Viewer**

**Implementation:**
1. **Add preview action to DocumentsController**
   - New `preview($id)` action that serves file with inline content disposition
   - Check file type and serve appropriate content-type header
   - Use existing authorization (if user can download, they can preview)

2. **Update document list view**
   - Add "Preview" button/icon next to Download button
   - Opens preview in new browser tab (browser handles rendering)
   - Different icon for previewable vs. non-previewable files

3. **File type handling**
   - **Natively previewable**: PDF, images (PNG, JPG, GIF), text files
   - **Requires viewer**: Word, Excel, PowerPoint (use browser plugins or convert to PDF)
   - **Not previewable**: ZIP, other binaries (show message, offer download)

4. **Optional: PDF conversion for Office docs**
   - Use existing CakePDF/DomPDF library if available
   - Or use cloud service (Google Docs Viewer, Office Online Viewer) via iframe
   - Or require manual PDF upload for preview

**Benefits:**
- **Simple implementation**: Leverages browser's native preview capabilities
- **No new dependencies**: Uses existing file storage and authorization
- **Fast**: No file conversion or storage overhead
- **Works immediately**: PDF and images work out of the box

**Files to Modify:**
- `plugins/Programs/src/Controller/Admin/DocumentsController.php` - Add preview action
- `plugins/Programs/templates/Admin/Documents/index.twig` - Add preview button
- `config/request_policy_configs.php` - Add preview permission (copy download rules)

**Technical Considerations:**
- Set `Content-Disposition: inline` header for preview (vs. `attachment` for download)
- Browser support varies by file type
- PDF.js can be added for better PDF preview control if needed
- Consider file size limits (large files may be slow to preview)

**Alternative for Office Documents:**
- **Option A**: Require users to upload PDF versions for preview
- **Option B**: Use iframe with Google Docs Viewer: `https://docs.google.com/viewer?url=YOUR_FILE_URL`
- **Option C**: Convert Office docs to PDF on upload (more complex)

---

## Request 1B: Add Bulk Document Export/Download

### Description
Create an option to export all documents or select multiple documents to download at a time (in a ZIP file).

### Priority
MEDIUM

### Problem Statement
A program may upload 30-50 documents. Users (especially NQMS reviewers) need to download all documents at once rather than downloading each individually.

### Addresses
- Time-consuming process of downloading 30-50 documents individually
- Need for NQMS reviewers to download entire program document sets
- Preventing duplicate downloads and file management issues

### Current Issues
- Only individual document download available
- Each document requires separate download action
- No bulk selection or "export all" option
- Reviewers waste time on repetitive download clicks

### Discovery Questions

1. **Bulk Selection:**
   - Should there be checkboxes to select multiple documents?
   - Should there be "Select All" / "Deselect All" options?
   - Should there be an "Export All" button separate from selective export?

2. **Export Format:**
   - Should multiple documents be combined into a ZIP file? *(Recommended: Yes)*
   - What should the ZIP file be named? (`program_name_documents_date.zip`?)
   - Should folder structure be preserved in ZIP? (organized by tags, assessment, etc.?)

3. **Access & Permissions:**
   - Who should have access to bulk export? (program admins, affiliate admins, global admins, NQMS reviewers?)
   - Should NQMS-limited contractors be able to bulk export if preview is available?
   - Should bulk downloads be logged for audit purposes?

4. **Technical Requirements:**
   - Should ZIP be generated on-demand or pre-generated?
   - Are there file size limits for ZIP export? (server/PHP memory limits?)
   - Should large exports be queued and emailed when ready?

5. **UI/UX:**
   - Where should the "Export All" button be located? (top of documents list?)
   - Where should the "Export Selected" button be located?
   - Should there be a confirmation showing how many files will be exported?

### Recommended Solution (Budget-Friendly)

**Approach: On-Demand ZIP Generation**

**Implementation:**
1. **Add checkboxes to document list**
   - Checkbox for each document row
   - "Select All" / "Deselect All" buttons
   - JavaScript to track selected documents

2. **Add bulk export actions**
   - "Export Selected" button (disabled if none selected)
   - "Export All" button (separate action)
   - Both create ZIP file and stream to browser

3. **ZIP generation**
   - New `exportDocuments()` action in DocumentsController
   - Accept array of document IDs or "all" flag
   - Use PHP ZipArchive class (built-in, no dependencies)
   - Stream ZIP directly to browser (no server storage)
   - Standard filename: `{program_name}_documents_{date}.zip`

4. **Authorization**
   - Use existing document permissions (if user can download individual docs, they can bulk export)
   - Check authorization for each document being included
   - Skip documents user doesn't have access to (with notice)

**Benefits:**
- **No new dependencies**: Uses PHP's built-in ZipArchive
- **No storage overhead**: ZIP generated in memory and streamed
- **Simple permissions**: Reuses existing document authorization
- **Scalable**: Works for small and large document sets

**Files to Modify:**
- `plugins/Programs/src/Controller/Admin/DocumentsController.php` - Add export actions
- `plugins/Programs/templates/Admin/Documents/index.twig` - Add checkboxes and export buttons
- JavaScript file for checkbox selection logic
- `config/request_policy_configs.php` - Add export permission

**Technical Considerations:**
- PHP `memory_limit` may need increase for large document sets (50+ files)
- Consider adding progress indicator for large exports
- ZIP file is deleted from memory after streaming
- Set appropriate timeout for large exports (`max_execution_time`)

**Database Changes:**
None required

**Future Enhancement:**
- For very large exports (100+ docs), implement background job with email notification when ready
- Add folder organization within ZIP (by document tags, assessment sections, etc.)

---

## Request 1C: Add Batch/Bulk Document Upload

### Description
Add functionality to upload multiple documents at once, allowing users to select and upload multiple files in a single action rather than uploading documents one at a time.

### Priority
MEDIUM-HIGH

### Problem Statement
Programs need to upload 30-50 documents to support their assessment submissions. Currently, users must upload each document individually, which is time-consuming and tedious. A batch upload feature would significantly improve the user experience for both program staff and reviewers who need to upload multiple documents.

### Addresses
- Time-consuming process of uploading 30-50 documents one at a time
- Repetitive clicking and form submission for each individual document
- User frustration with single-file upload limitation
- Need for efficient bulk document management
- Programs abandoning document uploads due to tedious process

### Current Issues
- Only single-file upload available
- Each document requires separate upload action
- Must fill out document name/description for each file individually
- No way to upload multiple files at once
- Users may give up before uploading all necessary documents

### Use Cases
- Program uploads 30 documents after completing assessment (policies, procedures, forms, curriculum, etc.)
- Reviewer uploads multiple reference documents for a program
- Affiliate admin uploads training materials for multiple programs
- Bulk migration of existing documents from external storage to NQMS

### Discovery Questions

1. **Upload Interface:**
   - Should users be able to drag-and-drop multiple files? *(Recommended: Yes)*
   - Should there be a "Select Multiple Files" button?
   - How many files should be allowed per batch? (limit: 10? 25? 50? unlimited?)
   - Should there be a total file size limit per batch? (e.g., 100MB max per batch?)

2. **File Management During Upload:**
   - Should users see a list of selected files before starting upload?
   - Should users be able to remove files from the queue before uploading?
   - Should there be a progress bar showing overall upload progress?
   - Should each file have an individual progress indicator?

3. **Document Metadata:**
   - How should document names be handled? (auto-use filename, or allow editing each name?)
   - Should users be able to add document tags during batch upload? (requires Request 2)
   - Should users be able to add descriptions for each document, or upload without descriptions?
   - Should there be bulk actions to apply the same tags to all uploaded files?

4. **Upload Processing:**
   - Should files upload sequentially or in parallel?
   - What happens if one file fails to upload? (stop all, or continue with others?)
   - Should there be a summary showing successful uploads and any failures?
   - Should users be able to retry failed uploads without re-selecting files?

5. **File Validation:**
   - Should file type validation happen before or during upload?
   - What file types are allowed? (PDF, Word, Excel, images, ZIP?)
   - What is the maximum individual file size? (current limit?)
   - Should duplicate files be detected and prevented?

6. **Access & Permissions:**
   - Who should have access to batch upload? (same as single upload permissions?)
   - Should there be any role-based restrictions on batch size?

7. **UI/UX:**
   - Should batch upload replace single upload, or be an additional option?
   - Where should the batch upload interface be located? (Documents tab, separate modal?)
   - Should there be a toggle between "Single Upload" and "Batch Upload" modes?

### Meeting Decisions (Session 2)

**Status:** DISCUSSED - Requirements to be confirmed

**Key Points:**
- Client confirmed need for batch upload functionality
- Programs upload large numbers of documents (30-50 files typical)
- Current single-file upload is major pain point
- Should work similar to bulk download (Request 1B) but in reverse

**Requirements to Confirm:**
1. Maximum number of files per batch
2. Total file size limit per batch
3. Metadata handling (names, descriptions, tags)
4. Error handling approach
5. UI/UX preferences

### Recommended Solution (Budget-Friendly)

**Approach: Modern HTML5 Multi-File Upload with Progress Tracking**

**Implementation:**
1. **Add multi-file upload interface**
   - Update file input to accept multiple files: `<input type="file" multiple>`
   - Add drag-and-drop zone for file selection
   - Display selected files in a list with file names and sizes
   - Allow removing files from queue before upload
   - "Upload All" button to start batch upload

2. **File upload processing**
   - Upload files using AJAX (one at a time sequentially for simplicity)
   - Or upload in parallel (2-3 concurrent) for faster processing
   - Use existing DocumentsController upload action
   - Track progress for each file and overall progress
   - Handle validation errors per file (file type, size, duplicates)

3. **Metadata handling**
   - Auto-populate document name from filename (user can edit if needed)
   - Optional description field (can be left blank for batch uploads)
   - If Request 2 (tags) implemented, allow selecting tags to apply to all files
   - Save each file individually with its metadata

4. **Progress & Error Handling**
   - Show progress bar for overall upload
   - Show status for each file (uploading, success, failed)
   - If file fails, mark it as failed but continue with remaining files
   - Show summary at end: "25 files uploaded successfully, 2 failed"
   - Allow retry for failed files without re-selecting all files

5. **UI/UX Design**
   - Add "Batch Upload" button next to existing "Upload Document" button
   - Opens modal or expands section with multi-file interface
   - Drag-and-drop target area: "Drag files here or click to select"
   - File queue shows: filename, file size, remove button
   - Upload button disabled until at least one file selected
   - Close modal automatically after successful upload (or show "Upload More" option)

**Benefits:**
- **Significant time savings**: Upload 30 files in one action vs. 30 separate actions
- **Better UX**: Drag-and-drop, progress tracking, bulk operations
- **No new dependencies**: Uses HTML5 file API and existing backend
- **Backward compatible**: Single upload still available
- **Error resilient**: Failed uploads don't block successful ones

**Files to Modify:**
- `plugins/Programs/templates/Admin/Documents/index.twig` - Add batch upload button and modal
- `plugins/Programs/webroot/js/documents-batch-upload.js` - New JavaScript for batch upload logic
- `plugins/Programs/src/Controller/Admin/DocumentsController.php` - May need minor adjustments for AJAX uploads
- `plugins/ThemeAdmin/webroot/assets/css/documents.css` - Styling for drag-and-drop and progress indicators

**Technical Considerations:**
- Use HTML5 File API for client-side file handling
- PHP `upload_max_filesize` and `post_max_size` may need adjustment for large batches
- AJAX upload allows for progress tracking and better error handling
- Consider `max_execution_time` for large batches (or upload files one at a time)
- Files uploaded individually on backend (easier authorization and error handling)
- Can reuse existing DocumentsTable validation and save logic

**Implementation Options:**

**Option A: Simple Sequential Upload (Recommended for MVP)**
- Upload files one at a time in sequence
- Easier to implement and debug
- Lower server load
- Predictable behavior
- Easier error handling

**Option B: Parallel Upload (Future Enhancement)**
- Upload 2-3 files concurrently
- Faster for large batches
- Requires more complex progress tracking
- Higher server load

**Batch Limits (Recommendations):**
- **Max files per batch**: 50 files (adjustable)
- **Max total batch size**: 100MB (adjustable based on server limits)
- **Max individual file size**: Same as current single upload limit (e.g., 10MB)
- Display limits clearly in UI

**Drag-and-Drop Enhancement:**
- Use HTML5 Drag and Drop API
- Provide visual feedback when dragging over drop zone
- Support folder drag-and-drop (if browser supports it)
- Fallback to file input for browsers without drag-and-drop support

**Future Enhancements:**
- Drag-and-drop folder support (upload entire folder structure)
- Pause/resume uploads for very large batches
- Background upload (continue uploading while user navigates away)
- Bulk edit metadata after upload (change names, add tags to multiple files at once)
- Integration with document tagging (Request 2) for bulk tagging during upload

---

## Request 1D: Add Document Editing Capability

### Description
Add ability to edit document metadata (name, description, tags) after upload. Currently, users can only add/upload documents but cannot edit them after they are uploaded.

### Priority
HIGH

### Problem Statement
Once a document is uploaded, there is no way to edit its name, description, or tags. If a user makes a mistake or needs to update document information, the only option is to delete the document and re-upload it with corrected information. This is inefficient and results in loss of upload history and metadata.

### Addresses
- Inability to correct mistakes in document names or descriptions after upload
- Cannot update document tags without deleting and re-uploading (requires Request 2)
- No way to rename documents for clarity or consistency
- Loss of upload history when forced to delete and re-upload
- Time waste in re-uploading large files just to fix metadata
- User frustration with lack of basic editing functionality

### Current Issues
- Only "Download" and "Delete" actions available
- No "Edit" button or option for documents
- Must delete and re-upload to make any changes
- Cannot correct typos or update information
- Cannot add/remove tags after initial upload (when Request 2 implemented)
- Re-uploading breaks any links or references to original document

### Use Cases
- User uploads document with typo in name, needs to correct it
- Reviewer wants to add more descriptive name to document for clarity
- User needs to update document description after upload
- User wants to add or change document tags (requires Request 2) after initial upload
- Program uploads 30 documents, realizes naming convention needs updating
- Affiliate admin needs to standardize document names across programs

### Discovery Questions

1. **What Can Be Edited:**
   - Should users be able to edit document name? *(Recommended: Yes)*
   - Should users be able to edit document description? *(Recommended: Yes)*
   - Should users be able to edit document tags (requires Request 2)? *(Recommended: Yes)*
   - Should users be able to replace the physical file (upload new version)? *(More complex - consider separate versioning feature)*
   - Should there be edit history/audit trail showing what was changed and when?

2. **Access & Permissions:**
   - Who should have access to edit documents? (same as delete permissions?)
   - Can users only edit documents they uploaded, or any document in their program?
   - Should global/affiliate admins be able to edit any document?
   - Should there be different permissions for editing metadata vs. replacing files?
   - Can program end users edit their own documents?

3. **Edit Interface:**
   - Should edit open in modal/popup or separate page?
   - Should there be inline editing (click name to edit) or dedicated edit form?
   - Where should "Edit" button be located? (next to Download/Delete buttons?)
   - What icon should be used? (pencil icon, "Edit" text?)
   - Should there be "Save" and "Cancel" buttons?

4. **Validation & Rules:**
   - Should document name be required? (currently is)
   - Should document name be unique within program?
   - Are there character limits or restrictions on names?
   - Can document name be empty/blank?
   - Should description be required or optional?

5. **File Replacement (Optional):**
   - Should users be able to replace the physical file without deleting/re-uploading?
   - If yes, should old file be kept (versioning) or permanently replaced?
   - Should file type restrictions apply to replacements?
   - Should file size limits apply to replacements?

6. **Audit Trail:**
   - Should system track who edited document and when?
   - Should system track what fields were changed?
   - Should edit history be visible to users?
   - Should there be "Last modified by" and "Last modified date" fields?

### Meeting Decisions (Session 2)

**Status:** NOT DISCUSSED - High priority missing feature identified

**Current State:**
- No edit functionality exists today
- Users can only add (upload) or delete documents
- Cannot modify any document metadata after upload
- Major usability issue

**Expected Requirements:**
- Add "Edit" button/action for documents
- Allow editing of document name and description at minimum
- Allow editing of document tags when Request 2 (tagging) is implemented
- Use same permission model as delete (NQMS staff, not necessarily program users)
- Simple modal or form for editing

**Requirements to Confirm:**
1. Which fields should be editable (name, description, tags)?
2. Who should have edit permissions?
3. Should there be edit history/audit trail?
4. UI/UX preferences (modal vs. page, inline vs. form)?
5. File replacement functionality needed?

### Recommended Solution (Budget-Friendly)

**Approach: Simple Metadata Edit Form**

**Implementation:**
1. **Add "Edit" button to document list**
   - Place next to "Download" and "Delete" buttons
   - Only visible to users with edit permissions
   - Pencil icon or "Edit" text

2. **Create edit form/modal**
   - Open in modal popup (or separate page if preferred)
   - Show current document name (editable text field)
   - Show current description (editable textarea)
   - Show current tags (editable checkboxes/multi-select - requires Request 2)
   - "Save" and "Cancel" buttons
   - Validation on save (required fields, character limits)

3. **Update controller action**
   - New `edit($id)` action in DocumentsController
   - Display edit form with current document data
   - New `update($id)` action (or update existing)
   - Validate and save changes
   - Update `modified` timestamp automatically
   - Redirect back to document list with success message

4. **Authorization**
   - Use existing document permissions
   - Same access level as delete (if user can delete, they can edit)
   - Check authorization in controller
   - NQMS staff (reviewers/affiliates) can edit documents
   - Program users: TBD based on client requirements

5. **Audit trail (optional)**
   - Add `modified_by` field to documents table (user_id)
   - Track who last modified document
   - Display "Last modified by [Name] on [Date]" in document list
   - Optional: Create document_audit_log table for full edit history

**Benefits:**
- **Fixes major usability gap**: No need to delete and re-upload
- **Simple implementation**: Standard CRUD edit functionality
- **Saves time**: Quick edits vs. re-uploading large files
- **Preserves history**: Don't lose upload date or references
- **Flexible**: Can edit name, description, and tags independently

**Files to Modify:**
- `plugins/Programs/src/Controller/Admin/DocumentsController.php` - Add edit and update actions
- `plugins/Programs/templates/Admin/Documents/index.twig` - Add edit button
- `plugins/Programs/templates/Admin/Documents/edit.twig` - New edit form (or modal)
- `config/request_policy_configs.php` - Add edit permission (likely same as delete)
- Optional: `config/Migrations/` - Add modified_by field for audit trail

**Database Changes (Optional - for audit trail):**
```sql
-- Add modified_by tracking
ALTER TABLE documents ADD COLUMN modified_by INT NULL AFTER modified;
ALTER TABLE documents ADD FOREIGN KEY (modified_by) REFERENCES users(id) ON DELETE SET NULL;

-- Or create full audit log table
CREATE TABLE document_audit_log (
    id INT AUTO_INCREMENT PRIMARY KEY,
    document_id INT NOT NULL,
    user_id INT NOT NULL,
    action VARCHAR(50) NOT NULL, -- 'edit', 'delete', etc.
    field_changed VARCHAR(100) NULL,
    old_value TEXT NULL,
    new_value TEXT NULL,
    created DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (document_id) REFERENCES documents(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_document_id (document_id),
    INDEX idx_created (created)
);
```

**Technical Considerations:**
- Editing metadata only, not the physical file (file replacement is separate feature)
- CakePHP's standard edit/update pattern makes this straightforward
- Validation rules from add form can be reused
- `modified` timestamp updates automatically (CakePHP convention)
- No impact on file storage or file system

**UI/UX Options:**

**Option A: Modal Popup (Recommended)**
- Edit button opens modal overlay
- Form appears on same page
- Quick and convenient
- No page navigation
- Better for small edits

**Option B: Separate Edit Page**
- Edit button navigates to edit page
- Full page form
- More space for complex forms
- Traditional CRUD pattern
- Better for extensive metadata

**Option C: Inline Editing**
- Click document name to edit in place
- Quick edits without modal/page
- Less obvious to users
- More complex JavaScript
- Best for single-field edits

**Recommendation:** Start with Option A (modal) or B (page) for MVP. Can add inline editing later.

**Future Enhancements:**
- **File versioning**: Upload new version of file while keeping old versions
- **Bulk edit**: Edit multiple documents at once (change tags on 10 documents)
- **Edit history view**: See all changes made to a document over time
- **Revert changes**: Undo recent edits
- **Document preview in edit form**: See document while editing metadata

**Integration with Other Requests:**
- **Request 2 (Tagging)**: Edit form will include tag selection when tagging is implemented
- **Request 1C (Batch Upload)**: After batch upload, users may need to bulk edit metadata
- Works independently of other requests but enhances all document features

---

## Request 2: Add Document Tagging System

### Description
Develop a system for tagging documents by document type. Replace or supplement the "Name" field with checkboxes/tags that allow users to categorize documents by type.

### Problem Statement
Documents are only identified by their filename. Users need a way to categorize documents by type (e.g., "Training Curriculum", "Mentor Application", "Policies") so reviewers can quickly identify document contents, especially when multiple document types are combined in one file.

### Addresses
- Inability to categorize or search documents by type
- One document file may contain multiple document types (e.g., policies manual with protocols, procedures, forms)
- Reviewers need to know what types of documents are included without opening files
- No way to search across programs for specific document types

### Current Issues
- Only "Name" field available for document identification
- No standardized categorization
- Cannot search by document type
- Cannot easily find all documents of a certain type across programs

### Use Cases
- Tag a "Policies & Procedures Manual" as containing: "Policies", "Procedures", "Forms"
- Search for all "Training Curriculum" documents across programs
- Filter documents by type when reviewing assessments
- Download all documents of a specific type

### Discovery Questions

1. **Tagging System Design:**
   - Should tags replace the "Name" field or supplement it? *(Recommended: Supplement)*
   - Should users be able to add multiple tags to one document?
   - Should tags be predefined (checkboxes) or free-text?
   - Can new tags be added by users or only by admins?

2. **Tag Options:**
   - What should the predefined tag list include? (MENTOR to provide)
   - Examples: Training Curriculum, Mentor Application, Policies, Procedures, Forms, Marketing Materials, etc.
   - How many tags are anticipated? (10-20? 20-50?)
   - Should tags be organized into categories?

3. **UI/UX:**
   - Where should tags appear on upload form? (Below file selection? Below name field?)
   - How should tags display in document list? (Under filename? As badges/chips?)
   - Should tags be filterable/clickable in the document list?
   - Should there be a tag legend or help text explaining each tag?

4. **Search & Filter:**
   - Should document list be filterable by tags?
   - Should there be a global document search by tags (Request 3)?
   - Should users be able to select multiple tag filters (AND vs. OR logic)?

5. **Existing Documents:**
   - What happens to documents without tags?
   - Should existing documents be retroactively tagged?
   - Should there be a bulk tagging feature for existing documents?

### Recommended Solution (Budget-Friendly)

**Approach: Many-to-Many Tagging with Predefined Tags**

**Implementation:**
1. **Database changes**
   - Create `document_tags` table (id, name, description, created, modified)
   - Create `documents_tags` junction table (document_id, tag_id)
   - Seed with MENTOR's predefined tag list
   - Keep existing `name` field on documents

2. **Update document upload form**
   - Add checkbox group or multi-select for tags
   - Display tag descriptions on hover/as help text
   - Tags optional but encouraged (keep name field required)
   - Multiple tags can be selected per document

3. **Update document display**
   - Show tags as badges/chips under document name
   - Tags visually distinct (colored badges)
   - Tags clickable to filter (or static if filtering not in scope)

4. **Add tag management (Global Admin only)**
   - Simple CRUD for managing tag list
   - Add/edit/delete/reorder tags
   - Update tag descriptions

**Benefits:**
- **Flexible**: Multiple tags per document
- **Standardized**: Predefined tags ensure consistency
- **Backward compatible**: Existing documents still work without tags
- **Searchable**: Foundation for Request 3 (global document search)

**Files to Modify:**
- `config/Migrations/` - Create document_tags and documents_tags tables
- `plugins/Programs/src/Model/Table/DocumentsTable.php` - Add Tags association
- `plugins/Programs/src/Model/Table/DocumentTagsTable.php` - New table class
- `plugins/Programs/src/Controller/Admin/DocumentsController.php` - Handle tags in add/edit
- `plugins/Programs/templates/Admin/Documents/add.twig` - Add tag checkboxes
- `plugins/Programs/templates/Admin/Documents/edit.twig` - Add tag checkboxes
- `plugins/Programs/templates/Admin/Documents/index.twig` - Display tags
- `config/Seeds/` - Seed initial tag list

**Database Changes:**
```sql
CREATE TABLE document_tags (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT NULL,
    created DATETIME DEFAULT CURRENT_TIMESTAMP,
    modified DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY idx_name (name)
);

CREATE TABLE documents_tags (
    document_id INT NOT NULL,
    tag_id INT NOT NULL,
    PRIMARY KEY (document_id, tag_id),
    FOREIGN KEY (document_id) REFERENCES documents(id) ON DELETE CASCADE,
    FOREIGN KEY (tag_id) REFERENCES document_tags(id) ON DELETE CASCADE
);
```

**Technical Considerations:**
- CakePHP's BelongsToMany association handles junction table automatically
- Tags can be managed separately from documents
- Easy to add tag filtering in future (Request 3)
- Consider adding tag usage count for analytics

**Future Enhancements:**
- Tag filtering in document list
- Tag-based search (Request 3)
- Tag usage analytics
- Suggested tags based on document name/content

---

## Request 3: Global Document Search and Access

### Description
Provide global or affiliate admins with the ability to search for and access all documents uploaded in the system, filterable by document tags and other criteria.

### Problem Statement
Affiliates and national staff need to search across multiple programs for specific types of documents (e.g., all training curricula, all marketing plans) to inform their work, create resources, or conduct research. Currently, there's no way to search or access documents across programs.

### Addresses
- Affiliate staff requests to access all documents by type for their service area
- National staff requests for samples across the country (e.g., marketing plans for National Mentoring Month)
- Researcher requests for document samples (e.g., theory of change documents)
- Cannot view what documents exist across programs

### Current Issues
- Documents only accessible within their program
- No cross-program search or filtering
- No way to export/download documents from multiple programs at once
- Affiliates and national staff cannot leverage existing resources

### Use Cases
- Affiliate admin searches for all "Training Curriculum" documents for programs they serve
- National staff searches for all "Marketing Plans" across the country
- Researcher searches for all "Theory of Change" documents
- Global admin generates report of all document types uploaded in the system

### Discovery Questions

1. **Scope & Access:**
   - Who should have access to global document search? (global admins, affiliate admins, NQMS reviewers?)
   - Should affiliate admins only see documents from their programs, or all programs?
   - Should there be an opt-in consent for programs to share documents beyond their affiliate?

2. **Search & Filter Criteria:**
   - Filter by document tags? *(Recommended: Yes, requires Request 2)*
   - Filter by program?
   - Filter by affiliate?
   - Filter by assessment status? (submitted, approved, etc.)
   - Filter by upload date range?
   - Keyword search in document names?

3. **Results Display:**
   - What information should display in results? (document name, tags, program name, upload date?)
   - Should results be sortable? (by date, program, name, tags?)
   - How many results per page?
   - Should preview be available from results? (requires Request 1A)

4. **Export Functionality:**
   - Should there be "Export All" for filtered results? *(Recommended: Yes)*
   - Should export create a ZIP file similar to Request 1B?
   - Should there be a limit on number of documents that can be exported at once?
   - Should large exports be queued/emailed?

5. **Privacy & Consent:**
   - Should programs opt-in to sharing documents beyond their affiliate?
   - Where should opt-in setting be? (top of documents tab? program settings? per document?)
   - What is the default? (opt-in or opt-out?)
   - Should document sharing consent be at program level or document level?

6. **UI Location:**
   - Should this be in the Reports menu? *(Suggested by client)*
   - Or a separate "Document Library" section?
   - Or under Documents with a "Search All Documents" button?

### Recommended Solution (Budget-Friendly)

**Approach: Reports-Based Document Search with Optional Consent**

**Implementation:**
1. **Add consent setting (if required)**
   - Add `share_documents` boolean to programs table (default: true or false per client)
   - Or add checkbox at top of Documents tab
   - Or per-document consent (more complex, not recommended initially)

2. **Create document search report**
   - New report in Reports plugin: "Document Library" or "Document Search"
   - Filters similar to NQMS Aggregate report:
     - Document tags (multi-select, requires Request 2)
     - Affiliate (multi-select for global admins, auto-filtered for affiliate admins)
     - Program (multi-select)
     - Upload date range
     - Keyword search in document name
   - "Search" button to execute filtered query

3. **Results display**
   - Table showing: Document name, Tags (badges), Program name, Affiliate name, Upload date
   - Sortable columns
   - Pagination (50-100 results per page)
   - "Preview" link (if Request 1A implemented)
   - "Download" link (individual document)
   - Checkbox for bulk selection

4. **Bulk export**
   - "Export Selected" and "Export All Results" buttons
   - Creates ZIP file with all matching documents
   - ZIP organized by program folders: `Program_Name/document_name.pdf`
   - Standard filename: `documents_export_{date}.zip`

5. **Authorization**
   - Global admins: See all documents (or all with consent if required)
   - Affiliate admins: See only their affiliate's program documents
   - NQMS reviewers: TBD based on role requirements
   - Respect document permissions (if user can't normally access, don't show)

**Benefits:**
- **Centralized access**: All document search in one place
- **Flexible filtering**: Multiple filter options for targeted searches
- **Familiar UI**: Reuses Reports plugin patterns
- **Privacy-conscious**: Optional consent mechanism
- **Bulk export**: Download multiple program documents at once

**Files to Modify:**
- `config/Migrations/` - Add `share_documents` to programs table (if consent required)
- `plugins/Reports/src/Controller/Admin/DocumentsController.php` - New controller for document search
- `plugins/Reports/templates/Admin/Documents/search.twig` - Search form and results
- `config/request_policy_configs.php` - Add permissions for document search
- `config/navigation.php` - Add "Document Library" to Reports menu

**Database Changes (if consent required):**
```sql
ALTER TABLE programs ADD COLUMN share_documents TINYINT(1) DEFAULT 1;
```

**Technical Considerations:**
- Query may be slow with many documents (add indexes on document tags)
- Consent default should be discussed with client (opt-in vs opt-out)
- ZIP generation may hit memory limits with large result sets (100+ docs)
- Consider adding result count before export ("Export 127 documents?")

**Privacy Options:**
- **Option A**: No consent required, global/affiliate admins can see all documents
- **Option B**: Program-level opt-in (checkbox on Documents tab)
- **Option C**: Document-level opt-in (checkbox per document, more complex)

**Recommendation**: Start with Option A or B (program-level) for simplicity. Can add document-level later if needed.

---

## Overall Discovery Questions

### General Scope
1. **Priority Order:**
   - What is the priority order for these requests?
   - **Request 1D (Edit Documents): HIGH priority** - Critical missing feature
   - Request 1A (Preview): HIGH priority
   - Request 1C (Batch Upload): MEDIUM-HIGH priority - Major pain point
   - Request 1B (Bulk Export): MEDIUM priority
   - Request 2 (Tags): Required for Request 3, enhances Request 1D
   - Request 3 (Global Search): Dependent on Request 2
   - Should these be implemented in phases or all together?

2. **Dependencies:**
   - Request 3 requires Request 2 (tags) to be fully functional
   - Request 3 benefits from Request 1A (preview) and 1B (bulk export)
   - Request 1C (batch upload) works independently but pairs well with 1B (bulk download)
   - Request 1D (edit) works independently but enhanced by Request 2 (can edit tags)
   - **Recommended order: 1D + 1A → 1C + 2 → 1B + 3**

3. **Timeline & Budget:**
   - What is the desired timeline for implementation?
   - Are there budget constraints that should inform phasing?
   - Should we start with high-priority items (1A, 1B) first?

### User Impact
1. **User Base:**
   - How many programs actively upload documents?
   - Average number of documents per program?
   - How many NQMS reviewers use the system?
   - How many affiliate admins would use global document search?

2. **File Types:**
   - What file types are most commonly uploaded? (PDF, Word, Excel, images?)
   - Are there file size limits currently enforced?
   - What percentage are PDF vs. Office documents?

3. **Training & Communication:**
   - What training or documentation will be needed for new features?
   - How should users be notified about preview, tagging, and search features?

### Technical Considerations
1. **Current System:**
   - Current file storage system? (S3 via Orases/Files plugin)
   - Average and maximum file sizes?
   - Total document storage size?
   - Any performance concerns with current document system?

2. **Privacy & Compliance:**
   - Are there FERPA or other privacy concerns with document sharing?
   - Should there be audit logging for document access?
   - Are there data retention policies for documents?

---

## Next Steps

1. **Schedule discovery sessions** with key stakeholders for each request
2. **Clarify priority order** and dependencies
3. **Confirm document edit requirements** for Request 1D:
   - Which fields can be edited (name, description, tags)
   - Who has edit permissions
   - UI/UX preferences (modal vs. page)
   - Audit trail requirements
4. **Confirm batch upload requirements** for Request 1C:
   - Maximum files per batch
   - Total file size limits
   - Metadata handling preferences
   - UI/UX preferences (drag-and-drop, modal, etc.)
5. **Determine consent requirements** for Request 3 (document sharing)
6. **Get list of document tags** from MENTOR for Request 2
7. **Identify file type distribution** to prioritize preview support (Request 1A)
8. **Create detailed solution proposals** with implementation plans
9. **Develop effort estimates** for each request
10. **Present findings and recommendations** to client for prioritization

### Critical Priority Items for Next Discovery Session:
- **Request 1D (Edit Documents)**: CRITICAL - Missing basic CRUD functionality
  - Confirm which fields should be editable
  - Determine permissions model
  - Choose UI approach (modal vs. page)
- **Request 1A (Preview)**: Determine file type support priorities
- **Request 1C (Batch Upload)**: Confirm technical requirements and UX preferences
