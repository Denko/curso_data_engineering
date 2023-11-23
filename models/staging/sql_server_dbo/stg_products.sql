with

source as (

    select * from {{ source('sql_server_dbo', 'products') }}

),

renamed as (

    select
        product_id::varchar(256) as product_id,
        price::float as product_price,
        name::varchar(256) as product_name,
        inventory::number(38,0) as inventory,
        _fivetran_deleted,
        _fivetran_synced as loaded_at

    from source

)

select * from renamed
union all
-- Code 9999 for no product and today date for loading
select {{ dbt_utils.generate_surrogate_key('9999') }},0,'no_product',0,null,current_timestamp()
