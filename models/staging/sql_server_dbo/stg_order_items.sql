with

source as (

    select * from {{ source('sql_server_dbo', 'order_items') }}

),

renamed as (

    select
        order_id::varchar(256) as order_id,
        product_id::varchar(256) as product_id,
        quantity::number(38,0) as quantity,
        _fivetran_deleted,
        _fivetran_synced as loaded_at

    from source

)

select * from renamed
