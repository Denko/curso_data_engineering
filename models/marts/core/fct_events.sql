with

events as (

    select * from {{ ref('stg_events') }}

),

products as (

    select * from {{ ref('dim_products') }}

),

customers as (

    select * from {{ ref('dim_customers') }}

),

orders as (

    select * from {{ ref('dim_orders') }}

),

customers as (

    select * from {{ ref('dim_customers') }}

)

dates as (

    select * from {{ ref('dim_dates') }}

)


renamed as (

    select
        event_id,
        page_url,
        event_type,
        user_id,
        product_id,
        session_id,
        created_at,
        order_id

    from events

)

select * from renamed
