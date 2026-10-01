select sum(unique_users) as total_sum
from(select
event_date,
count(distinct user_pseudo_id) as unique_users

FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
where
_TABLE_SUFFIX BETWEEN '20210101' AND '20210131'
group by event_date)
