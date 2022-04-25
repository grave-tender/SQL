SELECT e.last_name, e.department_id, d.department_name
FROM employees e LEFT OUTER JOIN departments d
ON (e.department_id = d.department_id)
WHERE e.last_name = 'Grant'
;

SELECT e.last_name, e.department_id, d.department_name
FROM employees e RIGHT OUTER JOIN departments d
ON (e.department_id = d.department_id)
;

SELECT e.last_name, e.department_id, d.department_name
FROM employees e FULL OUTER JOIN departments d
ON (e.department_id = d.department_id)
;

SELECT * FROM employees e WHERE e.last_name = 'Grant';
SELECT * FROM departments;
SELECT * FROM jobs j ;

SELECT *
FROM employees e RIGHT OUTER JOIN departments d
ON (e.department_id = d.department_id)
WHERE e.last_name = 'Grant';
;

SELECT *
FROM employees e RIGHT OUTER JOIN jobs j
ON (e.job_id = j.job_id)
WHERE e.last_name = 'Grant';
;

SELECT *
FROM jobs j
LEFT OUTER JOIN employees e
ON (e.job_id = j.job_id)
WHERE e.last_name = 'Grant';
;


SELECT chat.last_name, d.department_name, d.department_id
FROM employees chat
CROSS JOIN departments d;

SELECT worker.last_name "workers name", manager.last_name "managers name"
FROM employees worker JOIN employees manager
ON (worker.manager_id = manager.employee_id)
;

/*=====================================DDL=====================================*/

--connecte toi avec system user
show user;

CREATE TABLE hire_dates1(
    id NUMBER(8) ,
    hire_dates1 DATE DEFAULT sysdate );

INSERT INTO hire_dates1(ID, HIRE_DATE1) values (10, SYSDATE);

DELETE hire_dates1;

CREATE TABLE passenger (
    p_id number(4),
    name VARCHAR2(20) not null,
    email VARCHAR2(30),
    constraint pass_id_pk primary key(p_id),
    constraint pass_email_eq unique(email)
);

drop table hire_dates1;
drop table booking;

CREATE TABLE booking(
    booking_id number(4),
    prix number(9),
    p_id number(4),
    ville_depart VARCHAR2(20) not null,
    ville_arrivee VARCHAR2(20) not null,
    constraint book_id_pk primary key(booking_id),
    constraint book_p_id_fk foreign key(p_id) --no coma here
        references passenger(p_id),
    constraint book_prix_chk check (prix BETWEEN 100 AND 20000) 
);


INSERT INTO departments (
    department_id,
    department_name,
    manager_id,
    location_id
)
values (
    280,
    'Public Relations',
    100,
    1700
);

SELECT * FROM departments;

--=================EXERCISES

/*
creer les tables suivantes:
1. Hopital 
    h_id  numeric 4
    nom_hopital  string 20
    ville  string 
*/
CREATE TABLE Hopital(
    h_id number(4) primary key,
    nom_hopital VARCHAR2(20) not null,
    ville VARCHAR2(20) not null
);

/*
2. Patient
   p_id
   nom
   prenom
   gendre  M, F
   age  entre 0 et 120 ans
*/
CREATE TABLE Patient(
    p_id number(4) primary key,
    nom VARCHAR2(20) not null,
    prenom VARCHAR2(20) not null,
    gendre CHAR check (gendre = 'M' OR gendre = 'F') not null,
    age number check(age BETWEEN 0 AND 120) not null
);

-- INSERT INTO Patient(
--     p_id,
--     nom,
--     prenom,
--     gendre,
--     age
-- )
-- VALUES (
--     1234,
--     'Carlos',
--     'Leon',
--     'M',
--     23
-- );

/*
3. traitement
     t_id  number(4)
     p_id
     h_id
     date 

     Chapitre 10 slide 28...   A la place de ( Employees table)  ----> workers
*/

CREATE TABLE Traitement(
    p_id number(4),
    h_id number(4),
    date_trait date not null,
    constraint trait_p_id_fk foreign key (p_id) references Patient (p_id),
    constraint trait_h_id_fk foreign key (h_id) references Hopital (h_id)
)
;

DROP TABLE Hopital;
DROP TABLE Patient;
DROP TABLE Traitement;


ALTER TABLE Patient
ADD date_creation date default SYSDATE;

SELECT * FROM Patient;

ALTER TABLE Traitement
ADD type_traitement VARCHAR2(20);

SELECT * FROM Traitement; --NEEDS CONTENT TO BE ABLE TO DISPLAY SUMTHING

ALTER TABLE Patient
MODIFY prenom VARCHAR2(40);

SELECT * FROM Patient; --NEEDS CONTENT TO BE ABLE TO DISPLAY SUMTHING

ALTER TABLE Patient
DROP COLUMN date_creation;

UPDATE employees
SET department_id = 50
WHERE employee_id = 113;

UPDATE employees
SET job_id = (
	SELECT job_id
	FROM employees
	WHERE employee_id = 205),
salary = (
	SELECT salary
	FROM employees
	WHERE employee_id = 205)
WHERE employee_id = 113;

