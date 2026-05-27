-- ============================================================================
-- Programs Without Affiliate Mapping
-- ============================================================================
-- Purpose: Find all programs that are NOT mapped to any affiliates
--
-- Mapping Logic:
-- - Affiliates define service areas in service_areas table
-- - Service areas contain ZIP codes via postal_codes_service_areas junction table
-- - Programs have locations in program_locations table with ZIP codes
-- - When program location ZIP codes overlap with service area ZIP codes,
--   the affiliate gains access to those programs (they become "mapped")
--
-- Status Filtering:
-- - Program status values: 'approved', 'pending', 'paused'
-- - Change p.status = 'approved' to p.status = 'pending' to switch filters
-- ============================================================================

-- ----------------------------------------------------------------------------
-- Query 1: Simple - Programs Without Any Affiliate Mapping
-- ----------------------------------------------------------------------------
-- Returns all programs that have no affiliate mapping through ZIP code overlap
-- This includes programs with no locations OR programs whose ZIP codes don't
-- match any affiliate service area ZIP codes
--
-- STATUS FILTER: Change 'approved' to 'pending' or 'paused' as needed

SELECT p.*
FROM programs p
WHERE p.status = 'approved'  -- Filter: 'approved', 'pending', or 'paused'
AND NOT EXISTS (
    SELECT 1
    FROM program_locations pl
    INNER JOIN sam_postal_codes pc ON pl.zip_code = pc.code
    INNER JOIN postal_codes_service_areas pcsa ON pc.id = pcsa.postal_code_id
    INNER JOIN service_areas sa ON pcsa.service_area_id = sa.id
    WHERE pl.program_id = p.id
);


-- ----------------------------------------------------------------------------
-- Query 2: Detailed - Programs Without Mapping (with diagnostic info)
-- ----------------------------------------------------------------------------
-- Returns unmapped programs with additional context:
-- - location_count: How many locations the program has
-- - unique_zipcodes: How many unique ZIP codes across all locations
-- - matched_service_areas: Number of matching service areas (will be 0)
--
-- STATUS FILTER: Change 'approved' to 'pending' or 'paused' as needed

SELECT
    p.id,
    p.title,
    p.status,
    COUNT(DISTINCT pl.id) AS location_count,
    COUNT(DISTINCT pl.zip_code) AS unique_zipcodes,
    COUNT(DISTINCT pcsa.id) AS matched_service_areas
FROM programs p
LEFT JOIN program_locations pl ON p.id = pl.program_id
LEFT JOIN sam_postal_codes pc ON pl.zip_code = pc.code
LEFT JOIN postal_codes_service_areas pcsa ON pc.id = pcsa.postal_code_id
LEFT JOIN service_areas sa ON pcsa.service_area_id = sa.id
WHERE p.status = 'approved'  -- Filter: 'approved', 'pending', or 'paused'
GROUP BY p.id, p.title, p.status
HAVING matched_service_areas = 0
ORDER BY p.title;


-- ----------------------------------------------------------------------------
-- Query 3: Complete Overview - All Programs with Mapping Status
-- ----------------------------------------------------------------------------
-- Shows all programs with their affiliate mapping status
-- Unmapped programs appear first (mapped_affiliate_count = 0)
--
-- STATUS FILTER: Change 'approved' to 'pending' or 'paused' as needed

SELECT
    p.id,
    p.title,
    p.status,
    COUNT(DISTINCT pl.id) AS location_count,
    COUNT(DISTINCT sa.affiliate_id) AS mapped_affiliate_count,
    GROUP_CONCAT(DISTINCT a.name ORDER BY a.name SEPARATOR ', ') AS mapped_affiliates
FROM programs p
LEFT JOIN program_locations pl ON p.id = pl.program_id
LEFT JOIN sam_postal_codes pc ON pl.zip_code = pc.code
LEFT JOIN postal_codes_service_areas pcsa ON pc.id = pcsa.postal_code_id
LEFT JOIN service_areas sa ON pcsa.service_area_id = sa.id
LEFT JOIN affiliates a ON sa.affiliate_id = a.id
WHERE p.status = 'approved'  -- Filter: 'approved', 'pending', or 'paused'
GROUP BY p.id, p.title, p.status
ORDER BY mapped_affiliate_count ASC, p.title;


-- ----------------------------------------------------------------------------
-- Query 4: Breakdown by Reason - Why Programs Are Not Mapped
-- ----------------------------------------------------------------------------
-- Categorizes unmapped programs by the reason they're not mapped
--
-- STATUS FILTER: Change 'approved' to 'pending' or 'paused' as needed

SELECT
    p.id,
    p.title,
    p.status,
    CASE
        WHEN COUNT(DISTINCT pl.id) = 0 THEN 'No locations defined'
        WHEN COUNT(DISTINCT pl.zip_code) = 0 THEN 'Locations have no ZIP codes'
        ELSE 'ZIP codes not in any service area'
    END AS unmapped_reason,
    COUNT(DISTINCT pl.id) AS location_count,
    GROUP_CONCAT(DISTINCT pl.zip_code ORDER BY pl.zip_code SEPARATOR ', ') AS location_zipcodes
FROM programs p
LEFT JOIN program_locations pl ON p.id = pl.program_id
WHERE p.status = 'approved'  -- Filter: 'approved', 'pending', or 'paused'
AND NOT EXISTS (
    SELECT 1
    FROM program_locations pl2
    INNER JOIN sam_postal_codes pc ON pl2.zip_code = pc.code
    INNER JOIN postal_codes_service_areas pcsa ON pc.id = pcsa.postal_code_id
    INNER JOIN service_areas sa ON pcsa.service_area_id = sa.id
    WHERE pl2.program_id = p.id
)
GROUP BY p.id, p.title, p.status
ORDER BY unmapped_reason, p.title;


-- ============================================================================
-- Schema Reference
-- ============================================================================
-- Key Tables and Fields:
-- - programs (id, title, status)
--   * status values: 'approved', 'pending', 'paused'
-- - program_locations (program_id, zip_code)
-- - sam_postal_codes (id, code) -- 'code' is the ZIP code field
-- - postal_codes_service_areas (postal_code_id, service_area_id)
-- - service_areas (id, affiliate_id, title)
-- - affiliates (id, name)
--
-- Mapping Chain:
-- programs -> program_locations (zip_code)
--   -> sam_postal_codes (code)
--   -> postal_codes_service_areas
--   -> service_areas
--   -> affiliates
--
-- Usage Examples:
-- For APPROVED programs: WHERE p.status = 'approved'
-- For PENDING programs:  WHERE p.status = 'pending'
-- For PAUSED programs:   WHERE p.status = 'paused'
-- ============================================================================
