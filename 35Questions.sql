-- Exercises SQL
-- Part 2
-- 1.	Change salary of employee 115 to 8000 if the existing salary is less than 6000.
SELECT * FROM Employees WHERE employee_id = 115;

UPDATE Employees
SET salary = 8000
WHERE
    employee_id = 115
    AND
    salary < 6000;

SELECT * FROM Employees WHERE employee_id = 115;
-- 2.	Insert a new employee into employees with all the required details.
SELECT * FROM Employees;

INSERT INTO Employees (
    employee_id,
    first_name,
    last_name,
    email,
    phone_number,
    hire_date,
    job_id,
    salary,
    commission_pct,
    manager_id,
    department_id
    )
VALUES (
    EMPLOYEES_SEQ.nextval,
    'Carlos',
    'Leon',
    'CLEON',
    '515.123.1234',
    SYSDATE,
    'PR_REP',
    100000,
    NULL,
    101,
    110
);

SELECT * FROM Employees;

-- 3.	Delete department 20.
SELECT * FROM Employees WHERE department_id = 20;

SELECT * FROM Job_history WHERE department_id = 20;

UPDATE Job_history
SET department_id = NULL
WHERE department_id = 20;

ALTER TABLE Job_history
NOCHECK CONSTRAINT jhist_emp_id_st_date_pk;

UPDATE Employees
SET department_id = NULL
WHERE department_id = 20;

DELETE FROM Departments
WHERE department_id = 20;

-- 4.	Change job ID of employee 110 to IT_PROG if the employee belongs to department 10 and the existing job ID does not start with IT.
SELECT job_id FROM Employees WHERE employee_id = 110;

UPDATE Employees
SET job_id = 'IT_PROG'
WHERE employee_id = 110;
-- 5.	Insert a row into departments table with manager ID 120 and location ID in any location ID for city Tokyo.
SELECT location_id FROM Locations WHERE city = 'Tokyo';
INSERT INTO Departments(department_id, department_name, manager_id, location_id)
VALUES (
    departments_seq.NEXTVAL,
    'Unicorn Care',
    120,
    1200
);

SELECT * FROM Departments;
-- 6.	Display department name and number of employees in the department.
SELECT d.department_name, COUNT(e.department_id)
FROM Departments d
JOIN Employees e
ON (e.department_id = d.department_id)
GROUP BY d.department_name;

-- 7.	Display job title, employee ID, number of days between ending date and starting date for  
--for?... for what? turn down for what! *music*
SELECT jh.employee_id, j.job_title, jh.end_date-jh.start_date Days
FROM Job_history jh
JOIN Jobs j
ON (j.job_id = jh.job_id) 
WHERE department_id=90;
-- 8.	Display department name and manager first name.
SELECT d.department_name, e.first_name
FROM Departments d
JOIN Employees e
ON (e.department_id = d.department_id);

-- 9.	Display department name, manager name, and city.

SELECT d.department_name, e.first_name, l.city
FROM Departments d
JOIN Employees e
ON (e.department_id = d.department_id)
JOIN Locations l
ON (d.location_id = l.location_id);

-- 10.	Display country name, city, and department name.

SELECT c.country_name, d.department_name, e.first_name, l.city
FROM Departments d
JOIN Employees e
ON (e.department_id = d.department_id)
JOIN Locations l
ON (d.location_id = l.location_id)
JOIN Countries c
ON (l.country_id = c.country_id);

-- 11.	Display job title, department name, employee last name, starting date for all jobs from 2000 to 2005.
SELECT j.job_title, c.country_name, d.department_name, e.first_name, l.city
FROM Departments d
JOIN Employees e
ON (e.department_id = d.department_id)
JOIN Locations l
ON (d.location_id = l.location_id)
JOIN Countries c
ON (l.country_id = c.country_id)
JOIN Jobs j
ON (e.job_id = j.job_id);

