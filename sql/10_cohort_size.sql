with cohort as(
select 
user_pseudo_id,
min(event_date) as first_visit,
SUBSTR(min(event_date), 1, 6) as cohort_month
from `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
group by user_pseudo_id
)
select 
cohort_month,
count(user_pseudo_id) as users
from cohort
group  by cohort_month
order by cohort_month
