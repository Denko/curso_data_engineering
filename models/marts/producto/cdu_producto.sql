with
users as (
    select * from {{ ref("dim_customers") }}
),

events as (
    select * from {{ ref("fct_events") }}
),

renamed as (
    
    select
        e.session_id,
        u.customer_id,
        u.first_name,
        u.last_name,
        u.phone_number,
        u.email,
        min(created_at) as start_sesion,
        max(created_at) as end_sesion,
        datediff(minute, min(created_at), max(created_at))::number(10,0) as sesion_duration_minutes,
        count(page_url) as pages_views,
        sum(case when e.event_type = 'checkout' then 1 end) as checkout_amount,
        sum(case when e.event_type = 'package_shipped' then 1 end) as package_shipped_amount,
        sum(case when e.event_type = 'add_to_cart' then 1 end) as add_to_cart_amount,
        sum(case when e.event_type = 'page_view' then 1 end) as page_view_amount
        
    from events as e
    inner join
    users as u
    on e.user_id = u.customer_id
    group by
            e.session_id,
            u.customer_id,
            u.first_name,
            u.last_name,
            u.phone_number,
            u.email
)

select * from renamed