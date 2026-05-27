# MENTOR Connect 3-Step App

This is a **mentoring program discovery platform** — a web form that helps people find and connect with mentoring opportunities. It's designed to be embedded as an iframe on partner websites.

## How It Works (3 Steps)
1. **Fill out a search form** — user enters their info, zip code, mentoring type preferences, and whether they want to be a mentor or find one
2. **Browse results** — matching mentoring programs are displayed
3. **Contact programs** — users reach out directly to programs they're interested in

## Tech Stack
- **Backend:** Symfony 5.2 (PHP) with Twig templates
- **Frontend:** Vue.js 2 + TypeScript, built with Webpack Encore
- **Styling:** Sass/SCSS with MENTOR brand colors
- **Infrastructure:** Docker (Ubuntu 20.04 + Apache + PHP 8.0)
- **i18n:** English and French

## Architecture
- **Stateless** — no database; acts as a form gateway that submits to an external MENTOR API
- **Iframe-native** — uses `postMessage` API to communicate with parent windows (height sync, DOM readiness)
- **Single controller** (`HomeController`) with locale-aware routes (`/{_locale}/`)
- **MVC** with minimal model layer since data flows through to an external service

## Key Directories
| Directory | Purpose |
|-----------|---------|
| `src/` | PHP backend (single controller + kernel) |
| `assets/` | Frontend source (TypeScript, SCSS) |
| `templates/` | Twig HTML templates |
| `config/` | Symfony YAML configuration |
| `public/` | Web root (compiled assets, iframe script) |
| `docker/` | Dockerfile + Apache config |
| `translations/` | i18n locale files |

## Running Locally
- `docker-compose up` → serves on `localhost:8888`
- `deploy.sh` handles production builds (composer install → npm install → encore production → rsync)
