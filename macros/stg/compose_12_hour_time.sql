{%- macro compose_12_hour_time() -%}

t_hour || ':' || -- hour component
case 
    when len(t_minute) = 1 -- if single digit minute, pad with leading zero
    then '0' || t_minute 
    else t_minute 
end || 
t_am_pm -- append am/pm indicator

{%- endmacro -%}