-- 12.	Display job title and average salary of employees
SELECT j.job_title, AVG(e.salary) Average_Salary
FROM Jobs j
JOIN Employees e
ON (j.job_id = e.job_id)
GROUP BY j.job_title;

-- 13.	Display job title, employee name, and the difference between maximum salary for the job and salary of the employee.
SELECT j.job_title, e.first_name, j.max_salary - j.min_salary Difference_min_max_salaries
FROM Jobs j
JOIN Employees e
ON (j.job_id = e.job_id);

-- 14.	Display last name, job title of employees who have commission percentage and belongs to department 30.
SELECT e.last_name, j.job_title
FROM Employees e
JOIN Jobs j
ON (e.job_id = j.job_id)
WHERE e.commission_pct IS NOT NULL
AND e.department_id = 30;

-- 15.	Display details of jobs that were done by any employee who is currently drawing more than 15000 of salary.
SELECT j.*
FROM Jobs j
JOIN Employees e
ON (j.job_id = e.job_id)
WHERE e.salary > 15000;

-- 16.	Display department name, manager name, and salary of the manager for all managers whose experience is more than 5 years.
SELECT d.department_name, e.first_name, e.salary, jh.end_date - jh.start_date Experience_days
FROM Departments d
JOIN Employees e
ON (e.department_id = d.department_id)
JOIN Job_history jh
ON (e.job_id = jh.job_id)
WHERE jh.end_date - jh.start_date > 5 * 365 
;

-- 17.	Display employee name if the employee joined before his manager.
SELECT e.first_name
FROM Employees e
JOIN Departments d
ON (e.department_id = d.department_id)
JOIN Job_history jh
ON (jh.job_id = e.job_id)
WHERE jh.start_date < ANY (
    SELECT jh.start_date
    FROM Employees e
    JOIN Departments d
    ON (e.department_id = d.department_id)
    JOIN Job_history jh
    ON (jh.job_id = e.job_id)
    WHERE d.manager_id = e.employee_id
)
AND e.employee_id <> d.manager_id;

-- 18.	Display employee name, job title for the jobs employee did in the past where the job was done less than six months.
SELECT e.first_name, j.job_title
FROM Employees e
JOIN Jobs j
ON (e.job_id = j.job_id)
JOIN Job_history jh
ON (jh.job_id = e.job_id)
WHERE jh.end_date - jh.start_date > 182;
-- 19.	Display employee name and country in which he is working.
SELECT e.first_name, c.country_name
FROM Departments d
JOIN Employees e
ON (e.department_id = d.department_id)
JOIN Locations l
ON (d.location_id = l.location_id)
JOIN Countries c
ON (l.country_id = c.country_id)
JOIN Jobs j
ON (e.job_id = j.job_id);

-- 20.	Display department name, average salary and number of employees with commission within the department.
SELECT d.department_name, AVG(e.salary), COUNT(e.commission_pct)
FROM Departments d
JOIN Employees e
ON (e.department_id = d.department_id)
GROUP BY d.department_name;

-- 21.	Display the month in which more than 2 employees joined in any department located in Seattle. (Sydney dont exist lol)
SELECT SUBSTR(e.hire_date, 4, 3) FROM Employees e
JOIN Departments d
ON (e.department_id = d.department_id)
JOIN Locations l
ON (d.location_id = l.location_id)
WHERE l.city LIKE 'Seattle'
GROUP BY SUBSTR(e.hire_date, 4, 3)
HAVING COUNT(*) >= 2
;

-- 22.	Display details of departments in which the maximum salary is more than 10000.
SELECT d.*
FROM Departments d
JOIN Employees e
ON (d.department_id = e.department_id)
JOIN Jobs j
ON (j.job_id = e.job_id)
WHERE j.max_salary > 10000
;

