--Section4 Filtering Data
--where

select * 
from production.products

select *
from production.products
where category_id = 1
order by list_price desc

select *
from production.products
where category_id = 1
and model_year = '2018'
order by list_price desc

select *
from production.products
where list_price > 300
and model_year = '2018'
order by list_price desc

select *
from production.products
where list_price > 300
or model_year = '2018'
order by list_price desc

select *
from production.products
where list_price between 1899 and 1999.99
order by list_price desc

select *
from production.products
where list_price in (299.99, 466.99, 489.99)
order by list_price desc

select *
from production.products
where product_name like '%Cruiser%'
order by list_price

--AND operator
select *
from production.products
where category_id = 1 
	and list_price > 400
order by list_price desc

select *
from production.products
where category_id = 1 
	and list_price > 400
	and brand_id = 1
order by list_price desc

select *
from production.products
where brand_id = 1
	or brand_id = 2
	and list_price > 1000
order by brand_id desc

select *
from production.products
where (brand_id = 1
	or brand_id = 2)
	and list_price > 1000
order by brand_id desc

--OR Operator
select *
from production.products
where list_price < 200
	or list_price > 6000
order by list_price desc

select *
from production.products
where brand_id = 1
	or brand_id = 2
	or brand_id = 4
order by brand_id desc

select *
from production.products
where brand_id in (1,2,4)
order by brand_id desc

select *
from production.products
where (brand_id = 1
	or brand_id = 2)
	and list_price > 500
order by brand_id

--IN
select product_name,
	list_price
from production.products
where list_price in (89.99, 109.99, 159.99)
order by list_price

select product_name,
	list_price
from production.products
where list_price not in (89.99, 109.99, 159.99)
order by list_price

select product_id
from production.stocks
where store_id = 1
	and quantity >= 30

select product_id,
	product_name,
	list_price
from production.products
where product_id in (select product_id
					from production.stocks
					where store_id = 1
						and quantity >= 30)
order by list_price desc

--BETWEEN operator

select product_id,
	product_name,
	list_price
from production.products
where list_price between 149.99 and 199.99
order by list_price


select product_id,
	product_name,
	list_price
from production.products
where list_price not between 149.99 and 199.99
order by list_price

select *
from sales.orders

select order_id,
	customer_id,
	order_date,
	order_status
from sales.orders
where order_date between '01.15.2017' and '01.17.2017'

--LIKE operator

select *
from sales.customers

select customer_id,
	first_name,
	last_name
from sales.customers
where last_name like 'z%'
order by first_name

select customer_id,
	first_name,
	last_name
from sales.customers
where last_name like '%er'
order by first_name

select customer_id,
	first_name,
	last_name
from sales.customers
where last_name like 't%s'
order by first_name

select customer_id,
	first_name,
	last_name
from sales.customers
where last_name like '_u%'
order by first_name

select customer_id,
	first_name,
	last_name
from sales.customers
where last_name like '[YZ]%'
order by last_name

select customer_id,
	first_name,
	last_name
from sales.customers
where last_name like '[A-C]%'
order by first_name

select customer_id,
	first_name,
	last_name
from sales.customers
where last_name like '[^A-X]%'
order by last_name

select customer_id,
	first_name,
	last_name
from sales.customers
where first_name not like 'A%'
order by first_name

CREATE TABLE sales.feedbacks (
  feedback_id INT IDENTITY(1, 1) PRIMARY KEY, 
  comment VARCHAR(255) NOT NULL
);

INSERT INTO sales.feedbacks(comment)
VALUES('Can you give me 30% discount?'),
      ('May I get me 30USD off?'),
      ('Is this having 20% discount today?');

SELECT * FROM sales.feedbacks;

select *
from sales.feedbacks
where comment like '%30%'

select *
from sales.feedbacks
where comment like '%30!%%' escape '!'

select *
from sales.feedbacks
where comment like '%30@%%' escape '@'

--SQL Server Alies
select first_name,
	last_name
from sales.customers
order by first_name

select first_name + ' ' + last_name as full_name
from sales.customers

select first_name + ' ' + last_name as 'Full Name'
from sales.customers

select category_name 'Product Category'
from production.categories
order by category_name

select category_name 'Product Category'
from production.categories
order by 'Product Category'

select sales.customers.customer_id,
	first_name,
	last_name,
	order_id
from sales.customers
inner join sales.orders on sales.orders.customer_id = sales.customers.customer_id

--distinct clause

select city
from sales.customers
order by city

select distinct city
from sales.customers
order by city

select distinct city, state
from sales.customers
order by city

select city, state
from sales.customers
order by city

select distinct phone
from sales.customers
order by phone

select city,
	state,
	zip_code
from sales.customers
group by city,
	state,
	zip_code
order by city,
	state,
	zip_code