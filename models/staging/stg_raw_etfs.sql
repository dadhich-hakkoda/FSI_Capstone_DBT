{{
  config(
    materialized = 'table',
    alias = 'STG_RAW_ETFS'
  )
}}

with source as (
    select * 
    from {{ source('raw_data', 'ETFS') }}
),

flattened as (
    select
        content:meta:currency::string as currency,
        content:meta:symbol::string as symbol,
        content:meta:type::string as asset_type,
        content:meta:exchange::string as exchange_name,
        content:meta:mic_code::string as mic_code,
        
        value.value:datetime::date as date_transaction,
        value.value:open::float as open_price,
        value.value:high::float as high_price,
        value.value:low::float as low_price,
        value.value:close::float as close_price,
        value.value:volume::integer as trade_volume

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
    trade_volume,
    currency,
    exchange_name,
    mic_code,
    current_timestamp() as system_create_date,
    current_timestamp() as system_update_date
from flattened