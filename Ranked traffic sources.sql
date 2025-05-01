SELECT traffic_source, COUNT(traffic_source) as traffic_count
FROM `bigquery-public-data.thelook_ecommerce.events`
GROUP BY traffic_source
ORDER BY traffic_count DESC