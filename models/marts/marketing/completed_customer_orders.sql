{{
    config(
        materialized='view'
    )
}}


with orders as (
    select * from {{ ref('stg_jaffle_shop__orders') }}
)
,
customers as(
    select * from {{ ref('stg_jaffle_shop__customer') }}
)

select 
    first_name
    , last_name
    , count(distinct order_id) as completed_orders
    from customers
    join orders using(customer_id)
    where orders.status = 'completed'
    group by 1,2