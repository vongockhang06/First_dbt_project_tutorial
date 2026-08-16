{# This Jinja code generate SELECT statements to print numbers from 0 to 9 #}
{% set max_no=10 %}
{% for i in range(max_no) %}
    SELECT {{ i }} AS number
    {% if not loop.last %}
        UNION 
    {% endif %}
{% endfor %}
