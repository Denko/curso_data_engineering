with customers as (

    select * from {{ ref('users_snapshot')}}

),

orders as (

    select * from {{ ref('stg_orders') }}

),

addresses as (

    select * from {{ ref('dim_addresses') }}

),

dates as (

    select * from {{ ref('dim_dates') }}

),

customer_orders as (

    select
        user_id,

        min(created_at_utc) as first_order_date,
        max(created_at_utc) as most_recent_order_date,
        count(order_id) as number_of_orders,
        sum(order_total_usd) as user_total_cost_usd,
        avg(order_total_usd)::number(24,2) as user_avg_order_cost_usd

    from orders

    group by 1

),

final as (

    select
        customers.user_id as customer_id,
        customers.first_name,
        customers.last_name,
        customers.phone_number,
        customers.email,
        customer_orders.first_order_date::date as first_order_date,
        customer_orders.most_recent_order_date::date as most_recent_order_date,
        coalesce(customer_orders.number_of_orders, 0) as number_of_orders,
        coalesce(customer_orders.user_total_cost_usd, 0) as user_total_cost_usd,
        coalesce(user_avg_order_cost_usd, 0) as user_avg_order_cost_usd

    from customers

    left join customer_orders using (user_id)
    order by user_total_cost_usd desc

)

select * from final