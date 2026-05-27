# MENTOR Connector Overview

A **CakePHP 4.6 web application** for managing mentoring programs, built for MENTOR (mentoring.org). Recently upgraded from CakePHP 4.4 to 4.6 (November 2025).

## Tech Stack

- **Backend:** PHP 8.1, CakePHP 4.6, MySQL 8.0
- **Frontend:** Vue.js 2 (used for Service Areas), SCSS, Bootstrap
- **Infrastructure:** DDEV (local dev), Redis (caching/sessions)
- **Testing:** PHPUnit 9.6, PHPStan, CakePHP CodeSniffer
- **Developer:** Orases (uses private Composer packages: `orases/files`, `orases/helpers`)

## What It Does

A platform for managing **mentoring programs** with features including:

- **User management** with role-based access (affiliate, program, mc_affiliate roles)
- **Program management** with NQMS (National Quality Mentoring System) assessments
- **Affiliate/organization** and **partner** management
- **Search functionality** for finding mentoring programs
- **Inquiry tracking** from searches
- **Geographic service area** management (Vue.js app)
- **Reporting and data import/export**
- **Webhook integrations**
- **Notification reminders** (CRON-based)

## Architecture

**Plugin-based** — each major feature lives in its own plugin under `plugins/`:

| Plugin | Purpose |
|--------|---------|
| Users | Authentication, authorization, user management, profiles |
| Programs | Core program management with NQMS assessment functionality |
| Affiliates | Affiliate/organization management |
| Inquiries | Inquiry tracking from searches |
| Searches | Search functionality for finding mentoring programs |
| Partners | Partner organization management |
| ServiceAreas | Geographic service area management (Vue.js app) |
| Reports | Reporting functionality |
| DataImport | Data import utilities |
| NQMS | National Quality Mentoring System assessment questions, badges, sections |
| Webhooks | Webhook integration |
| SystemManagement | System-level management features |
| ThemeAdmin | Admin theme and UI components |

Each plugin has its own controllers, models, templates, and routes.

### Key Patterns

- **Policy-based authorization** with role-based access control
- **AuthorBehavior** for tracking `created_by` and `modified_by`
- **TrimmedBehavior** for auto-trimming whitespace on save
- **Entity ownership verification** for security on edit/delete operations
- Separate **CSRF middleware** and **FormProtection** layers
- API routes under `/admin/api/*`
- Root `/` redirects to `/admin`

### Environments

Four environments managed via `config/app_local.php`:
- `dev` — internal development
- `review` — internal QA
- `staging` — external QA
- `production` — live

Configs stored in **1Password** vault.

## Key Commands

```bash
# Development
ddev start                                              # Start environment
composer install                                        # Install dependencies
bin/cake migrations migrate -c migrations -p Orases/Files  # Plugin migrations
bin/cake migrations migrate -c migrations               # App migrations

# Testing & Quality
composer test          # Run all tests
composer cs-check      # Check code style
composer cs-fix        # Fix code style
composer stan          # Static analysis

# Maintenance
bin/cake cache clear_all                        # Clear all cache
bin/cake cache clear _cake_model_               # Clear model cache
bin/cake bake migration MigrationName           # Create migration

# CRON
bin/cake Programs.reminder_notifications        # Notification reminders (runs hourly, sends at 4am EST)

# Frontend
./compile.sh service-areas                      # Build Vue.js app (Node 16, Yarn)
```

## File Structure

```
mentor-connect/
├── config/          # App config, routes, migrations, seeds
├── plugins/         # Plugin-based feature modules (13 plugins)
├── src/             # Core app (controllers, models, middleware, commands)
├── templates/       # Shared templates
├── tests/           # Test cases
├── vue/             # Vue.js source
├── webroot/         # Public web root (CSS, JS, images, compiled Vue)
├── vendor/          # Composer dependencies
└── .ddev/           # DDEV local dev configuration
```
