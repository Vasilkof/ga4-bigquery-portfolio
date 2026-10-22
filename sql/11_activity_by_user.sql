select
user_pseudo_id,
SUBSTR(event_date, 1, 6) as activity_month
from `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
group by user_pseudo_id, activity_month
