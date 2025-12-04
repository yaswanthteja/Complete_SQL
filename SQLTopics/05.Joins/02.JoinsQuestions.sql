

/* 
Data for sql joins


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

select * from family_j;




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

















-- Reffer SQl_Joins_Answers.sql for Answers



/* inner join will fetch the common records  which are avalilable from both tables  
*/



-- Fetch All the employee name and the department name they belong to using left join .

/*
LEFT JOIN will bring/fetch all the records from left table and matching records from right table


	- so here in this example we need to fetch all employee names present in that data base
	- first we need to find where we can find the employee details in the table
	- In this case we find them in employee_j table  so we need to consider it as left table and perform operation
	- in the query we can found ou that we have Ali, Robin have dept_name as null because in department_j table doesn't contain D10

	-- left join = first it will do inner join + any additional records in the left table 


	
*/






/* 
Right Join will fetch all records from the right table and matching records from left table
Right join = first it will do inner join + any additional records in the right table 
*/


/* FUll JOIN
 Full outer join Returns all records when  there is a match in either left  or right table
full join = inner join 
  + all remaining records from left table(including Nulls)
  + all remaining records from Right table(including Nulls)
*/


/* CROSS JOIN
returns cartesian product
*/




/* Natural JOIN
that combines rows from two or more tables based on columns with the same name and data type. 
the natural join do inner join if the tables have same column names
The natural join do cross join if the tables don't have same name
*/




/*
SELF JOIN
A self join is a regular join in which a table is joined to  itself
there is no self join term We can use any kind of join in self join ex: left join, right join
*/




-- Fetch employee name and department name  from employee_j and department_j





-- Fetch All the employee name and the department name they belong to using left join.




-- Fetch All the employee name and the department name they belong to using right join.




-- Fetch All the employee name and the department name they belong to using full join.



-- Fetch All the employee name and the department name they belong to using Cross join.




-- Fetch All the employee name and the department name they belong to using Natural join.




-- Fetch employee name  as employee_name and their assigned  manager as manager_name  using self join




-- Fetch child name as child_name and child_age and their parent name as parent_name and parent_age using self join table family_j



-- fetch details of all emp, their manager, their department and the projects they work on.







/*
 scenario 1: Your CEO wants to see which employees are correctly assigned to their respective departments. This will help verify that the company's internal records are accurate.

*/




/*
 Scenario2: All Employees with Departments 
You need a comprehensive list of all employees, including those not yet assigned to a department, to ensure no one is overlooked during planning.

*/







/*
Scenario 3: Ensuring Adequate Staffing Across Departments

Your CEO wants to ensure that every department in your company has employees assigned to it. This includes identifying any departments that might be currently understaffed or have no employees at all. This information is crucial for planning future hiring efforts and ensuring efficient resource allocation.

*/




/*
Scenario4: Planning Team-Building Activities

As an HR manager, you want to organize team-building activities for employees who report to the same manager. Identifying pairs of employees who share the same manager will help you tailor activities to enhance teamwork and communication within those teams.

*/







/*
Scenario 5: Project Teams

You need to explore all possible team combinations for upcoming projects to understand potential team dynamics and resource utilization.

*/







