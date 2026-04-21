-- Fact model: claims summary by payer and month
with stg_claims as (
    select * from {{ ref('stg_claims') }}
),

summary as (
    select
        payer_type,
        claim_month,
        state,
        count(claim_id)                                                          as total_claims,
        sum(paid_amount)                                                         as total_paid,
        avg(paid_amount)                                                         as avg_claim_amount,
        count(case when claim_status = 'DENIED' then 1 end)                      as denied_claims,
        count(case when claim_status = 'PAID' then 1 end)                        as paid_claims,
        round(
            count(case when claim_status = 'DENIED' then 1 end) * 100.0
            / nullif(count(claim_id), 0), 2
        )                                                                        as denial_rate_pct
    from stg_claims
    group by payer_type, claim_month, state
)

select * from summary
