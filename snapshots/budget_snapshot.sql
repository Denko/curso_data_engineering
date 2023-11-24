{% snapshot budget_snapshot %}

{{
    config(
      target_schema='snapshots',
      unique_key='budget_id',
      strategy='timestamp',
      updated_at='loaded_at',
      invalid_hard_delete=True
    )
}}

select * from {{ ref('stg_budget') }}
WHERE loaded_at = (SELECT max(loaded_at) FROM {{ ref('stg_budget') }}) -- Hace que el snapshot sea incremental.

{% endsnapshot %}