use BikeStores
go

--section1. querying data

select first_name,
	last_name
from sales.customers

select first_name,
	last_name,
	email
from sales.customers

select *
from sales.customers

select *
from sales.customers
where state = 'CA'

select *
from sales.customers
where state = 'CA'
order by first_name

select city,
	count(*) as number_of_customers
from sales.customers
where state = 'CA'
group by city
order by city


--where clause filters rows
--having clause filters groups
select city,
	count(*) as number_of_customers
from sales.customers
where state = 'CA'
group by city
having count(*) > 10
order by city



