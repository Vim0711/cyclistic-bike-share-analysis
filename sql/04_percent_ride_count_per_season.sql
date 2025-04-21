WITH seasonal_totals AS (
  SELECT
    CASE
      WHEN ride_month IN ('22-07', '22-08') THEN 'Summer'
      WHEN ride_month IN ('22-09', '22-10', '22-11') THEN 'Fall'
      WHEN ride_month IN ('22-12', '23-01', '23-02') THEN 'Winter'
      WHEN ride_month IN ('23-03', '23-04', '23-05') THEN 'Spring'
      WHEN ride_month IN ('23-06') THEN 'Summer'
    END AS season,
    COUNT(*) AS total_rides
  FROM `cyclistic-capstone-456323.cyclistic_tripdata.all_trips_cleaned`
  GROUP BY season
),

grouped_rides AS (
  SELECT
    CASE
      WHEN ride_month IN ('22-07', '22-08') THEN 'Summer'
      WHEN ride_month IN ('22-09', '22-10', '22-11') THEN 'Fall'
      WHEN ride_month IN ('22-12', '23-01', '23-02') THEN 'Winter'
      WHEN ride_month IN ('23-03', '23-04', '23-05') THEN 'Spring'
      WHEN ride_month IN ('23-06') THEN 'Summer'
    END AS season,
    member_casual,
    COUNT(*) AS ride_count
  FROM `cyclistic-capstone-456323.cyclistic_tripdata.all_trips_cleaned`
  GROUP BY season, member_casual
)

SELECT
  g.season,
  g.member_casual,
  g.ride_count,
  t.total_rides,
  ROUND(g.ride_count * 100.0 / t.total_rides, 2) AS percent_of_season
FROM grouped_rides g
JOIN seasonal_totals t
  ON g.season = t.season
ORDER BY g.season, g.member_casual;
