
/*
WINDOW FUNCTION

- Window function applies aggregate, ranking and analytic functions  over a particular window; for example, sum, avg, or row_number
And OVER clause is used with window functions to define that  window.

*/



/*


Let’s look at some definitions:


- Expression is the name of the column that we want the window  function operated on. This may not be necessary depending on what  window function is used

- OVER is just to signify that this is a window function

- PARTITION BY divides the rows into partitions so we can specify which  rows to use to compute the window function

- ORDER BY is used so that we can order the rows within each partition.  This is optional and does not have to be specified

- ROWS can be used if we want to further limit the rows within our  partition. This is optional and usually not used



*/

/*
Window Function Types

- Aggregate Functioons :- sum(),count(),min(),max(),avg()
- Ranking FUnctions :- ROW_NUMBER(),RANK(),DENSE_RANK(),PERCENT_RANK(),NTILE()
- Analytic Functions :- LEAD(),LAG(),FIRST_VALUE,LAST_VALUE,NTH_VALUE
*/



-- create table

create table test_wf(new_id int,
                new_cat varchar(50));

--insert values into test_wf
insert into test_wf(new_id,new_cat) values
	(100,'Agni'),
	(200,'Agni'),
	(500,'Dharti'),
	(700,'Dharti'),
	(200,'Vayu'),
	(300,'Vayu'),
	(500,'Vayu');

select * from test_wf;


-- Using Aggregate Function with window function

/*
The ORDER BY clause within the window function means that the calculations are performed in an incremental,
cumulative manner within each partition (new_cat). Each function (SUM, AVG, COUNT, MIN, MAX) is recalculated for each row within the partition, including all previous rows.
*/

select *,
    SUM(new_id) over(PARTITION BY new_cat ORDER BY new_id) AS "Total",
	Avg(new_id) OVER(PARTITION BY new_cat ORDER BY new_id) AS "avg",
	COUNT(new_id) OVER(PARTITION BY new_cat ORDER BY new_id) AS "Count",
	MIN(new_id) OVER(PARTITION BY new_cat ORDER BY new_id) AS "Min",
	MAX(new_id) OVER(PARTITION BY new_cat ORDER BY new_id) AS "Max"
From test_wf;

-- Without the ORDER BY clause, the window functions are calculated for the entire partition at once.

SELECT new_id, new_cat,
SUM(new_id) OVER( PARTITION BY new_cat ) AS "Total",
AVG(new_id) OVER( PARTITION BY new_cat ) AS "Average",
COUNT(new_id) OVER( PARTITION BY new_cat ) AS "Count",
MIN(new_id) OVER( PARTITION BY new_cat ) AS "Min",
MAX(new_id) OVER( PARTITION BY new_cat ) AS "Max"  
FROM test_wf;





/*
Calculates results for the entire window frame. Each function will return the same value for every row because the entire table is treated as a single window frame.
*/

