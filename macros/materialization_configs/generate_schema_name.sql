{# 
  🧠✨ DEFAULT SCHEMA OVERRIDE ALERT ✨🧠
  This macro overrides dbt's built-in `generate_schema_name` macro, 
    which materialized in the target.schema for warehouse connection

  dbt calls this macro EVERY time it needs to decide
  what schema a model should be built into.
  (Yes, every model. No pressure. 🙈)
#}
{% macro generate_schema_name(custom_schema_name, node) -%}

  {# 
    🏷️ `custom_schema_name`:
      - comes from `+schema:` in dbt_project.yml or model config
      - example: +schema: staging

    📦 `node`:
      - metadata about the model being built (name, path, config, vibes)
      - we don't need it here, but dbt insists on passing it anyway
        ...but maybe it could be used to customize more attributes based on metadata 👀
  #}

  {# 
    🤔 CASE 1:
    If NO custom schema is configured for this model...
    (aka: no +schema defined, nothing fancy happening-- BUT IT'S WRONG ❌)
  #}
  {%- if custom_schema_name is none or target.name | lower == 'development' -%}

    {# 
      🏠 `target.schema`:
        - the default schema defined in:
          • profiles.yml (dbt Core)
          • OR dbt Cloud Environment connection settings
        - this keeps the default schema with the unique user prefix in dev 
        ‼️ PUBLIC is used in all Snowflake connections for this project, 
            so that's where it is coming from 😅

      Returning this means:
        👉 "Just build it in the default schema (PUBLIC) and move on."
        ‼️🚨 IF SOMETHING MATERIALIZES HERE, THAT IS WRONG 🚨‼️
    #}
    {{ return(target.schema) }}

  {# 
    💅 CASE 3:
    A custom schema *was* provided and NOT in dev
    (for example: +schema: staging — we love a clear intention 😇)
  #}
  {%- else -%}

    {# 
      ✂️ `custom_schema_name | trim`:
        - removes any accidental whitespace
        - returns ONLY the custom schema name, clean and unbothered

      🔥 This is the glow-up:
        👉 dbt will now build into `staging` (or whatever other custom schema name configured 🙃)
        🚫 NOT `public_staging`

      🧱 FYI:
      Default dbt behavior would normally do:
        target.schema + '_' + custom_schema_name
      which is how we ended up with `public_staging` in the first place 🙃
    #}
    {{ return(custom_schema_name | trim) }}

  {%- endif -%}

{# 
  🎬 End of macro
  dbt schema chaos: resolved.

  🧐 A good test after running would be to check the count() of tables/views 
     materialized in the PUBLIC schema post-dbt run-- this would let the eng know
     that a materialization has gone wrong, and they need to look at the config of 
     the underlying model related to that materialized object 👀
#}
{%- endmacro %}
