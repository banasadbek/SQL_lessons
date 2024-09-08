use BikeStores
go
--Section6 group by
select customer_id,
	year(order_date) order_year
from sales.orders
where customer_id in (1,2)
order by customer_id

select customer_id,
	year(order_date) order_year
from sales.orders
where customer_id in (1,2)
group by customer_id,
	year(order_date)
order by customer_id

select customer_id,
	year(order_date) order_year,
	count(order_id) order_placed
from sales.orders
where customer_id in (1,2)
group by customer_id,
	year(order_date)
order by customer_id

select city,
	count(customer_id) customer_count
from sales.customers
group by city
order by city


select city,
	state,
	count(customer_id) customer_count
from sales.customers
group by state,
	city
order by state,
	city

select brand_name,
	min(list_price) min_price,
	max(list_price) max_price
from production.products p
inner join production.brands b
on b.brand_id = p.brand_id
where model_year = 2018
group by brand_name
order by brand_name

select brand_name,
	avg(list_price) avg_price
from production.products p
inner join production.brands b
on b.brand_id = p.brand_id
where model_year = 2018
group by brand_name
order by brand_name

select * from sales.order_items

select order_id,
	sum(quantity * list_price * (1-discount)) net_value
from sales.order_items
group by order_id

--having
select customer_id,
	year(order_date),
	count(order_id) order_count
from sales.orders
group by customer_id,
	year(order_date)
having count(order_id) > 2
order by customer_id

select order_id,
	sum(quantity *	list_price * (1-discount)) net_value
from sales.order_items
group by order_id
having sum(quantity *	list_price * (1-discount)) > 20000
order by net_value

select category_id,
	max(list_price) max_list_price,
	min(list_price) min_list_price
from production.products
group by category_id
having max(list_price) > 4000
or min(list_price) < 500

select category_id,
	avg(list_price) avg_list_price
from production.products
group by category_id
having avg(list_price) between 500 and 1000


