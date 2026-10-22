WITH activity AS (
  select
user_pseudo_id,
SUBSTR(event_date, 1, 6) as activity_month
from `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
group by user_pseudo_id, activity_month
),
cohort AS (
  select 
user_pseudo_id,
min(event_date) as first_visit,
SUBSTR(min(event_date), 1, 6) as cohort_month
from `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
 
group by user_pseudo_id
),
cohort_activity as (
SELECT 
activity.user_pseudo_id,
activity_month,
cohort_month, 
Date_diff(parse_date('%Y%m', activity_month) , (parse_date('%Y%m', cohort_month)), month) as month_number
FROM activity
JOIN cohort
  ON activity.user_pseudo_id = cohort.user_pseudo_id
)
select
cohort_month,
month_number,
count(distinct(user_pseudo_id)) as num_users
from cohort_activity
group by cohort_month, month_number
order by cohort_month, month_number
 





