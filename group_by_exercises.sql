/*
1. Create a new file named group_by_exercises.sql

2. In your script, use DISTINCT to find the unique titles in the titles table. How many unique titles have there ever been? Answer that in a comment in your SQL file.

3. Write a query to to find a list of all unique last names of all employees that start and end with 'E' using GROUP BY.

4. Write a query to to find all unique combinations of first and last names of all employees whose last names start and end with 'E'.

5. Write a query to find the unique last names with a 'q' but not 'qu'. Include those names in a comment in your sql code.

6. Add a COUNT() to your results (the query above) to find the number of employees with the same last name.

7. Find all all employees with first names 'Irena', 'Vidya', or 'Maya'. Use COUNT(*) and GROUP BY to find the number of employees for each gender with those names.

8. Using your query that generates a username for all of the employees, generate a count employees for each unique username. Are there any duplicate usernames? BONUS: How many duplicate usernames are there?

9. More practice with aggregate functions:

a. Find the historic average salary for all employees. Now determine the current average salary.
b. Now find the historic average salary for each employee. Reminder that when you hear "for each" in the problem statement, you'll probably be grouping by that exact column.
c. Find the current average salary for each employee.
d. Find the maximum salary for each current employee.
e. Now find the max salary for each current employee where that max salary is greater than $150,000.
f. Find the current average salary for each employee where that average salary is between $80k and $90k.
*/

USE employees;

#2 -- 7 unique titles
SELECT count(DISTINCT title)
FROM titles;

#3
SELECT last_name
FROM employees
WHERE last_name LIKE 'e%e'
GROUP BY last_name;

#4
SELECT CONCAT(first_name, ' ', last_name) as full_name
FROM employees
WHERE last_name LIKE 'E%E'
GROUP BY full_name;

#5 -- Chleq, Lindqvist, Qiwen
SELECT DISTINCT last_name
FROM employees
WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%';

#6
SELECT last_name, count(*)
FROM employees
WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%'
GROUP BY last_name;

#7
SELECT gender, count(*)
FROM employees
WHERE first_name IN('Irena', 'Vidya', 'Maya')
GROUP BY gender;

#8 -- There are 300,024 usernames total. 285,872 unique usernames implies duplicate usernames. The difference says there are 14,152 duplicates.
SELECT CONCAT(
SUBSTR(LOWER(first_name), 1, 1), 
SUBSTR(LOWER(last_name), 1, 4),
 '_', 
 SUBSTR(birth_date, 6, 2), 
 SUBSTR(birth_date, 3, 2)
 ) AS username
FROM employees #finishing the query here returns 300,024 rows
GROUP BY username #adding GROUP BY returns 285,872 rows
HAVING COUNT(username) > 1; #counting all the  usernames that occur more than once gives 13,251 usernames with duplicates

#9a -- $63,810.74 historic avg. $72,012.24 current avg
SELECT AVG(salary)
FROM salaries
WHERE to_date > CURDATE();

#9b
SELECT emp_no, AVG(salary)
FROM salaries
GROUP BY emp_no;

#9c
SELECT emp_no, AVG(salary)
FROM salaries
WHERE to_date > CURDATE()
GROUP BY emp_no;

#9d
SELECT emp_no, MAX(salary)
FROM salaries
GROUP BY emp_no;

#9e
SELECT emp_no, MAX(salary) as maximum_effort
FROM salaries
GROUP BY emp_no
HAVING maximum_effort > 150000;

#9f
SELECT emp_no, AVG(salary) AS salaries
FROM salaries
WHERE to_date > CURDATE()
GROUP BY emp_no
HAVING salaries BETWEEN 80000 AND 90000;
