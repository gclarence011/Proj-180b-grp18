SELECT
  visitor.month,
  (purchase.number/visitor.number)*100 as Coversion_Rate
FROM (
  SELECT
    FORMAT_DATE('%B %Y', DATE (created_at)) AS month,
    COUNT(DISTINCT ip_address) AS number
  FROM
    `bigquery-public-data.thelook_ecommerce.events`
  WHERE
    created_at >= "2024-01-01"
    AND created_at < "2025-01-01"
    AND sequence_number=1 
  GROUP BY
    month 
    ) visitor
JOIN (
  SELECT
    FORMAT_DATE('%B %Y', DATE (created_at)) AS month,
    COUNT(DISTINCT ip_address) AS number
  FROM
    `bigquery-public-data.thelook_ecommerce.events`
  WHERE
    event_type = 'purchase'
    AND created_at >= "2024-01-01"
    AND created_at < "2025-01-01"
  GROUP BY
    month ) purchase
ON
  visitor.month = purchase.month
ORDER BY
  PARSE_DATE('%B %Y',visitor.month)