
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



-- Ranking functions 

SELECT new_id,new_cat,
ROW_NUMBER() OVER(ORDER BY new_id) AS "ROW_NUMBER",
RANK() OVER(ORDER BY new_id) AS "RANK",
DENSE_RANK() OVER(ORDER BY new_id) AS "DENSE_RANK", 
PERCENT_RANK() OVER(ORDER BY new_id) AS "PERCENT_RANK",
NTILE(3) OVER(ORDER BY new_id) "NTILE"
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


