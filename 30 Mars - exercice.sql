--1
select 
    EMPLOYEE_ID,
    LAST_NAME
from
    EMPLOYEES
where
    DEPARTMENT_ID in 20 ;

--2
select 
    EMPLOYEE_ID,
    LAST_NAME,
    DEPARTMENT_ID
from
    EMPLOYEES ;

--3
select
    LAST_NAME
from
    EMPLOYEES
where
    DEPARTMENT_ID in 30 
    and
    SALARY > 1500 ;

--4
select
    LAST_NAME
from
    EMPLOYEES
where
    DEPARTMENT_ID in 30 
    and
    SALARY between 2000 and 4000 ;

--5
select
    LAST_NAME
from
    EMPLOYEES
where
    LAST_NAME like 'K%' ;

--6
select
    LAST_NAME
from
    EMPLOYEES
where
    LAST_NAME like '%_e' ;

--extra
select
    LAST_NAME,
    DEPARTMENT_ID
from
    EMPLOYEES
where
    DEPARTMENT_ID = 100
    or
    DEPARTMENT_ID = 201
    and
    LAST_NAME like 'C%' ;

select
    LAST_NAME,
    DEPARTMENT_ID
from
    EMPLOYEES
where
    ( DEPARTMENT_ID = 100
    or
    DEPARTMENT_ID = 201 )
    and
    LAST_NAME like 'C%' ;

select
    LAST_NAME,
    SALARY
from EMPLOYEES
order by SALARY desc ; 

select
    LAST_NAME,
    DEPARTMENT_ID
from EMPLOYEES
where DEPARTMENT_ID = &DEPT
