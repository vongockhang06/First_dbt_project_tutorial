{% snapshot snapshot_name %}
---1.config
{{
    config(
        target_schema='L3_CONSUMPTION',
        unique_key='CUSTOMERID',
        strategy='timestamp',
        updated_at='Updated_at'
        ---invalidate_hard_deletes=False by default
        --- This one ontrols how dbt reacts 
        --- when a record is completely deleted from the source table.
        --- When false, if a row is deleted from source table,
        ---dbt ignores the deletion and keeps the existing row active in your snapshot table
        --- When true, dbt detects that the primary key no longer exists in the source and "closes out" 
        ---the record by setting dbt_valid_to to the current snapshot execution timestamp
    )
}}
---2. Our model
SELECT * FROM {{ source('landing','cust') }}

{%endsnapshot%}