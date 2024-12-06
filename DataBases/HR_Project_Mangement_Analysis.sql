

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

