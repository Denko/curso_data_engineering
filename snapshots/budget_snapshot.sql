{% snapshot budget_snapshot %}

{{
    config(
      target_schema='snapshots',
      unique_key='_row',
      strategy='timestamp',
      updated_at='_fivetran_synced',
      invalid_hard_delete=True
    )
}}

select * from {{ source('google_sheets', 'budget') }}

{% endsnapshot %}