with

stg_orders as (
    select * 
    from {{ ref('stg_orders') }}
),

shipping_service as (

    select * from {{ ref('dim_shipping_services') }}

),

promos as (

    select * from {{ ref('dim_promos') }}

),

dates as (

    select * from {{ ref('dim_dates') }}

),

addresses as (

    select * from {{ ref('dim_addresses') }}

),

customers as (

    select * from {{ ref('dim_customers') }}

),

renamed as (
-- POR HACER
    select
        order_id,
        shipping_service,
        shipping_cost_usd,
        address_id,
        created_at_utc,
        promo_id,
        estimated_delivery_at_utc,
        order_cost_usd,
        user_id,
        order_total_usd,
        delivered_at_utc,
        tracking_id,
        order_status

    from stg_orders

)

select * from renamed