WITH stg_orders AS (
    SELECT *
    FROM {{ ref('stg_orders') }}
),

renamed_casted AS (
    SELECT
        {{ dbt_utils.generate_surrogate_key(['shipping_service']) }} AS shipping_service_id,
        shipping_service AS shipping_service_name,
        count(shipping_service_id) as total_orders_service,
        avg(shipping_cost_usd) as average_shipping_cost_usd
        -- average between an order created and delivered
        -- avg_shipping_time_gap
FROM stg_orders
WHERE shipping_cost_usd is not null
GROUP BY shipping_service_id, shipping_service_name
ORDER BY total_orders_service DESC
)

SELECT * FROM renamed_casted
