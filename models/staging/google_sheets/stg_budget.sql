{{ config(
    materialized='incremental',
    unique_key = 'budget_id',
    on_schema_change='fail'
    ) 
    }}


WITH stg_budget_products AS (
    SELECT *
    FROM {{ source('google_sheets','budget') }}
    {% if is_incremental() %}

        WHERE _fivetran_synced > (SELECT max(loaded_at) FROM {{ this }})

    {% endif %}
),

renamed_casted AS (
    SELECT
        {{dbt_utils.generate_surrogate_key(['_row'])}} AS budget_id,
        product_id,
        quantity,
        month,
        _fivetran_synced AS loaded_at
    FROM stg_budget_products
)

SELECT * FROM renamed_casted