# Admin Dashboard GP

A multi-tenant admin dashboard for mall and shop management, built with Rails 8.1 and backed by Supabase (PostgreSQL). Features role-based access control for Mall Admins and Shop Admins, QR code generation, points/rewards tracking, stamp programs, and a data analysis dashboard.

## Tech Stack

| Layer | Technology |
|---|---|
| **Framework** | Ruby on Rails 8.1 |
| **Language** | Ruby 3.4.8 |
| **Database** | PostgreSQL 15 (Supabase) |
| **Frontend** | ERB + Tailwind CSS + Hotwire (Turbo + Stimulus) |Solid Queue, Solid Cable |
| **Assets** | Propshaft + Importmap |
| **Deployment** | Kamal + Docker |

## Architecture

### Multi-Tenant Roles
- **Mall Admin** — manages malls, shops, categories, tiers, users, mall admins, system configs, audit logs
- **Shop Admin** — manages shop offers, stamp programs, QR codes, earn/redeem transactions, receipts, shop admins

### Key Features
- Shop approval / deactivation workflow
- Points wallet and balance tracking
- Stamp card programs with user stamp cards
- QR code generation for stamp redemptions
- Offer creation and redemption tracking
- Audit logging for all admin actions
- Data analysis dashboard

## Prerequisites

- Ruby 3.4.8 (managed via `.ruby-version`)
- PostgreSQL 15+ (local or Supabase)
- Node.js not required (Tailwind is managed by `tailwindcss-rails`)

## Quick Start — Native (Development)

### 1. Install dependencies

```bash
bundle install
```

### 2. Configure the database

Copy and edit the `.env` file with your PostgreSQL credentials:

```bash
# .env
DB_HOST="localhost"
DB_NAME="admin_dashboard_development"
DB_USERNAME="postgres"
DB_PASS="your_password"
DB_PORT="5432"
DB_SSLMODE="disable"
```

### 3. Set up the database

```bash
# Create and seed the database
bin/rails db:create db:migrate db:seed
```

### 4. Start the development server

```bash
bin/dev
```

This boots the Rails server and Tailwind CSS watcher concurrently. The app will be available at `http://localhost:3000`.

## Quick Start — Docker

### Option A: docker-compose (app + local PostgreSQL)

```bash
docker compose up --build
```

This starts a PostgreSQL 15 container and the Rails app on port 80. The database is stored in `./tmp/db`.

### Option B: Pre-built image (your own PostgreSQL)

```bash
docker pull hmsh00/admin_dashboard_gp:latest

docker run -d --name admin-dashboard \
  -p 80:80 \
  -e DB_HOST="your-db-host" \
  -e DB_NAME="your-db-name" \
  -e DB_USERNAME="your-username" \
  -e DB_PASS="your-password" \
  -e DB_PORT="5432" \
  -e DB_SSLMODE="require" \
  -e SECRET_KEY_BASE="$(openssl rand -hex 64)" \
  -e RAILS_ENV="production" \
  hmsh00/admin_dashboard_gp:latest
```

### Option C: Build your own image

```bash
docker build -t admin-dashboard-gp .

docker run -d --name admin-dashboard \
  -p 80:80 \
  -e DB_HOST="your-db-host" \
  -e DB_NAME="your-db-name" \
  -e DB_USERNAME="your-username" \
  -e DB_PASS="your-password" \
  -e DB_PORT="5432" \
  -e DB_SSLMODE="require" \
  -e SECRET_KEY_BASE="$(openssl rand -hex 64)" \
  -e RAILS_ENV="production" \
  admin-dashboard-gp
```

## Running Tests

```bash
bin/rails test
bin/rails test:system
```

## Environment Variables

| Variable | Description | Default |
|---|---|---|
| `DB_HOST` | PostgreSQL host | `localhost` |
| `DB_NAME` | Database name | `admin_dashboard_development` |
| `DB_USERNAME` | Database user | `postgres` |
| `DB_PASS` | Database password | `password` |
| `DB_PORT` | Database port | `5432` |
| `DB_SSLMODE` | SSL mode | `require` |
| `SECRET_KEY_BASE` | Rails secret key | *(required in production)* |
| `RAILS_ENV` | Rails environment | `development` |
