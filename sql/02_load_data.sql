-- Update this path for your machine. HEADER maps the CSV column names to the table.
truncate table orders;
copy orders from 'C:/path/to/business-operations-analytics/data/orders.csv'
with (format csv, header true, null '');

analyze orders;
