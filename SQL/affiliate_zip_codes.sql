-- ============================================================================
-- Affiliate ZIP Codes
-- ============================================================================
-- Purpose: Retrieve all ZIP codes associated with affiliates through their
--          service areas
--
-- Mapping Logic:
-- - Affiliates define service areas in service_areas table
-- - Service areas contain ZIP codes via postal_codes_service_areas junction
-- - ZIP codes are stored in sam_postal_codes table
-- ============================================================================

-- ----------------------------------------------------------------------------
-- Query 1: Simple - All Affiliate ZIP Codes
-- ----------------------------------------------------------------------------
-- Returns all ZIP codes for all affiliates

SELECT DISTINCT
    a.id AS affiliate_id,
    a.name AS affiliate_name,
    pc.code AS zip_code
FROM affiliates a
INNER JOIN service_areas sa ON a.id = sa.affiliate_id
INNER JOIN postal_codes_service_areas pcsa ON sa.id = pcsa.service_area_id
INNER JOIN sam_postal_codes pc ON pcsa.postal_code_id = pc.id
ORDER BY a.name, pc.code;


-- ----------------------------------------------------------------------------
-- Query 2: Affiliate ZIP Code Count Summary
-- ----------------------------------------------------------------------------
-- Shows how many ZIP codes each affiliate has in their service areas

SELECT
    a.id AS affiliate_id,
    a.name AS affiliate_name,
    COUNT(DISTINCT pc.code) AS total_zip_codes,
    COUNT(DISTINCT sa.id) AS service_area_count
FROM affiliates a
INNER JOIN service_areas sa ON a.id = sa.affiliate_id
INNER JOIN postal_codes_service_areas pcsa ON sa.id = pcsa.service_area_id
INNER JOIN sam_postal_codes pc ON pcsa.postal_code_id = pc.id
GROUP BY a.id, a.name
ORDER BY total_zip_codes DESC, a.name;


-- ----------------------------------------------------------------------------
-- Query 3: Detailed - ZIP Codes by Service Area
-- ----------------------------------------------------------------------------
-- Shows ZIP codes grouped by affiliate and service area

SELECT
    a.id AS affiliate_id,
    a.name AS affiliate_name,
    sa.id AS service_area_id,
    sa.title AS service_area_name,
    pc.code AS zip_code
FROM affiliates a
INNER JOIN service_areas sa ON a.id = sa.affiliate_id
INNER JOIN postal_codes_service_areas pcsa ON sa.id = pcsa.service_area_id
INNER JOIN sam_postal_codes pc ON pcsa.postal_code_id = pc.id
ORDER BY a.name, sa.title, pc.code;


-- ----------------------------------------------------------------------------
-- Query 4: Specific Affiliate ZIP Codes
-- ----------------------------------------------------------------------------
-- Filter ZIP codes for a specific affiliate (change affiliate_id or name)

SELECT DISTINCT
    pc.code AS zip_code,
    sa.title AS service_area_name
FROM affiliates a
INNER JOIN service_areas sa ON a.id = sa.affiliate_id
INNER JOIN postal_codes_service_areas pcsa ON sa.id = pcsa.service_area_id
INNER JOIN sam_postal_codes pc ON pcsa.postal_code_id = pc.id
WHERE a.id = 1  -- Change this to target a specific affiliate
   -- OR a.name = 'Affiliate Name'  -- Alternatively filter by name
ORDER BY pc.code;


-- ----------------------------------------------------------------------------
-- Query 5: ZIP Codes with Multiple Affiliates
-- ----------------------------------------------------------------------------
-- Identifies ZIP codes that are shared across multiple affiliates

SELECT
    pc.code AS zip_code,
    COUNT(DISTINCT a.id) AS affiliate_count,
    GROUP_CONCAT(DISTINCT a.name ORDER BY a.name SEPARATOR ', ') AS affiliates
FROM affiliates a
INNER JOIN service_areas sa ON a.id = sa.affiliate_id
INNER JOIN postal_codes_service_areas pcsa ON sa.id = pcsa.service_area_id
INNER JOIN sam_postal_codes pc ON pcsa.postal_code_id = pc.id
GROUP BY pc.code
HAVING affiliate_count > 1
ORDER BY affiliate_count DESC, pc.code;


-- ============================================================================
-- Schema Reference
-- ============================================================================
-- Key Tables and Fields:
-- - affiliates (id, name)
-- - service_areas (id, affiliate_id, title)
-- - postal_codes_service_areas (postal_code_id, service_area_id)
-- - sam_postal_codes (id, code) -- 'code' is the ZIP code field
--
-- Mapping Chain:
-- affiliates -> service_areas -> postal_codes_service_areas -> sam_postal_codes
-- ============================================================================
