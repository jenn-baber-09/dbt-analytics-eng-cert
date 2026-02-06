{%- macro watermark_date_create() -%}

    -- creating watermark columns for incremental model
    -- making sure it is in timestamp format for appropriate 
    -- microbatching/incremental builds 
    current_date::timestamp as dbt_created_at, 
    current_date::timestamp as dbt_updated_at

{%- endmacro -%}
