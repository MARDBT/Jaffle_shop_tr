{# in dbt Develop #}


{% set old_fct_orders_query %}
select *
from {{ ref('fct_orders_deprecated') }}
{% endset %}


{% set new_fct_orders_query %}
select *
from {{ ref('fct_orders') }}
{% endset %}


{{ audit_helper.compare_queries(
    a_query=old_fct_orders_query,
    b_query=new_fct_orders_query,
    primary_key=["id_order"]
) }}

-- consultar: select * from MARUIZ_BRONZE_DB.DBT_CORE.fct_orders_compare;