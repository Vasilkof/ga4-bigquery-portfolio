WITH
  channel_stats AS (
    SELECT
      traffic_source.medium,
      COUNT(DISTINCT user_pseudo_id) AS users,
      COUNTIF(event_name = 'purchase') AS purchases,
      SUM(ecommerce.purchase_revenue_in_usd) AS revenue
    FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
    GROUP BY traffic_source.medium
  )
SELECT
  medium,
  users,
  purchases,
  revenue,
  ROUND((purchases / users), 3) AS conversion_rate,
  ROUND((revenue / purchases), 2) AS avg_order_value,
  ROUND((revenue / users), 2) AS revenue_per_user
FROM channel_stats
ORDER BY conversion_rate DESC
