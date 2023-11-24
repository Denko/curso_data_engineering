WITH src_addresses AS (
    SELECT *
    FROM {{ ref('stg_addresses') }}
),


-- POR HACER-- número de pedidos por estado, gasto total por estado, media de gasto por estado o demás (en tabla intermedia orders_addresses)
renamed_casted AS (
    SELECT
        address_id,
        zipcode,
        country,
        address,
        state
    FROM src_addresses
)

SELECT * FROM renamed_casted