WITH src_budget_products AS (
    SELECT *
    FROM {{ source('google_sheets', 'budget') }}
),

renamed_casted AS (
    SELECT
        {{dbt_utils.generate_surrogate_key(['_row'])}} AS budget_id,
        product_id,
        quantity,
        month,
        _fivetran_synced AS loaded_at
    FROM src_budget_products
)

SELECT * FROM renamed_casted
