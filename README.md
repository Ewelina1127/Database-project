# AirPort Shiny Application

This repository contains two versions of the same Shiny application for managing an airport database:

* **postgres-version/**: full-featured version using PostgreSQL, PL/pgSQL functions, and triggers.
* **sqlite-version/**: a lightweight demo using SQLite (no external database server needed).

---

## Prerequisites

* **R** (>= 4.0) and the following R packages:

  ```r
  install.packages(c(
    "shiny",
    "DBI",
    "config",
    "DT",
    "shinyjs",
    # PostgreSQL version only:
    "RPostgres",
    # SQLite version only:
    "RSQLite"
  ))
  ```
* **PostgreSQL** server (for postgres-version only).
* Git (to clone this repository).

---

## Repository Structure

```
my-portfolio/
├── .gitignore
├── config.yml
├── README.md       # this file
├── SCHEMA_DOCUMENTATION.md
├── postgres-version/    # full Postgres version
│   ├── airportdb.sql
│   ├── global.R
│   ├── helper_functions.R
│   ├── ui.R
│   └── server.R
└── sqlite-version/      # SQLite demo version
    ├── airportdb.sqlite
    ├── global.R
    ├── helper_functions_sqlite.R
    ├── ui.R
    └── server.R
```

---

## Configuration (`config.yml`)

```yaml
default:
  db:
    type: sqlite
    path: "sqlite-version/airportdb.sqlite"

postgres:
  db:
    type: postgres
    driver: Postgres
    host: "localhost"
    port: 5432
    dbname: "airport"
    user: "postgres"
    password: "YourPassword"
```

* **default**: points to the SQLite-demo database.
* **postgres**: connection settings for the PostgreSQL version.

---

## Running the App

### 1. SQLite Demo (default)

1. Ensure `config.yml` has the `default` profile selected.
2. In R console:

   ```r
   setwd("sqlite-version")
   library(shiny)
   runApp(".")
   
   ```
3. The app will open in your browser, using the local `airportdb.sqlite` file.

### 2. PostgreSQL Full Version

1. Create the database and objects in PostgreSQL:

   ```bash
   psql -U postgres -d airport -f postgres-version/airportdb.sql
   ```
2. In `config.yml`, either rename the `postgres` block to `default`, or launch with explicit profile:

   ```r
   cfg <- config::get(config = "postgres")
   ```
3. In R console:

   ```r
   setwd("postgres-version")
   library(shiny)
   runApp(".")
   ```
4. The app will connect to your PostgreSQL server and use the PL/pgSQL functions and triggers.

---

## Schema Documentation

See **SCHEMA\_DOCUMENTATION.md** for detailed descriptions of tables, views, triggers, functions, and constraints.

---

## Contributing

Feel free to open issues and submit pull requests. For major changes, please discuss them via issue first.

---

*Enjoy exploring both the demo and the full-featured Postgres setup!*
