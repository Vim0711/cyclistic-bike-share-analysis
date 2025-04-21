SELECT
ROUND(AVG(ride_length_seconds)/60, 2) mean_ride_time_minutes ,
member_casual 
FROM `cyclistic_tripdata.all_trips_cleaned`
GROUP BY member_casual