SELECT
  user_pseudo_id,
  event_name,
  event_timestamp,
  ep.value.int_value AS ga_session_id
FROM
  `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`,
  UNNEST(event_params) AS ep
WHERE
  ep.key = 'ga_session_id'
  AND _TABLE_SUFFIX BETWEEN '20210101' AND '20210131'
  AND event_name IN ('begin_checkout', 'add_shipping_info')
ORDER BY user_pseudo_id, ga_session_id, event_timestamp
