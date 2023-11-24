with customers as (

    select * from {{ ref('stg_users')}}

),

orders as (

    select * from {{ ref('stg_orders') }}

),

customer_orders as (

    select
        user_id,

        min(created_at_utc) as first_order_date,
        max(created_at_utc) as most_recent_order_date,
        count(order_id) as number_of_orders

    from orders

    group by 1

),


final as (

    select
        customers.user_id as customer_id,
        customers.first_name,
        customers.last_name,
        customer_orders.first_order_date::date as first_order_date,
        customer_orders.most_recent_order_date::date as most_recent_order_date,
        coalesce(customer_orders.number_of_orders, 0) as number_of_orders

    from customers

    left join customer_orders using (user_id)

)

select * from final