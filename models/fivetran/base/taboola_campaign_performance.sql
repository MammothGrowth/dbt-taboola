with performance_table as(
    select

        date_time::DATE as date_day,
        campaign_id,
        impressions,
        clicks,
        cpa_actions_num as conversions,
        spent as spend,
        currency

    from {{source('taboola_ads', 'CAMPAIGN_SITE_DAY_REPORT')}}
 
)
select

    {{ dbt_utils.surrogate_key('date_day', 'campaign_id') }}::varchar as id,
    date_day,
    campaign_id,
    impressions,
    clicks,
    conversions,
    spend,
    currency

from performance_table
