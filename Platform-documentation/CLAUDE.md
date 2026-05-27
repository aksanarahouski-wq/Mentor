# CLAUDE.md — Platform Documentation

## What This Is

All documentation about the MENTOR platform — how the system is architected, how the three repos work together, and how to operate it (roles, permissions, workflows). This is the single place for platform-level docs, independent of any specific scope or release.

## Architecture & Design

| File | What It Explains |
|------|-----------------|
| `solution-architecture.md` | Complete system architecture — how all 3 apps connect, data flow diagrams, user journey (discover → search → connect), search matching logic, environments, glossary. **Start here if you're new to the project.** |
| `mentor-connect-overview.md` | Detailed overview of the CakePHP backend — tech stack, plugin architecture (13 plugins), key patterns, commands, file structure. |
| `mentor-connect-3-step-app-overview.md` | Overview of the embeddable Symfony search form — how the 3 steps work, tech stack, key directories. |
| `search-flow-explained.md` | End-to-end search flow — form parameters, backend processing (Haversine distance, delivery method filtering, role filtering, badge ranking), database tables involved, key source files. |

## Roles & Permissions

| Folder | What's Inside |
|--------|--------------|
| `UserRolesAccess/` | Comprehensive user roles and permissions documentation — 8 files covering the complete permission matrix, NQMS assessment workflows, business guides, QA testing guides, and known discrepancies. See its own CLAUDE.md for details. |

## When to Read What

- **New to the project?** Start with `solution-architecture.md`
- **Need to understand search?** Read `search-flow-explained.md`
- **Working on the backend?** Read `mentor-connect-overview.md` then the repo's own `CLAUDE.md`
- **Need permission details?** Go to `UserRolesAccess/`
