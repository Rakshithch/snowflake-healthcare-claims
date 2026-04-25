# Healthcare Claims Analytics Data Warehouse
## Snowflake · dbt · SQL · Kimball Star Schema

End-to-end cloud data warehouse for healthcare claims analytics — built on Snowflake with dbt transformation pipelines, dimensional modeling, and automated data quality tests.

---

## Tech Stack

| Layer | Technology |
|-------|------------|
| Cloud Data Warehouse | Snowflake |
| Transformation | dbt (data build tool) |
| Data Modeling | Kimball Star Schema |
| Language | SQL |
| Data Quality | dbt Tests (unique, not_null, accepted_values) |
| Version Control | Git / GitHub |

---

## Architecture

```
RAW_CLAIMS (source)
      │
      ▼
stg_claims (dbt staging)
Cleans, standardizes, adds claim_month
      │
      ▼
fct_claims_summary (dbt marts)
Aggregated denial rate by payer, month, state
      │
      ▼
Analytical Views (Snowflake SQL)
  - VW_CLAIMS_BY_PAYER
  - VW_CLAIMS_BY_DIAGNOSIS
  - VW_MONTHLY_TREND
```

---

## Star Schema Design

```
                    DIM_DATE
                       |
DIM_PROVIDER ---- FACT_CLAIMS ---- DIM_PATIENT
```

- **FACT_CLAIMS** — claim transactions with measures (paid_amount, claim_status)
- **DIM_PROVIDER** — provider dimension
- **DIM_PATIENT** — patient dimension
- **DIM_DATE** — date dimension

---

## dbt Project Structure

```
healthcare_claims_dbt/
├── dbt_project.yml
├── models/
│   ├── staging/
│   │   ├── sources.yml             # Source definition for RAW_CLAIMS
│   │   ├── stg_claims.sql          # Staging model: clean + standardize
│   │   └── schema.yml              # 7 column-level data quality tests
│   └── marts/
│       ├── fct_claims_summary.sql  # Aggregated denial rate mart
│       └── schema.yml              # 5 column-level data quality tests
```

---

## Data Quality Tests

12 automated dbt tests across all key columns:

| Model | Column | Tests |
|-------|--------|-------|
| stg_claims | claim_id | unique, not_null |
| stg_claims | patient_id | not_null |
| stg_claims | provider_id | not_null |
| stg_claims | claim_status | not_null, accepted_values (PAID/DENIED/PENDING/ADJUSTED) |
| stg_claims | payer_type | not_null, accepted_values (MEDICARE/MEDICAID/COMMERCIAL) |
| stg_claims | paid_amount | not_null |
| stg_claims | claim_date | not_null |
| fct_claims_summary | payer_type | not_null |
| fct_claims_summary | claim_month | not_null |
| fct_claims_summary | state | not_null |
| fct_claims_summary | total_claims | not_null |
| fct_claims_summary | denial_rate_pct | not_null |

---

## Key Analytical Views

**VW_CLAIMS_BY_PAYER**
Aggregates total claims, paid amount, and denial rate by payer type (Medicare, Medicaid, Commercial).

**VW_CLAIMS_BY_DIAGNOSIS**
Breaks down claim volume and average paid amount by ICD-10 diagnosis code.

**VW_MONTHLY_TREND**
Tracks monthly claims volume and denial rate trends over time for executive reporting.

---

## Key Findings

- Medicare accounts for the highest average claim amount and denial rate
- Denial rate analysis by payer enables targeted revenue cycle interventions
- Monthly trend views support HEDIS and CMS reporting requirements
- Star schema design reduces query complexity for BI tools (Power BI, Tableau)

---

## Healthcare Domain Context

| Term | Description |
|------|-------------|
| X12 EDI 837 | Standard format for healthcare claims submission |
| X12 EDI 835 | Standard format for claims payment and remittance |
| HEDIS | Healthcare Effectiveness Data and Information Set |
| ICD-10 | International Classification of Diseases diagnosis codes |
| HIPAA | Health Insurance Portability and Accountability Act |
| Denial Rate | Percentage of claims denied by payer — key revenue cycle KPI |

---

## Related Project

- [Healthcare Claims Analytics — PySpark and Databricks](https://github.com/Rakshithch/healthcare-claims-pyspark)
