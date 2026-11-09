<p align="center">
  <img src="https://user-images.githubusercontent.com/19147922/27816506-9f15355a-60a9-11e7-98cc-585312264801.png" alt="Osdag logo"><br>
</p>

# Osdag on Cloud: Column Cover Plate Connection (my work)

My work on **[Osdag on Cloud](https://github.com/osdag-admin/Osdag-web)**: adding a *Column-to-Column Cover Plate* connection module (bolted, plus a welded variant) to the web version of Osdag.

![Django](https://img.shields.io/badge/Django-3.2-092E20?logo=django&logoColor=white)
![Django REST Framework](https://img.shields.io/badge/DRF-3.14-A30000)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-4169E1?logo=postgresql&logoColor=white)
![React](https://img.shields.io/badge/React-18-61DAFB?logo=react&logoColor=black)
![Vite](https://img.shields.io/badge/Vite-646CFF?logo=vite&logoColor=white)
![Three.js](https://img.shields.io/badge/Three.js-000000?logo=threedotjs&logoColor=white)
![License: LGPL v3](https://img.shields.io/badge/License-LGPL_v3-blue.svg)

> **Credit:** Osdag (Open Steel Design and Graphics) is developed by the **Osdag team at FOSSEE, IIT Bombay** and its contributors. Osdag® and the Osdag logo are registered trademarks of IIT Bombay. This repository is a copy of the upstream [osdag-admin/Osdag-web](https://github.com/osdag-admin/Osdag-web) codebase (the desktop app lives at [osdag-admin/Osdag](https://github.com/osdag-admin/Osdag)), with my changes added on top. Almost all of the code here was written by the upstream contributors. It is **not** an official Osdag release. For the real product, visit [osdag.fossee.in](https://osdag.fossee.in/).

## Overview

Osdag is free/libre, open-source software for designing and detailing steel structures to the Indian Standard **IS 800:2007**. *Osdag on Cloud* is its web edition. It has a Django + Django REST Framework backend wrapping the Osdag design modules, and a React (Vite) frontend with input docks, design-preference dialogs, output docks and a Three.js 3D viewer for the CAD model. Upstream already shipped shear connections: Fin Plate, End Plate, Cleat Angle and Seated Angle.

## What I added

All my commits (April 2025) cover the **Column Cover Plate** moment-connection module:

**Backend**
- `osdag_api/modules/column_cover_plate_bolted.py` and `column_cover_plate_welded.py`: API modules that define the required input keys, validate input, build the design object, format output values and export a `.brep` CAD model
- `osdag/web_api/columncoverplate_outputView.py` and `columncoverplate_welded_outputView.py`: new endpoints `POST /calculate-output/Column-Cover-Plate-Bolted` and `.../Column-Cover-Plate-Welded`
- Registered the modules in `osdag_api/module_finder.py` / `common_defs.py`
- Graceful fallback when pythonOCC (`OCC`) is not installed: dummy modules and CAD stubs plus warning logs, so the interface still loads
- Small fixes to `populate_database.py`, `update_sequences.py` and the shared shear-connection helpers

**Frontend (`osdagclient/`)**
- `ColumnCoverPlateBolted.jsx` / `ColumnCoverPlateWelded.jsx`: input dock and page for the new module, at routes `/design/:designType/column_cover_plate_bolted` and `/column_cover_plate_welded`
- Reworked section modals for the design preferences (column, connector, bolt, weld, detailing, design), plus the `DesignPreferences` dialog
- Design messages now appear only in the 3D viewer (`threerender.jsx`) instead of overlapping the preferences dialog
- `ErrorBoundary.jsx` and additional styles in `App.css`

### Current status

The UI flow, API wiring and module registration for the Column Cover Plate module work end to end. To run without pythonOCC, `design_type/connection/column_cover_plate.py` and `cad/common_logic.py` were replaced in this copy with simplified versions. As a result, **the output values for this module are placeholders** and do not come from a real IS 800 design calculation, and 3D model generation is limited. Restoring the upstream design logic is the next step.

## Tech stack

| Layer | Technologies |
|-------|--------------|
| Backend | Python, Django 3.2, Django REST Framework, SimpleJWT, django-cors-headers, psycopg2 |
| Design / CAD | Osdag design modules (IS 800:2007), pythonOCC (optional), FreeCAD, LaTeX design reports |
| Frontend | React 18, Vite, React Router 6, Redux Toolkit, Ant Design, MUI, Three.js (`@react-three/fiber`, `drei`), Axios |
| Database | PostgreSQL |

## Project structure

```
osdag/
├── osdag_web/          # Django project (settings, URLs, DB credentials)
├── osdag/              # Django app: REST views (web_api/), models, URLs
├── osdag_api/          # Layer between Osdag design code and the web API
│   └── modules/        # fin_plate, end_plate, cleat_angle, seated_angle,
│                       # column_cover_plate_bolted, column_cover_plate_welded
├── design_type/        # Osdag design classes (connections, members)
├── cad/                # CAD model generation
├── design_report/      # LaTeX report generation
├── osdagclient/        # React + Vite frontend
│   └── src/components/ # Input docks, modals, output docks, 3D viewer
├── ResourceFiles/      # Section databases, images
├── populate_database.py / update_sequences.py
├── docker-compose.yml / Dockerfile
└── LICENSE             # Osdag licence (LGPL v3)
```

## Getting started

These steps follow the upstream Osdag on Cloud setup and target Ubuntu 20.04 / 22.04.

### Prerequisites

- Python 3 with Conda (the upstream Osdag installer provides an environment that includes pythonOCC)
- Node.js 16+
- PostgreSQL
- FreeCAD and `texlive-latex-extra` (for CAD and PDF reports)

### 1. Database

```sql
-- sudo -u postgres psql
CREATE ROLE <db_user> PASSWORD '<db_password>' SUPERUSER CREATEDB CREATEROLE INHERIT REPLICATION LOGIN;
CREATE DATABASE "postgres_Intg_osdag" WITH OWNER <db_user>;
```

Database settings live in `osdag_web/postgres_credentials.py`, and the Django key in `osdag_web/secret_key.py`:

| Setting | Where | Example |
|---------|-------|---------|
| DB user | `get_username()` | `<db_user>` |
| DB password | `get_password()` | `<db_password>` |
| DB host | `get_host()` | `localhost` |
| DB port | `get_port()` | `5432` |
| DB name | `get_database_name()` | `postgres_Intg_osdag` |
| Django secret key | `secret_key.py → get_secret_key()` | `<your-django-secret-key>` |

### 2. Backend

```bash
git clone https://github.com/VamsiKrishnaThota03/osdag.git
cd osdag
conda activate                       # environment from the Osdag installer
pip install -r requirements.txt
python populate_database.py
python update_sequences.py
python manage.py migrate
python manage.py runserver 8000
```

### 3. Frontend

```bash
cd osdagclient
npm install
npm run dev                          # http://localhost:5173
```

### Docker (upstream setup)

`docker-compose.yml` defines `backend`, `frontend` and `db` (Postgres 14) services. It expects the database host to be `db` and uses its own credentials, so update `osdag_web/postgres_credentials.py` to match before running `docker compose up`.

## API endpoints for this module

| Method | Path | Purpose |
|--------|------|---------|
| `POST` | `/calculate-output/Column-Cover-Plate-Bolted` | Validate inputs and return output values, logs and CAD model for the bolted cover plate |
| `POST` | `/calculate-output/Column-Cover-Plate-Welded` | Same for the welded variant |

The other endpoints (sessions, design preferences, design report, user accounts, the shear-connection modules) come from upstream. See `osdag/urls.py`.

## License

Osdag is © Osdag contributors / FOSSEE, IIT Bombay and is released under the **GNU Lesser General Public License v3**. See [LICENSE](LICENSE). My changes are provided under the same licence.

## Links

- Upstream web app: https://github.com/osdag-admin/Osdag-web
- Upstream desktop app: https://github.com/osdag-admin/Osdag
- Osdag website: https://osdag.fossee.in/
- Contributing to Osdag: [CONTRIBUTING.md](CONTRIBUTING.md)
