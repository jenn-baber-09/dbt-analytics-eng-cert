{# =============================================================================
  generate_base_model ⚡

  Purpose:
    Generates starter SQL for a base / staging model from a dbt source.
    Output is printed at compile time — copy/paste it into a model and refactor.

  How to use (dbt Cloud IDE):
    1. Ensure the source table exists in sources.yml
    2. Paste the macro call into a statement tab or analysis file
    3. HIGHLIGHT the entire macro call before compiling (important!)
    4. Compile → copy the generated SQL → paste into a model file

  Required args:
    - source_name     : dbt source name
    - table_name      : source table name

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
