select event_name,
count(distinct(concat(user_pseudo_id,CAST(ep.value. int_value as string)))) as session_count

from `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`, unnest(event_params) as ep
where ep.key = 'ga_session_id' and _TABLE_SUFFIX BETWEEN '20210101' AND '20210131' and event_name in ('session_start', 'view_item', 'add_to_cart', 'begin_checkout','add_shipping_info', 'add_payment_info', 'purchase')
GROUP BY event_name
order by session_count desc
