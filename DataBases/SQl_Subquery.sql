
/*
what is Subquery?
- A subquery, also known as a nested query or inner query, is a query that is embedded within another query. 
- Subqueries are used to retrieve data based on values from another query's result or to perform an operation before using the result in the main query. 
- we can use subquery in different parts of sql statements SELECT, FROM, WHERE.

Types of SubQuery
- correlated Subquery     :- The subquery is dependent on the outer query,and it reference columns from the outer query and it is executed once for each  of the outer query.
- Non Correlated Subquery :- It is independent of the outer query,it is executed on it's own and doesn't reference any columns from the outer query.
- scalar subquery         :- A scalar subquery taht will always returns a single value which is one row and one column
- multiple row subquery:- A subquery that returns multiple rows of results
 
*/




-- create the tables 

drop table employee_sq

-- creating the employee_sq table
create table employee_sq
( emp_ID int
, emp_NAME varchar(50)
, DEPT_NAME varchar(50)
, SALARY int);

insert into employee_sq values(101, 'Mohan', 'Admin', 4000);
insert into employee_sq values(102, 'Rajkumar', 'HR', 3000);
insert into employee_sq values(103, 'Akbar', 'IT', 4000);
insert into employee_sq values(104, 'Dorvin', 'Finance', 6500);
insert into employee_sq values(105, 'Rohit', 'HR', 3000);
insert into employee_sq values(106, 'Rajesh',  'Finance', 5000);
insert into employee_sq values(107, 'Preet', 'HR', 7000);
insert into employee_sq values(108, 'Maryam', 'Admin', 4000);
insert into employee_sq values(109, 'Sanjay', 'IT', 6500);
insert into employee_sq values(110, 'Vasudha', 'IT', 7000);
insert into employee_sq values(111, 'Melinda', 'IT', 8000);
insert into employee_sq values(112, 'Komal', 'IT', 10000);
insert into employee_sq values(113, 'Gautham', 'Admin', 2000);
insert into employee_sq values(114, 'Manisha', 'HR', 3000);
insert into employee_sq values(115, 'Chandni', 'IT', 4500);
insert into employee_sq values(116, 'Satya', 'Finance', 6500);
insert into employee_sq values(117, 'Adarsh', 'HR', 3500);
insert into employee_sq values(118, 'Tejaswi', 'Finance', 5500);
insert into employee_sq values(119, 'Cory', 'HR', 8000);
insert into employee_sq values(120, 'Monica', 'Admin', 5000);
insert into employee_sq values(121, 'Rosalin', 'IT', 6000);
insert into employee_sq values(122, 'Ibrahim', 'IT', 8000);
insert into employee_sq values(123, 'Vikram', 'IT', 8000);
insert into employee_sq values(124, 'Dheeraj', 'IT', 11000);

drop table department_sq;

-- Create department_sq Table
CREATE TABLE department_sq (
    dept_id INTEGER PRIMARY KEY,
    dept_name VARCHAR(50),
    location VARCHAR(100)
);


-- Insert Data into department_sq
INSERT INTO department_sq (dept_id, dept_name, location) VALUES
(2, 'HR', 'Bangalore'),
(3, 'IT', 'Bangalore'),
(4, 'Finance', 'Mumbai'),
(5, 'Marketing', 'Bangalore'),
(6, 'Sales', 'Mumbai');






drop table sales_sq

-- create sales_sq table

CREATE table sales_sq(sotre_id int,
					store_name varchar(50),
					product_name varchar(50),
					quantity int,
					price int);

INSERT INTO sales_sq values(1,'Apple Store 1','iPhone 13 pro',1,1000),
							(1,'Apple Store 1','MacBook pro 14',3,6000),
							(1,'Apple Store 1','AirPods Pro',2,500),
							(2,'Apple Store 2','iPhone 13 pro',2,2000),
							(3,'Apple Store 3','iPhone 12 Pro',1,750),
							(3,'Apple Store 3','MacBook pro 14',1,2000),
							(3,'Apple Store 3','MacBook Air',4,4400),
							(3,'Apple Store 3','iPhone 13',2,1800),
							(3,'Apple Store 3','Airpods Pro',3,750),
							(4,'Apple Store 4','iPhone 12 Pro',2,1500),
							(4,'Apple Store 4','MacBook pro 16',1,3500);




