select 
user_pseudo_id,
min(event_date) as first_visit,
SUBSTR(min(event_date), 1, 6) as cohort_month
from `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
 
group by user_pseudo_id
