use bikestores
go

--section9 cte, recursive cte
with cte as(
	--anchor member

	--recursive member

	--termination condition
)

with cte_numbers(n, weekday)
as(
	select 0,
		datename(dw, 0)
	union all
	select n+1,
		datename(dw, n+1)
	from cte_numbers
	where n<6
)
select weekday
from cte_numbers

with cte_org
as (
	select staff_id,
		first_name,
		manager_id
	from sales.staffs
	where manager_id is null
	
	union all

	select e.staff_id,
		e.first_name,
		e.manager_id
	from sales.staffs e
	inner join cte_org o
	on o.staff_id = e.manager_id
)
select * from cte_org

