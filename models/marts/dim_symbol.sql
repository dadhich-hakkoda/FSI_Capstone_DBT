{{
  config(
    materialized = 'table',
    alias = 'DIM_SYMBOL'
  )
}}

SELECT
  -- Surrogate key
  ROW_NUMBER() OVER (ORDER BY symbol) as dim_symbol_key,
  
  -- Symbol information
  symbol,
  asset_type,
  currency,
  currency_base,
  currency_quote,
  exchange_name,
  NULL as exchange_timezone,  -- Placeholder since not in source
  FALSE as internal,          -- Default value
  mic_code,
  
  -- System versioning
  CURRENT_TIMESTAMP() as system_current_date,
  TRUE as system_current_flag,
  NULL as system_end_date,
  CURRENT_TIMESTAMP() as system_start_date,
  CURRENT_TIMESTAMP() as system_update_date,
  1 as system_version
  
FROM {{ ref('vw_distinct_symbol') }}