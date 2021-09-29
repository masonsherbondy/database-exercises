/* Create a file named case_exercises.sql and craft queries to return the results for the following criteria:

BONUS

What is the current average salary for each of the following department groups: R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?

+-------------------+-----------------+
| dept_group        | avg_salary      |
+-------------------+-----------------+
| Customer Service  |                 |
| Finance & HR      |                 |
| Sales & Marketing |                 |
| Prod & QM         |                 |
| R&D               |                 |
+-------------------+-----------------+
*/
USE employees;
#1. Write a query that returns all employees (emp_no), their department number, their start date, their end date, and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not.

SELECT emp_no, dept_no, hire_date AS start_date,
	CASE WHEN dept_emp.to_date > NOW() THEN 1
	ELSE 0
	END AS is_current_employee,
	CASE WHEN dept_emp.to_date NOT LIKE '9999%' THEN dept_emp.to_date
	ELSE NULL
	END AS end_date
FROM employees
JOIN dept_emp USING(emp_no);

#2. Write a query that returns all employee names (previous and current), and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name.
SELECT CONCAT(first_name, ' ', last_name) AS employee,
	CASE WHEN SUBSTR(last_name, 1, 1) IN ('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H') THEN 'A-H'
		 WHEN SUBSTR(last_name, 1, 1) IN ('I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q') THEN 'I-Q'
		 WHEN SUBSTR(last_name, 1, 1) IN ('R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z') THEN 'R-Z'
		ELSE NULL
		END AS alpha_group
FROM employees;

#3. How many employees (current or previous) were born in each decade?
SELECT 
	CASE
		WHEN birth_date LIKE '195%' THEN '1950s'
		WHEN birth_date LIKE '196%' THEN '1960s'
		ELSE NULL
		END AS decade,
	COUNT(*)
FROM employees
GROUP BY decade;

