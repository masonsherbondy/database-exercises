/*1. Create a file named where_exercises.sql. Make sure to use the employees database.

2. Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya' using IN. Enter a comment with the number of records returned.
709 rows affected

3. Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', as in Q2, but use OR instead of IN. Enter a comment with the number of records returned. Does it match number of rows from Q2?
241 rows affected. jk 709 rows affected after more letters

4. Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', using OR, and who is male. Enter a comment with the number of records returned.
619 rows affected

5. Find all current or previous employees whose last name starts with 'E'. Enter a comment with the number of employees whose last name starts with E.
7330 rows affected. 7330 employees have a last name that starts with 'E'.

6. Find all current or previous employees whose last name starts or ends with 'E'. Enter a comment with the number of employees whose last name starts or ends with E. How many employees have a last name that ends with E, but does not start with E?
30,723 employees have a last name that starts with or ends with 'e'. 23,393 employees have a last name that ends with and does not start with 'e'.

7. Find all current or previous employees employees whose last name starts and ends with 'E'. Enter a comment with the number of employees whose last name starts and ends with E. How many employees' last names end with E, regardless of whether they start with E?
899 employees have a last name that starts and ends with 'e'. 24,292 employees have a last name that ends with 'e', regardless of whether they start with 'e'.

8. Find all current or previous employees hired in the 90s. Enter a comment with the number of employees returned.
135,214 employees returned

9. Find all current or previous employees born on Christmas. Enter a comment with the number of employees returned.
842 employees returned

10. Find all current or previous employees hired in the 90s and born on Christmas. Enter a comment with the number of employees returned.
362 employees returned

11. Find all current or previous employees with a 'q' in their last name. Enter a comment with the number of records returned.
1,873 employees have a 'q' in their last name

12. Find all current or previous employees with a 'q' in their last name but not 'qu'. How many employees are found?
547 employees were found
*/


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