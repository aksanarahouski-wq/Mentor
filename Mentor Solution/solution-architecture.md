# MENTOR Solution — Documentation & Architecture

## Executive Summary

The MENTOR Solution is a web-based platform that connects prospective mentors and mentees with mentoring programs across the United States and Canada. It consists of three interconnected applications that work together to provide program discovery, search, inquiry management, and program administration.

---

## Solution Components

### 1. MENTOR Connect 3-Step App (Embeddable Search Form)

**What it is:** A lightweight, embeddable search form designed to be placed on partner websites via an iframe.

**Business Purpose:** Extends MENTOR's reach by allowing partner organizations to offer mentoring program search directly on their own websites — without building custom integrations.

**What users do:**
1. Fill out a short form (name, email, zip code, role, mentoring preferences)
2. Submit the form
3. Get redirected to the main MENTOR Connect App to see results

**Key characteristics:**
- Embeddable on any partner website via a simple script tag
- Supports English and French
- Tracks which partner site the search came from (via partner ID)
- No database — purely a form that passes data forward

**Tech:** Symfony 5.2 (PHP), Twig templates, Docker/Apache

---

### 2. MENTOR Connect App (User-Facing Frontend)

**What it is:** The main user-facing web application where mentors and mentees search for programs, view results, and submit inquiries.

**Business Purpose:** Provides the primary interface for the public to discover mentoring programs and for program administrators to manage their listings.

**What users do:**

*Public Users (Mentors/Mentees):*
- Search for mentoring programs by location, role, and preferences
- Browse and filter results (by focus area, ages served, mentoring type, distance, etc.)
- View detailed program profiles (description, contact info, badges, locations)
- Submit inquiries to programs they're interested in

*Program Administrators:*
- Manage their program listings and organization details
- View and respond to inquiries from prospective mentors/mentees
- Upload logos, update contact info, manage service areas

*System Administrators:*
- Manage all programs, organizations, partners, and user accounts
- View search analytics and export data
- Configure system settings, regions, and partner organizations

**Key characteristics:**
- Multi-language (English, French)
- Multi-country (US and Canada with country-specific options)
- Receives search parameters from the 3-Step App via URL
- Role-based access for different user types
- Sentry error tracking, Google Analytics integration

**Tech:** Vue.js 2, TypeScript, Bootstrap, Axios (API client)

---

### 3. MENTOR Connector (Backend API & Admin System)

**What it is:** The backend engine that powers the entire solution — stores all data, processes searches, manages programs, and serves the API.

**Business Purpose:** Central data platform that houses all mentoring programs, processes search matching, tracks inquiries, and provides administrative tools.

**What it does:**
- Stores and manages the mentoring program database
- Processes search queries using geographic proximity matching (Haversine formula)
- Filters programs by delivery method, role acceptance, status, and attributes
- Tracks all searches and inquiries for analytics and partner attribution
- Manages the NQMS (National Quality Mentoring System) badge/assessment system
- Sends email notifications when inquiries are submitted
- Provides admin dashboards for program and organization management

**Key characteristics:**
- Plugin-based architecture (Programs, Searches, Inquiries, Partners, etc.)
- MySQL database with geographic coordinate lookups
- Redis caching for performance
- Role-based authorization (affiliate, program admin, system admin)
- CSV export for search and inquiry data
- Webhook integrations for third-party systems
- Four environments: dev, review, staging, production

**Tech:** CakePHP 4.6 (PHP 8.1), MySQL 8.0, Redis, DDEV

---

## How the Applications Connect

```
                        MENTOR SOLUTION ARCHITECTURE
  ============================================================================

  PARTNER WEBSITES                    MENTOR PLATFORM
  (mentoring.org, partner sites)      (mentorconnector.org or similar)

  +-------------------------------+
  |                               |
  |   Partner Website             |
  |                               |
  |   +------------------------+  |
  |   |                        |  |      +----------------------------+
  |   |  3-Step App (iframe)   |  |      |                            |
  |   |                        |  |      |   MENTOR Connect App       |
  |   |  [Name, Email, Zip]    |--------->   (Vue.js Frontend)        |
  |   |  [Role, Preferences]   |  | GET  |                            |
  |   |  [Submit Search]       |  |      |   /handler?firstName=...   |
  |   |                        |  |      |                            |
  |   +------------------------+  |      |   +--------------------+   |
  |                               |      |   | Search Results     |   |
  +-------------------------------+      |   | Program Details    |   |
                                         |   | Inquiry Forms      |   |
                                         |   | Admin Dashboards   |   |
  +-------------------------------+      |   +--------------------+   |
  |                               |      |            |               |
  |   Direct Access               |      +----------------------------+
  |   (users visit site directly) |                   |
  |                               |                   | REST API
  +-------------|------------------+                   | (JSON)
                |                                     |
                +------------------------------------>|
                                                      v
                                         +----------------------------+
                                         |                            |
                                         |   MENTOR Connector         |
                                         |   (CakePHP Backend)        |
                                         |                            |
                                         |   +--------------------+   |
                                         |   | Search Engine      |   |
                                         |   | (Haversine/geo)    |   |
                                         |   +--------------------+   |
                                         |   | Program Database   |   |
                                         |   +--------------------+   |
                                         |   | Inquiry Tracking   |   |
                                         |   +--------------------+   |
                                         |   | Partner Analytics  |   |
                                         |   +--------------------+   |
                                         |   | Email Notifications|   |
                                         |   +--------------------+   |
                                         |   | NQMS Assessments   |   |
                                         |   +--------------------+   |
                                         |            |               |
                                         +----------------------------+
                                                      |
                                                      v
                                         +----------------------------+
                                         |   MySQL 8.0 + Redis        |
                                         |   - Programs & Locations   |
                                         |   - Organizations          |
                                         |   - Searches & Inquiries   |
                                         |   - Partners & Users       |
                                         |   - Postal Code Geocoding  |
                                         |   - NQMS Badges            |
                                         +----------------------------+
```

