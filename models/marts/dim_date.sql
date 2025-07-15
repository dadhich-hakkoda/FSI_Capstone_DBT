{{
  config(
    materialized = 'table',
    alias = 'DIM_DATE'
  )
}}

WITH date_range AS (
  SELECT 
    MIN(date_transaction) AS min_date,
    MAX(date_transaction) AS max_date
  FROM {{ ref('stg_transactions') }}
),

date_spine AS (
  SELECT
    DATEADD('day', seq4(), (SELECT MIN(date_transaction) FROM {{ ref('stg_transactions') }})) AS date_transaction
  FROM TABLE(GENERATOR(ROWCOUNT => 10000))
),

date_series AS (
  SELECT *
  FROM date_spine
  WHERE date_transaction <= (SELECT MAX(date_transaction) FROM {{ ref('stg_transactions') }})
),

enriched_dates AS (
  SELECT
    date_transaction,
    -- Date parts
    DAY(date_transaction) AS day_of_month,
    DAYOFWEEK(date_transaction) AS day_of_week,
    DAYOFYEAR(date_transaction) AS day_of_year,
    
    -- Month/quarter info
    MONTHNAME(date_transaction) AS month_name,
    MONTH(date_transaction) AS month_num,
    QUARTER(date_transaction) AS quarter_num,
    
    -- Year info
    YEAR(date_transaction) AS year_num,
    CONCAT(YEAR(date_transaction), '-', LPAD(MONTH(date_transaction), 2, '0')) AS year_month,
    CONCAT(YEAR(date_transaction), '-Q', QUARTER(date_transaction)) AS year_quarter,
    
    -- System versioning
    TRUE AS system_current_flag,
    NULL AS system_end_date,
    date_transaction AS system_start_date,
    1 AS system_version
  FROM date_series
)

SELECT
  date_transaction,
  day_of_month,
  day_of_week,
  day_of_year,
  month_name,
  month_num,
  quarter_num,
  year_num,
  year_month,
  year_quarter,
  ROW_NUMBER() OVER (ORDER BY date_transaction) AS dim_transaction_key,
  CURRENT_TIMESTAMP() AS system_current_date,
  system_current_flag,
  system_end_date,
  system_start_date,
  CURRENT_TIMESTAMP() AS system_update_date,
  system_version
FROM enriched_dates
