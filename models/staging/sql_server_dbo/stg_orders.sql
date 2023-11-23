with

source as (

    select * from {{ ref('base_orders') }}

),

renamed as (

    select
        order_id::varchar(256) as order_id,
        shipping_service,
        shipping_cost::number(10, 2) as shipping_cost_usd,
        address_id::varchar(256) as address_id,
        created_at as created_at_utc,
        {{ dbt_utils.generate_surrogate_key(['promo_id']) }} as promo_id,
        estimated_delivery_at as estimated_delivery_at_utc,
        order_cost::number(10, 2) as order_cost_usd,
        user_id::varchar(256) as user_id,
        order_total::number(10, 2) as order_total_usd,
        delivered_at as delivered_at_utc,
        tracking_id::varchar(256) as tracking_id,
        order_status,
        _fivetran_deleted,
        _fivetran_synced as loaded_at

    from source

)

select * from renamed
union all
-- Code 9999 for no order and today date for loading
select {{ dbt_utils.generate_surrogate_key('9999') }},
        'no_shipping_service',
        0,
        {{ dbt_utils.generate_surrogate_key('9999') }}, 
        null, 
        {{ dbt_utils.generate_surrogate_key('9999') }},
        null,
        0,
        {{ dbt_utils.generate_surrogate_key('9999') }},
        0,
        null,
        null,
        null,
        null,
        null

