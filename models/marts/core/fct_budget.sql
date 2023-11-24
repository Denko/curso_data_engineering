WITH budget AS (
    SELECT *
    FROM {{ ref('budget_snapshot') }}

),

products AS (

    SELECT *
    FROM {{ ref('dim_products') }}

),

dates AS (

    SELECT *
    FROM {{ ref('dim_dates') }}

),
 -- POR HACER
renamed_casted AS (
    SELECT
        budget_id,
        product_id,
        quantity,
        budget_date
        -- meter el campo mes-año y y año de la dim_dates
    FROM budget
)

SELECT * FROM renamed_casted