-- find the employees who's salary is more than the average salary earned by all employees

-- 1. find the avg salary
-- 2. filter all the employees based on the above result

select * from employee
select avg(salary) from employee

select * 
from employee_sq
where salary > 5791.6666666666666667;


-- now using subquery
select *    --outerquery/mainquery
from employee_sq
where salary > (select avg(salary) from employee_sq); --subquery


select * from employee_sq;
select * from department_sq;


-- single column,multiple column subquery

-- find department who do not have any employees

select *
from  department_sq
where dept_name not in (select distinct dept_name from employee_sq);


-- multiple column

select *
from employee_sq
where (dept_name,salary) in (select dept_name, max(salary)
							  from employee_sq
							  group by dept_name);

-- Correlated subquery
 
-- find the employees in each department who earn more than average salary in the department.

select *
from employee_sq e1
where salary > (select avg(salary)
				from employee_sq e2
				where e2.dept_name=e1.dept_name
				);

-- find department who do not have any employee?

select *
from department_sq d
where not exists (select 1 from employee_sq e where e.dept_name=d.dept_name); 

-- 1 is constant here any thing we can give any thing and  it returns that 
select 1 from employee_sq e where e.dept_name='Admin'




--nested subquery
select * from sales_sq

-- Find stores who's sales were better tahn the avearge sales across all stores

/*
1. find the total sales for each store
2. find avg sales for all the stores.
compare 1 & 2
*/


select *
from  ( select store_name,sum(price) as total_sales
      from sales_sq
	  group by store_name) sales   --total sales for stores
	  
join (select avg(total_sales) as sales  
      from (select store_name,sum(price) as total_sales
	        from sales_sq
			group by store_name) x)avg_sales
	  on sales.total_sales > avg_sales.sales;
	  

-- best approach with clause

with sales as
   (select store_name,sum(Price) as total_sales
   from sales_sq
   group by store_name)
select *
from sales
join(select avg(total_sales) as sales
               FROM sales x) avg_sales
			   on sales.total_sales > avg_sales.sales;

-- using a subquery in select clause

-- fetch all employee details and add remark to those employees who earn more than the average pay.

-- avoid adding subquery in select statement,every time the select clause runs subquery also runs

select *,
    (case when salary > (select avg(salary) from employee_sq)
	       then 'Higher than average'
		   else null
	 end) as remarks
from employee_sq;




-- best approch

SELECT *,
    (CASE 
        WHEN salary > avg_sal.sal
        THEN 'Higher than average'
        ELSE NULL
    END) AS remarks
FROM employee_sq
CROSS JOIN (SELECT AVG(salary) AS sal FROM employee_sq) avg_sal;



-- having

-- Find the sores who sold  more units tahn the average units sold by all stores.

select store_name, sum(quantity)
from sales_sq
group by store_name
having sum(quantity) > (select avg(quantity) from sales_sq);


/*Subquery inside Insert

*/
-- Insert data to employee history table. Make sure not insert duplicate records.
create table employee_history_sq
( emp_ID int
, emp_NAME varchar(50)
, DEPT_NAME varchar(50)
, SALARY int
, location varchar(100));

select * from employee_history_sq;

-- this will ensure that it will fetch the data from both the tables and add it to employee_history_sq

insert into employee_history_sq
select e.emp_id, e.emp_name, d.dept_name,e.salary,d.location
from employee_sq e
join department_sq d on d.dept_name=e.dept_name
where not exists (select 1
                 from employee_history_sq eh      --no duplicates
				 where eh.emp_id=e.emp_id);

select * from employee_sq

/* Sub query inside update

*/


/*give 10% increment to all employees in Bangalore location based on the maximum salary
earned by an emp in each dept. only consider employees ion employee_history_sq
*/

update employee_sq e
set salary =(select max(salary)+(max(salary)*0.1)
             from employee_history_sq eh
			 where eh.dept_name= e.dept_name)
where e.dept_name in (select dept_name
                      from department_sq
					  where location='Bangalore')
and e.emp_id in (select emp_id from employee_history_sq);


select * from employee_sq;


-- Subquery using Delete

/*
Delete all departments who do not have any employees
*/

delete  from department_sq
where dept_name in (select dept_name
                    from department_sq d
					where not exists( select 1 
					                 from employee_sq e
									 where e.dept_name=d.dept_name));

									



