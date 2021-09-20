/* 1. Create a new SQL script named limit_exercises.sql.

2. MySQL provides a way to return only unique results from our queries with the keyword DISTINCT. For example, to find all the unique titles within the company, we could run the following query:

SELECT DISTINCT title FROM titles;
List the first 10 distinct last name sorted in descending order.

3. Find all previous or current employees hired in the 90s and born on Christmas. Find the first 5 employees hired in the 90's by sorting by hire date and limiting your results to the first 5 records. Write a comment in your code that lists the five names of the employees returned.

4. Try to think of your results as batches, sets, or pages. The first five results are your first page. The five after that would be your second page, etc. Update the query to find the tenth page of results.

LIMIT and OFFSET can be used to create multiple pages of data. What is the relationship between OFFSET (number of results to skip), LIMIT (number of results per page), and the page number?

*/

SELECT DISTINCT title FROM titles;

#2
SELECT DISTINCT last_name
FROM employees
ORDER BY last_name DESC
LIMIT 10;
#Results: 1. Zykh 2. Zyda 3. Zwicker 4. Zweizig 5. Zumaque 6. Zultner 7. Zucker 8. Zuberek 9. Zschoche 10. Zongker

#3
SELECT *
FROM employees
WHERE hire_date LIKE "199%" AND birth_date LIKE "%12-25"
ORDER BY hire_date ASC
LIMIT 5;
#Results: First hire: Alselm Cappello 2. Utz Mandell 3. Bouchung Schreiter 4. Baocai Kushner 5. Petter Stroustrup

#4
SELECT *
FROM employees
WHERE hire_date LIKE "199%" AND birth_date LIKE "%12-25"
ORDER BY hire_date
LIMIT 5 OFFSET 45;
#To reiterate, the limit is the size of the page. You can determine how many pages you want to skip (offset) by multiplying the page size (limit) by the number of pages you need to skip. If you skip 9 pages, you arrive at page 10. If you skip 10 pages, you arrive at page 11. If my LIMIT is 8, my query will display a page of 8 results. If I want to skip the first 7 pages, I would OFFSET my query by 56 results. This will bring me to page 8, and it will give me 8 results (page size).
#The relationship between OFFSET and the LIMIT and the page number is LIMIT determines page size which subsequently determines the OFFSET value if you want to navigate the data by page number. The OFFSET value is determined by the product of LIMIT and number of pages you want to skip.
#Let OFFSET value be "OFv" and LIMIT value be "L" and desired page number be "p". Lp-L = OFv or we could do L(p-1) = OFv