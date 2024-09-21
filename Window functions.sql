DROP TABLE IF EXISTS demand2;

CREATE TABLE demand2 (
  day INT,
  qty FLOAT
);


INSERT INTO demand2
  (day, qty)
VALUES
  (1, 10),
  (2, 6),
  (3, 21),
  (4, 9),
  (6, 12),
  (7, 18),
  (8, 3),
  (9, 6),
  (10, 23);

select *
from demand2

--task 1
select *,
	sum(qty) over(order by day) as cumQty
from demand2

DROP TABLE IF EXISTS demand;

CREATE TABLE demand (
  product VARCHAR(10),
  day INT,
  qty FLOAT
);


INSERT INTO demand
  (product, day, qty)
VALUES
  ('A', 1, 10),
  ('A', 2, 6),
  ('A', 3, 21),
  ('A', 4, 9),
  ('A', 5, 19),
  ('B', 1, 12),
  ('B', 2, 18),
  ('B', 3, 3),
  ('B', 4, 6),
  ('B', 5, 23);

--task 2
select *,
	sum(qty) over(partition by product order by(day)) as CUMSUM
from demand

--task3
;with cte as(
select *,
	row_number() over(partition by product order bY(qty)) as rn
from demand
)
select product,
	day,
	qty,
	rn
from cte
where rn in (1,2)

--task4
;with cte as(
select *,
	lag(qty, 1) over(order by (select null)) as qty_lag
from demand
)
select *,
	round(((qty/qty_lag)-1)*100, 2)
from cte
where qty_lag is not null

--task5
;with cte as(
select product,
	day,
	qty
from demand
)
select *,
	min(qty) over(partition by(product)) min_qty,
	max(qty) over(partition by(product)) max_qty
from cte

--task6
;with cte as(
select *,
	row_number() over(partition by product order by(qty)) as rn
from demand
)
select product,
	day,
	qty
from cte
where rn in(2, 4)

--task7

with tbl as (
  select day, 
          product,
          qty,
          max(qty) over (partition by day) as maxqty
  from demand)
select day,
	product,
	qty,
	maxqty
from tbl
where qty = maxqty;

select day,
	product,
	qty,
	qty as maxqty
from demand
where qty in (
select max(qty)
from demand
group by day
) 
order by day

--task8
DROP TABLE IF EXISTS demand;

CREATE TABLE demand (
  product VARCHAR(10),
  location VARCHAR(10),
  sales INT,
  refunds INT
);


INSERT INTO demand
  (product, location, sales, refunds)
VALUES
  ('A', 'S1', 9, 2),
  ('B', 'S1', 8, 1),
  ('B', 'S1', 7, 3),
  ('B', 'S2', 51, 8),
  ('C', 'S2', 33, 10),
  ('D', 'S2', 12, 3),
  ('A', 'S2', 10, 2),
  ('B', 'S2', 152, 17),
  ('E', 'S3', 101, 23),
  ('C', 'S3', 73, 12),
  ('F', 'S3', 63, 19),
  ('F', 'S3', 23, 4),
  ('D', 'S3', 5, 0),
  ('A', 'S3', 5, 0);

select *,
	row_number() over(partition by location order by (sales))
from demand

--task9
with cte as(
select location,
	product,
	sum(sales) as total_sales
from demand
group by location, product
),
ranked as(
select location,
	product,
	total_sales,
	row_number() over(partition by(location) order by(total_sales) desc) as rn
from cte
)
select * from ranked 
where rn in(1,2)

--task10

with cte as(
select location,
	product,
	sum(sales) as total_sales
from demand
group by location, product
),
ranked as(
select location,
	product,
	total_sales,
	row_number() over(partition by(location) order by(total_sales) desc) as rn
from cte
)
select * from ranked 
where rn in(1,2,3)

--task11
select sum(sales) as total_sales
from demand

select product,
	sales,
	sum(sales) over(partition by product) as tslp
from demand

--task12

with cte1 as(
select distinct product,
	sum(sales) over(partition by product) as total_product_sales,
	(select sum(sales)
	from demand) as total_sales
from demand
)
,cte2 as(
select *,
	sum(total_product_sales) over(order by total_product_sales) as cum_total_sales
from cte1
)
,cte3 as(
SELECT *, 
    round(CAST(cum_total_sales AS DECIMAL(10, 2)) / CAST(total_sales AS DECIMAL(10, 2)),3) AS cum_perc_sales
FROM cte2
)
select * from cte3
where cum_perc_sales < 0.80


--task13

