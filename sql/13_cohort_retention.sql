WITH
  activity AS (
    SELECT
      user_pseudo_id,
      SUBSTR(event_date, 1, 6) AS activity_month
    FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
    GROUP BY user_pseudo_id, activity_month
  ),
  cohort AS (
    SELECT
      user_pseudo_id,
      min(event_date) AS first_visit,
      SUBSTR(min(event_date), 1, 6) AS cohort_month
    FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
    GROUP BY user_pseudo_id
  ),
  cohort_activity AS (
    SELECT
      activity.user_pseudo_id,
      activity_month,
      cohort_month,
      Date_diff(
        parse_date('%Y%m', activity_month),
        (parse_date('%Y%m', cohort_month)),
        month) AS month_number
    FROM activity
    JOIN cohort
      ON activity.user_pseudo_id = cohort.user_pseudo_id
  ),
  users_per_month AS (
    SELECT
      cohort_month,
      month_number,
      COUNT(DISTINCT (user_pseudo_id)) AS num_users
    FROM cohort_activity
    GROUP BY cohort_month, month_number
  ),
  cohort_size AS (
    SELECT
      cohort_month,
      num_users AS cohort_size
    FROM users_per_month
    WHERE month_number = 0
  )
SELECT
  cohort_size.cohort_month,
  month_number,
  num_users,
  cohort_size.cohort_size,
  Round((num_users / cohort_size.cohort_size), 3) AS retention_rate
FROM users_per_month
JOIN cohort_size
  ON users_per_month.cohort_month = cohort_size.cohort_month
ORDER BY cohort_month, month_number