SELECT new_id, new_cat,
SUM(new_id) OVER( ORDER BY new_id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS "Total",
AVG(new_id) OVER( ORDER BY new_id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS "Average",  COUNT(new_id) OVER( ORDER BY new_id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS "Count",  MIN(new_id) OVER( ORDER BY new_id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS "Min",  MAX(new_id) OVER( ORDER BY new_id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS "Max"
FROM test_wf;




/*
ROW_NUMBER() :-The ROW_NUMBER function assigns a unique sequential integer to each row within the partition of a result set, starting at 1 for the first row.
RANK(): - The RANK() function assigns a rank to each row within the partition of a result set. When it encounters ties (duplicate values), it assigns the same rank to the tied values and skips the consecutive ranks for the next values.
DENSE_RANK():- The DENSE_RANK function assigns a rank to each row within the partition of a result set, and if there are duplicate values, it assigns the same rank to those values. Unlike RANK(), DENSE_RANK continues the ranking without skipping any ranks after the duplicates.
PERCENT_RANK():- The PERCENT_RANK function assigns a rank in percentages to each row within the partition of a result set, and if there are duplicate values, it assigns the same rank to those values. Unlike RANK(), PERCENT_RANK continues the ranking without skipping any ranks after the duplicates.
NTILE():- The NTILE function assigns a bucket number to each row in the partition, with the number of buckets specified as an argument.
NTILE(4) number can be any thing and  it will divides the rows into number of buckets (quartiles) with in column we specified.

*/

/*
NTILE()

Defination :The NTILE function assigns a bucket number to each row in the partition, with the number of buckets specified as an argument.

NTILE(4) number can be any thing and  it will divides the rows into number of buckets (quartiles) with in column we specified.

*/



-- Ranking functions 

SELECT new_id,
ROW_NUMBER() OVER(ORDER BY new_id) AS "ROW_NUMBER",
RANK() OVER(ORDER BY new_id) AS "RANK",
DENSE_RANK() OVER(ORDER BY new_id) AS "DENSE_RANK",  
PERCENT_RANK() OVER(ORDER BY new_id) AS "PERCENT_RANK",
NTILE(4)OVER(ORDER BY new_id) AS "NTILE"
FROM test_wf




-- Analytic functions
SELECT 
    new_id,
    FIRST_VALUE(new_id) OVER (ORDER BY new_id RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS "FIRST_VALUE",
    LAST_VALUE(new_id) OVER (ORDER BY new_id RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS "LAST_VALUE",
    LEAD(new_id) OVER (ORDER BY new_id RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS "LEAD",
    LAG(new_id) OVER (ORDER BY new_id RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS "LAG",
    NTH_VALUE(new_id, 2) OVER (ORDER BY new_id RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS "NTH_VALUE" 
FROM test_wf;


-- NTH_VALUE with out specified frame gives you null for the first row

SELECT new_id, FIRST_VALUE(new_id) OVER( ORDER BY new_id) AS "FIRST_VALUE", 
LAST_VALUE(new_id) OVER( ORDER BY new_id) AS "LAST_VALUE",
LEAD(new_id)OVER( ORDER BY new_id) AS "LEAD", 
LAG(new_id) OVER( ORDER BY new_id) AS "LAG", 
NTH_VALUE(new_id, 2) OVER ( ORDER BY new_id ) AS "NTH_VALUE" 
FROM test_wf

/*

SELECT 
    new_id, 
    new_cat,
    NTH_VALUE(new_id, 2) OVER (ORDER BY new_id RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS "NTH_VALUE"
FROM test_wf;



How NTH_VALUE Works Without Specified Frame
For the first row (new_id = 100):

-The window frame is: [100]

There's no 2nd value here, so NTH_VALUE(new_id, 2) returns NULL.

- For the second row (new_id = 200):

- The window frame is: [100, 200]

The 2nd value is 200, so NTH_VALUE(new_id, 2) returns 200.

- For the third row (new_id = 500):

The window frame is: [100, 200, 500]

The 2nd value is 200, so NTH_VALUE(new_id, 2) returns 200.

Why It Gave NULL
In the first row's frame, there aren't enough rows to find a second value.

Since NTH_VALUE(new_id, 2) needs the second value and it doesn't exist in the frame for the first row, it returns NULL.

*/





-- create the tables 

drop table employee_wf;

-- creating the employee_sq table
create table employee_wf
( emp_ID int
, emp_NAME varchar(50)
, DEPT_NAME varchar(50)
, SALARY int);

insert into employee_wf values(101, 'Mohan', 'Admin', 4000),
(102, 'Rajkumar', 'HR', 3000),
(103, 'Akbar', 'IT', 4000),
(104, 'Dorvin', 'Finance', 6500),
(105, 'Rohit', 'HR', 3000),
(106, 'Rajesh',  'Finance', 5000),
(107, 'Preet', 'HR', 7000),(108, 'Maryam', 'Admin', 4000),
(109, 'Sanjay', 'IT', 6500),
(110, 'Vasudha', 'IT', 7000),
(111, 'Melinda', 'IT', 8000),
(112, 'Komal', 'IT', 10000),
(113, 'Gautham', 'Admin', 2000),
(114, 'Manisha', 'HR', 3000),
(115, 'Chandni', 'IT', 4500),
(116, 'Satya', 'Finance', 6500),
(117, 'Adarsh', 'HR', 3500),
(118, 'Tejaswi', 'Finance', 5500),
(119, 'Cory', 'HR', 8000),
(120, 'Monica', 'Admin', 5000),
(121, 'Rosalin', 'IT', 6000),
(122, 'Ibrahim', 'IT', 8000),
(123, 'Vikram', 'IT', 8000),
(124, 'Dheeraj', 'IT', 11000);



select * from employee_wf;

-- Using Aggregate functions
select dept_name,max(salary) as max_salary
from employee_wf
group by dept_name;


-- using window function, by using window function it will create a window 
select e.*,
max(salary) over() as max_salary
from employee_wf e;



-- find the maximum salary of employees on each  department
select e.*,
MAX(salary) over(partition by dept_name) as Max_salary
from employee_wf e;


--find the minimum salary of employees on each  department
select e.*,
MIN(salary) over(partition by dept_name) as Min_salary
from employee_wf e;

--  find the total count of employee  on each  department 
select e.*,
count(emp_id) over(partition by dept_name) as count_emp
from employee_wf e;

-- find the avg salary of employees on each  department in integer
SELECT e.*,
CAST(AVG(salary) OVER (PARTITION BY dept_name) AS INT) AS avg_salary
FROM employee_wf e;

-- find the total salary of employees on each  department
select e.*,
sum(salary) over(partition by dept_name) as total_salary
from employee_wf e;


-- Ranking Functions

-- row _number

select e.*,
row_number() over() as row_num
from employee_wf e;

-- find the no of employees on each  department
select e.*,
row_number() over(partition by dept_name) as row_num
from employee_wf e;

-- fetch the first 2 employees from each department to join the companay

select *
from(
	select e.*,
	row_number() over(partition by dept_name order by emp_id) as row_num
	from employee_wf e )x
where x.row_num<3;

-- fetch the top3 employees in each deaprtment earning the max salary.

select * from(
	select e.*,
	rank() over(partition by dept_name order by salary desc) as rnk
	from employee_wf e) x
where x.rnk<4;


-- Differnce between rank, dense rank,percent rank
select e.*, 
rank() over(partition by dept_name order by salary desc)as rnk,
dense_rank() over(partition by dept_name order by salary desc) as dense_rnk,
percent_rank()over(partition by dept_name order by salary desc)as percent_rnk,
row_number() over(partition by dept_name order by salary desc)as row_num

from employee_wf e;



--NTILE()


SELECT e.*,
    NTILE(4) OVER (PARTITION BY DEPT_NAME ORDER BY SALARY) AS salary_quartile
FROM employee_wf e;

-- if we specify NTILE(2)

SELECT e.*,
    NTILE(2) OVER (PARTITION BY DEPT_NAME ORDER BY SALARY) AS salary_half
FROM employee_wf e;








-- lag() -fetches previous row data
select e.*,
lag(salary)over(partition by dept_name order by emp_id)as previous_salary
from employee_wf e;

/*
In lag() and lead()
 lag(): we can pass arguments example lag(salary,2,0)  here 2 is the number of rows prior or previous to current row by deault it is 1, 0 can be anything and is the value which relaces default value that is null.
lead() we can pass arguments example lead(salary,2,0)  here 2 is the number of rows next to current row by deault it is 1, 0 can be anything and is the value which relaces default value that is null.

*/
select e.*,
lag(salary,2,0)over(partition by dept_name order by emp_id)as previous_salary
from employee_wf e;


--Lead() --fetches the next row data

select e.*,
lead(salary) over(partition by dept_name order by emp_id) as next_salary
from employee_wf e;

-- fetch the details for 2 rows
select e.*,
lead(salary,2,0) over(partition by dept_name order by emp_id) as next_salary
from employee_wf e;



-- fetch a quey to display if the salary of an employee is higher,lower or equal to the previous employee.

select e.*,
lag(salary) over(partition by dept_name order by emp_id) as previous_sal,
case
	when e.salary > lag(salary) over(partition by dept_name order by emp_id ) then 'higher than previous salary' 
	when e.salary < lag(salary) over(partition by dept_name order by emp_id ) then 'lower than previous salary' 
	when e.salary = lag(salary) over(partition by dept_name order by emp_id ) then 'same as the previous  salary'
	end sal_range

from employee_wf e;





/*
Analytical Functions
*/



/*



*/



-- Script to create the Products table and load data into it.

DROP TABLE products_wf;
CREATE TABLE products_wf
( 
    product_category varchar(255),
    brand varchar(255),
    product_name varchar(255),
    price int
);

INSERT INTO products_wf VALUES
('Phone', 'Apple', 'iPhone 12 Pro Max', 1300),
('Phone', 'Apple', 'iPhone 12 Pro', 1100),
('Phone', 'Apple', 'iPhone 12', 1000),
('Phone', 'Samsung', 'Galaxy Z Fold 3', 1800),
('Phone', 'Samsung', 'Galaxy Z Flip 3', 1000),
('Phone', 'Samsung', 'Galaxy Note 20', 1200),
('Phone', 'Samsung', 'Galaxy S21', 1000),
('Phone', 'OnePlus', 'OnePlus Nord', 300),
('Phone', 'OnePlus', 'OnePlus 9', 800),
('Phone', 'Google', 'Pixel 5', 600),
('Laptop', 'Apple', 'MacBook Pro 13', 2000),
('Laptop', 'Apple', 'MacBook Air', 1200),
('Laptop', 'Microsoft', 'Surface Laptop 4', 2100),
('Laptop', 'Dell', 'XPS 13', 2000),
('Laptop', 'Dell', 'XPS 15', 2300),
('Laptop', 'Dell', 'XPS 17', 2500),
('Earphone', 'Apple', 'AirPods Pro', 280),
('Earphone', 'Samsung', 'Galaxy Buds Pro', 220),
('Earphone', 'Samsung', 'Galaxy Buds Live', 170),
('Earphone', 'Sony', 'WF-1000XM4', 250),
('Headphone', 'Sony', 'WH-1000XM4', 400),
('Headphone', 'Apple', 'AirPods Max', 550),
('Headphone', 'Microsoft', 'Surface Headphones 2', 250),
('Smartwatch', 'Apple', 'Apple Watch Series 6', 1000),
('Smartwatch', 'Apple', 'Apple Watch SE', 400),
('Smartwatch', 'Samsung', 'Galaxy Watch 4', 600),
('Smartwatch', 'OnePlus', 'OnePlus Watch', 220);





-- All the SQL Queries 

select * from products_wf;


-- FIRST_VALUE :- Returns the first value in an ordered set of values.


-- Write query to display the most expensive product under each category (corresponding to each record)

select p.*,
FIRST_VALUE(product_name) over(partition by product_category order by price desc) as most_exp_product
from products_wf p;


-- LAST_VALUE  Returns the last value in an ordered set of values.


-- Write query to display the least expensive product under each category (corresponding to each record)




-- Alternate way to write SQL query using Window functions
     

            
-- NTH_VALUE 
-- Write query to display the Second most expensive product under each category.




-- NTILE
-- Write a query to segregate all the expensive phones, mid range phones and the cheaper phones.





-- CUME_DIST (cumulative distribution) ; 
/*  Formula = Current Row no (or Row No with value same as current row) / Total no of rows */

-- Query to fetch all products which are constituting the first 30% 
-- of the data in products table based on price.





-- PERCENT_RANK (relative rank of the current row / Percentage Ranking)
/* Formula = Current Row No - 1 / Total no of rows - 1 */

-- Query to identify how much percentage more expensive is "Galaxy Z Fold 3" when compared to all products.


Window
A window function creates a window, also known as a partition. This window is a subset of rows defined by the PARTITION BY clause. All rows sharing the same value(s) in the partitioning column(s) form a partition.


The frame clause in SQL window functions is used to define the set of rows that the window function operates over, called the window frame. The frame can be defined using ROWS or RANGE, each with its own behavior:

ROWS vs. RANGE
ROWS: Defines the window frame in terms of a specific number of rows before and after the current row.

RANGE: Defines the window frame in terms of a range of values relative to the current row's value.

Frame Specifications

UNBOUNDED PRECEDING: The frame starts at the first row of the partition.

UNBOUNDED FOLLOWING: The frame ends at the last row of the partition.

CURRENT ROW: The frame includes only the current row.

n PRECEDING: The frame starts n rows before the current row.

n FOLLOWING: The frame ends n rows after the current row.






-- using row clause
-- Calculate the running total of salaries within each department for the current row and the two preceding rows.

SELECT 
    emp_ID, 
    emp_NAME, 
    DEPT_NAME, 
    SALARY,
    SUM(SALARY) OVER (
        PARTITION BY DEPT_NAME 
        ORDER BY SALARY 
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS running_total
FROM employee_wf;




-- using range clause

-- Calculate the running total of salaries within each department for rows with the same salary or up to two less than the current row's salary.


SELECT 
    emp_ID, 
    emp_NAME, 
    DEPT_NAME, 
    SALARY,
    SUM(SALARY) OVER (
        PARTITION BY DEPT_NAME 
        ORDER BY SALARY 
        RANGE BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS running_total
FROM employee_wf;



Window (or Partition)
Definition: A window function creates a window, also known as a partition. This window is a subset of rows defined by the PARTITION BY clause. All rows sharing the same value(s) in the partitioning column(s) form a partition.

Frame
Definition: Within each partition, a frame is a further subset of rows defined by the ROWS or RANGE clause. This frame determines the specific rows the window function operates on within the partition.



Window/Partition: Defines a group of rows for the window function to operate on.

Frame: Defines a subset of the partition for more specific operations.