-- 23.	Display details of departments managed by ‘Smith’.
SELECT d.*
FROM Departments d
JOIN Employees e
ON (d.department_id = e.department_id)
JOIN Jobs j
ON (j.job_id = e.job_id)
WHERE e.first_name LIKE 'Steven'
;
-- 24.	Display jobs into which employees joined in the current year.
SELECT j.*
FROM Jobs j
JOIN Employees e
ON (e.job_id = j.job_id)
WHERE SUBSTR(e.hire_date, 8, 2) LIKE 22
;
-- 25.	Display employees who did not do any job in the past.
SELECT e.*
FROM Employees e
WHERE e.employee_id NOT IN (
    SELECT e.employee_id
    FROM Employees e
    JOIN Job_history jh
    ON (e.employee_id = jh.employee_id)
);

-- 26.	Display job title and average salary for employees who did a job in the past.
SELECT j.job_title, AVG(e.salary)
FROM Employees e
JOIN Job_history jh
ON (e.employee_id = jh.employee_id)
JOIN Jobs j
ON (e.job_id = j.job_id)
GROUP BY j.job_title;

-- 27.	Display country name, city, and number of departments where department has more than 5 employees.
SELECT c.country_name, l.city, COUNT(d.department_id)
FROM Departments d
JOIN Employees e
ON (d.department_id = e.department_id)
JOIN Locations l
ON (d.location_id = d.location_id)
JOIN Countries c
ON (c.country_id = l.country_id)
WHERE d.department_id IN (
    SELECT department_id 
	FROM employees 
    GROUP BY department_id 
    HAVING COUNT(department_id)>=5
)
GROUP BY c.country_name, l.city;

-- 28.	Display details of manager who manages more than 5 employees. TODO: not finished
SELECT e.first_name
FROM employees e
JOIN Departments d
ON (e.department_id = d.department_id)
WHERE d.manager_id = e.employee_id
GROUP BY e.first_name
HAVING 5 < ALL (
    
);

SELECT d.department_id, COUNT(e.FIRST_NAME)
FROM Departments d
JOIN EMPLOYEES e
ON (e.department_id = d.department_id)
GROUP BY d.department_id;

-- 29.	Display employee name, job title, start date, and end date of past jobs of all employees with commission percentage null.
SELECT e.first_name, j.job_title, jh.start_date, jh.end_date
FROM Employees e
JOIN Jobs j
ON (e.job_id = j.job_id)
JOIN Job_history jh
ON (jh.employee_id = e.employee_id)
WHERE e.commission_pct IS NULL;
-- 30.	Display the departments into which no employee joined in last two years.
SELECT d.*
FROM Departments d
JOIN Employees e
ON (d.department_id = e.department_id)
WHERE SUBSTR(e.hire_date, 8, 2) <= (SUBSTR(SYSDATE, 8, 2) - 2);

-- 31.	Display the details of departments in which the max salary is greater than 10000 for employees who did a job in the past.
SELECT d.*
FROM Departments d
JOIN Employees e
ON (d.department_id = e.department_id)
JOIN Jobs j
ON (j.job_id = e.job_id)
JOIN Job_history jh
ON (e.employee_id = jh.employee_id)
WHERE j.max_salary > 10000
;
-- 32.	Display details of current job for employees who worked as IT Programmers in the past.
SELECT j.*
FROM Jobs j
JOIN Employees e
ON (j.job_id = e.job_id)
JOIN Job_history jh
ON (jh.employee_id = jh.employee_id)
WHERE jh.job_id LIKE 'IT_PROG';

-- 33.	Display the details of employees drawing the highest salary in the department.
SELECT e.*
FROM Employees e
JOIN Departments d
ON (e.department_id = d.department_id)
WHERE e.salary >= ALL (
    SELECT e.salary
    FROM Employees e
    WHERE e.department_id = d.department_id
);

-- 34.	Display the city of employee whose employee ID is 105.
SELECT l.city
FROM Locations l
JOIN Departments d
ON (d.location_id = l.location_id)
JOIN Employees e
ON (e.department_id = d.department_id)
WHERE e.employee_id = 105;

-- 35.	Display third highest salary of all employees

SELECT e.salary
FROM Employees e
ORDER BY e.salary DESC;