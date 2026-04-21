-- Staging model: clean raw claims data
with source as (
    select * from {{ source('claims', 'RAW_CLAIMS') }}
),

staged as (
    select
        CLAIM_ID                                    as claim_id,
        PATIENT_ID                                  as patient_id,
        PROVIDER_ID                                 as provider_id,
        DIAGNOSIS_CODE                              as diagnosis_code,
        PROCEDURE_CODE                              as procedure_code,
        CLAIM_DATE                                  as claim_date,
        PAID_AMOUNT                                 as paid_amount,
        UPPER(CLAIM_STATUS)                         as claim_status,
        UPPER(PAYER_TYPE)                           as payer_type,
        UPPER(STATE)                                as state,
        DATE_TRUNC('MONTH', CLAIM_DATE)             as claim_month
    from source
)

select * from staged
