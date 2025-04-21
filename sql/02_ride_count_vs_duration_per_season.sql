select
 CASE
      WHEN ride_month IN ('22-12', '23-01', '23-02') THEN 'Winter'
      WHEN ride_month IN ('23-03', '23-04', '23-05') THEN 'Spring'
      WHEN ride_month IN ('23-06', '23-07', '23-08') THEN 'Summer'
      WHEN ride_month IN ('22-09', '22-10', '22-11') THEN 'Fall'
      WHEN ride_month IN ('22-07', '22-08') THEN 'Summer'
    END AS season,
count(ride_id) AS ride_count,
ROUND(AVG(ride_length_seconds)/60,2) AS avg_ride_duration,
member_casual
from
`cyclistic_tripdata.all_trips_cleaned`


group by season, member_casual

order by season