use BikeStores
go

--section10 pivot
select *
from production.products

select *
from production.categories

select category_name,
	count(product_id) production_count
from production.products p
inner join production.categories c
on p.category_id = c.category_id
group by category_name

select *
from (
	select category_name,
		product_id 
	from production.products p
	inner join production.categories c
	on p.category_id = c.category_id
) as t
pivot(
	count(product_id)
	for category_name in(
		[Children Bicycles]
		,[Comfort Bicycles]
		,[Cruisers Bicycles]
		,[Cyclocross Bicycles]
		,[Electric Bikes]
		,[Mountain Bikes]
		,[Road Bikes]) 
) as pivot_table


select *
from (
	select category_name,
		product_id,
		model_year
	from production.products p
	inner join production.categories c
	on p.category_id = c.category_id
) as t
pivot(
	count(product_id)
	for category_name in(
		[Children Bicycles]
		,[Comfort Bicycles]
		,[Cruisers Bicycles]
		,[Cyclocross Bicycles]
		,[Electric Bikes]
		,[Mountain Bikes]
		,[Road Bikes]) 
) as pivot_table

--generating column values
declare @columns nvarchar(max) = ''

select @columns += QUOTENAME(category_name) + ','
from production.categories
order by category_name

set @columns = left(@columns, len(@columns) - 1)

print @columns
