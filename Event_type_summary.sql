SELECT event_type, min(min_seq) as minimum_seq, avg(avg_seq) as avg_seq, avg(seq_count) as avg_seq_count_per_session
FROM (
  SELECT session_id, event_type, count(sequence_number)as seq_count, min(sequence_number) as min_seq, avg(sequence_number) as avg_seq
  FROM `bigquery-public-data.thelook_ecommerce.events`
  GROUP BY session_id, event_type
)
GROUP BY event_type 