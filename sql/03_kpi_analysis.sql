-- Executive KPI trend. Returned and cancelled orders are excluded from recognized revenue.
with enriched as (
  select *,
    quantity * unit_price * (1 - discount_pct) as net_revenue,
    quantity * unit_cost as total_cost
  from orders
), recognized as (
  select * from enriched where status = 'Delivered'
)
select
  date_trunc('month', order_date)::date as month,
  count(*) as delivered_orders,
  count(distinct customer_id) as active_customers,
  round(sum(net_revenue), 2) as revenue,
  round(sum(net_revenue - total_cost), 2) as gross_profit,
  round(100.0 * sum(net_revenue - total_cost) / nullif(sum(net_revenue), 0), 2) as gross_margin_pct,
  round(avg(net_revenue), 2) as average_order_value
from recognized
group by 1
order by 1;

-- Operational performance by region and channel.
select
  region, channel,
  count(*) as total_orders,
  count(*) filter (where status = 'Delivered') as delivered_orders,
  count(*) filter (where status = 'Cancelled') as cancelled_orders,
  count(*) filter (where status = 'Returned') as returned_orders,
  round(100.0 * count(*) filter (where status = 'Cancelled') / nullif(count(*), 0), 2) as cancellation_rate_pct,
  round(avg(ship_date - order_date) filter (where status = 'Delivered'), 2) as avg_fulfillment_days
from orders
group by 1, 2
order by cancellation_rate_pct desc, avg_fulfillment_days desc;

-- Product profitability: rank delivered categories by gross profit.
select
  product_category,
  round(sum(quantity * unit_price * (1 - discount_pct)), 2) as revenue,
  round(sum(quantity * (unit_price * (1 - discount_pct) - unit_cost)), 2) as gross_profit,
  dense_rank() over (order by sum(quantity * (unit_price * (1 - discount_pct) - unit_cost)) desc) as profit_rank
from orders
where status = 'Delivered'
group by 1
order by profit_rank;
