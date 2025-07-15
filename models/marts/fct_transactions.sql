{{
  config(
    materialized = 'table',
    alias = 'FCT_TRANSACTIONS'
  )
}}

SELECT
  -- Transaction facts
  t.symbol,
  t.date_transaction,
  t.open_price,
  t.high_price,
  t.low_price,
  t.close_price,
  t.trade_volume,
  
  -- Dimension keys
  d.dim_transaction_key,  -- ✅ Fixed name
  s.dim_symbol_key,
  
  -- System metadata
  CURRENT_TIMESTAMP() AS system_current_date,
  CURRENT_TIMESTAMP() AS system_update_date,
  
  -- Surrogate key for fact table
  ROW_NUMBER() OVER (ORDER BY t.date_transaction, t.symbol) AS fact_transaction_key
FROM {{ ref('stg_transactions') }} t
JOIN {{ ref('dim_date') }} d 
  ON t.date_transaction = d.date_transaction
JOIN {{ ref('dim_symbol') }} s 
  ON t.symbol = s.symbol
