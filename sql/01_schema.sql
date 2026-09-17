-- PostgreSQL. Safe to rerun when rebuilding the project dataset.
drop table if exists orders;

create table orders (
  order_id varchar(20) primary key,
  order_date date not null,
  customer_id varchar(20) not null,
  region varchar(30) not null,
  channel varchar(30) not null,
  product_category varchar(30) not null,
  quantity integer not null check (quantity > 0),
  unit_price numeric(12,2) not null check (unit_price >= 0),
  unit_cost numeric(12,2) not null check (unit_cost >= 0),
  discount_pct numeric(5,4) not null check (discount_pct between 0 and 1),
  status varchar(20) not null check (status in ('Delivered', 'Cancelled', 'Returned')),
  ship_date date,
  check (ship_date is null or ship_date >= order_date)
);
