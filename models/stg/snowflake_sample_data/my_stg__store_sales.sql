{%- if is_incremental() -%}

    -- macro that materializes the max(dbt_updated_at) from the target table
    -- to use in is_incremental() filtering below 
    {{ fetch_last_update_date() }}

{%- endif -%}


select
       -- creating PK and watermark columns for incremental model
       -- https://github.com/dbt-labs/dbt-utils#generate_surrogate_key-source

       {{ dbt_utils.generate_surrogate_key([
            'ss_sold_date_sk',
            'ss_sold_time_sk',
            'ss_item_sk',
            'ss_customer_sk',
            'ss_ticket_number'
        ]) }} as merge_key,       
       {{ watermark_date_create() }},

        -- adding categorical indicator to tell origin of sale record
        -- options: 'Catalog', 'Store', 'Web'
       'Store' as sale_origin, 

       -- compiled sold_datetime TIMESTAMP_NTZ for better
       -- datetime comparisons across data-- using dimensions
       -- from both date_dim and time_dim table as parameters 
       {{ compose_utc_timestamp(
            date_dim.d_date, 
            time_dim.t_hour, 
            time_dim.t_minute, 
            time_dim.t_second, 
            source_tz='UTC'
            ) 
        }}  as sold_datetime, 

       ss_item_sk as item_sk,
       ss_customer_sk as customer_sk,
       ss_cdemo_sk as cdemo_sk,

       -- full customer address generation, cust_address as table alias
       {{ compose_addresses('customer', 'cust_address') }},

       ss_store_sk as store_sk,
       ss_promo_sk as promo_sk,
       ss_ticket_number as ticket_number,
       ss_quantity as quantity,
       ss_wholesale_cost as wholesale_cost,
       ss_list_price as list_price,
       ss_sales_price as sales_price,
       ss_ext_discount_amt as ext_discount_amt,
       ss_ext_sales_price as ext_sales_price,
       ss_ext_wholesale_cost as ext_wholesale_cost,
       ss_ext_list_price as ext_list_price,
       ss_ext_tax as ext_tax,
       ss_coupon_amt ss_coupon_amt,
       ss_net_paid as net_paid,
       ss_net_paid_inc_tax as net_paid_inc_tax,
       ss_net_profit as net_profit

from {{ source('snowflake_sample_data', 'store_sales') }} 

-- replacing date / time skews with actual date / time values
left join {{ source('snowflake_sample_data', 'date_dim') }} as date_dim 
    on ss_sold_date_sk = date_dim.d_date_sk 
left join {{ source('snowflake_sample_data', 'time_dim') }} as time_dim 
    on ss_sold_time_sk = time_dim.t_time_sk

-- replacing customer address skews with actual address values
left join {{ source('snowflake_sample_data', 'customer_address') }} as cust_address
    on ss_addr_sk = cust_address.ca_address_sk

{% if is_incremental() %}

    -- filter for new or updated records only 
    where dbt_updated_at > {{ last_update_date }} 

{% endif %}