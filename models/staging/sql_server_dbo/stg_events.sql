{{ config(
    materialized='incremental',
    unique_key = 'event_id'
    ) 
    }}

with

source as (

    select * from {{ ref('base_events') }}
    {% if is_incremental() %}

        WHERE _fivetran_synced > (SELECT max(loaded_at) FROM {{ this }})

    {% endif %}

),

renamed as (

    select
        event_id::varchar(256) as event_id,
        page_url::varchar(1024) as page_url,
        event_type::varchar(100) as event_type,
        user_id::varchar(256) as user_id,
        product_id::varchar(256) as product_id,
        session_id::varchar(256) as session_id,
        created_at::timestamp_tz(9) as created_at,
        order_id::varchar(256) as order_id,
        _fivetran_deleted,
        _fivetran_synced as loaded_at

    from source

)

select * from renamed
