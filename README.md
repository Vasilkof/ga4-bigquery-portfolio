# ga4-bigquery-portfolio

SQL analysis of GA4 e-commerce sample data in BigQuery.

## Objective

I wanted to determine the number of unique users in January 2021. I compared the number of unique users for each day (aggregated monthly data) with the total number of unique users for the entire month.

## Data

I used data from the public dataset `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*` (for the Google Merchandise Store) for January 2021. This data may differ from actual metrics, as it only simulates real-world statistics.

## Queries

- `01_january_unique_users_by_day.sql` — calculating the number of unique users for each day in January.
- `02_january_unique_users_total.sql` — counting the total number of unique users for the entire month (accounting for deduplication across the full period).
- `03_january_sum_of_daily_users.sql` — summing the unique user counts for each day in January to check if the simple sum of daily figures matches the total monthly value.

## Key Finding

The sum of unique users by day (106,565) exceeds the total number of unique users for the month (94,790) because returning visitors were counted multiple times in the daily statistics. On average, each active user visited the store on **1.12 different days** in January (106,565 / 94,790), indicating a high proportion of one-time site visits within the month. > 
**Important analytical insight:** You cannot simply sum the number of unique users across individual days to calculate weekly or monthly metrics, as this leads to inflated figures due to the double-counting of the same visitors. To obtain accurate aggregate data for a given period, you must calculate unique users based on the entire time interval. Note that `user_pseudo_id` identifies a specific device or browser rather than an individual person; consequently, the same user accessing the service from different devices will be counted separately.
