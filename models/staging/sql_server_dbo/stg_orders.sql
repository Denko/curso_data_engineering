with

source as (

    select * from {{ source('sql_server_dbo', 'orders') }}

),

renamed as (

    select
        order_id,
        shipping_service,
        shipping_cost::number(10, 2) as shipping_cost_usd,
        address_id,
        created_at,
        case
            when promo_id is not null or promo_id != '' then {{dbt_utils.generate_surrogate_key(['promo_id'])}}
            else {{dbt_utils.generate_surrogate_key(coalesce(promo_id,'no_promo'))}}
        end as promo_id,
        estimated_delivery_at,
        order_cost::number(10,2) AS order_cost_usd,
        user_id,
        order_total::number(10,2) AS order_total_usd,
        delivered_at,
        tracking_id,
        status,
        _fivetran_deleted,
        _fivetran_synced AS date_load

    from source

)

select * from renamed
