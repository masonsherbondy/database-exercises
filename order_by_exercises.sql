/*1.Create a new file named order_by_exercises.sql and copy in the contents of your exercise from the previous lesson.

2. Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name. In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?

3. Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name and then last name. In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?

4. Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by last name and then first name. In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?

5. Write a query to to find all employees whose last name starts and ends with 'E'. Sort the results by their employee number. Enter a comment with the number of employees returned, the first employee number and their first and last name, and the last employee number with their first and last name.

6. Write a query to to find all employees whose last name starts and ends with 'E'. Sort the results by their hire date, so that the newest employees are listed first. Enter a comment with the number of employees returned, the name of the newest employee, and the name of the oldest emmployee.

7. Find all employees hired in the 90s and born on Christmas. Sort the results so that the oldest employee who was hired last is the first result. Enter a comment with the number of employees returned, the name of the oldest employee who was hired last, and the name of the youngest emmployee who was hired first.

*/

#WHERE Exercises here
#1
USE employees;

#2
SELECT *
FROM employees
WHERE first_name IN('Irena', 'Vidya', 'Maya');

#3
SELECT *
FROM employees
WHERE first_name = 'Irena' OR first_name = 'Vidya' OR first_name = 'Maya';

#4
SELECT *
FROM employees
WHERE first_name = 'Irena' OR first_name = 'Vidya' OR first_name = 'Maya'
AND gender = 'M';

#5
SELECT *
FROM employees
WHERE last_name LIKE "e%";

#6
SELECT *
FROM employees
WHERE last_name LIKE "e%" OR last_name LIKE "%e";
#6a
SELECT *
FROM employees
WHERE last_name LIKE "%e" AND last_name NOT LIKE "e%";

#7
SELECT *
FROM employees
WHERE last_name LIKE "E%" AND last_name LIKE "%E";
#7a
SELECT *
FROM employees
WHERE last_name LIKE "%e";

#8
SELECT *
FROM employees
WHERE hire_date LIKE "199%";

#9
SELECT *
FROM employees
WHERE birth_date LIKE "%12-25";

#10
SELECT *
FROM employees
WHERE hire_date LIKE "199%" AND birth_date LIKE "%12-25";

#11
SELECT *
FROM employees
WHERE last_name LIKE "%q%";

#12
SELECT *
FROM employees
WHERE last_name LIKE "%q%" AND last_name NOT LIKE "%qu%";


#Order Exercises
#2
SELECT *
FROM employees
WHERE first_name IN('Irena', 'Vidya', 'Maya')
ORDER BY first_name;
#Irena Reutenauer first result and Vidya Simmen last result

#3
SELECT *
FROM employees
WHERE first_name IN('Irena', 'Vidya', 'Maya')
ORDER BY first_name, last_name;
#Irena Acton first result and Vidya Zweizig last result

#4
SELECT *
FROM employees
WHERE first_name IN('Irena', 'Vidya', 'Maya')
ORDER BY last_name, first_name;
#Irena Acton first result and Maya Zyda last result

#5
SELECT *
FROM employees
WHERE last_name LIKE "E%" AND last_name LIKE "%E"
ORDER BY emp_no;
#899 employees returned; first result 10021 Ramzi Erde; last result 499648 Tadahiro Erde

#6
SELECT *
FROM employees
WHERE last_name LIKE "E%" AND last_name LIKE "%E"
ORDER BY hire_date DESC;
#899 employees returned; Teiji Eldridge newest employee; Sergi Erde oldest employee

#7
SELECT *
FROM employees
WHERE hire_date LIKE "199%" AND birth_date LIKE "%12-25"
ORDER BY birth_date ASC, hire_date DESC;
#362 employees returned; Khun Bernini is the latest hire that is the oldest; Douadi Pettis is the youngest christmas baby to be hired first