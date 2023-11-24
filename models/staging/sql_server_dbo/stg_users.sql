{{ config(
    materialized='incremental',
    unique_key = 'user_id'
    ) 
    }}


WITH stg_users_incremental AS (
    SELECT *
    FROM {{ ref('base_users') }}
    {% if is_incremental() %}

        WHERE _fivetran_synced > (SELECT max(loaded_at) FROM {{ this }})

    {% endif %}
),

renamed_casted AS (
    SELECT
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
    FROM stg_users_incremental
)

SELECT * FROM renamed_casted


