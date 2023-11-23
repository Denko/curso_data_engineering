WITH src_addresses AS (
    SELECT *
    FROM {{ source('sql_server_dbo', 'addresses') }}
),

-- Ejemplo con casteo aunque no es necesario en este caso porque los campos vienen ya con buen formato
renamed_casted AS (
    SELECT
        address_id::varchar(50) as address_id,
        zipcode::number(38, 0) as zipcode,
        country::varchar(50) as country,
        address::varchar(150) as address,
        state::varchar(50) as state,
        _fivetran_deleted,
        _fivetran_synced AS loaded_at
    FROM src_addresses
)

SELECT * FROM renamed_casted
union all
-- Code 9999 for no address and today date for loading
select {{ dbt_utils.generate_surrogate_key('9999') }},null,null,null,null,null,current_timestamp()
