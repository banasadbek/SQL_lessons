use BikeStores
go

--section2 order by

select first_name,
	last_name
from sales.customers
order by first_name

select first_name,
	last_name
from sales.customers
order by first_name desc

select city,
	first_name,
	last_name
from sales.customers
order by city,
	first_name

select city,
	first_name,
	last_name
from sales.customers
order by city desc,
	first_name asc

select city,
	first_name,
	last_name
from sales.customers
order by state

select first_name,
	last_name
from sales.customers
order by len(first_name) desc

