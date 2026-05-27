# SharePoint Migration Plan - MENTOR Connect

**Document Version:** 1.0
**Date:** 2025-11-04
**Status:** Draft

---

## Executive Summary

This document outlines the comprehensive plan for migrating MENTOR Connect's document storage from local file system to Microsoft SharePoint Online. The migration involves transitioning all program documents and assessment attachments while maintaining system availability and data integrity.

---

## Table of Contents

1. [Current State Analysis](#current-state-analysis)
2. [SharePoint Integration Architecture](#sharepoint-integration-architecture)
3. [Migration Strategy](#migration-strategy)
4. [Technical Implementation Plan](#technical-implementation-plan)
5. [Data Migration Process](#data-migration-process)
6. [Testing Plan](#testing-plan)
7. [Risk Management](#risk-management)
8. [Timeline and Resources](#timeline-and-resources)
9. [Post-Migration Plan](#post-migration-plan)
10. [Appendices](#appendices)

---

## 1. Current State Analysis

### 1.1 Current Storage Configuration

**Storage Type:** Local File System
**Storage Location:** `/data/o-files/`
**Framework:** League Flysystem with Local Adapter
**Management Plugin:** Orases/Files (proprietary)

### 1.2 Document Types

| Document Type | Database Table | Foreign Key | Purpose |
|---------------|----------------|-------------|---------|
| Program Documents | `program_documents` | `program_id` | Program-level documentation |
| Assessment Attachments | `program_assessment_response_attachments` | `program_assessment_response_id` | Assessment question responses |

### 1.3 File Metadata Storage

All files tracked in `o_files` table with:
- Unique ID (UUID)
- File path (relative)
- Original filename
- File size (bytes)
- MIME type
- File hash (integrity)
- JSON metadata
- Creation timestamp

### 1.4 Supported File Types

- **Documents:** PDF, PPT, PPTX, DOC, DOCX
- **Images:** JPEG, PNG, GIF, SVG, WebP
- **Audio:** MP3, WAV, OGG
- **Video:** MP4, MOV (if applicable)

### 1.5 Key Application Files

| File Path | Purpose |
|-----------|---------|
| `/src/Model/Entity/OFile.php` | File entity with URL generation |
| `/plugins/Programs/src/Controller/Admin/DocumentsController.php` | Document CRUD operations |
| `/vendor/orases/files/src/FilesystemAwareTrait.php` | File operation methods |
| `/config/filesystem.php` | Storage adapter configuration |

### 1.6 Current Data Volume

**ACTION REQUIRED:** Execute analysis query:
```sql
-- Total file count
SELECT COUNT(*) as total_files FROM o_files;

-- Total storage size
SELECT SUM(size) as total_bytes,
       SUM(size)/1024/1024/1024 as total_gb
FROM o_files;

-- Files by type
SELECT mime, COUNT(*) as count, SUM(size)/1024/1024 as size_mb
FROM o_files
GROUP BY mime
ORDER BY count DESC;

-- Program documents count
SELECT COUNT(*) as program_docs FROM program_documents;

-- Assessment attachments count
SELECT COUNT(*) as assessment_attachments
FROM program_assessment_response_attachments;
```

---

## 2. SharePoint Integration Architecture

### 2.1 SharePoint Environment

**Platform:** Microsoft SharePoint Online (Microsoft 365)
**Authentication:** Azure AD OAuth 2.0
**API:** Microsoft Graph API
**Storage Adapter:** Custom Flysystem adapter or Azure Blob Storage

### 2.2 Proposed Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    MENTOR Connect Application                │
├─────────────────────────────────────────────────────────────┤
│  DocumentsController          OFilesController (API)         │
│      (Programs Plugin)         (Orases/Files Plugin)         │
├─────────────────────────────────────────────────────────────┤
│                    Orases/Files Plugin                       │
│  FilesystemAwareTrait         OFile Entity                  │
├─────────────────────────────────────────────────────────────┤
│                    League Flysystem                          │
├─────────────────────────────────────────────────────────────┤
│              SharePoint/Graph API Adapter (NEW)              │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  ┌──────────────────────────────────────────────┐          │
│  │         Microsoft Graph API                   │          │
│  │  (OAuth 2.0 Authentication via Azure AD)     │          │
│  └──────────────────────────────────────────────┘          │
│                         │                                    │
│                         ▼                                    │
│  ┌──────────────────────────────────────────────┐          │
│  │         SharePoint Online                     │          │
│  │  - Document Library: mentor-connect-files    │          │
│  │  - Folder Structure: /programs/{id}/         │          │
│  │  - Folder Structure: /assessments/{id}/      │          │
│  └──────────────────────────────────────────────┘          │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

### 2.3 SharePoint Structure

**Site:** `https://{tenant}.sharepoint.com/sites/mentor-connect`
**Document Library:** `MentorConnectFiles`

**Folder Structure:**
```
/MentorConnectFiles
├── /programs
│   ├── /{program_id}
│   │   ├── /{document_id}_{filename}
│   │   └── ...
│   └── ...
├── /assessments
│   ├── /{assessment_response_id}
│   │   ├── /{file_id}_{filename}
│   │   └── ...
│   └── ...
└── /archive (for legacy organization if needed)
```

### 2.4 Authentication Configuration

**Azure AD App Registration Requirements:**
- Application (client) ID
- Directory (tenant) ID
- Client Secret
- Redirect URI (if using interactive auth)

**Required Permissions:**
- `Sites.ReadWrite.All` - Read/write site content
- `Files.ReadWrite.All` - Read/write files

**Grant Type:** Client Credentials (server-to-server)

---

## 3. Migration Strategy

### 3.1 Selected Approach: Phased Migration

**Phase 1: Setup & Testing (Week 1-2)**
- Azure AD app registration
- SharePoint site and library setup
- Adapter development and testing
- Dev environment configuration

**Phase 2: Pilot Migration (Week 3)**
- Migrate small subset of files (100-500 files)
- Validate upload/download/delete operations
- Performance testing
- Rollback testing

**Phase 3: Batch Migration (Week 4-5)**
- Migrate files in batches (by program or date)
- Monitor for errors
- Maintain local backup
- Update database records incrementally

**Phase 4: Cutover & Cleanup (Week 6)**
- Switch production to SharePoint adapter
- Monitor production usage
- Verify all files accessible
- Archive/remove local files (after 30-day retention)

### 3.2 Rollback Plan

**Triggers for Rollback:**
- >5% file access failures
- Critical file corruption
- Performance degradation >50%
- Authentication failures

**Rollback Steps:**
1. Switch `filesystem.php` back to Local adapter
2. Restore database from pre-migration backup
3. Verify local files still accessible
4. Investigate issues
5. Plan remediation

### 3.3 Downtime Requirements

**Pilot Phase:** No downtime (read-only mode for migrated subset)
**Production Cutover:** 2-4 hour maintenance window (weekend preferred)
**Contingency:** Additional 4-hour window if rollback needed

---

## 4. Technical Implementation Plan

### 4.1 Prerequisites

**Software Requirements:**
- PHP 8.1+ (current version)
- Composer dependencies:
  - `microsoft/microsoft-graph` (Graph SDK)
  - `league/flysystem` (already installed)
  - Custom SharePoint adapter or `league/flysystem-azure-blob-storage`

**Azure Requirements:**
- Active Microsoft 365 subscription
- Global Administrator access for app registration
- SharePoint site collection administrator access

**Development Environment:**
- Staging/dev environment with SharePoint test site
- Database snapshot capability
- File backup system

### 4.2 Code Implementation Tasks

#### Task 1: Create SharePoint Flysystem Adapter

**File:** `/src/Filesystem/SharePointAdapter.php`

```php
<?php
namespace App\Filesystem;

use League\Flysystem\FilesystemAdapter;
use League\Flysystem\Config;
use Microsoft\Graph\Graph;
use Microsoft\Graph\Model;

class SharePointAdapter implements FilesystemAdapter
{
    private Graph $graph;
    private string $siteId;
    private string $driveId;
    private string $basePath;

    public function __construct(array $config)
    {
        // Initialize Graph client with OAuth credentials
        // Set site and drive IDs
        // Configure base path
    }

    public function fileExists(string $path): bool
    {
        // Check if file exists in SharePoint
    }

    public function write(string $path, string $contents, Config $config): void
    {
        // Upload file to SharePoint
    }

    public function read(string $path): string
    {
        // Download file from SharePoint
    }

    public function delete(string $path): void
    {
        // Delete file from SharePoint
    }

    // Additional required methods...
}
```

#### Task 2: Update Filesystem Configuration

**File:** `/config/filesystem.php`

```php
<?php
use App\Filesystem\SharePointAdapter;
use Cake\Core\Configure;

return [
    'Filesystem' => [
        'default' => [
            'adapter' => SharePointAdapter::class,
            'adapterArguments' => [
                'tenant_id' => env('SHAREPOINT_TENANT_ID'),
                'client_id' => env('SHAREPOINT_CLIENT_ID'),
                'client_secret' => env('SHAREPOINT_CLIENT_SECRET'),
                'site_url' => env('SHAREPOINT_SITE_URL'),
                'library_name' => env('SHAREPOINT_LIBRARY', 'MentorConnectFiles'),
            ],
            'entityClass' => 'App\Model\Entity\OFile',
        ],
        // Keep local as backup during migration
        'local' => [
            'adapter' => 'League\Flysystem\Local\LocalFilesystemAdapter',
            'adapterArguments' => [ROOT . DS . 'data' . DS . 'o-files'],
            'entityClass' => 'App\Model\Entity\OFile',
        ],
    ],
];
```

#### Task 3: Update Environment Configuration

**File:** `/.env` (add these variables)

```bash
# SharePoint Configuration
SHAREPOINT_TENANT_ID=your-tenant-id
SHAREPOINT_CLIENT_ID=your-client-id
SHAREPOINT_CLIENT_SECRET=your-client-secret
SHAREPOINT_SITE_URL=https://yourtenant.sharepoint.com/sites/mentor-connect
SHAREPOINT_LIBRARY=MentorConnectFiles

# Migration Settings
MIGRATION_BATCH_SIZE=100
MIGRATION_MODE=local  # Options: local, sharepoint, dual
```

#### Task 4: Update OFile Entity for SharePoint URLs

**File:** `/src/Model/Entity/OFile.php`

Update the URL generation method to support SharePoint:

```php
public function getSharePointUrl(): string
{
    if ($this->hasSharePointConfig()) {
        $siteUrl = Configure::read('Filesystem.default.adapterArguments.site_url');
        $library = Configure::read('Filesystem.default.adapterArguments.library_name');
        return $siteUrl . '/_layouts/15/download.aspx?share=' . urlencode($this->path);
    }
    return $this->getUrl(); // Fallback to local URL
}

private function hasSharePointConfig(): bool
{
    $fileSystem = Configure::read('Filesystem');
    if ($fileSystem && !empty($fileSystem['default']['adapter'])) {
        return strpos($fileSystem['default']['adapter'], 'SharePointAdapter') !== false;
    }
    return false;
}
```

#### Task 5: Create Migration Command

**File:** `/src/Command/MigrateToSharePointCommand.php`

```php
<?php
namespace App\Command;

use Cake\Console\Arguments;
use Cake\Console\Command;
use Cake\Console\ConsoleIo;
use Cake\ORM\TableRegistry;

class MigrateToSharePointCommand extends Command
{
    public function execute(Arguments $args, ConsoleIo $io)
    {
        $io->out('Starting SharePoint migration...');

        $batchSize = $args->getOption('batch-size', 100);
        $dryRun = $args->getOption('dry-run', false);

        $oFilesTable = TableRegistry::getTableLocator()->get('OFiles');
        $files = $oFilesTable->find()
            ->where(['migrated_to_sharepoint IS' => null])
            ->limit($batchSize)
            ->all();

        $success = 0;
        $failed = 0;

        foreach ($files as $file) {
            try {
                // 1. Read from local
                $content = $this->readLocalFile($file);

                // 2. Upload to SharePoint
                if (!$dryRun) {
                    $newPath = $this->uploadToSharePoint($file, $content);

                    // 3. Update database
                    $file->path = $newPath;
                    $file->migrated_to_sharepoint = true;
                    $oFilesTable->save($file);
                }

                $success++;
                $io->verbose("Migrated: {$file->filename}");

            } catch (\Exception $e) {
                $failed++;
                $io->error("Failed: {$file->filename} - {$e->getMessage()}");
            }
        }

        $io->success("Migration batch complete: {$success} success, {$failed} failed");

        return static::CODE_SUCCESS;
    }

    // Helper methods...
}
```

#### Task 6: Database Schema Updates

**Create Migration:** `bin/cake bake migration AddSharePointFieldsToOFiles`

```php
<?php
use Migrations\AbstractMigration;

class AddSharePointFieldsToOFiles extends AbstractMigration
{
    public function change()
    {
        $table = $this->table('o_files');

        $table->addColumn('migrated_to_sharepoint', 'boolean', [
            'default' => false,
            'null' => false,
        ]);

        $table->addColumn('sharepoint_id', 'string', [
            'default' => null,
            'limit' => 255,
            'null' => true,
        ]);

        $table->addColumn('sharepoint_url', 'string', [
            'default' => null,
            'limit' => 500,
            'null' => true,
        ]);

        $table->addColumn('migration_date', 'datetime', [
            'default' => null,
            'null' => true,
        ]);

        $table->addIndex(['migrated_to_sharepoint']);

        $table->update();
    }
}
```

### 4.3 Azure AD Configuration Steps

1. **Register Application:**
   - Navigate to Azure Portal > Azure Active Directory > App registrations
   - Click "New registration"
   - Name: "MENTOR Connect File Storage"
   - Supported account types: "Single tenant"
   - Click "Register"

2. **Configure Authentication:**
   - Go to "Certificates & secrets"
   - Create new client secret
   - Copy client secret value (only shown once)
   - Note expiration date for renewal

3. **Set API Permissions:**
   - Go to "API permissions"
   - Add permission > Microsoft Graph > Application permissions
   - Select: `Sites.ReadWrite.All`, `Files.ReadWrite.All`
   - Click "Grant admin consent"

4. **Note Configuration Values:**
   - Application (client) ID
   - Directory (tenant) ID
   - Client secret value

5. **SharePoint Site Setup:**
   - Create or identify SharePoint site
   - Create document library "MentorConnectFiles"
   - Grant app permission to site (if needed)

---

## 5. Data Migration Process

### 5.1 Pre-Migration Checklist

- [ ] Complete data volume analysis
- [ ] Create full database backup
- [ ] Create full file system backup
- [ ] Set up SharePoint test environment
- [ ] Deploy code changes to dev/staging
- [ ] Test adapter with sample files
- [ ] Verify authentication works
- [ ] Test upload/download/delete operations
- [ ] Run performance benchmarks
- [ ] Document baseline metrics

### 5.2 Migration Execution Steps

**Step 1: Pilot Migration (Week 3)**

```bash
# Migrate first 100 files
bin/cake migrate_to_sharepoint --batch-size=100 --dry-run

# Review dry run output, then execute
bin/cake migrate_to_sharepoint --batch-size=100

# Verify files in SharePoint
# Test access through application
# Check database records updated
```

**Step 2: Incremental Batch Migration (Week 4-5)**

```bash
# Run in loop until all files migrated
while true; do
    bin/cake migrate_to_sharepoint --batch-size=500

    # Check remaining count
    remaining=$(mysql -e "SELECT COUNT(*) FROM o_files WHERE migrated_to_sharepoint = 0")

    if [ $remaining -eq 0 ]; then
        break
    fi

    # Wait between batches to avoid rate limits
    sleep 300  # 5 minutes
done
```

**Step 3: Verification**

```bash
# Verify all files migrated
bin/cake verify_sharepoint_migration

# Test random sample of files
bin/cake test_file_access --sample-size=100

# Check for orphaned files
bin/cake audit_files
```

**Step 4: Production Cutover**

```bash
# 1. Enable maintenance mode
bin/cake maintenance_mode on

# 2. Run final incremental migration
bin/cake migrate_to_sharepoint --batch-size=1000

# 3. Switch filesystem config to SharePoint
# Update config/filesystem.php or environment variable

# 4. Clear cache
bin/cake cache clear_all

# 5. Verify application works
# Test uploads, downloads, deletes

# 6. Disable maintenance mode
bin/cake maintenance_mode off

# 7. Monitor logs and errors
tail -f logs/error.log
```

### 5.3 Migration Monitoring

**Key Metrics to Track:**

| Metric | Target | Alert Threshold |
|--------|--------|-----------------|
| Migration success rate | >99% | <95% |
| File access latency | <2 seconds | >5 seconds |
| Upload failure rate | <1% | >5% |
| API rate limit errors | 0 | >10 per hour |
| Database update failures | 0 | >1 |

**Logging Requirements:**
- Log every file migration attempt (success/failure)
- Log SharePoint API errors with full stack trace
- Log performance metrics (upload time, download time)
- Create daily migration summary reports

### 5.4 Data Validation

**Validation Checks:**

1. **File Count Validation:**
   ```sql
   -- Should match
   SELECT COUNT(*) FROM o_files WHERE migrated_to_sharepoint = 1;
   -- vs count in SharePoint
   ```

2. **File Integrity Validation:**
   ```sql
   -- Check hash matches after migration
   SELECT id, filename, hash
   FROM o_files
   WHERE migrated_to_sharepoint = 1
   ORDER BY RAND()
   LIMIT 100;
   ```
   Then download and verify hashes match.

3. **Relationship Integrity:**
   ```sql
   -- Verify all program documents have valid files
   SELECT pd.id, pd.document_id
   FROM program_documents pd
   LEFT JOIN o_files of ON pd.document_id = of.id
   WHERE of.id IS NULL;

   -- Should return 0 rows
   ```

4. **Accessibility Test:**
   - Test file downloads through application UI
   - Verify correct MIME types returned
   - Check file preview functionality
   - Test with different user roles/permissions

---

## 6. Testing Plan

### 6.1 Unit Testing

**Test Cases:**

1. **SharePointAdapter Tests** (`tests/TestCase/Filesystem/SharePointAdapterTest.php`)
   - Test file upload
   - Test file download
   - Test file deletion
   - Test file existence check
   - Test error handling (network failures, auth failures)
   - Test large file handling (>100MB)

2. **OFile Entity Tests**
   - Test SharePoint URL generation
   - Test config detection
   - Test backward compatibility with local URLs

3. **Migration Command Tests**
   - Test batch processing
   - Test error recovery
   - Test dry-run mode
   - Test database updates

### 6.2 Integration Testing

**Scenarios:**

1. **Upload Flow:**
   - User uploads document via DocumentsController
   - File saved to SharePoint
   - Database record created with SharePoint path
   - File accessible immediately after upload

2. **Download Flow:**
   - User requests file download
   - File retrieved from SharePoint
   - Correct MIME type headers sent
   - File content matches original

3. **Delete Flow:**
   - User deletes document
   - File removed from SharePoint
   - Database record deleted or marked deleted
   - File no longer accessible

4. **Permission Flow:**
   - Verify user authorization still works
   - Test access denial for unauthorized users
   - Test program-level permissions

### 6.3 Performance Testing

**Benchmarks:**

| Operation | Current (Local) | Target (SharePoint) | Acceptable Max |
|-----------|----------------|---------------------|----------------|
| File upload (1MB) | 100ms | 500ms | 2s |
| File download (1MB) | 50ms | 300ms | 1s |
| File delete | 10ms | 200ms | 500ms |
| File list (100 files) | 100ms | 500ms | 2s |

**Load Testing:**
- Simulate 50 concurrent users
- Mix of upload/download operations
- Monitor SharePoint throttling
- Check API rate limits

### 6.4 User Acceptance Testing (UAT)

**Test Scenarios:**

1. Program administrator uploads program document
2. User downloads assessment attachment
3. Administrator replaces existing document
4. User previews PDF in browser
5. User downloads multiple files (bulk)
6. Search for documents by name
7. View document list with thumbnails

**UAT Participants:**
- 3-5 internal users
- 1-2 program administrators
- 1 system administrator

**UAT Duration:** 1 week (during pilot phase)

### 6.5 Security Testing

**Security Checklist:**

- [ ] Verify OAuth tokens are encrypted in storage
- [ ] Test token refresh mechanism
- [ ] Verify file access requires authentication
- [ ] Test file permissions (users can't access unauthorized files)
- [ ] Check for path traversal vulnerabilities
- [ ] Verify secure transmission (HTTPS)
- [ ] Test rate limiting on upload endpoints
- [ ] Verify file type validation still works
- [ ] Test file size limits
- [ ] Check audit logging for file operations

---

## 7. Risk Management

### 7.1 Risk Register

| Risk ID | Risk Description | Probability | Impact | Mitigation Strategy | Owner |
|---------|------------------|-------------|--------|---------------------|-------|
| R1 | Data loss during migration | Low | Critical | Full backup, pilot testing, batch migration | Tech Lead |
| R2 | SharePoint API rate limiting | Medium | High | Throttle requests, implement retry logic, cache | Developer |
| R3 | Authentication token expiration | Medium | Medium | Implement auto-refresh, monitoring | Developer |
| R4 | Performance degradation | Medium | High | Performance testing, CDN if needed | Tech Lead |
| R5 | Migration script failures | Medium | Medium | Error handling, transaction rollback, logging | Developer |
| R6 | User disruption during cutover | High | Medium | Phased approach, maintenance window | PM |
| R7 | Cost overrun on SharePoint storage | Low | Medium | Monitor usage, set alerts, quotas | PM |
| R8 | Incompatible file types | Low | Low | Test all MIME types, fallback to local | Developer |
| R9 | Network connectivity issues | Medium | High | Retry logic, timeout handling, circuit breaker | Developer |
| R10 | Rollback complexity | Low | High | Document rollback, practice rollback, backups | Tech Lead |

### 7.2 Contingency Plans

**If migration fails mid-process:**
1. Stop migration immediately
2. Document failure point (which files completed)
3. Rollback database to pre-migration state OR
4. Keep dual mode (some files local, some SharePoint)
5. Investigate root cause
6. Fix issues
7. Resume from checkpoint

**If SharePoint performance is poor:**
1. Implement caching layer (Redis/Memcached)
2. Add CDN in front of SharePoint (Azure CDN)
3. Optimize file access patterns
4. Consider hybrid model (hot files in cache, cold in SharePoint)

**If costs exceed budget:**
1. Review storage usage
2. Implement file retention policies
3. Archive old/unused files to cheaper storage tier
4. Negotiate Microsoft 365 plan upgrade

### 7.3 Success Criteria

**Migration is considered successful when:**

- [ ] 100% of files migrated to SharePoint
- [ ] 99%+ of files accessible through application
- [ ] No data loss or corruption
- [ ] File operations meet performance targets
- [ ] User acceptance testing passed
- [ ] Zero critical bugs in production
- [ ] Rollback plan tested and documented
- [ ] Team trained on new system
- [ ] Documentation complete

---

## 8. Timeline and Resources

### 8.1 Detailed Timeline

| Week | Phase | Tasks | Deliverables |
|------|-------|-------|--------------|
| **Week 1** | Setup | - Azure AD app registration<br>- SharePoint site setup<br>- Adapter development start<br>- Dev environment config | - Azure app credentials<br>- SharePoint site live<br>- Dev environment ready |
| **Week 2** | Development | - Complete adapter development<br>- Unit tests<br>- Integration tests<br>- Migration script development | - Working adapter<br>- Test suite passing<br>- Migration script ready |
| **Week 3** | Pilot Testing | - Deploy to staging<br>- Migrate pilot files (100-500)<br>- UAT with internal team<br>- Performance testing | - Pilot migration complete<br>- UAT sign-off<br>- Performance baseline |
| **Week 4** | Batch Migration | - Migrate 25% of files<br>- Monitor and fix issues<br>- Iterate on migration script | - 25% files migrated<br>- Issues log and fixes |
| **Week 5** | Batch Migration | - Migrate remaining 75% of files<br>- Continuous monitoring<br>- Prepare for cutover | - 100% files migrated<br>- Verification complete<br>- Cutover plan finalized |
| **Week 6** | Cutover & Support | - Production cutover<br>- Switch to SharePoint adapter<br>- Monitor production<br>- Hypercare support | - Production live on SharePoint<br>- Monitoring dashboard<br>- Post-migration report |

### 8.2 Resource Requirements

**Team:**

| Role | Time Commitment | Responsibilities |
|------|----------------|------------------|
| Senior Developer | 100% (6 weeks) | Adapter development, migration script, technical lead |
| QA Engineer | 50% (6 weeks) | Test plan, test execution, UAT coordination |
| DevOps Engineer | 25% (6 weeks) | Azure setup, deployment, monitoring |
| Project Manager | 25% (6 weeks) | Planning, coordination, stakeholder communication |
| System Administrator | 10% (6 weeks) | SharePoint admin, permissions, support |

**Infrastructure:**

- Microsoft 365 subscription (existing or new)
- Azure AD Premium (if not already available)
- Development/staging SharePoint site
- Database backup storage (2x current size)
- File backup storage (2x current size)

**Budget Estimate:**

| Item | Estimated Cost |
|------|----------------|
| SharePoint storage (1TB) | $120-240/year (depends on M365 plan) |
| Azure AD app (if separate) | Included in M365 |
| Development time (6 weeks) | $30,000 - $50,000 |
| QA/Testing time | $10,000 - $15,000 |
| Project management | $5,000 - $8,000 |
| Contingency (20%) | $9,000 - $15,000 |
| **Total** | **$54,000 - $88,000** |

### 8.3 Dependencies

**External:**
- Microsoft 365 subscription approval
- Azure AD admin access granted
- SharePoint site creation approved
- Network firewall rules (if applicable)

**Internal:**
- Database backup system ready
- Staging environment available
- Code freeze during cutover window
- User communication plan approved

---

## 9. Post-Migration Plan

### 9.1 Monitoring (First 30 Days)

**Daily Monitoring:**
- File access error rates
- SharePoint API response times
- Upload/download success rates
- Authentication failures
- User-reported issues

**Weekly Review:**
- Performance metrics vs baseline
- Cost analysis (SharePoint storage usage)
- User feedback summary
- Outstanding issues/bugs

**Monitoring Tools:**
- Application logs (`logs/error.log`, `logs/migration.log`)
- SharePoint admin center
- Azure AD sign-in logs
- Custom dashboard (Grafana/Kibana if available)

### 9.2 Support Plan

**Hypercare Period:** First 2 weeks post-cutover

**Support Availability:**
- Business hours: Immediate response
- After hours: On-call developer available

**Issue Escalation:**
1. Level 1: User support team (file access issues)
2. Level 2: Application support (app errors)
3. Level 3: Development team (code/integration issues)
4. Level 4: Microsoft support (SharePoint platform issues)

### 9.3 Optimization Opportunities

**After 30 days, evaluate:**

1. **Caching Strategy:**
   - Implement Redis/Memcached for frequently accessed files
   - Cache SharePoint URLs for 24 hours
   - Pre-generate download links

2. **CDN Integration:**
   - Add Azure CDN in front of SharePoint
   - Reduce latency for global users
   - Offload traffic from SharePoint

3. **File Retention Policy:**
   - Archive files older than 3 years to cold storage
   - Automatically delete files after 7 years (if allowed)
   - Reduce storage costs

4. **Metadata Enhancements:**
   - Add tags/labels in SharePoint
   - Enable SharePoint search
   - Integrate with Microsoft Search

### 9.4 Documentation

**Required Documentation:**

- [ ] SharePoint Integration Architecture Diagram
- [ ] API Authentication Guide
- [ ] Migration Runbook (for future migrations)
- [ ] Troubleshooting Guide
- [ ] User Guide (if UI changes)
- [ ] Admin Guide (SharePoint management)
- [ ] Disaster Recovery Plan
- [ ] Code Documentation (PHPDoc for adapter)

### 9.5 Training

**Team Training:**
- SharePoint basics for support team (2 hours)
- Azure AD authentication troubleshooting (1 hour)
- Migration script usage (for future needs) (1 hour)
- Monitoring and alerting (1 hour)

**User Training:**
- If file access changes significantly, provide:
  - Quick reference guide
  - Video tutorial
  - FAQ document

### 9.6 Decommissioning Local Storage

**After 30 days (if migration successful):**

1. **Verify Complete Migration:**
   ```sql
   SELECT COUNT(*) FROM o_files WHERE migrated_to_sharepoint = 0;
   -- Should be 0
   ```

2. **Archive Local Files:**
   - Compress `/data/o-files/` directory
   - Store archive in secure backup location
   - Document archive location and retention period

3. **Update Configuration:**
   - Remove local adapter from `filesystem.php`
   - Remove local file path from environment

4. **Clean Up:**
   - Delete local files after 90-day retention
   - Remove old migration scripts (keep in version control)
   - Archive migration logs

---

## 10. Appendices

### Appendix A: SQL Queries for Analysis

```sql
-- A1: Total file statistics
SELECT
    COUNT(*) as total_files,
    SUM(size) as total_bytes,
    ROUND(SUM(size)/1024/1024/1024, 2) as total_gb,
    MIN(created) as oldest_file,
    MAX(created) as newest_file
FROM o_files;

-- A2: Files by MIME type
SELECT
    mime,
    COUNT(*) as count,
    ROUND(SUM(size)/1024/1024, 2) as size_mb,
    ROUND(AVG(size)/1024, 2) as avg_size_kb
FROM o_files
GROUP BY mime
ORDER BY count DESC;

-- A3: Files by creation year
SELECT
    YEAR(created) as year,
    COUNT(*) as count,
    ROUND(SUM(size)/1024/1024/1024, 2) as size_gb
FROM o_files
GROUP BY YEAR(created)
ORDER BY year DESC;

-- A4: Orphaned files (no relationships)
SELECT of.id, of.filename, of.created
FROM o_files of
LEFT JOIN program_documents pd ON of.id = pd.document_id
LEFT JOIN program_assessment_response_attachments para ON of.id = para.file_id
WHERE pd.id IS NULL AND para.id IS NULL;

-- A5: Largest files
SELECT id, filename, ROUND(size/1024/1024, 2) as size_mb, mime
FROM o_files
ORDER BY size DESC
LIMIT 100;

-- A6: Migration progress tracking
SELECT
    COUNT(*) as total,
    SUM(CASE WHEN migrated_to_sharepoint = 1 THEN 1 ELSE 0 END) as migrated,
    SUM(CASE WHEN migrated_to_sharepoint = 0 THEN 1 ELSE 0 END) as remaining,
    ROUND(SUM(CASE WHEN migrated_to_sharepoint = 1 THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) as percent_complete
FROM o_files;
```

### Appendix B: SharePoint API Examples

```php
// B1: Upload file to SharePoint
$graph = new Graph();
$graph->setAccessToken($accessToken);

$file = $graph->createRequest('PUT', "/sites/{site-id}/drive/root:/{path}:/content")
    ->attachBody(file_get_contents($localPath))
    ->setReturnType(Model\DriveItem::class)
    ->execute();

// B2: Download file from SharePoint
$content = $graph->createRequest('GET', "/sites/{site-id}/drive/items/{item-id}/content")
    ->execute();

// B3: Delete file from SharePoint
$graph->createRequest('DELETE', "/sites/{site-id}/drive/items/{item-id}")
    ->execute();

// B4: Get file metadata
$metadata = $graph->createRequest('GET', "/sites/{site-id}/drive/items/{item-id}")
    ->setReturnType(Model\DriveItem::class)
    ->execute();

// B5: Create folder
$folder = $graph->createRequest('POST', "/sites/{site-id}/drive/root/children")
    ->attachBody([
        'name' => 'programs',
        'folder' => new \stdClass(),
        '@microsoft.graph.conflictBehavior' => 'rename'
    ])
    ->setReturnType(Model\DriveItem::class)
    ->execute();
```

### Appendix C: Environment Variables Reference

```bash
# SharePoint Configuration
SHAREPOINT_TENANT_ID=            # Azure AD tenant ID (GUID)
SHAREPOINT_CLIENT_ID=            # Application (client) ID (GUID)
SHAREPOINT_CLIENT_SECRET=        # Client secret value
SHAREPOINT_SITE_URL=             # https://{tenant}.sharepoint.com/sites/{site-name}
SHAREPOINT_LIBRARY=              # Document library name (default: MentorConnectFiles)

# Migration Configuration
MIGRATION_MODE=local             # Options: local, sharepoint, dual
MIGRATION_BATCH_SIZE=100         # Files per batch
MIGRATION_RETRY_ATTEMPTS=3       # Retry failed uploads
MIGRATION_RETRY_DELAY=5          # Seconds between retries
MIGRATION_LOG_LEVEL=info         # debug, info, warning, error

# Performance Configuration
SHAREPOINT_UPLOAD_TIMEOUT=300    # Seconds (5 minutes)
SHAREPOINT_DOWNLOAD_TIMEOUT=120  # Seconds (2 minutes)
SHAREPOINT_CACHE_TTL=86400       # Cache URLs for 24 hours

# Monitoring
SHAREPOINT_ALERT_EMAIL=          # Email for critical alerts
SHAREPOINT_LOG_PATH=             # Custom log path (default: logs/sharepoint.log)
```

### Appendix D: Troubleshooting Guide

**Problem:** Files not uploading to SharePoint

**Possible Causes & Solutions:**
1. Authentication failure
   - Check client secret not expired
   - Verify app permissions granted
   - Check token refresh logic

2. Network timeout
   - Increase timeout settings
   - Check firewall rules
   - Verify SharePoint site accessible

3. File size limit
   - SharePoint Online limit: 250GB per file
   - Check file size before upload
   - Implement chunked upload for large files

4. API rate limiting
   - Implement exponential backoff
   - Reduce batch size
   - Add delays between requests

**Problem:** Files not downloading

**Possible Causes & Solutions:**
1. File path incorrect
   - Verify path format in database
   - Check SharePoint folder structure
   - Validate item ID vs path-based access

2. Permissions issue
   - Verify app has read permissions
   - Check SharePoint item-level permissions
   - Validate user authorization in app

**Problem:** Slow performance

**Possible Causes & Solutions:**
1. Network latency
   - Implement caching
   - Use CDN
   - Check server location vs SharePoint region

2. Large files
   - Stream downloads instead of loading into memory
   - Implement resumable downloads
   - Compress files if possible

3. High concurrency
   - Implement connection pooling
   - Use async operations
   - Add load balancing

### Appendix E: Rollback Procedure

**Complete Rollback Steps:**

1. **Notification** (5 minutes)
   ```bash
   # Notify all users
   bin/cake send_notification --message="System entering maintenance mode for emergency rollback"
   ```

2. **Enable Maintenance Mode** (2 minutes)
   ```bash
   bin/cake maintenance_mode on
   ```

3. **Switch to Local Adapter** (5 minutes)
   ```bash
   # Update config/filesystem.php
   # Change adapter from SharePointAdapter to LocalFilesystemAdapter
   # OR update environment variable
   export MIGRATION_MODE=local

   # Clear cache
   bin/cake cache clear_all
   ```

4. **Restore Database** (15-30 minutes)
   ```bash
   # Restore from backup taken before migration
   mysql mentor_connect < backups/pre_migration_backup.sql
   ```

5. **Verify Local Files** (10 minutes)
   ```bash
   # Check files exist
   ls -lh data/o-files/ | wc -l

   # Test random file access
   bin/cake test_file_access --storage=local --sample-size=50
   ```

6. **Disable Maintenance Mode** (2 minutes)
   ```bash
   bin/cake maintenance_mode off
   ```

7. **Monitor** (1 hour)
   ```bash
   # Watch for errors
   tail -f logs/error.log

   # Check file access metrics
   bin/cake file_metrics --interval=5m
   ```

8. **Post-Rollback Actions**
   - Document what went wrong
   - Analyze root cause
   - Update migration plan
   - Schedule remediation
   - Communicate timeline to stakeholders

**Total Rollback Time:** ~1-2 hours

### Appendix F: Contact Information

| Role | Name | Email | Phone |
|------|------|-------|-------|
| Project Manager | TBD | | |
| Technical Lead | TBD | | |
| Senior Developer | TBD | | |
| QA Lead | TBD | | |
| SharePoint Admin | TBD | | |
| Microsoft Support | | | 1-800-XXX-XXXX |

### Appendix G: References

**Documentation:**
- Microsoft Graph API: https://docs.microsoft.com/en-us/graph/api/overview
- SharePoint REST API: https://docs.microsoft.com/en-us/sharepoint/dev/sp-add-ins/get-to-know-the-sharepoint-rest-service
- League Flysystem: https://flysystem.thephpleague.com/
- Azure AD Authentication: https://docs.microsoft.com/en-us/azure/active-directory/develop/

**Tools:**
- Graph Explorer: https://developer.microsoft.com/en-us/graph/graph-explorer
- SharePoint Admin Center: https://admin.microsoft.com/sharepoint
- Azure Portal: https://portal.azure.com

**Support:**
- Microsoft 365 Support: https://support.microsoft.com/
- Stack Overflow: https://stackoverflow.com/questions/tagged/microsoft-graph

---

## Document Control

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | 2025-11-04 | Claude (AI Assistant) | Initial draft |
| | | | |
| | | | |

---

## Approval

| Role | Name | Signature | Date |
|------|------|-----------|------|
| Project Sponsor | | | |
| Technical Lead | | | |
| Project Manager | | | |
| Security Officer | | | |

---

**END OF DOCUMENT**
