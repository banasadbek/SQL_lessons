use BikeStores
go

--Section8 Set Operators: UNION, INTERSECT, EXCEPT
select top 100 first_name from sales.staffs
union
select top 100 first_name from sales.customers

select first_name,
	last_name
from sales.staffs
union
select first_name,
	last_name
from sales.customers
order by first_name,
	last_name


select last_name
from sales.staffs
intersect
select first_name
from sales.customers

