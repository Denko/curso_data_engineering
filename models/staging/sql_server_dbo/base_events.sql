with

source as (

    select * from {{ source('sql_server_dbo', 'events') }}

),

renamed as (

    select
        event_id,
        page_url,
        event_type,
        user_id,
        DECODE(product_id,'',null,product_id) as product_id,
        session_id,
        created_at,
        DECODE(order_id,'',null,order_id) as order_id,
        _fivetran_deleted,
        _fivetran_synced as loaded_at

    from source

)

select * from renamed