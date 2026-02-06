
with source as (

    select * 
    from {{ source('snowflake_sample_data', 'income_band') }}

),

renamed as (

    select
        ib_income_band_sk,
        ib_lower_bound,
        ib_upper_bound

    from source

)

select * from renamed