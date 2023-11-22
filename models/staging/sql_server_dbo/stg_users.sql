with

source as (

    select * from {{ source('sql_server_dbo', 'users') }}

),

renamed as (

    select
        user_id::varchar(256),
        updated_at::timestamp_tz(9),
        address_id::varchar(256),
        last_name::varchar(256),
        created_at::timestamp_tz(9),
        phone_number::varchar(50),
        total_orders::number(38,0),
        first_name::varchar(256),
        email::varchar(256),
        _fivetran_deleted,
        _fivetran_synced as loaded_at

    from source

)

select * from renamed
