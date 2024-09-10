{{ config(  enabled = true,severity = 'warn') }}

  select
    order_id, 
  order_total,
from {{ ref('fct_orders') }}
where order_total > 99