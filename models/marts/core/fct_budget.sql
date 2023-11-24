WITH stg_budget AS (
    SELECT *
    FROM {{ ref('budget_snapshot') }}

),

products AS (

    SELECT *
    FROM {{ ref('dim_products') }}

),
 -- POR HACER
renamed_casted AS (
    SELECT
        {{dbt_utils.generate_surrogate_key(['_row'])}} AS budget_id,
        product_id,
        quantity,
        month,
        _fivetran_synced AS loaded_at
    FROM stg_budget
)

SELECT * FROM renamed_casted