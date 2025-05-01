SELECT
  FORMAT_DATE('%B %Y', visitor.month) AS month_display,
  (purchase.number/visitor.number)*100 as Coversion_Rate
FROM (
  SELECT
    DATE_TRUNC(DATE(created_at), MONTH) AS month,
    COUNT(DISTINCT ip_address) AS number
  FROM
    `b-group-18-project.ecommerce_dataset.partitioned_cluster2_events`
  WHERE
    DATE(created_at) BETWEEN '2024-01-01' AND '2024-12-31'
    AND sequence_number = 1
  GROUP BY
    month 
    ) visitor
JOIN (
  SELECT
    DATE_TRUNC(DATE(created_at), MONTH) AS month,
    COUNT(DISTINCT ip_address) AS number
    
  FROM
    `b-group-18-project.ecommerce_dataset.partitioned_cluster2_events`
  WHERE
    event_type = 'purchase'
    AND DATE(created_at) BETWEEN '2024-01-01' AND '2024-12-31'
  
  GROUP BY
    month ) purchase
ON
  visitor.month = purchase.month
ORDER BY
  visitor.month