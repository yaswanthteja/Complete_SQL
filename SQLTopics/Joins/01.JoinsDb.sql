

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







