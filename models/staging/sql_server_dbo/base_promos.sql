with

source as (

    select * from {{ source('sql_server_dbo', 'promos') }}

),

renamed as (

    select
        {{dbt_utils.generate_surrogate_key(['promo_id'])}} as promo_id,
        promo_id as name,
        discount,
        status,
        _fivetran_deleted,
        _fivetran_synced

from source

)

select * from renamed
