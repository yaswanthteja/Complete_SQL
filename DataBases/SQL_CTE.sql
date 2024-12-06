-- CTE (Common Table Expression)
-- QUERY 1 :
drop table emp;
create table emp_cte
( emp_ID int
, emp_NAME varchar(50)
, SALARY int);

insert into emp_cte values(101, 'Mohan', 40000);
insert into emp_cte values(102, 'James', 50000);
insert into emp_cte values(103, 'Robin', 60000);
insert into emp_cte values(104, 'Carol', 70000);
insert into emp_cte values(105, 'Alice', 80000);
insert into emp_cte values(106, 'Jimmy', 90000);

select * from emp_cte;

with avg_sal(avg_salary) as
		(select cast(avg(salary) as int) from emp_cte)
select *
from emp_cte e
join avg_sal av on e.salary > av.avg_salary





-- QUERY 2 :
DrOP table sales_cte ;
create table sales_cte
(
	store_id  		int,
	store_name  	varchar(50),
	product			varchar(50),
	quantity		int,
	cost			int
);
insert into sales_cte values
(1, 'Apple Originals 1','iPhone 12 Pro', 1, 1000),
(1, 'Apple Originals 1','MacBook pro 13', 3, 2000),
(1, 'Apple Originals 1','AirPods Pro', 2, 280),
(2, 'Apple Originals 2','iPhone 12 Pro', 2, 1000),
(3, 'Apple Originals 3','iPhone 12 Pro', 1, 1000),
(3, 'Apple Originals 3','MacBook pro 13', 1, 2000),
(3, 'Apple Originals 3','MacBook Air', 4, 1100),
(3, 'Apple Originals 3','iPhone 12', 2, 1000),
(3, 'Apple Originals 3','AirPods Pro', 3, 280),
(4, 'Apple Originals 4','iPhone 12 Pro', 2, 1000),
(4, 'Apple Originals 4','MacBook pro 13', 1, 2500);

select * from sales_cte;


-- Find total sales per each store
select s.store_id, sum(s.cost) as total_sales_per_store
from sales_cte s
group by s.store_id;


-- Find average sales with respect to all stores
select cast(avg(total_sales_per_store) as int) avg_sale_for_all_store
from (select s.store_id, sum(s.cost) as total_sales_per_store
	from sales_cte s
	group by s.store_id) x;



-- Find stores who's sales where better than the average sales accross all stores
select *
from   (select s.store_id, sum(s.cost) as total_sales_per_store
				from sales_cte s
				group by s.store_id
	   ) total_sales
join   (select cast(avg(total_sales_per_store) as int) avg_sale_for_all_store
				from (select s.store_id, sum(s.cost) as total_sales_per_store
		  	  		from sales_cte s
			  			group by s.store_id) x
	   ) avg_sales
on total_sales.total_sales_per_store > avg_sales.avg_sale_for_all_store;



-- Using WITH clause
WITH total_sales as
		(select s.store_id, sum(s.cost) as total_sales_per_store
		from sales_cte s
		group by s.store_id),
	avg_sales as
		(select cast(avg(total_sales_per_store) as int) avg_sale_for_all_store
		from total_sales)
select *
from   total_sales
join   avg_sales
on total_sales.total_sales_per_store > avg_sales.avg_sale_for_all_store;
