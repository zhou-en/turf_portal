# Turf Portal

Turf Portal is a Django-based web application for managing turf business operations, including orders, invoices, products, buyers, and stock management.

---

## Architecture

### System Overview

```mermaid
graph TD
    User[User/Browser] -->|HTTPS| Vercel[Vercel Edge Network]
    Vercel -->|WSGI| Django[Django Application]
    Django -->|SQL| DB[(PostgreSQL Database)]
    Django -->|Static Files| WhiteNoise[WhiteNoise / Static Storage]

    subgraph "Django Application"
        Auth[Authentication]
        Sales[Sales Module]
        Invoice[Invoice Module]
        Stock[Stock Module]
        Expense[Expense Module]
    end

    Sales --> Stock
    Sales --> Invoice
    Invoice --> Sales
```

### Database Schema (Simplified)

```mermaid
erDiagram
    BUYER ||--o{ ORDER : places
    ORDER ||--|{ ORDERLINE : contains
    ORDER ||--|| INVOICE : generates
    PRODUCT ||--o{ ORDERLINE : included_in
    TURFROLL ||--o{ ORDERLINE : allocated_to
    WAREHOUSE ||--o{ TURFROLL : stores

    BUYER {
        string name
        string type
        string status
    }
    ORDER {
        string number
        string status
        datetime closed_date
    }
    INVOICE {
        string number
        string status
    }
    TURFROLL {
        string status
        float available
        float original_size
    }
```

---

## Build & Deployment

### CI/CD Pipeline

This project uses GitHub Actions for Continuous Integration and Continuous Deployment.

- **Trigger**: Pushes to `master`, `main`, or `develop` branches.
- **Steps**:
    1.  Checkout code.
    2.  Set up Python environment.
    3.  Install dependencies.
    4.  Run linting (flake8).
    5.  (Optional) Run tests.

### Deployment to Vercel

The application is configured for deployment on Vercel using the "Zero Config" approach with `vercel.json`.

1.  **Configuration**: `vercel.json` handles routing and build settings.
2.  **Build Script**: `build_files.sh` installs dependencies, runs migrations, and collects static files.
3.  **Environment Variables**: Ensure the following variables are set in your Vercel project settings:
    - `SECRET_KEY`
    - `DEBUG` (Set to `False` in production)
    - `ALLOWED_HOSTS` (e.g., `.vercel.app`)
    - `DB_NAME`, `DB_USER`, `DB_PASSWORD`, `DB_HOST` (PostgreSQL connection details)
    - `EMAIL_HOST_USER`, `EMAIL_HOST_PASSWORD` (For sending invoices)

---

## Build Statuses

- [Develop](https://github.com/zhou-en/turf_portal/tree/develop)
    ![Develop Status](https://github.com/zhou-en/turf_portal/actions/workflows/django.yml/badge.svg?branch=develop)

- [Master](https://github.com/zhou-en/turf_portal/tree/master)
    ![Master Status](https://github.com/zhou-en/turf_portal/actions/workflows/django.yml/badge.svg?branch=master)


## Environment Dependencies

- For PDF feature to work, the following package has to be installed in the deployed environment (if supported by the platform):
```shell
sudo apt install wkhtmltopdf
```

## Backup Database on Lubuntu
- Login as `postgres` user: `sudo su - postgres`
- Dump `sql` file: `psql -U postgres turf-portal > db_backup.sql`
- Restore: `psql -U postgres postgresql://turf_portal_user:password@localhost:5432/turf_portal < db_backup.sql`
