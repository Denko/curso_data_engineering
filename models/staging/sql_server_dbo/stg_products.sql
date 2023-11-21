with

source as (

    select * from {{ source('sql_server_dbo', 'products') }}

),

renamed as (

    select
        product_id::varchar(256),
        price::float as product_price,
        name::varchar(256) as product_name,
        inventory::number(38,0),
        _fivetran_deleted,
        _fivetran_synced as date_load

    from source

)

select * from renamed
