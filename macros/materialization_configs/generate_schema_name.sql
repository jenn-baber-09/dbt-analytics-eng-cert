{% macro generate_schema_name(custom_schema_name, node) -%}
    
    {# capture dbt's global debug flag 🔍 #}
    {%- set debug = flags.DEBUG -%}

    {# normalize inputs: treat whitespace-only as missing 🧽 #}
    {%- set custom = custom_schema_name | trim if custom_schema_name is not none else none -%}
    {%- set env = target.name | lower -%}

    {%- if debug -%}
        {{ log("target.name: " ~ env) }}
        {{ log("custom_schema_name: " ~ custom) }}
    {% endif %}

    {# case 1️⃣: no custom schema provided → fail fast 💥 #}
    {%- if custom is none or custom == "" -%}
        {%- do exceptions.raise_compiler_error(
            "missing +schema config for node '" ~ node.unique_id ~
            "' (name='" ~ node.name ~ "', path='" ~ node.original_file_path ~ "'). " ~
            "set +schema in dbt_project.yml or via {{ config(schema='...') }}."
        ) -%}
    {%- endif -%}

    {# case 2️⃣: dev-only → use dbt default: <target.schema>_<custom_schema> 👷‍♀️ #}
    {%- if env in ["dev", "development"] -%}

        {%- if debug -%}
            {{ log("compiled custom schema for dev: " ~ target.schema ~ "_" ~ custom) }}
        {% endif %}

        {{ return(target.schema ~ "_" ~ custom) }}
    {%- endif -%}

    {# case 3️⃣: non-dev → keep it clean 🏭 #}
    
    {%- if debug -%}
        {{ log("returning custom schema in non-dev env: " ~ custom) }}
    {% endif %}

    {{ return(custom) }}

{%- endmacro -%}
