with

source as (

    select * from {{ ref('base_orders') }}

),

renamed as (

    select
        order_id::varchar(256),
        shipping_service,
        shipping_cost::number(10, 2) as shipping_cost_usd,
        address_id::varchar(256),
        created_at as created_at_utc,
        {{ dbt_utils.generate_surrogate_key(['promo_id']) }} as promo_id,
        estimated_delivery_at as estimated_delivery_at_utc,
        order_cost::number(10, 2) as order_cost_usd,
        user_id::varchar(256),
        order_total::number(10, 2) as order_total_usd,
        delivered_at as delivered_at_utc,
        tracking_id::varchar(256),
        order_status,
        _fivetran_deleted,
        _fivetran_synced as date_load

    from source

)

select * from renamed
