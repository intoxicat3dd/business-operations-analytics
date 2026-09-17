-- Customer is retained if they have a delivered order in a later calendar month.
with delivered_orders as (
  select customer_id, date_trunc('month', order_date)::date as order_month
  from orders
  where status = 'Delivered'
  group by 1, 2
), cohorts as (
  select customer_id, min(order_month) as cohort_month
  from delivered_orders
  group by 1
), activity as (
  select c.cohort_month, d.customer_id,
    (extract(year from age(d.order_month, c.cohort_month)) * 12
     + extract(month from age(d.order_month, c.cohort_month)))::int as month_number
  from cohorts c join delivered_orders d using (customer_id)
)
select
  cohort_month,
  count(distinct customer_id) filter (where month_number = 0) as cohort_size,
  round(100.0 * count(distinct customer_id) filter (where month_number = 1)
    / nullif(count(distinct customer_id) filter (where month_number = 0), 0), 2) as month_1_retention_pct,
  round(100.0 * count(distinct customer_id) filter (where month_number = 2)
    / nullif(count(distinct customer_id) filter (where month_number = 0), 0), 2) as month_2_retention_pct,
  round(100.0 * count(distinct customer_id) filter (where month_number = 3)
    / nullif(count(distinct customer_id) filter (where month_number = 0), 0), 2) as month_3_retention_pct
from activity
group by 1
order by 1;
