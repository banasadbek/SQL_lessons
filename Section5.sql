use BikeStores
go

--Section5 JOINS

create schema hr
go

create table hr.candidates(
	id int primary key identity,
	fullname varchar(100) not null)

create table hr.employees(
	id int primary key identity,
	fullname varchar(100) not null)

insert into hr.candidates
values('John Doe'),
    ('Lily Bush'),
    ('Peter Drucker'),
    ('Jane Doe')

insert into hr.employees
values('John Doe'),
    ('Jane Doe'),
    ('Michael Scott'),
    ('Jack Sparrow');

select * from hr.candidates
select * from hr.employees

select c.id, c.fullname,
	e.id, e.fullname
from hr.candidates c
inner join hr.employees e
on c.fullname = e.fullname

select c.id, c.fullname,
	e.id, e.fullname
from hr.candidates c
left outer join hr.employees e
on c.fullname = e.fullname

select c.id, c.fullname,
	e.id, e.fullname
from hr.candidates c
left outer join hr.employees e
on c.fullname = e.fullname
where e.id is null

select c.id, c.fullname,
	e.id, e.fullname
from hr.candidates c
right outer join hr.employees e
on c.fullname = e.fullname

select c.id, c.fullname,
	e.id, e.fullname
from hr.candidates c
right outer join hr.employees e
on c.fullname = e.fullname
where c.id is null

select c.id, c.fullname,
	e.id, e.fullname
from hr.candidates c
full outer join hr.employees e
on c.fullname = e.fullname

select c.id, c.fullname,
	e.id, e.fullname
from hr.candidates c
full outer join hr.employees e
on c.fullname = e.fullname
where c.id is null or e.id is null

--inner join
select p.product_name,
    p.list_price,
    p.category_id,
	c.category_name
from production.products p
inner join production.categories c
on p.category_id = c.category_id
order by p.product_name desc

select product_name,
	list_price,
	category_name,
	brand_name
from production.products p
inner join production.categories c
on p.category_id = c.category_id
inner join production.brands b
on p.brand_id = b.brand_id
order by product_name desc

--left outer join
select product_name,
	order_id
from production.products p
left outer join sales.order_items o
on p.product_id = o.product_id
order by order_id

select product_name,
	order_id
from production.products p
left outer join sales.order_items o
on p.product_id = o.product_id
where order_id is null

select p.product_id,
	o.order_id,
	i.item_id,
	o.order_date
from production.products p
left join sales.order_items i
on p.product_id = i.product_id
left join sales.orders o 
on o.order_id = i.order_id

select product_name,
	order_id
from production.products p
left outer join sales.order_items o
on p.product_id = o.product_id
where order_id = 100
order by order_id

select product_name,
	order_id
from production.products p
left outer join sales.order_items o
on p.product_id = o.product_id
and order_id = 100
order by order_id

--right join

select product_name,
	order_id
from sales.order_items o
right join production.products p
on o.product_id = p.product_id
order by order_id

select product_name,
	order_id
from sales.order_items o
right join production.products p
on o.product_id = p.product_id
where order_id is null
order by order_id

--full outer join
create schema pm

create table pm.projects(
	id int primary key identity,
	title varchar(255) not null)

create table pm.members(
	id int primary key identity,
	name varchar(120) not null,
	project_id int,
	foreign key(project_id) references pm.projects(id))

insert into pm.projects(title)
values('New CRM for Project Sales'),
    ('ERP Implementation'),
    ('Develop Mobile Sales Platform')

insert into pm.members(name, project_id)
values ('John Doe', 1),
    ('Lily Bush', 1),
    ('Jane Doe', 2),
    ('Jack Daniel', null)

select * from pm.projects
select * from pm.members

select m.name,
	p.title
from pm.projects p
full join pm.members m
on m.project_id = p.id

select m.name,
	p.title
from pm.projects p
full join pm.members m
on m.project_id = p.id
where m.name is null or
	p.title is null

--cross join
select product_id,
	product_name,
	store_id,
	0 as quantity
from production.products
cross join sales.stores
order by product_name,
	store_id

select s.store_id,
	p.product_id,
	isnull(sales, 0) sales
from sales.stores s
cross join production.products p
left join (select s.store_id,
		p.product_id,
		sum(quantity * i.list_price)sales
		from sales.orders o
		inner join sales.order_items i on i.order_id = o.order_id
		inner join sales.stores s on s.store_id = o.store_id
		inner join production.products p on p.product_id = i.product_id
		group by s.store_id,
			p.product_id) c
on c.store_id = s.store_id
and c.product_id = p.product_id
where sales is null
order by p.product_id,
	store_id

--self join
SELECT
    e.first_name + ' ' + e.last_name employee,
    m.first_name + ' ' + m.last_name manager
FROM
    sales.staffs e
INNER JOIN sales.staffs m ON m.staff_id = e.manager_id
ORDER BY
    manager;

SELECT
    e.first_name + ' ' + e.last_name employee,
    m.first_name + ' ' + m.last_name manager
FROM
    sales.staffs e
LEFT JOIN sales.staffs m ON m.staff_id = e.manager_id
ORDER BY
    manager;

SELECT
    c1.city,
	c1.customer_id,
	c2.customer_id,
    c1.first_name + ' ' + c1.last_name customer_1,
    c2.first_name + ' ' + c2.last_name customer_2
FROM
    sales.customers c1
INNER JOIN sales.customers c2 ON c1.customer_id > c2.customer_id
AND c1.city = c2.city
ORDER BY
    city,
    customer_1,
    customer_2;

