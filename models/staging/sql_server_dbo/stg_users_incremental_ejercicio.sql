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
        user_id,
        first_name,
        last_name,
        address_id,
        replace(phone_number, '-', '')::number AS phone_number,
        _fivetran_synced AS f_carga
    FROM stg_users_incremental
)

SELECT * FROM renamed_casted
