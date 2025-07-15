{{
  config(
    materialized = 'table'
  )
}}

-- Stocks data
SELECT
  symbol,
  'STOCK' as asset_type,
  date_transaction,
  open_price,
  high_price,
  low_price,
  close_price,
  trade_volume,
  currency,
  exchange_name,
  mic_code,
  system_create_date,
  system_update_date
FROM {{ ref('stg_raw_stocks') }}

UNION ALL

-- ETFs data
SELECT
  symbol,
  'ETF' as asset_type,
  date_transaction,
  open_price,
  high_price,
  low_price,
  close_price,
  trade_volume,
  currency,
  exchange_name,
  mic_code,
  system_create_date,
  system_update_date
FROM {{ ref('stg_raw_etfs') }}

UNION ALL

-- Forex data
SELECT
  symbol,
  'FOREX' as asset_type,
  date_transaction,
  open_price,
  high_price,
  low_price,
  close_price,
  NULL as trade_volume,
  currency,
  NULL as exchange_name,
  NULL as mic_code,
  system_create_date,
  system_update_date
FROM {{ ref('stg_raw_forex') }}

UNION ALL

-- Crypto data
SELECT
  symbol,
  'CRYPTO' as asset_type,
  date_transaction,
  open_price,
  high_price,
  low_price,
  close_price,
  NULL as trade_volume,
  currency,
  NULL as exchange_name,
  NULL as mic_code,
  system_create_date,
  system_update_date
FROM {{ ref('stg_raw_crypto') }}