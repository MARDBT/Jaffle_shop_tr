  select
    order_id, 
    sum(order_total) as sum_order_total
from {{ ref('fct_orders') }}
group by 1
having sum_order_total < 0