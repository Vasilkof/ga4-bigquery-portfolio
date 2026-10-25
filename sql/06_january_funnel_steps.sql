with session as ( select
event_name,
count(distinct(concat(user_pseudo_id,CAST(ep.value. int_value as string)))) as session_count

from `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`, unnest(event_params) as ep
where ep.key = 'ga_session_id' and _TABLE_SUFFIX BETWEEN '20210101' AND '20210131' and event_name in ('session_start', 'view_item', 'add_to_cart', 'begin_checkout','add_shipping_info', 'add_payment_info', 'purchase')
GROUP BY event_name
order by session_count desc
),
session_step_number as ( select
event_name,
session_count,
case 
when event_name = 'session_start' THEN 1
when event_name = 'view_item' THEN 2    
when event_name = 'add_to_cart' THEN 3   
when event_name = 'begin_checkout' THEN 4
when event_name = 'add_shipping_info' THEN 5        
when event_name = 'add_payment_info' THEN 6   
when event_name = 'purchase' THEN 7
END as step_number
from session
)
SELECT 
event_name,
session_count,
step_number,
LAG(session_count) OVER (ORDER BY step_number) as previous_count_session,
ROUND(session_count/LAG(session_count) OVER (ORDER BY step_number), 3) as pct_of_previous_step
from session_step_number
order by step_number

