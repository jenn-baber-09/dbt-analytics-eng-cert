{# =============================================================================
  generate_alias_name ✂️🧼

  purpose:
    remove common layer prefixes from model names so database objects look clean.
    ex: stg__store_sales -> store_sales ✅

  prefixes stripped (first match wins):
    - src__ : sources
    - stg__ : staging 
    - seed__ : seeds 

  notes 📝
    - if a model explicitly sets `alias`, dbt will use that value instead.
      (this macro respects explicit aliases.) 
    - dbt calls generate_alias_name automatically when building models.
============================================================================= #}
{% macro generate_alias_name(custom_alias_name, node) -%}

    {# if the engineer explicitly set alias=..., use it as-is 🎯 #}
    {%- if custom_alias_name is not none -%}
        {{ return(custom_alias_name | trim | lower) }}
    
    {%- endif -%}

    {# base name starts as the model's file-based name 🧱 #}
    {%- set raw_name = node.name | lower -%}

    {# strip known prefixes ✂️ #}
    {%- set prefixes = ["seed__", "src__", "stg__"] -%}
    {%- set cleaned_name = raw_name -%}

    {%- for p in prefixes -%}
        {%- if cleaned_name.startswith(p) -%}
            {%- set cleaned_name = cleaned_name[p | length :] -%} 

            {%- break -%}

        {%- endif -%}
        
    {%- endfor -%}

    {# 
        optional: preserve dbt's version suffixing for versioned models 🧪
        dbt's default logic for versioned models is encoded in generate_alias_name. :contentReference[oaicite:3]{index=3}
    #}
    {%- if node.version is not none -%} 
        {{ return(cleaned_name ~ "_v" ~ node.version) }}

    {%- else -%} 
        {{ return(cleaned_name) }}

    {%- endif -%}

{%- endmacro %}
