with

source as (

    select * from {{ source('sql_server_dbo', 'order_items') }}

),

renamed as (

    select
        order_id::varchar(256),
        product_id::varchar(256),
        quantity::number(38,0),
        _fivetran_deleted,
        _fivetran_synced as date_load

    from source

)

select * from renamed
