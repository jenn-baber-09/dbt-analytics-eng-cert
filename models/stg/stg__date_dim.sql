with source as (

    select * 
    from {{ source('snowflake_sample_data', 'date_dim') }}

),

renamed as (

    select
        d_date_sk as date_sk, -- random unique key <> numeric representation of d_date 😮‍💨
        d_date_id as date_id,

        d_date as date, -- 'YYYY-MM-DD' date used to create dateparts throughout model
                        -- this is used as the relative "source of truth" for transformations

        -- index values can be used to plot date parts 
        -- sequentially easily overtime in visualizations
        -- ⚠️ does NOT represent the numeric value of the date part, 
        -- but the order relative to all dates in the dataset 
        d_month_seq as month_index,
        d_week_seq as week_index,
        d_quarter_seq as quarter_index,

        d_year as year,
        dayofyear(d_date) as day_of_year,
        d_dow as day_of_week,
        d_moy as month,
        d_dom as day_of_month,
        d_qoy as quarter,
        d_fy_year as fiscal_year,
        d_fy_quarter_seq as fiscal_quarter_number,
        d_fy_week_seq as fiscal_week_number,
        d_day_name as day_name,
        'Q' || d_qoy || '-' || d_year as quarter_name, -- formats as 'Q1-2023'

        -- datatype string -> boolean for Y/N columns
        -- these fields have both values, so just 
        -- setting Y = true, N = false 
        case 
            when d_holiday = 'Y'
            then true 
            else false 
        end as is_holiday, -- 👈 add `is_` in front of bool column to follow styleguide 😏
        case 
            when d_weekend = 'Y'
            then true 
            else false 
        end as is_weekend,
        case 
            when d_following_holiday = 'Y'
            then true 
            else false 
        end as is_following_holiday,

        -- calculating relative date values based on 
        -- d_date to align columns into useable, correct data
        date_trunc('month', d_date) as first_day_of_month,
        last_day(d_date, 'month') as last_day_of_month,
        dateadd('y', -1, d_date) as same_day_last_year,
        dateadd('q', -1, d_date) as same_day_last_quarter,

        -- changing varchar to boolean and recalculating 
        -- true/false values based on current date since all 
        -- values = 'N' across all records
        
        -- case statements will evaluate to true if 
        -- the day, week, quarter, or year of the date
        -- aligns with the current date, so use these bools carefully 🫡
        -- (i.e., current_day = true across multiple months and years)
        
        -- 💡 recommend: use multiple bools if looking to compare 
        -- trends over time relative to today's date! 📈
        case 
            when day(d_date) = day(current_date::date)
            then true 
            else false 
        end as is_current_day,
        case 
            when d_week_seq = week(current_date)
            then true 
            else false 
        end as is_current_week, -- 👈 add `is_` in front of bool column to follow styleguide 😏
        case 
            when d_month_seq = month(current_date)
            then true 
            else false 
        end as is_current_month,
        case 
            when d_quarter_seq = quarter(current_date)
            then true 
            else false 
        end as is_current_quarter,
        case 
            when d_year = year(current_date)
            then true 
            else false 
        end as is_current_year

    from source

)

select * from renamed
