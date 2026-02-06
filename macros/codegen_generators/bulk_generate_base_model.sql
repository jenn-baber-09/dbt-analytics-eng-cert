{# =============================================================================
  bulk base model generator ⚡🧱

  purpose:
    generates starter sql for multiple base / staging models from a dbt source
    using dbt-labs/codegen’s generate_base_model macro.
    output is printed at compile time — copy/paste each block into its own model.

  how to use (dbt cloud ide) ☁️🖱️
    1) ensure the source + tables exist in sources.yml ✅
    2) open this macro file, edit the two vars below:
         - source_name
         - table_list
    3) paste this macro call into a statement tab or an analysis file:
         {{ bulk_generate_base_models() }}
    4) highlight all code inside the macro before compiling 🔦 (important!)
        ⚠️ if you just select-all, you will get a blank output ⚠️
    5) compile → copy each generated sql block → paste into separate model files 🧱✨

  ❌ ignore args (do not use) 🙅‍♀️
    ‼️👇 materializations are controlled in dbt_project.yml only 👇‼️
    - materialized
    - leading_commas        👈 against the styleguide 😏
    - case_sensitive_cols   👈 keep it lowercase + pretty 😌

  💡 PRO TIP: generate table_list fast (snowflake) ❄️
    run this to get a copy/paste-ready list of quoted lowercase table names:

    select listagg('''' || lower(table_name) || '''', ', ')
    from <source_database_name>.information_schema.tables
    where table_schema = '<source_schema_name>';

    then paste the output between the [ ... ] below ✅
============================================================================= #}
{% macro bulk_generate_base_models() -%}

  {# --------------------------------------------------------------------------
    👇 EDIT SOURCE INFO HERE ✍️🧠
    set the source and table values explicitly in this macro file.
  -------------------------------------------------------------------------- #}
    {%- set source_name = "snowflake_sample_data" -%}
    {%- set table_list = [
        "promotion",
        "warehouse",
        "income_band",
        "web_page",
        "web_sales",
        "time_dim",
        "catalog_returns",
        "reason",
        "date_dim",
        "inventory",
        "item",
        "store",
        "store_returns",
        "household_demographics",
        "catalog_page",
        "store_sales",
        "customer_demographics",
        "catalog_sales",
        "call_center",
        "web_site",
        "customer_address",
        "ship_mode",
        "customer",
        "web_returns",
    ] -%}

    {#- - 🖐️🛑 END MANUAL EDITS --#}

    
    {# guardrails 🧯 #}
    {%- if table_list is string -%}
        {{
            exceptions.raise_compiler_error(
                "table_list must be a list of strings (ex: ['customers','orders']), not a single string 🫠"
            )
        }}
    {%- endif -%}

    {%- if table_list is not iterable -%}
        {{
            exceptions.raise_compiler_error(
                "table_list must be iterable (a list/tuple) of table names 🧠"
            )
        }}
    {%- endif -%}

    {# loop through tables and print a labeled block for each one 🧱✨ #}
    {%- for table in table_list -%}

        -- =====================================================================
        -- generated base model for: {{ source_name }}.{{ table }} 🧱⚡
        -- suggested file: models/staging/<domain>/stg__{{ table | lower }}.sql
        -- =====================================================================
        {{
            codegen.generate_base_model(
                source_name=source_name, table_name=table | lower
            )
        }}

    {%- endfor -%}

{%- endmacro %}
