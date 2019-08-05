with performance_table as(
    select

        date_time::DATE as date_day,
        campaign_id,
        site,
        impressions,
        clicks,
        cpa_actions_num as conversions,
        spent as spend

    from {{source('taboola_ads', 'CAMPAIGN_SITE_DAY_REPORT')}}
 
)
select

    {{ dbt_utils.surrogate_key('date_day', 'campaign_id') }}::varchar as id,
    date_day,
    campaign_id,
    sum(impressions) impressions,
    sum(clicks) clicks,
    sum(conversions) conversions,
    sum(spend) spend

from performance_table
{{ dbt_utils.group_by(3) }}

