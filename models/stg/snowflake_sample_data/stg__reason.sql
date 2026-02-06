
with source as (

    select * 
    from {{ source('snowflake_sample_data', 'reason') }}

),

renamed as (

    select
        r_reason_sk,
        r_reason_id,
        r_reason_desc

    from source

)

select * from renamed