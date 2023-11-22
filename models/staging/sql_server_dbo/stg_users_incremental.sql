{{ config(
    materialized='incremental',
    unique_key = 'user_id'
    ) 
    }}


WITH stg_users_incremental AS (
    SELECT *
    FROM {{ source('sql_server_dbo','users') }}
    {% if is_incremental() %}

        WHERE _fivetran_synced > (SELECT max(f_carga) FROM {{ this }})

    {% endif %}
),

renamed_casted AS (
    SELECT
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
    FROM stg_users_incremental
)

SELECT * FROM renamed_casted
