{%set
    expected_count ={
        'cust': 50,
        'employees': 20,
        'stores': 10,
        'suppliers': 5,
        'products': 100,
        'orderitems': 1000,
        'orders': 200
    }
%}
{%for table, count in expected_count.items()%}
    SELECT 
        '{{table}}' AS table_name,
        {{count}} AS expect_count,
        COUNT(*)  AS record_count
    FROM {{ source('landing',table) }}
    HAVING COUNT(*) < {{count}}
    {%if not loop.last %}
    UNION ALL
    {% endif %}
{% endfor %}