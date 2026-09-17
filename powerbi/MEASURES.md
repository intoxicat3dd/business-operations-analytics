# Power BI model and measures

Import `data/orders.csv`. Set `order_date` and `ship_date` to Date and numeric fields to decimal/whole number as appropriate. Create a Calendar table and relate `Calendar[Date]` to `orders[order_date]`.

```DAX
Calendar = CALENDAR(MIN(orders[order_date]), MAX(orders[order_date]))
Delivered Orders = CALCULATE(COUNTROWS(orders), orders[status] = "Delivered")
Net Revenue = CALCULATE(SUMX(orders, orders[quantity] * orders[unit_price] * (1 - orders[discount_pct])), orders[status] = "Delivered")
Gross Profit = CALCULATE(SUMX(orders, orders[quantity] * (orders[unit_price] * (1 - orders[discount_pct]) - orders[unit_cost])), orders[status] = "Delivered")
Gross Margin % = DIVIDE([Gross Profit], [Net Revenue])
Average Order Value = DIVIDE([Net Revenue], [Delivered Orders])
Cancellation Rate % = DIVIDE(CALCULATE(COUNTROWS(orders), orders[status] = "Cancelled"), COUNTROWS(orders))
Avg Fulfillment Days = AVERAGEX(FILTER(orders, orders[status] = "Delivered"), DATEDIFF(orders[order_date], orders[ship_date], DAY))
```

Build three pages:

1. **Executive overview** — KPI cards, monthly revenue/profit line chart, and region/channel slicers.
2. **Operations** — cancellation rate and fulfillment days by region/channel, plus status decomposition.
3. **Customer retention** — cohort matrix exported from `sql/04_cohort_retention.sql`; use conditional formatting for the retention percentages.
