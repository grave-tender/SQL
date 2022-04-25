-- 1.	Display details of jobs where the minimum salary is greater than 10000.
SELECT j.*
FROM JOBS j
WHERE j.min_salary > 10000;

-- 2.	Display the first name and join date of the employees who joined between 2002 and 2005.
SELECT e.first_name, e.hire_date
FROM employees e
WHERE e.hire_date BETWEEN '01-JAN-2002' AND '01-JAN-2005';

-- 3.	Display first name and join date of the employees who is either IT Programmer or Sales Man. 
SELECT e.first_name, e.hire_date
FROM employees e
JOIN jobs j
ON (e.job_id = j.job_id)
WHERE j.job_title LIKE 'IT Programmer' OR j.job_title LIKE 'Sales Manager';

-- 4.	Display employees who joined after 1st January 2008.
SELECT e.*
FROM employees e
WHERE e.hire_date > '01-JAN-2008';

-- 5.	Display details of employees with ID 150 or 160.
SELECT e.*
FROM employees e
WHERE e.employee_id = 150 OR e.employee_id = 160;

-- 6.	Display first name, salary, commission pct, and hire date for employees with salary less than 10000.
SELECT e.first_name, e.salary, e.commission_pct, e.hire_date
FROM employees e
WHERE salary < 10000;

-- 7.	Display job Title, the difference between minimum and maximum salaries for jobs with max salary in the range 10000 to 20000.
SELECT j.job_title, j.max_salary - j.min_salary salary_difference
FROM jobs j
WHERE j.max_salary - j.min_salary BETWEEN 10000 AND 20000;

-- 8.	Display first name, salary, and round the salary to thousands.
SELECT e.first_name, ROUND( e.salary, -3) rounded_salary
FROM employees e;

-- 9.	Display details of jobs in the descending order of the title.
SELECT j.*
FROM jobs j
ORDER BY j.job_title DESC;

-- 10.	Display employees where the first name or last name starts with S.
SELECT e.*
FROM employees e
WHERE e.first_name LIKE 'S%' OR e.e.last_name LIKE 'S%';

-- 11.	Display employees who joined in the month of May.
SELECT *
FROM employees e
WHERE e.hire_date LIKE '%MAY%';

-- 12.	Display details of the employees where commission percentage is null and salary in the range 5000 to 10000 and department is 30.
SELECT e.*
FROM employees e
JOIN departments d
ON (e.department_id = d.department_id)
WHERE e.commission_pct IS NULL
AND salary BETWEEN 5000 AND 10000
AND e.department_id = 30;

-- 13.	Display first name and date of first salary of the employees.
SELECT e.first_name, e.hire_date + 14 first_salary
FROM employees e;

-- 14.	Display first name and experience of the employees.
SELECT e.first_name, jh.*
FROM employees e
JOIN job_history jh
ON e.employee_id = jh.employee_id;

-- 15.	Display first name of employees who joined in 2001.
SELECT e.first_name
FROM employees e
WHERE e.hire_date LIKE '%01';

-- 16.	Display first name and last name after converting the first letter of each name to upper case and the rest to lower case.
SELECT
    UPPER(SUBSTR(e.first_name, 0, 1)) || LOWER(SUBSTR(e.first_name, 2, LENGTH(e.first_name))) first_name_formatted,
    UPPER(SUBSTR(e.last_name, 0, 1)) || LOWER(SUBSTR(e.last_name, 2, LENGTH(e.last_name))) last_name_formatted
FROM employees e;

-- 17.	Display the first word in the job title.
SELECT SUBSTR(j.job_title, 0, REGEXP_INSTR(j.job_title, ' |$')) job_title_first_word
FROM jobs j;

-- 18.	Display the length of the first name for employees where the last name contains character ‘b’ after 3rd position.
SELECT e.first_name
FROM employees e
WHERE SUBSTR(e.last_name, 3,1) LIKE 'b';

