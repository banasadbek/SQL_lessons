use BikeStores
go

--section7 subqueries
select order_id,
	order_date,
	customer_id
from sales.orders
where customer_id in (
	select customer_id
	from sales.customers
	where city = 'New York')
order by order_Date desc

select product_name,
	list_price
from production.products
where list_price > (
	select avg(list_price)
	from production.products
	where brand_id in (
		select brand_id
		from production.brands
		where brand_name = 'Strider'
		or brand_name = 'Trek'))
order by list_price

select order_id,
	order_date,
	(select max(list_price)
	from sales.order_items i
	where i.order_id = o.order_id) as max_list_price
from sales.orders o
order by order_date desc 

select * from sales.order_items

select	product_id,
	product_name
from production.products
where category_id in (
	select category_id
	from production.categories
	where category_name = 'Mountain Bikes' 
	or category_name = 'Road Bikes')

--ANY
select product_name,
	list_price
from production.products
where list_price >= any (
	select avg(list_price)
	from production.products
	group by brand_id)

select brand_id,  avg(list_price)
from production.products
group by brand_id

--ALL
select product_name,
	list_price
from production.products
where list_price >= all (
	select avg(list_price)
	from production.products
	group by brand_id)

--EXISTS

select customer_id,
	first_name,
	last_name,
	city
from sales.customers c
where exists(
	select customer_id
	from sales.orders o
	where o.customer_id = c.customer_id
	and year(order_date) = 2017)
order by first_name,
	last_name

select top 10 *
	from sales.orders o
	where year(order_date) = 2017
	order by customer_id


select customer_id,
	first_name,
	last_name,
	city
from sales.customers c
where exists(
	select top 10 customer_id
	from sales.orders o
	where c.customer_id = o.customer_id 
	and year(order_date) = 2017)
order by customer_id

--
select staff_id,
	count(order_id) order_count
from sales.orders
group by staff_id

select avg(order_count) average_order_count_by_staff
from(
select staff_id,
	count(order_id) order_count
from sales.orders
group by staff_id) t

--cross apply
select c.category_name,
	r.product_name,
	r.list_price
from production.categories c
cross apply(
	select top 2 *
	from production.products p
	where p.category_id = c.category_id
	order by list_price desc,
		product_name) r
order by c.category_name,
	r.list_price desc


