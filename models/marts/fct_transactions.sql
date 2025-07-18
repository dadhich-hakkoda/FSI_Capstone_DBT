{{
  config(
    materialized = 'table',
    alias = 'FCT_TRANSACTIONS'
  )
}}

SELECT
  -- Core transaction data
  symbol,
  date_transaction,
  open_price,
  high_price,
  low_price,
  close_price,
  trade_volume,
  
  -- System metadata
  CURRENT_TIMESTAMP() AS system_current_date,
  CURRENT_TIMESTAMP() AS system_update_date
  
FROM {{ ref('stg_transactions') }}