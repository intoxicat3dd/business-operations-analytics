# Business Operations Analytics

A portfolio-ready analytics project for tracking revenue, customers, fulfillment, and retention. It uses PostgreSQL for the analytical layer and Power BI for reporting.

## What this answers

- How are revenue, orders, margin, and average order value trending?
- Which regions and channels are driving profitable growth?
- Where are fulfillment delays and cancellations concentrated?
- Are newly acquired customer cohorts returning in subsequent months?

## Project layout

| Path | Purpose |
| --- | --- |
| `data/orders.csv` | Small, synthetic dataset that can be loaded as-is |
| `sql/01_schema.sql` | Re-runnable table definition |
| `sql/02_load_data.sql` | PostgreSQL load command |
| `sql/03_kpi_analysis.sql` | Executive and operational KPI queries |
| `sql/04_cohort_retention.sql` | Customer-cohort retention matrix |
| `powerbi/MEASURES.md` | DAX measures and model instructions |
| `docs/DATA_DICTIONARY.md` | Field definitions and metric rules |

## Quick start

1. Create a PostgreSQL database and run `sql/01_schema.sql`.
2. Update the absolute CSV path in `sql/02_load_data.sql`, then run it.
3. Run `sql/03_kpi_analysis.sql` and `sql/04_cohort_retention.sql` for the analysis tables.
4. In Power BI, import `data/orders.csv`, add the measures in `powerbi/MEASURES.md`, and build the specified report pages.

All records are synthetic and intentionally small so the project is reproducible. For production use, replace the CSV ingestion with a scheduled source and apply the metric definitions in `docs/DATA_DICTIONARY.md`.
