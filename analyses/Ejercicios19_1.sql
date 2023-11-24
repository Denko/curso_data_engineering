--¿Cuántos usuarios tenemos?
select 
    count(*) 
from {{ ref('dim_customers')}}
where first_name is not null

--En promedio, ¿cuánto tiempo tarda un pedido desde que se realiza hasta que se entrega?
select
    avg(datediff(day, created_at_utc, delivered_at_utc))::number(10,2) as avg_diff_order_created_and_delivered
from {{ ref("dim_orders") }}
where created_at_utc is not null AND delivered_at_utc is not null

--¿Cuántos usuarios han realizado una sola compra? ¿Dos compras? ¿Tres o más compras?
with compras_usuario as (
    select
        user_id as usuarios,
        count(distinct(order_id)) total_compras
    from {{ ref("dim_orders") }}
    GROUP by 1
)
select
    case 
        when total_compras >= 3 then '3+'
        else total_compras::varchar
    end as total_compras,
        count(distinct usuarios) as users
from compras_usuario
GROUP BY 1
order by total_compras

--En promedio, ¿Cuántas sesiones únicas tenemos por hora?
select
    date_trunc('hour',created_at) as horas,
    count(distinct session_id) as sesiones_unicas
from {{ ref("fct_events") }}
group by horas
order by horas
