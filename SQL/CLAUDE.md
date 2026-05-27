# CLAUDE.md — SQL Scripts

## What This Is

Utility SQL scripts for the MENTOR Connector database. These are standalone queries, not migrations.

## Files

| File | Purpose |
|------|---------|
| `affiliate_zip_codes.sql` | Queries related to affiliate-to-zip-code mappings (how affiliates claim geographic coverage) |
| `programs_without_affiliate_mapping.sql` | Finds programs that have no affiliate mapped via zip code — useful for identifying orphaned programs |

## Context

Affiliate-to-program relationships are geographic: affiliates claim zip codes via `affiliates_zip_codes`, and programs are matched to affiliates when their `programs.zip_code` falls within an affiliate's claimed area. These scripts help audit that mapping.
