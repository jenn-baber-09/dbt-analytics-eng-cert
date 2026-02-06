{# -----------------------------------------------------------------------------
  Macro: compose_utc_timestamp 🕰️🌍
  Goal:
    Build a UTC timestamp from:
      - a DATE expression (from date_dim, e.g. d.D_DATE)
      - hour/minute/second expressions (from time_dim, e.g. t.T_HOUR, etc.)
    Converts from a source timezone -> UTC for consistency 😍

  Arguments (all should be SQL expressions / column references):
    date_expr   : date column/expression (DATE)
    hour_expr   : hour (0-23)
    minute_expr : minute (0-59)
    second_expr : second (0-59)
    source_tz   : IANA timezone name like 'America/Chicago' (default 'UTC')
                 (If your source is already UTC, leave as 'UTC' ✅)
----------------------------------------------------------------------------- #}
{% macro compose_utc_timestamp(date_expr, hour_expr, minute_expr, second_expr, source_tz='UTC') -%}

  {# ---- null safety 🧯
     If any required parts are null, return NULL rather than erroring or guessing.
  #}
  {%- set base_ts -%}
    
    {# 
        if something ends up NULL this is a problem 🔥🚒👨‍🚒
        but that's why we have data_tests 😇
    #}
    case
      when {{ date_expr }}   is null
        or {{ hour_expr }}   is null
        or {{ minute_expr }} is null
        or {{ second_expr }} is null
      then null
      else
        {# Snowflake: create a TIMESTAMP_NTZ from date + time parts 🧱 #}
        TIMESTAMP_NTZ_FROM_PARTS(
          {{ date_expr }},
          {{ hour_expr }},
          {{ minute_expr }},
          {{ second_expr }}
        )
    end
  {%- endset -%}

  {# ---- timezone handling 🌐
     Snowflake's CONVERT_TIMEZONE can convert a TIMESTAMP_NTZ if you supply source + target tz.
     We normalize everything to UTC 🎯
  #}
  {%- if source_tz | lower == 'utc' -%}

    {{ return(base_ts) }} {# return current if already in UTC #}

  {%- else -%}

    {# converts base_ts in UTC timezone before returning #}
    {{ return("CONVERT_TIMEZONE('" ~ source_tz ~ "', 'UTC', " ~ base_ts ~ ")") }}

  {%- endif -%}

{%- endmacro %}
