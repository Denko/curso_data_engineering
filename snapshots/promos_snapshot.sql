{% snapshot promos_snapshot %}

{{
    config(
      target_schema='snapshots',
      unique_key='promo_id',
      strategy='check',
      check_cols=['promo_discount'],
      invalid_hard_delete=True 
    )
}}
-- Invalid hard delete hace un borrado lógico pero no se borran. se usa para mantener los datos en el histórico aunque no lleguen al snapshot 
select * from {{ ref('stg_promos') }}
WHERE loaded_at = (SELECT max(loaded_at) FROM {{ ref('stg_promos') }}) -- Hace que el snapshot sea incremental.
-- De la tabla de origen coja los registros cuya fecha de carga sea la máxima de la subconsulta(el stg incremental).


{% endsnapshot %}