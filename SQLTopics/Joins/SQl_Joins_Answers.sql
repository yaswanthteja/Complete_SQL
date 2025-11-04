





/*

Reffer to Comprehensive HR and Project Management Analysis project for scenario based approach
*/

-- create the tables 

drop table employee_j

-- creating the employee_j table
CREATE TABLE employee_j (
    emp_id VARCHAR(10) PRIMARY KEY,
    emp_name VARCHAR(50),
    salary DECIMAL(10, 2),
    dept_id VARCHAR(10),
    manager_id VARCHAR(10)
);

INSERT INTO employee_j (emp_id, emp_name, salary, dept_id, manager_id) VALUES
('E1', 'Rahul', 15000, 'D1', 'M1'),
('E2', 'Manoj', 15000, 'D1', 'M1'),
('E3', 'James', 55000, 'D2', 'M2'),
('E4', 'Michael', 25000, 'D2', 'M2'),
('E5', 'Ali', 20000, 'D10', 'M3'),
('E6', 'Robin', 35000, 'D10', 'M3');

drop table department_j;

-- Create department_j Table
CREATE TABLE department_j (
    dept_id VARCHAR(20) PRIMARY KEY,
    dept_name VARCHAR(50) NOT NULL
);

-- Insert Data into department_j
INSERT INTO department_j (dept_id, dept_name) VALUES
('D1', 'IT'),
('D2', 'HR'),
('D3', 'Finance'),
('D4', 'Admin');

drop table manager_j

-- Create manager_j Table
CREATE TABLE manager_j (
    manager_id VARCHAR(10) PRIMARY KEY,
    manager_name VARCHAR(50),
    dept_id VARCHAR(10)
);

-- Insert Data into manager_j
INSERT INTO manager_j (manager_id, manager_name, dept_id) VALUES
('M1', 'Prem', 'D3'),
('M2', 'Shripadh', 'D4'),
('M3', 'Nick', 'D1'),
('M4', 'Cory', 'D1');


drop table projects_j

-- Create projects_j Table
CREATE TABLE projects_j (
    project_id VARCHAR(20),
    project_name VARCHAR(100),
    team_member_id VARCHAR(20)
);

-- Insert Data into projects_j
INSERT INTO projects_j (project_id, project_name, team_member_id) VALUES
('P1', 'Data Migration', 'E1'),
('P1', 'Data Migration', 'E2'),
('P1', 'Data Migration', 'M3'),
('P2', 'ETL Tool', 'E1'),
('P2', 'ETL Tool', 'M4');


-- select queries 
select * from employee_j;
select * from department_j;
select * from manager_j;
select * from projects_j;



/* inner join will fetch the common records  which are avalilable from both tables  
*/


-- Fetch employee name and department name  from employee_j and department_j

select e.emp_name,d.dept_name
from employee_j e
join department_j d
on e.dept_id=d.dept_id;



-- Fetch All the employee name and the department name they belong to.
/*
LEFT JOIN will bring/fetch all the records from left table and matching records from right table
	- so here in this example we need to fetch all employee names present in that data base
	- first we need to find where we can find the employee details in the table
	- In this case we find them in employee_j table  so we need to consider it as left table and perform operation
	- in the query we can found ou that we have Ali, Robin have dept_name as null because in department_j table doesn't contain D10

	-- left join = first it will do inner join + any additional records in the left table 
*/




-- Fetch All the employee name and the department name they belong to using left join.

select e.emp_name,d.dept_name
from employee_j e
left join department_j d
on e.dept_id=d.dept_id;

/* 
Right Join will fetch all records from the right table and matching records from left table
Right join = first it will do inner join + any additional records in the right table 
*/

*/



-- Fetch All the employee name and the department name they belong to using right join.

select e.emp_name,d.dept_name
from employee_j e
right join department_j d
on e.dept_id=d.dept_id;



-- select queries 
select * from employee_j;
select * from department_j;
select * from manager_j;
select * from projects_j;




-- fetch details of all emp, their manager, their department and the projects they work on.

select e.emp_name,d.dept_name,e.manager_id,p.project_name
from employee_j e
left join department_j d on e.dept_id=d.dept_id
join manager_j m on m.manager_id=e.manager_id
left join projects_j p on p.team_member_id=e.emp_id;


/* FUll JOIN
 Full outer join Returns all records when  there is a match in either left  or right table
full join = inner join 
  + all remaining records from left table(including Nulls)
  + all remaining records from Right table(including Nulls)
*/


