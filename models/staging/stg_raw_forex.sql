{{
  config(
    materialized = 'table',
    alias = 'STG_RAW_FOREX'
  )
}}

with source as (
    select * 
    from {{ source('raw_data', 'FOREX') }}
),

flattened as (
    select
        content:meta:currency_base::string as currency_base,
        content:meta:currency_quote::string as currency_quote,
        content:meta:symbol::string as symbol,
        content:meta:type::string as asset_type,
        
        value.value:datetime::date as date_transaction,
        value.value:open::float as open_price,
        value.value:high::float as high_price,
        value.value:low::float as low_price,
        value.value:close::float as close_price

    from source,
    lateral flatten(input => content:values) as value
)

select 
    symbol,
    asset_type,
    date_transaction,
    open_price,
    high_price,
    low_price,
    close_price,
    currency_base || '/' || currency_quote as currency,
    current_timestamp() as system_create_date,
    current_timestamp() as system_update_date
from flattened