SELECT 
  day_of_week,
  COUNT(ride_id) AS ride_count,
  member_casual
FROM `cyclistic-capstone-456323.cyclistic_tripdata.all_trips_cleaned`
GROUP BY day_of_week,member_casual
ORDER BY ride_count DESC
