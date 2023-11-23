WITH users AS (
    SELECT *
    FROM {{ source('sql_server_dbo','users') }}
),

renamed_casted AS (
    SELECT
        user_id,
        updated_at,
        address_id,
        last_name,
        created_at,
        phone_number,
        total_orders,
        first_name,
        email,
        _fivetran_deleted,
        _fivetran_synced
    FROM users
)

SELECT * FROM renamed_casted
union all
-- Code 9999 for no user and today date for loading
select {{ dbt_utils.generate_surrogate_key('9999') }},
        current_timestamp(),
        {{ dbt_utils.generate_surrogate_key('9999') }},
        null, 
        current_timestamp(), 
        null,
        null,
        null,
        null,
        null,
        null