/*
Create a file named join_exercises.sql to do your work in.

Join Example Database

1. Use the join_example_db. Select all the records from both the users and roles tables.

2. Use join, left join, and right join to combine results from the users and roles tables as we did in the lesson. Before you run each query, guess the expected number of results.

3. Although not explicitly covered in the lesson, aggregate functions like count can be used with join queries. Use count and the appropriate join type to get a list of roles along with the number of users that has the role. Hint: You will also need to use group by in the query.

Employees Database

1. Use the employees database.

2. Using the example in the Associative Table Joins section as a guide, write a query that shows each department along with the name of the current manager for that department.


  Department Name    | Department Manager
 --------------------+--------------------
  Customer Service   | Yuchang Weedman
  Development        | Leon DasSarma
  Finance            | Isamu Legleitner
  Human Resources    | Karsten Sigstam
  Marketing          | Vishwani Minakawa
  Production         | Oscar Ghazalie
  Quality Management | Dung Pesch
  Research           | Hilary Kambil
  Sales              | Hauke Zhang
  
3. Find the name of all departments currently managed by women.


Department Name | Manager Name
----------------+-----------------
Development     | Leon DasSarma
Finance         | Isamu Legleitner
Human Resources | Karsetn Sigstam
Research        | Hilary Kambil

4. Find the current titles of employees currently working in the Customer Service department.


Title              | Count
-------------------+------
Assistant Engineer |    68
Engineer           |   627
Manager            |     1
Senior Engineer    |  1790
Senior Staff       | 11268
Staff              |  3574
Technique Leader   |   241

5. Find the current salary of all current managers.


Department Name    | Name              | Salary
-------------------+-------------------+-------
Customer Service   | Yuchang Weedman   |  58745
Development        | Leon DasSarma     |  74510
Finance            | Isamu Legleitner  |  83457
Human Resources    | Karsten Sigstam   |  65400
Marketing          | Vishwani Minakawa | 106491
Production         | Oscar Ghazalie    |  56654
Quality Management | Dung Pesch        |  72876
Research           | Hilary Kambil     |  79393
Sales              | Hauke Zhang       | 101987

6. Find the number of current employees in each department.


+---------+--------------------+---------------+
| dept_no | dept_name          | num_employees |
+---------+--------------------+---------------+
| d001    | Marketing          | 14842         |
| d002    | Finance            | 12437         |
| d003    | Human Resources    | 12898         |
| d004    | Production         | 53304         |
| d005    | Development        | 61386         |
| d006    | Quality Management | 14546         |
| d007    | Sales              | 37701         |
| d008    | Research           | 15441         |
| d009    | Customer Service   | 17569         |
+---------+--------------------+---------------+

7. Which department has the highest average salary? Hint: Use current not historic information.


+-----------+----------------+
| dept_name | average_salary |
+-----------+----------------+
| Sales     | 88852.9695     |
+-----------+----------------+

8. Who is the highest paid employee in the Marketing department?


+------------+-----------+
| first_name | last_name |
+------------+-----------+
| Akemi      | Warwick   |
+------------+-----------+

9. Which current department manager has the highest salary?


+------------+-----------+--------+-----------+
| first_name | last_name | salary | dept_name |
+------------+-----------+--------+-----------+
| Vishwani   | Minakawa  | 106491 | Marketing |
+------------+-----------+--------+-----------+

10. Bonus Find the names of all current employees, their department name, and their current manager's name.


240,124 Rows

Employee Name | Department Name  |  Manager Name
--------------|------------------|-----------------
 Huan Lortz   | Customer Service | Yuchang Weedman

 .....

11. Bonus Who is the highest paid employee within each department
*/

#Join Example Database
#1
USE join_example_db;
SELECT *
FROM roles;
SELECT *
FROM users;

#2
SELECT users.name AS user_name, roles.name AS role_name
FROM users
JOIN roles ON users.role_id = roles.id;

SELECT users.name AS user_name, roles.name AS role_name
FROM users
LEFT JOIN roles ON users.role_id = roles.id;

SELECT users.name AS user_name, roles.name AS role_name
FROM users
RIGHT JOIN roles ON users.role_id = roles.id;

#3
SELECT roles.name AS role_name, COUNT(roles.name) as users_per_role
FROM roles
JOIN users ON roles.id = users.role_id
GROUP BY role_name;

#Employees Database
#1
USE employees;

#2
SELECT dept_name AS 'Department Name', CONCAT(first_name, ' ', last_name) AS 'Department Manager'
FROM employees
JOIN dept_manager USING(emp_no)
JOIN departments USING(dept_no)
WHERE to_date > NOW()
ORDER BY dept_name;

#3
SELECT dept_name AS 'Department Name', CONCAT(first_name, ' ', last_name) AS 'Department Manager'
FROM employees
JOIN dept_manager USING(emp_no)
JOIN departments USING(dept_no)
WHERE gender = 'F' AND to_date > NOW();

#4
SELECT DISTINCT title AS 'Job Title', dept_name AS 'Current Department', COUNT(title) AS 'Staff'
FROM titles
JOIN dept_emp USING(emp_no)
JOIN departments USING(dept_no)
WHERE titles.to_date > NOW() AND dept_emp.to_date > NOW() AND departments.dept_name = 'Customer Service'
GROUP BY title
ORDER BY title;

#5
SELECT dept_name AS 'Department Name', CONCAT(first_name, ' ', last_name) AS 'Department Manager', salary AS 'Salary'
FROM employees
JOIN dept_manager USING(emp_no)
JOIN departments USING(dept_no)
JOIN salaries USING(emp_no)
WHERE salaries.to_date > NOW() AND dept_manager.to_date > NOW();

#6
SELECT dept_no AS 'Department No.', dept_name AS 'Department Name', COUNT(dept_emp.emp_no) AS 'Number of Employees'
FROM dept_emp
JOIN departments USING(dept_no)
WHERE to_date > NOW()
GROUP BY dept_name
ORDER BY dept_no;

#7
SELECT dept_no AS 'Department No.', dept_name AS 'Department Name', AVG(salary) AS 'Average Salary'
FROM dept_emp
JOIN salaries USING(emp_no)
JOIN departments USING (dept_no)
WHERE salaries.to_date > NOW()
GROUP BY dept_name
HAVING AVG(salary)
ORDER BY AVG(salary) DESC
LIMIT 1;

#8
SELECT CONCAT(first_name, ' ', last_name) AS 'Highest Paid Employee from Marketing', salary AS 'Salary', dept_no AS 'Department No.'
FROM employees
JOIN dept_emp USING(emp_no)
JOIN salaries USING(emp_no)
WHERE salaries.to_date > NOW() AND dept_no = 'd001'
ORDER BY salary DESC
LIMIT 1;

#9
SELECT dept_name AS 'Department Name', CONCAT(first_name, ' ', last_name) AS 'Department Manager', salary AS 'Salary'
FROM employees
JOIN dept_manager USING(emp_no)
JOIN departments USING(dept_no)
JOIN salaries USING(emp_no)
WHERE salaries.to_date > NOW() AND dept_manager.to_date > NOW()
ORDER BY salary DESC
LIMIT 1;
