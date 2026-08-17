{% macro generate_schema_name(custom_schema_name, node) -%}
   
    {%- set default_schema = target.schema -%}
	
    {%- if custom_schema_name is none -%}
        {{ default_schema }}
		
    {%- else -%}
        {{ custom_schema_name | trim }}
    {%- endif -%}
	
{%- endmacro %}
---By default (without this schema), when we define custom schema in dbt_project.yml
--- it will create like this: target_schema + '_' + custom schema
--- So the name of my custom schema if I dont have this macro is 
--- L1.Landing_L2.Process

--- Why dbt know to use this macro among many macros without explicitly calling it?
--- generate_schema_name is the name of internal built-in function 
--- dbt is hardcoded to look for a macro with that exact name 
--- every single time it compiles a model relation.

--- What is node?
-- In dbt macros, the node parameter represents a dictionary object containing 
-- all the metadata for the specific resource (model, seed, snapshot, or test) 
-- that dbt is currently processing.
-- When dbt runs, it parses your project and creates a DAG (Directed Acyclic Graph) 
-- where every single item is represented as a node.