-- Fetch All the employee name and the department name they belong to using full join.


select e.emp_name,d.dept_name
from employee_j e
full join department_j d
on d.dept_id=e.dept_id

/* CROSS JOIN
returns cartesian product
*/


-- Fetch All the employee name and the department name they belong to using cross join.


select e.emp_name,d.dept_name
from employee_j e
cross join department_j d;



/* Natural JOIN
that combines rows from two or more tables based on columns with the same name and data type. 
the natural join do inner join if the tables have same column names
The natural join do cross join if the tables don't have same name
*/


-- Fetch All the employee name and the department name they belong to using Natural join.



select e.emp_name,d.dept_name
from employee_j e
natural join department_j d;

/*
SELF JOIN
A self join is a regular join in which a table is joined to  itself
there is no self join term We can use any kind of join in self join ex: left join, right join
*/


-- Fetch employee name  as employee_name and their assigned  manager as manager_name  using self join


SELECT DISTINCT e1.emp_name AS employee_name, m.manager_name
FROM employee_j e1
JOIN employee_j e2 ON e1.manager_id = e2.manager_id 
	AND e1.emp_id <> e2.emp_id
JOIN manager_j m ON e1.manager_id = m.manager_id;



/*
self join


*/


CREATE TABLE family_j (
    member_id VARCHAR(10),
    name VARCHAR(50),
    age INTEGER,
    parent_id VARCHAR(10)
);

INSERT INTO family_j (member_id, name, age, parent_id) VALUES
('F1', 'David', 4, 'F5'),
('F2', 'Carol', 10, 'F5'),
('F3', 'Michael', 12, 'F5'),
('F4', 'Johnson', 36, NULL),
('F5', 'Maryam', 40, 'F6'),
('F6', 'Stewart', 70, NULL),
('F7', 'Rohan', 6, 'F4'),
('F8', 'Asha', 8, 'F4');

select * from family_j;



-- Fetch child name as child_name and child_age and their parent name as parent_name and parent_age using self join table family_j


select  child.name as child_name
,child.age as child_age
,parent.name as parent_name
,parent.age as parent_age
from family_j as child
join family_j as parent
on child.parent_id=parent.member_id




/*

Comprehensive HR and Project Management Analysis

Imagine You are the HR and Project Manager at a company that uses several internal databases to manage employees, departments, managers, and project teams. Your CEO has asked for a comprehensive report that covers multiple aspects of the organization's structure, staffing, and project assignments. This report will help identify gaps, ensure proper assignments, and facilitate better resource planning.

One of your tasks is to ensure that each department has the necessary personnel to operate efficiently. 
You maintain  key tables in your database: 

employee_j 	for employee information and 
department_j 	for department details,
manager_j 	for manager details,
projects_j 	for project details.

*/




/*
 scenario 1: Your CEO wants to see which employees are correctly assigned to their respective departments. This will help verify that the company's internal records are accurate.

*/

select e.emp_name,d.dept_name
from employee_j e
join department_j d
on e.dept_id=d.dept_id;


/*
 Scenario2: All Employees with Departments 
You need a comprehensive list of all employees, including those not yet assigned to a department, to ensure no one is overlooked during planning.

*/

select e.emp_name,d.dept_name
from employee_j e
LEFT JOIN department_j d
on e.dept_id=d.dept_id;



/*
Scenario 3: Ensuring Adequate Staffing Across Departments

Your CEO wants to ensure that every department in your company has employees assigned to it. This includes identifying any departments that might be currently understaffed or have no employees at all. This information is crucial for planning future hiring efforts and ensuring efficient resource allocation.

*/

SELECT e.emp_name, d.dept_name
FROM employee_j e
RIGHT JOIN department_j d
ON e.dept_id = d.dept_id;


/*
Scenario4: Planning Team-Building Activities

As an HR manager, you want to organize team-building activities for employees who report to the same manager. Identifying pairs of employees who share the same manager will help you tailor activities to enhance teamwork and communication within those teams.

*/

SELECT DISTINCT e1.emp_name AS employee_name, m.manager_name
FROM employee_j e1
JOIN employee_j e2 ON e1.manager_id = e2.manager_id 
	AND e1.emp_id <> e2.emp_id
JOIN manager_j m ON e1.manager_id = m.manager_id;



/*
Scenario 5: Project Teams

You need to explore all possible team combinations for upcoming projects to understand potential team dynamics and resource utilization.

*/

SELECT e.emp_name, p.project_name
FROM employee_j e
CROSS JOIN projects_j p;








