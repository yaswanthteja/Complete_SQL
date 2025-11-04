

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







