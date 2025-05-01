SELECT city, COUNT(city) as city_count
FROM `bigquery-public-data.thelook_ecommerce.events`
GROUP BY city
HAVING city_count > 1000
ORDER BY city_count DESC
LIMIT 3