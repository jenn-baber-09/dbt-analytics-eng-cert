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
       
       -- descriptive date values for readability
       sold_date_dim.d_date as ss_sold_date,
       {{ compose_12_hour_time() }} as ss_sold_time, 

       ss_item_sk,
       ss_customer_sk,
       ss_cdemo_sk,

       -- full customer address generation, cust_address as table alias
       {{ compose_addresses('customer', 'cust_address') }},

       ss_store_sk,
       ss_promo_sk,
       ss_ticket_number,
       ss_quantity,
       ss_wholesale_cost,
       ss_list_price,
       ss_sales_price,
       ss_ext_discount_amt,
       ss_ext_sales_price,
       ss_ext_wholesale_cost,
       ss_ext_list_price,
       ss_ext_tax,
       ss_coupon_amt,
       ss_net_paid,
       ss_net_paid_inc_tax,
       ss_net_profit

from {{ source('snowflake_sample_data', 'store_sales') }} 

-- replacing date / time skews with actual date / time values
left join {{ source('snowflake_sample_data', 'date_dim') }} as sold_date_dim 
    on ss_sold_date_sk = sold_date_dim.d_date_sk 
left join {{ source('snowflake_sample_data', 'time_dim') }} as sold_time_dim 
    on ss_sold_time_sk = sold_time_dim.t_time_sk

-- replacing customer address skews with actual address values
left join {{ source('snowflake_sample_data', 'customer_address') }} as cust_address
    on ss_addr_sk = cust_address.ca_address_sk

{% if is_incremental() %}

    -- filter for new or updated records only 
    where dbt_created_at > {{ last_update_date }} 
        or dbt_updated_at > {{ last_update_date }} 

{% endif %}