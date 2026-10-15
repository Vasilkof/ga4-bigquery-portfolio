select 
count(distinct(concat(user_pseudo_id,CAST(ep.value. int_value as string)))) as total_session

from `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`, unnest(event_params) as ep
where ep.key = 'ga_session_id' and _TABLE_SUFFIX BETWEEN '20210101' AND '20210131'
