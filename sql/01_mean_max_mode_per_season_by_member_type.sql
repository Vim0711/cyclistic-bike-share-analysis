-- Step 1: Frequency table for mode calculation
WITH freq_table AS (
  SELECT
    CASE
      WHEN ride_month IN ('22-12', '23-01', '23-02') THEN 'Winter'
      WHEN ride_month IN ('23-03', '23-04', '23-05') THEN 'Spring'
      WHEN ride_month IN ('23-06', '23-07', '23-08') THEN 'Summer'
      WHEN ride_month IN ('22-09', '22-10', '22-11') THEN 'Fall'
      WHEN ride_month IN ('22-07', '22-08') THEN 'Summer'
    END AS season,
    member_casual,
    ride_length_seconds,
    COUNT(*) AS freq
  FROM `cyclistic-capstone-456323.cyclistic_tripdata.all_trips_cleaned`
  WHERE ride_month IN ('22-07', '22-08', '22-09', '22-10', '22-11',
                       '22-12', '23-01', '23-02',
                       '23-03', '23-04', '23-05',
                       '23-06', '23-07', '23-08')
  GROUP BY season, ride_length_seconds,member_casual
),

-- Step 2: Rank each ride length per season by frequency
ranked_modes AS (
  SELECT
    season,
    ride_length_seconds AS mode_ride_length,
    freq,
    ROW_NUMBER() OVER (PARTITION BY season ORDER BY freq DESC) AS rank
  FROM freq_table
),

-- Step 3: Summary table for mean and max
season_summary AS (
  SELECT
    CASE
      WHEN ride_month IN ('22-12', '23-01', '23-02') THEN 'Winter'
      WHEN ride_month IN ('23-03', '23-04', '23-05') THEN 'Spring'
      WHEN ride_month IN ('23-06') THEN 'Summer'
      WHEN ride_month IN ('22-09', '22-10', '22-11') THEN 'Fall'
      WHEN ride_month IN ('22-07', '22-08') THEN 'Summer'
    END AS season,
    ROUND(AVG(ride_length_seconds), 2) AS mean_ride_length,
    MAX(ride_length_seconds) AS max_ride_length,
    member_casual
  FROM `cyclistic-capstone-456323.cyclistic_tripdata.all_trips_cleaned`
  WHERE ride_month IN ('22-07', '22-08', '22-09', '22-10', '22-11',
                       '22-12', '23-01', '23-02',
                       '23-03', '23-04', '23-05',
                       '23-06')
  GROUP BY season,member_casual
)

-- Step 4: Join the two together
SELECT
  s.season,
  s.mean_ride_length,
  s.max_ride_length,
  m.mode_ride_length,
  member_casual
FROM season_summary AS s
LEFT JOIN ranked_modes AS m
  ON s.season = m.season
WHERE m.rank = 1
ORDER BY s.season;
