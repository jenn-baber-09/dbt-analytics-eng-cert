{%- macro fetch_last_update_date() -%}
    {% set last_update_date = none %}

    {% if execute %}
        {% set result = run_query(
            "select coalesce(max(dbt_created_at), '1900-01-01 00:00:00'::timestamp) as last_update_date from " ~ this
        ) %}

        {% if result and result.rows | length > 0 %}
            {% set last_update_date = result.rows[0][0] %}
        {% endif %}
    {% endif %}

    return {{ last_update_date }}

{%- endmacro -%}