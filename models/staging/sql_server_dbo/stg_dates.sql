{{ 
    config(
        materialized='table', 
        sort='date_day',
        dist='date_day',
        pre_hook="alter session set timezone = 'Europe/Madrid'; alter session set week_start = 7;" 
        ) }}

with date as (
    {{ dbt_utils.date_spine(
        datepart="day",
        start_date="cast('2000-01-01' as date)",
        end_date="cast(current_date()+365 as date)"
    )
    }}  
)


select
      date_day as fecha_forecast
    , year(date_day)*10000+month(date_day)*100+day(date_day) as id_date
    , year(date_day) as year_date
    , month(date_day) as month_date
    ,monthname(date_day) as desc_month
    , year(date_day)*100+month(date_day) as id_year_month
    , date_day-1 as day_before
    , year(date_day)||weekiso(date_day)||dayofweek(date_day) as year_week_day
    , weekiso(date_day) as week_date
    --Añadir trimestre, cuantrimestre, semestre, año fiscal, trimestre fiscal, cuatrimestre fiscal y semestre fiscal
from date
order by
    date_day desc