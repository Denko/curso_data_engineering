with

source as (

    select * from {{ ref('base_promos') }}

),

renamed as (

    select
        promo_id::varchar(256),
        name::varchar(32) as promo_name,
        discount::number(38,0) as promo_discount,
        status::varchar(256) as promo_status,
        _fivetran_deleted,
        _fivetran_synced as date_load

    from source
    

)

select * from renamed
union all
-- Code 9999 for no promos and today date for loading
select {{ dbt_utils.generate_surrogate_key('9999') }},'No promo',0,'inactive',null,current_timestamp()