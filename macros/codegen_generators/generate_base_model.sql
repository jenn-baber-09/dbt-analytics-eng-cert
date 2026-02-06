{# =============================================================================
  generate_base_model ⚡

  Purpose:
    Generates starter SQL for a base / staging model from a dbt source.
    Output is printed at compile time — copy/paste it into a model and refactor.
  
  💡 PRO TIP: if you need to generate a LOT of new models, check out `bulk_generate_base_model.sql` 😉

  How to use (dbt Cloud IDE):
    1. Ensure the source table exists in sources.yml
    2. Paste the macro call into a statement tab or analysis file
    3. HIGHLIGHT the entire macro call before compiling (important!)
    4. Compile → copy the generated SQL → paste into a model file

  Required args:
    - source_name     : dbt source name
    - table_name      : source table name

  ❌ Ignore args (DO NOT USE):
    ‼️👇 materializations are controlled in dbt_project.yml ONLY 👇‼️
    - materialized         (table | view | incremental | etc.)
    - leading_commas       (default=false) 👈 leading commas are against the styleguide 😏
    - case_sensitive_cols  (default=false) 👈 lowercase output follows the styleguide 😏

  Example:
    {{ codegen.generate_base_model(
        source_name='<database>',
        table_name='<table>'
    ) }}

  Alternative (CLI):
    dbt run-operation generate_base_model --args '{
      "source_name": "<database>",
      "table_name": "<table_name>"
    }'
============================================================================= #}

{{ codegen.generate_base_model(
    source_name='snowflake_sample_data',
    table_name='store_sales'

) }}
