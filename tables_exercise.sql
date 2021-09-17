-- Use the employees database
USE `employees`;
-- List all tables
SHOW TABLES;
-- Explore the 'employees' table. What different data types are present in this table?
SHOW CREATE TABLE employees; 
-- int, date, varchar, enum

-- Which tables do you think have a numeric column type?
-- dept_manager, departments, dept_emp_latest_date, employees, salaries

-- Which tables do you think have a string column type?
-- i think all of them

-- Which tables do you think have a date column type?
-- dept_emp, dept_emp_latest_date, dept_manager, employees

-- What is the relationship between 'employees' and the 'departments' tables?
SHOW CREATE TABLE departments; 
-- I do not see a relationship between the 'employees' and the 'departments' tables

-- Show the SQL that created the dept_manager table
SHOW CREATE TABLE dept_manager;
-- CREATE TABLE `dept_manager` ( `emp_no` int NOT NULL, `dept_no` char(4) NOT NULL, `from_date` date NOT NULL, `to_date` date NOT NULL,  PRIMARY KEY (`emp_no`,`dept_no`), KEY `dept_no` (`dept_no`), CONSTRAINT `dept_manager_ibfk_1` FOREIGN KEY (`emp_no`) REFERENCES `employees` (`emp_no`) ON DELETE CASCADE ON UPDATE RESTRICT, CONSTRAINT `dept_manager_ibfk_2` FOREIGN KEY (`dept_no`) REFERENCES `departments` (`dept_no`) ON DELETE CASCADE ON UPDATE RESTRICT) ENGINE=InnoDB DEFAULT CHARSET=latin1