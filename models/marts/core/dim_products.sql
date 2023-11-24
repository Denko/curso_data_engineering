with

source as (

    select * from {{ ref('products_snapshot') }}

),

renamed as (

    select
        product_id,
        product_price,
        product_name,
        inventory

    from source

)

select * from renamed