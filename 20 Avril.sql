SELECT employee_id, job_id FROM employees
INTERSECT
SELECT employee_id, job_id FROM job_history;

select * from employees where employee_id = 113;
select * from job_history where employee_id = 113;

SELECT employee_id FROM employees
MINUS
SELECT employee_id FROM job_history;

SELECT employee_id, job_id, salary FROM employees
UNION
SELECT employee_id, job_id, 0 FROM job_history;

SELECT *
FROM employees
WHERE salary > (
    SELECT salary
    FROM employees
    WHERE last_name = 'Abel'
);

select * from employees where last_name = 'Abel';

SELECT employee_id, last_name, job_id, salary
FROM   employees
WHERE  salary < ALL (
    SELECT salary
    FROM   employees
    WHERE  job_id = 'IT_PROG'
)
AND    job_id <> 'IT_PROG';

select last_name,job_id,salary
from employees
where job_id IN (SELECT job_id
FROM employees
WHERE last_name = 'Taylor')
AND salary IN (SELECT salary
FROM employees
WHERE last_name = 'Taylor');

SELECT emp.last_name
FROM   employees emp
WHERE  emp.employee_id NOT IN(
    SELECT mgr.manager_id
    FROM   employees mgr
);
