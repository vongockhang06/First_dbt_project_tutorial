{% macro  find_rev_cost_profit(table) %}
WITH aggregated_sales AS (
    SELECT
        sales_date,
        SUM(quantity_sold * unit_sell_price) AS total_revenue,
        SUM(quantity_sold * unit_purchase_cost) AS total_cost
    FROM {{ source('training', table) }}
    GROUP BY sales_date
)
SELECT
    sales_date,
    total_revenue,
    total_cost,
    (total_revenue - total_cost) AS profit
FROM aggregated_sales
{% endmacro %}