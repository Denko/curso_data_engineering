with

source as (

    select * from {{ source('sql_server_dbo', 'orders') }}

),

renamed as (

    select
        order_id,
        DECODE(shipping_service,'','No Shipping Service',shipping_service) as shipping_service,
        shipping_cost,
        address_id,
        created_at,
        DECODE(promo_id,'','No promo',promo_id) as promo_id,
        estimated_delivery_at,
        order_cost,
        user_id,
        order_total,
        delivered_at,
        DECODE(tracking_id,'',null,tracking_id) as tracking_id,
        status as order_status,
        _fivetran_deleted,
        _fivetran_synced

    from source

)

select * from renamed
