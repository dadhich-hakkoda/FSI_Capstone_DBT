{{
  config(
    materialized = 'view',
    alias = 'VW_DISTINCT_SYMBOL'
  )
}}

SELECT DISTINCT
  symbol,
  asset_type,
  currency,
  CASE 
    WHEN asset_type IN ('FOREX', 'CRYPTO') THEN SPLIT_PART(currency, '/', 1)
    ELSE NULL 
  END as currency_base,
  CASE 
    WHEN asset_type IN ('FOREX', 'CRYPTO') THEN SPLIT_PART(currency, '/', 2)
    ELSE NULL 
  END as currency_quote,
  exchange_name,
  -- Removed exchange_timezone since it doesn't exist in source
  mic_code
FROM {{ ref('stg_transactions') }}