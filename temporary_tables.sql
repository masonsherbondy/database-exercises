/* Create a file named temporary_tables.sql to do your work for this exercise.

/* 1. Using the example from the lesson, create a temporary table called employees_with_departments that contains first_name, last_name, and dept_name for employees currently with that department. Be absolutely sure to create this table on your own database. If you see "Access denied for user ...", it means that the query was attempting to write a new table to a database that you can only read.
*/
CREATE TEMPORARY TABLE hopper_1550.employees_with_departments AS 
	SELECT first_name, last_name, dept_name
	FROM employees.employees
	JOIN employees.dept_emp USING(emp_no)
	JOIN employees.departments USING(dept_no);

#a. Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns
ALTER TABLE hopper_1550.employees_with_departments ADD full_name VARCHAR(31); # +1 for space

#b. Update the table so that full name column contains the correct data
UPDATE hopper_1550.employees_with_departments
SET full_name = CONCAT(first_name, ' ', last_name);

#c. Remove the first_name and last_name columns from the table.
ALTER TABLE hopper_1550.employees_with_departments DROP COLUMN first_name;
ALTER TABLE hopper_1550.employees_with_departments DROP COLUMN last_name;

#d. What is another way you could have ended up with this same table?
CREATE TEMPORARY TABLE hopper_1550.employees_with_departments AS 
	SELECT CONCAT(first_name, ' ', last_name) AS full_name, dept_name
	FROM employees.employees
	JOIN employees.dept_emp USING(emp_no)
	JOIN employees.departments USING(dept_no);

#2. Create a temporary table based on the payment table from the sakila database.

CREATE TEMPORARY TABLE hopper_1550.sakila_payments_copy AS
SELECT *
FROM sakila.payment;

#Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of cents of the payment. For example, 1.99 should become 199.
ALTER TABLE hopper_1550.sakila_payments_copy ADD amount1 INT UNSIGNED NOT NULL;
UPDATE hopper_1550.sakila_payments_copy SET amount1 = amount *100;
ALTER TABLE hopper_1550.sakila_payments_copy DROP amount;
ALTER TABLE hopper_1550.sakila_payments_copy RENAME COLUMN amount1 TO amount;

SELECT *
FROM hopper_1550.sakila_payments_copy;

DROP TABLE hopper_1550.sakila_payments_copy;

#3. Find out how the current average pay in each department compares to the overall, historical average pay. In order to make the comparison easier, you should use the Z-score for salaries. In terms of salary, what is the best department right now to work for? The worst?
USE employees;

SELECT AVG(salary)
FROM salaries; #AS historical mean

SELECT AVG(salary) 
FROM salaries s
JOIN dept_emp de USING(emp_no)
JOIN departments USING(dept_no)
WHERE s.to_date > NOW() AND de.to_date > NOW()
GROUP BY dept_name; #AS raw data points

SELECT STDDEV(salary)
FROM salaries; #AS standard deviation of historic salaries

CREATE TEMPORARY TABLE hopper_1550.z_scores AS
SELECT dept_name, ROUND(AVG(salary),2) AS curr_avg, (SELECT ROUND(AVG(salary),2) FROM salaries) AS hist_avg
FROM salaries s
JOIN dept_emp de USING(emp_no)
JOIN departments d USING(dept_no)
WHERE s.to_date > NOW() AND de.to_date > NOW()
GROUP BY dept_name;


ALTER TABLE hopper_1550.z_scores
ADD z_score DEC(4,2);

UPDATE hopper_1550.z_scores
SET z_score = (curr_avg - hist_avg)/ (SELECT STDDEV(salary) FROM salaries);

SELECT *
FROM hopper_1550.z_scores
ORDER BY curr_avg DESC;

#The best department to work for right now is Sales. The worst department to work for is Human Resources.

DROP TABLE hopper_1550.z_scores;