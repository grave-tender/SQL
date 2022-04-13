--1. Afficher nom, prenom, nom de department.
select e.FIRST_NAME, e.LAST_NAME, d.DEPARTMENT_NAME
from EMPLOYEES e join DEPARTMENTS d
on (e.DEPARTMENT_ID = d.DEPARTMENT_ID)
;

--2. Afficher les departments qui ont plus de 5 employees department_id, department_name
select e.DEPARTMENT_ID, d.DEPARTMENT_NAME, COUNT(*)
from EMPLOYEES e join DEPARTMENTS d
on (e.DEPARTMENT_ID = d.DEPARTMENT_ID)
group by e.DEPARTMENT_ID, d.DEPARTMENT_NAME
having COUNT(*) >= 5
;

--3. Afficher tous les departments : department name , ville et le pays
select d.DEPARTMENT_NAME, l.CITY, c.COUNTRY_NAME
from DEPARTMENTS d
join LOCATIONS l
on (d.LOCATION_ID = l.LOCATION_ID)
join COUNTRIES c
on (l.COUNTRY_ID = c.COUNTRY_ID)
;

--4. Afficher tous les employees qui ont un salaire plus que la moyenne de salaire de department 90
select e.*
from EMPLOYEES e
where e.SALARY > (
    select AVG(e.SALARY)
    from EMPLOYEES e
    where e.DEPARTMENT_ID = 90
)
;

--5. Afficher le nombre d employees par ville:
select l.city, COUNT(l.city)
from locations l
join departments d
on (l.location_id = d.location_id)
join employees e
on (d.department_id = e.department_id)
group by l.city;