-- 19?	Display first name in upper case and email address in lower case for employees where the first name and email address are the same irrespective of the case.
SELECT UPPER(e.first_name), LOWER(e.email)
FROM employees e
WHERE LOWER(e.first_name) LIKE LOWER(e.email);


-- 20.	Display employees who joined in the current year.
SELECT e.*
FROM employees e
WHERE SUBSTR(e.hire_date, 8) LIKE SUBSTR(SYSDATE, 8);

-- 21.	Display the number of days between system date and 1st January 2011.
SELECT ROUND(SYSDATE - TO_DATE('01-01-2011', 'DD-MM-YYYY'), 0) - 1 days_since_JAN_2011 FROM DUAL;

-- 22.	Display how many employees joined in each month of the current year.
SELECT COUNT(*)
FROM employees e
WHERE SUBSTR(hire_date,4,3) LIKE SUBSTR(SYSDATE,4,3);

-- 23.	Display manager ID and number of employees managed by the manager.
SELECT d.manager_id, COUNT(*)
FROM employees e
JOIN departments d
ON (e.department_id = d.department_id)
GROUP BY d.manager_id;

-- 24.	Display employee ID and the date on which he ended his previous job.
SELECT e.employee_id, jh.end_date
FROM employees e
JOIN job_history jh
ON(e.employee_id = jh.employee_id)
WHERE jh.end_date IS NOT NULL;

-- 25.	Display number of employees joined after 15th of the month.
SELECT COUNT(*)
FROM employees e
WHERE SUBSTR(e.hire_date,0,2) LIKE '15';

-- 26.	Display the country ID and number of cities we have in the country.
SELECT c.country_id, COUNT(l.city)
FROM countries c
JOIN locations l
ON (c.country_id = l.country_id)
GROUP BY c.country_id;

-- 27.	Display the average salary of employees in each department who have commission percentage.
SELECT AVG(e.salary)
FROM employees e
WHERE e.commission_pct IS NOT NULL
GROUP BY e.department_id;

-- 28.	Display job ID, number of employees, sum of salary, and difference between highest salary and lowest salary of the employees of the job.
SELECT
    j.job_id,
    COUNT(e.employee_id),
    SUM(e.salary),
    j.max_salary - j.min_salary
FROM jobs j
JOIN employees e
ON (j.job_id = e.job_id)
GROUP BY j.job_id, j.max_salary, j.min_salary;

-- 29.	Display job ID for jobs with average salary more than 10000.
SELECT j.job_id, (j.max_salary - j.min_salary)/2
FROM jobs j
WHERE (j.max_salary - j.min_salary)/2 > 10000;

-- 30.	Display years in which more than 10 employees joined.
SELECT SUBSTR(e.hire_date, 8, 2), COUNT(SUBSTR(e.hire_date, 8, 2))
FROM employees e
GROUP BY SUBSTR(e.hire_date, 8, 2);

-- 31?	Display departments in which more than five employees have commission percentage.
SELECT e.department_id
FROM employees e
WHERE e.commission_pct IS NOT NULL
GROUP BY e.department_id
HAVING COUNT(e.commission_pct)>5;

-- 32.	Display employee ID for employees who did more than one job in the past.
SELECT e.employee_id
FROM employees e
JOIN job_history jh
ON (e.employee_id = jh.employee_id);

-- 33?	Display job ID of jobs that were done by more than 3 employees for more than 100 days.
SELECT jh.job_id
FROM job_history jh
WHERE jh.end_date-jh.start_date > 100
GROUP BY jh.job_id
HAVING COUNT(*)>=3;


-- 34?	Display department ID, year, and Number of employees joined.
SELECT e.department_id, &year, COUNT(e.employee_id)
FROM employees e
GROUP BY e.department_id, e.hire_date, TO_DATE(&year, 'YYYY')
HAVING '20' || SUBSTR(e.hire_date, 8, 2) LIKE &year;

-- 35. Display departments where any manager is managing more than 5 employees.
SELECT e.department_id
FROM employees e
GROUP BY e.department_id
HAVING COUNT(e.employee_id) > 5;