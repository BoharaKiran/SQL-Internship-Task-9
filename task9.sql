use intern_training_db;

#Create salary data inside the employees table
create table employees1(
employee_id int primary key,
employee_name varchar(50),
department varchar(50),
salary int
);

insert into employees1 values
(1,'Pooja','HR',40000),
(2,'Rina','IT',60000),
(3,'Shiv','HR',50000),
(4,'Priya','Finance',30000),
(5,'Rahul','IT',40000),
(6,'Ram','HR',50000);

#Subquery in WHERE Clause
SELECT employee_name, salary
FROM employees1
WHERE salary > (
    SELECT AVG(salary)
    FROM employees1
);

#Subquery in SELECT Clause	 
select employee_name,salary,
(select avg(salary) from employees1) avg_salary
from employees1;

#Subquery in FROM Clause
SELECT e.employee_name, e.salary
FROM employees1 e
JOIN (
SELECT department,AVG(salary) AS dept_avg
from employees1
GROUP BY department
)d
ON e.department = d.department
WHERE e.salary > d.dept_avg;

#correlated subqueries
SELECT employee_name, salary
FROM employees1 e
WHERE salary > (
    SELECT AVG(salary)
    FROM employees1
    WHERE department = e.department
);

#Same Logic Using JOIN (Comparison)
SELECT e.employee_name, e.salary
FROM employees1 e
JOIN (
    SELECT department, AVG(salary) avg_sal
    FROM employees1
    GROUP BY department
) a
ON e.department = a.department
WHERE e.salary > a.avg_sal;

#Subquery Returning Multiple Rows
SELECT employee_name
FROM employees1
WHERE department IN (
    SELECT department
    FROM employees1
    WHERE salary > 60000
);

#Debugging Common Subquery Errors
where salary IN (SELECT salary FROM employees1);

#Situations Where Subqueries Are Unavoidable
/*Comparing row-by-row values
Filtering based on aggregated results
Data validation checks
EXISTS / NOT EXISTS logic*/

SELECT employee_name
FROM employees1 e
WHERE EXISTS (
    SELECT 1
    FROM employees1
    WHERE department = e.department
    AND salary > 65000
);



