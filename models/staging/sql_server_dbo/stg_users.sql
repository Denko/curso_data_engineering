with

source as (

    select * from {{ ref('base_users') }}

),

renamed as (

    select
        cast(user_id as varchar(256)) as user_id,
        cast(updated_at as timestamp_tz(9)) as updated_at,
        cast(address_id as varchar(256)) as address_id,
        cast(last_name as varchar(256)) as last_name,
        cast(created_at as timestamp_tz(9)) as created_at,
        cast(phone_number as varchar(50)) as phone_number,
        cast(total_orders as number(38,0)) as total_orders,
        cast(first_name as varchar(256)) as first_name,
        cast(email as varchar(256)) as email,
        _fivetran_deleted,
        _fivetran_synced as loaded_at

    from source

)

select * from renamed

