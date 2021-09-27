/* Create a file named subqueries_exercises.sql and craft queries to return the results for the following criteria:


7. Hint Number 1 You will likely use a combination of different kinds of subqueries.

8. Hint Number 2 Consider that the following code will produce the z score for current salaries.

-- Returns the historic z-scores for each salary
-- Notice that there are 2 separate scalar subqueries involved
SELECT salary, 
    (salary - (SELECT AVG(salary) FROM salaries)) 
    / 
    (SELECT stddev(salary) FROM salaries) AS zscore
FROM salaries;

*/

USE employees;
#1. Find all the current employees with the same hire date as employee 101010 using a sub-query.
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date = (
				SELECT hire_date
				FROM employees
				WHERE emp_no = '101010'
);

#2. Find all the titles ever held by all current employees with the first name Aamod.
SELECT DISTINCT title
FROM titles
WHERE emp_no IN (
				SELECT emp_no
				FROM dept_emp
				JOIN employees USING(emp_no)
				WHERE first_name = 'Aamod' AND to_date > NOW()
);

#3. How many people in the employees table are no longer working for the company? Give the answer in a comment in your code.
SELECT COUNT(emp_no)
FROM employees
WHERE emp_no IN (
				SELECT emp_no
				FROM dept_emp
				WHERE to_date < NOW()
);
# 85,108 employees no longer work for the company

#4. Find all the current department managers that are female. List their names in a comment in your code.
SELECT first_name, last_name, gender
FROM dept_manager dm
JOIN employees e USING(emp_no)
WHERE dm.to_date > NOW() AND emp_no IN (
					SELECT emp_no
					FROM employees
					WHERE gender = 'F'
);
#Isamu Legleitner, Karsten Sigstam, Leon DasSarma, Hilary Kambil
/* wrote subquery into solution, noticed it was more work, simplified query
SELECT first_name, last_name, to_date, gender
FROM dept_manager dm
JOIN employees e USING(emp_no)
WHERE dm.to_date > NOW() AND gender = 'F';
*/

#5. Find all the employees who currently have a higher salary than the companies overall, historical average salary.
SELECT first_name, last_name, salary
FROM employees
JOIN salaries s USING(emp_no)
WHERE s.to_date > NOW() AND salary > (
									SELECT AVG(salary)
									FROM salaries
)
ORDER BY salary;

#6. How many current salaries are within 1 standard deviation of the current highest salary? (Hint: you can use a built in function to calculate the standard deviation.) What percentage of all salaries is this?
SELECT COUNT(salary)
FROM salaries
WHERE to_date > NOW() AND salary > ((
									SELECT salary
									FROM salaries
									WHERE to_date > NOW()
									ORDER BY salary DESC
									LIMIT 1
) - (
		SELECT STDDEV(salary)
		FROM salaries
		WHERE to_date > NOW()
)
);
#83 current salaries are within 1 standard deviation (using current salaries) of the current highest salary
SELECT (
		SELECT COUNT(salary)
		FROM salaries
		WHERE to_date > NOW() AND salary > ((
											SELECT salary
											FROM salaries
											WHERE to_date > NOW()
											ORDER BY salary DESC
											LIMIT 1
) - (
	SELECT STDDEV(salary)
	FROM salaries
	WHERE to_date > NOW()
))
) / (
	SELECT COUNT(salary)
	FROM salaries
	WHERE to_date > NOW()
)*100 AS Percent;
# 83 salaries is .0029% of all salaries and .0346% of all current salaries

# Alternative standard deviation (standard deviation using all data)
SELECT COUNT(salary)
FROM salaries
WHERE to_date > NOW() AND salary > ((
									SELECT salary
									FROM salaries
									WHERE to_date > NOW()
									ORDER BY salary DESC
									LIMIT 1
) - (
		SELECT STDDEV(salary)
		FROM salaries
)
);
#78 current salaries are within 1 standard deviation of the current highest salary

SELECT (
		SELECT COUNT(salary)
		FROM salaries
		WHERE to_date > NOW() AND salary > ((
											SELECT salary
											FROM salaries
											WHERE to_date > NOW()
											ORDER BY salary DESC
											LIMIT 1
) - (
	SELECT STDDEV(salary)
	FROM salaries
))
) / (
	SELECT COUNT(salary)
	FROM salaries
	WHERE to_date > NOW()
)*100 AS Percent;

#78 salaries is .0027% of all salaries and .0325% of all current salaries

#BONUS

#1. Find all the department names that currently have female managers.
SELECT dept_name
FROM departments
JOIN dept_manager USING(dept_no)
WHERE dept_no IN (SELECT dept_no 
					FROM dept_manager dm
					JOIN employees e USING(emp_no)
					WHERE dm.to_date > NOW() AND gender = 'F'

) AND to_date > NOW();

#2. Find the first and last name of the employee with the highest salary.
SELECT first_name, last_name
FROM employees
WHERE emp_no = (SELECT emp_no
				FROM salaries
				ORDER BY salary DESC
				LIMIT 1
);

#3. Find the department name that the employee with the highest salary works in.
SELECT dept_name
FROM departments
JOIN dept_emp USING(dept_no)
WHERE emp_no = (SELECT emp_no
					FROM salaries
					ORDER BY salary DESC
					LIMIT 1
);
#Sales is the department with the highest paid employee, current and historic.

