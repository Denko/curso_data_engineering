{{ config(
    materialized='incremental',
    unique_key = 'order_item_id'
    ) 
    }}

with

source as (

    select * from {{ source('sql_server_dbo', 'order_items') }}
    {% if is_incremental() %}

        WHERE _fivetran_synced > (SELECT max(loaded_at) FROM {{ this }})

    {% endif %}

),

renamed as (

    select
        {{ dbt_utils.generate_surrogate_key(['order_id','product_id']) }} as order_item_id,
        order_id::varchar(256) as order_id,
        product_id::varchar(256) as product_id,
        quantity::number(38,0) as quantity,
        _fivetran_deleted,
        _fivetran_synced as loaded_at

    from source

)

select * from renamed
