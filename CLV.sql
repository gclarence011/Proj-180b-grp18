select avg(ave_order_user.avg_order*order_freq.freq*ave_CLS.number) as CLV
from(
  select orders.user_id as user_id, avg(order_total.total_order)as avg_order
  from(
    select order_id, sum(sale_price) as total_order
    from `bigquery-public-data.thelook_ecommerce.order_items`
    group by order_id
  )order_total 
  join `bigquery-public-data.thelook_ecommerce.orders` as orders
  on orders.order_id = order_total.order_id
  group by user_id
)ave_order_user
join(
  select user_id, avg(orders_year)as freq
  from(
    select user_id, FORMAT_DATE('%Y', DATE (created_at)) as year,count(created_at) as orders_year
    from `bigquery-public-data.thelook_ecommerce.orders`
    group by user_id, year
  )
  group by user_id
) as order_freq
on ave_order_user.user_id = order_freq.user_id
join(
  select avg(customer_lifespan) as number
  from(
    select user_id, date_diff(date(last), date(first), year)as customer_lifespan
    from(
      select user_id, min(created_at) as first, max(created_at) as last, 
      from `bigquery-public-data.thelook_ecommerce.orders`
      group by user_id
    )
  )
)as ave_CLS
on 1=1

 





