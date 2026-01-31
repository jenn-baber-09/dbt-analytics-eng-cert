{%- macro compose_addresses(object, table_alias) -%}

    {%- if object.lower().strip() == 'store' -%}
        {%- set column_prefix = 's' -%}

    {%- elif object.lower().strip() == 'customer' -%}
        {%- set column_prefix = 'ca' -%}

    {%- elif object.lower().strip() == 'warehouse' -%}
        {%- set column_prefix = 'w' -%}

    {%- else -%}
        {%- do exceptions.raise_compiler_error("Unsupported object type for compose_addresses macro: " ~ object) -%}

    {%- endif -%}

    {{table_alias}}.{{ column_prefix }}_street_number || ' ' ||
            {{table_alias}}.{{ column_prefix }}_street_name || ' ' ||
            {{table_alias}}.{{ column_prefix }}_street_type || ' ' ||
            {{table_alias}}.{{ column_prefix }}_suite_number || ', ' ||
            {{table_alias}}.{{ column_prefix }}_city || ', ' ||
            {{table_alias}}.{{ column_prefix }}_state || ' ' ||
            {{table_alias}}.{{ column_prefix }}_zip || ' ' ||
            {{table_alias}}.{{ column_prefix }}_country
    as {{ object.lower() }}_full_address 

{%- endmacro -%}