{{ config(  enabled = true) }}

select
    customer_id, 
    avg(order_total) as average_amount
from {{ ref('fct_orders') }}
group by 1
having count(customer_id) > 1 and average_amount < 1