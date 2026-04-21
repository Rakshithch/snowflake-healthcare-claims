# Healthcare Claims Analytics — Snowflake

A cloud-based healthcare claims data warehouse built on Snowflake, demonstrating star schema design, SQL analytics, and payer performance reporting.

## Project Overview
- Designed and implemented a **star schema** with 1 fact table and 3 dimension tables (Provider, Patient, Date)
- Ingested and transformed raw healthcare claims data across Medicare, Medicaid, and Commercial payers
- Built analytical **SQL views** for denial rate tracking, diagnosis-level cost analysis, and monthly claims trends
- Queried multi-dimensional data joining provider, patient, and date dimensions

## Tech Stack
- **Snowflake** — Cloud data warehouse
- **SQL** — Data modeling, transformation, and analytics
- **Star Schema** — Kimball-style dimensional modeling

## Key Analyses
- Claims denial rate by payer type
- Cost breakdown by diagnosis code (ICD-10)
- Monthly claims volume and spend trends
- Provider performance by specialty and payer