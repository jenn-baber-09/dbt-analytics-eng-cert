{%- macro watermark_date_create() -%}

    -- creating watermark columns for incremental model
    current_date as dbt_created_at, 
    current_date as dbt_updated_at

{%- endmacro -%}
