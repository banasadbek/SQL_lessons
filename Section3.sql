use BikeStores
go

--section3 select top

select *
from production.products

select top 10 
	product_name,
	list_price
from production.products
order by list_price desc

select count(product_name)
from production.products

select top 1 percent
	product_name,
	list_price
from production.products
order by list_price desc

--top with ties
select top 3 with ties
	product_name,
	list_price
from production.products
order by list_price desc

--offset [] rows
--fetch next [] rows only

select product_name,
	list_price
from production.products
order by list_price,
	product_name

select product_name,
	list_price
from production.products
order by list_price,
	product_name
offset 10 rows


select product_name,
	list_price
from production.products
order by list_price,
	product_name
offset 10 rows
fetch next 10 rows only

--top ten most expensive products
select product_name,
	list_price
from production.products
order by list_price,
	product_name
offset 0 rows
fetch next 10 rows only