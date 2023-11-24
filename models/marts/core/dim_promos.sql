with

source as (

    select * from {{ ref('promos_snapshot') }}

),

renamed as (

    select
        promo_id,
        promo_name,
        promo_discount,
        promo_status

    from source
    

)

select * from renamed