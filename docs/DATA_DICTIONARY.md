# Data dictionary and metric policy

| Field | Definition |
| --- | --- |
| `order_id` | Unique transaction identifier |
| `order_date` | Date the order was placed |
| `customer_id` | Anonymized customer identifier |
| `region`, `channel`, `product_category` | Dimensions for operational segmentation |
| `quantity`, `unit_price`, `unit_cost`, `discount_pct` | Inputs to revenue and gross-profit calculations |
| `status` | `Delivered`, `Cancelled`, or `Returned` |
| `ship_date` | Dispatch date; blank for an unshipped cancellation |

## Metric definitions

- **Recognized revenue:** `quantity × unit_price × (1 − discount_pct)` on delivered orders only.
- **Gross profit:** recognized revenue less `quantity × unit_cost` on delivered orders only.
- **Cancellation rate:** cancelled orders divided by all orders.
- **Average fulfillment days:** `ship_date − order_date` on delivered orders only.
- **Retention:** the share of a cohort with a delivered order in a later calendar month. Cohort month is a customer's first delivered-order month.

This project intentionally treats returns as excluded from recognized revenue. If returns are captured after an accounting period closes, replace this rule with your organization’s revenue-recognition policy and document the restatement behavior.
