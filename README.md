# 🏦 FSI Capstone DBT Project

This repository contains the dbt-core implementation of the Financial Services Industry (FSI) Capstone Project for Hakkoda. It showcases a full ELT pipeline for transforming and modeling financial data, including stocks, ETFs, forex, and crypto transactions.

## 📁 Project Structure

```
dadhich-hakkoda-fsi_capstone_dbt/
│
├── README.md                # Project documentation
├── dbt_project.yml          # DBT project configuration
├── package-lock.yml         # Lock file for package dependencies
├── packages.yml             # DBT packages being used
│
├── analyses/                # For ad-hoc analysis (currently empty)
│   └── .gitkeep
│
├── macros/                  # Custom macros (currently empty)
│   └── .gitkeep
│
├── models/
│   ├── sources.yml          # Source definitions for raw data
│   ├── marts/               # Core data models
│   │   ├── dim_date.sql
│   │   ├── dim_symbol.sql
│   │   ├── fct_transactions.sql
│   │   └── schema.yml       # Model-level documentation/tests
│   └── staging/             # Staging layer
│       ├── stg_raw_crypto.sql
│       ├── stg_raw_etfs.sql
│       ├── stg_raw_forex.sql
│       ├── stg_raw_stocks.sql
│       ├── stg_transactions.sql
│       └── vw_distinct_symbol.sql
│
├── seeds/                   # Seed data (currently empty)
│   └── .gitkeep
│
├── snapshots/               # Snapshot definitions (currently empty)
│   └── .gitkeep
│
└── tests/                   # Custom tests (currently empty)
    └── .gitkeep
```

## 🚀 Objectives

- Replicate and enhance the Coalesce FSI Capstone using **dbt Core**
- Implement an end-to-end **ELT** pipeline: extract raw financial datasets, transform via staging, and model fact/dimension tables
- Enable downstream analytics (e.g., Sigma dashboards)

## 🧱 Key Models

- `dim_symbol.sql` - Contains unique financial symbols (stocks, crypto, forex, ETFs)
- `dim_date.sql` - Standardized date dimension
- `fct_transactions.sql` - Fact table for transaction-level data
- `stg_*` - Staging models to clean and prepare raw data
- `vw_distinct_symbol.sql` - View for deduplicated symbol entries across asset types

## 🛠️ Technologies Used

- [dbt-core](https://docs.getdbt.com/docs/introduction)
- [Snowflake](https://www.snowflake.com/) (as data warehouse)
- [Sigma](https://www.sigmacomputing.com/) (for downstream BI, outside this repo)
- GitHub for version control

## ✅ Running the Project

1. **Set up environment**:
   ```bash
   python -m venv .venv
   source .venv/bin/activate
   pip install dbt-core dbt-snowflake
   ```

2. **Install packages**:
   ```bash
   dbt deps
   ```

3. **Configure your profiles.yml**:
   Typically located in `~/.dbt/`, use your Snowflake credentials and profile name.

4. **Run models**:
   ```bash
   dbt run
   ```

5. **Test models**:
   ```bash
   dbt test
   ```

6. **Generate docs**:
   ```bash
   dbt docs generate
   dbt docs serve
   ```

## 📌 Notes

- The models are organized in **staging** and **marts** layers to follow dbt best practices.
- `sources.yml` is used to register external/raw data sources for traceability.
- All models are materialized as **tables** unless otherwise configured.

## 🙌 Acknowledgments

This project is part of a capstone assignment for the Hakkoda FSI Data Engineering program. 
Made by Harsh Dadhich.