---

## User Journey — End to End

```
  STEP 1: DISCOVER                STEP 2: SEARCH               STEP 3: CONNECT
  ========================        ========================      ========================

  A prospective mentor            The system finds matching     The user reaches out
  or mentee finds a               programs near them            to a program
  search form

  +-------------------+           +-------------------+         +-------------------+
  | Partner Website   |           | Results Page      |         | Program Profile   |
  |                   |           |                   |         |                   |
  | "Find a Mentor"   |   --->   | 12 programs found |  --->   | Citywide Mentors  |
  |                   |           | within 15 miles   |         |                   |
  | Name: Jane Doe    |           |                   |         | [Submit Inquiry]  |
  | Email: jane@...   |           | - Citywide Mentors|         |                   |
  | Zip: 10001        |           | - Big Brothers    |         | Name: Jane Doe    |
  | Role: Mentor      |           | - Youth Connect   |         | Phone: 555-1234   |
  | Distance: 15 mi   |           | - ...             |         | "I'd like to      |
  |                   |           |                   |         |  volunteer"        |
  | [Search]          |           | Filter by:        |         |                   |
  +-------------------+           | Focus | Age | Type|         | [Send]            |
                                  +-------------------+         +-------------------+

                                                                        |
                                                                        v
                                                                +-------------------+
                                                                | Program Admin     |
                                                                | receives inquiry  |
                                                                | via email +       |
                                                                | admin dashboard   |
                                                                +-------------------+
```

---

## Data Flow Summary

| Step | Action | From | To | Data |
|------|--------|------|----|------|
| 1 | User fills search form | Partner site (3-Step App) | Connect App (Frontend) | Name, email, zip, role, preferences |
| 2 | Search is saved | Connect App | Connector (Backend API) | Search criteria via `POST /a/app/search` |
| 3 | Results are fetched | Connect App | Connector (Backend API) | Search ID via `GET /a/app/search/results/list/{id}` |
| 4 | Programs are matched | Connector | MySQL Database | Geographic proximity + attribute filtering |
| 5 | Results displayed | Connector (API response) | Connect App (Frontend) | Matched programs with distance, badges, details |
| 6 | User submits inquiry | Connect App | Connector (Backend API) | Contact info via `POST /a/app/inquiry` |
| 7 | Notifications sent | Connector | Email (program admins) | Inquiry details to program administrators |

---

## Search Matching Logic (Business View)

When a user searches, the system finds programs that match **all** of these criteria:

1. **Location** — Program has a location within the specified distance (e.g., 15 miles) of the user's zip code, calculated using real geographic coordinates. *Or* the program operates nationwide if the user selected that option.

2. **Delivery Method** — Program offers at least one of the user's selected delivery methods:
   - Community-based (mentor and mentee meet in the community)
   - Site-based (mentoring happens at a specific location)
   - E-mentoring (virtual/online mentoring)

3. **Role** — Program is currently accepting the user's role:
   - Accepting mentors (if user wants to be a mentor)
   - Accepting mentees (if user is looking for a mentor)

4. **Status** — Only approved programs appear in results. Paused, pending, or deleted programs are excluded.

5. **Quality Ranking** — Results are sorted by the number of NQMS (National Quality Mentoring System) badges a program has earned, putting higher-quality programs first.

---

## Environments

| Environment | Purpose | Audience |
|-------------|---------|----------|
| **Dev** | Internal development and feature building | Development team |
| **Review** | Internal QA and testing | QA team, stakeholders |
| **Staging** | External QA and pre-release validation | Client, external testers |
| **Production** | Live platform serving real users | Public |

---

## Key Business Metrics Tracked

- **Searches per partner** — How many searches each partner website generates (counter cache)
- **Inquiries per partner** — How many inquiries result from each partner's searches
- **Inquiry status** — Whether program admins have contacted inquiring users (un-contacted vs. contacted)
- **Program coverage** — Number of approved programs, geographic distribution
- **NQMS badge adoption** — Quality certification across the program network

---

## Glossary

| Term | Definition |
|------|------------|
| **NQMS** | National Quality Mentoring System — a certification/badge framework for evaluating mentoring program quality |
| **Partner** | An organization that embeds the 3-Step search form on their website to help users find mentoring programs |
| **Inquiry** | A request from a prospective mentor/mentee to connect with a specific program |
| **Affiliate** | An organization affiliated with MENTOR that may oversee multiple programs |
| **Service Area** | The geographic region a mentoring program serves |
| **Delivery Method** | How mentoring is conducted: community-based, site-based, or e-mentoring |
| **Haversine Formula** | Mathematical formula used to calculate distance between two geographic points on Earth |
