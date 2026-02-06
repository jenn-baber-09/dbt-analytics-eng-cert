{# =============================================================================
  generate_alias_name ✂️🧼

  purpose:
    strip layer prefixes so relations are clean.
    ex: stg__store_sales -> store_sales ✅

  prefixes stripped (first match wins):
    - seed__
    - src__
    - stg__

  notes 📝
    - if a model explicitly sets `alias`, dbt uses it. (we still normalize it.)
    - dbt calls this automatically when building models.
============================================================================= #}
{% macro generate_alias_name(custom_alias_name, node) -%}

    {%- set debug = flags.DEBUG -%}

    {%- if custom_alias_name -%}
        
        {%- if debug -%}
            {{ log("Custom alias configured: " ~ custom_alias_name, info=true) }}
        {%- endif -%}

        {{ return(custom_alias_name | trim) }}


    {%- else -%}
    
        {%- set cleaned_name = node.name -%}
        {%- set prefixes = ['seed__', 'src__', 'stg__'] -%}

        {%- for p in prefixes -%}

            {%- if cleaned_name.startswith(p) -%}
                {%- set cleaned_name = cleaned_name[p | length:] -%}
                {%- if debug -%}
                    {{ log("stripped prefix '" ~ p ~ "' → returning " ~ cleaned_name, info=true) }}
                {%- endif -%}

                {{ return(cleaned_name | trim) }}

            {%- endif -%}
            
            {%- if debug -%}
                {{ log("no prefix '" ~ p ~ "' found in " ~ cleaned_name ~ " → checking next prefix")}}
            {%- endif -%}

        {%- endfor -%}
        
        {%- if debug -%}
            {{ log("No prefixes found-- returning model name") }}
        {%- endif -%}
        
        {{ return(node.name) }}

    {%- endif -%}

{%- endmacro %}
