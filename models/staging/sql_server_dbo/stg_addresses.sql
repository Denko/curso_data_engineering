
WITH src_addresses AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'addresses') }}
    ),
-- Ejemplo con casteo aunque no es necesario en este caso porque los campos vienen ya con buen formato
renamed_casted AS (
    SELECT
        address_id::varchar(50),
        zipcode::number(38,0),
        country::varchar(50),
        address::varchar(150),
        state::varchar(50),
        _fivetran_deleted,
        _fivetran_synced AS date_load
    FROM src_addresses
    )

SELECT * FROM renamed_casted

