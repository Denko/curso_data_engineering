with

stg_order_items as (

    select * from {{ ref('stg_order_items') }}

),

products as (

    select * from {{ ref('dim_products') }}

),

orders as (

    select * from {{ ref('dim_orders') }}

),
-- POR HACER
renamed as (

    select
        order_item_id,
        order_id,
        product_id,
         quantity

from stg_order_items

)

select * from renamed