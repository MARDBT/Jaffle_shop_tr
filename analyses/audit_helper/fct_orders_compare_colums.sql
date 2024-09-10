{# in dbt Develop #}


{% set old_fct_orders_query %}
select order_id
,concat(
LOCATION_ID
,'//',CUSTOMER_ID
,'//',SUBTOTAL_CENTS
,'//',TAX_PAID_CENTS
,'//',ORDER_TOTAL_CENTS
,'//',SUBTOTAL
,'//',TAX_PAID
,'//',ORDER_TOTAL
,'//',ORDERED_AT
,'//',ORDER_COST
,'//',ORDER_ITEMS_SUBTOTAL
,'//',COUNT_FOOD_ITEMS
,'//',COUNT_DRINK_ITEMS
,'//',COUNT_ORDER_ITEMS
,'//',IS_FOOD_ORDER
,'//',IS_DRINK_ORDER
,'//',CUSTOMER_ORDER_NUMBER) AS concat_columns
from {{ ref('fct_orders_deprecated') }}
{% endset %}


{% set new_fct_orders_query %}
select order_id
,concat(
LOCATION_ID
,'//',CUSTOMER_ID
,'//',SUBTOTAL_CENTS
,'//',TAX_PAID_CENTS
,'//',ORDER_TOTAL_CENTS
,'//',SUBTOTAL
,'//',TAX_PAID
,'//',ORDER_TOTAL
,'//',ORDERED_AT
,'//',ORDER_COST
,'//',ORDER_ITEMS_SUBTOTAL
,'//',COUNT_FOOD_ITEMS
,'//',COUNT_DRINK_ITEMS
,'//',COUNT_ORDER_ITEMS
,'//',IS_FOOD_ORDER
,'//',IS_DRINK_ORDER
,'//',CUSTOMER_ORDER_NUMBER) AS concat_columns
from {{ ref('fct_orders') }}
{% endset %}


{% set audit_query = audit_helper.compare_column_values(
    a_query=old_fct_orders_query,
    b_query=new_fct_orders_query,
    primary_key="order_id",
    column_to_compare="concat_columns"
) %}

{% set audit_results = run_query(audit_query) %}


{% if execute %}
    {% do audit_results.print_table() %}
{% endif %}