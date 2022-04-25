--=======================DOODLE=========
CREATE TABLE A(
    a_id number(4) primary key,
    d VARCHAR2(20)
)
;

CREATE TABLE B(
    b_id number(4) primary key,
    d VARCHAR2(20)
)
;

CREATE TABLE C(
    c_id number(4),
    d VARCHAR2(20),
    a_id number(4),
    b_id number(4),
    constraint c_a_id_fk foreign key (a_id) references A (a_id),
    constraint c_b_id_fk foreign key (b_id) references B (b_id)
)
;

INSERT INTO A (
    a_id,
    d
)
VALUES (
    1,
    'data dans A'
);

INSERT INTO B (
    b_id,
    d
)
VALUES (
    1,
    'data dans B'
);

INSERT INTO(
    c_id,
    d,
    a_id,
    b_id
)
VALUES(
    1,
    'data dans C',
    1,
    1
);

DROP TABLE A;
DROP TABLE B;
DROP TABLE C;


--======COURS

CREATE TABLE dept80
AS
    SELECT employee_id, last_name, salary*12 "ANNSAL", hire_date
    from EMPLOYEES
    where department_id = 80
;

SELECT * FROM dept80;

drop table dept80;



CREATE TABLE dep
AS
    SELECT *
    from DEPARTMENTS
;

SELECT * FROM dep;

COMMIT;

UPDATE dep SET department_name = 'bob';

SELECT * FROM dep;

ROLLBACK;

SELECT * FROM dep;

-- DROP TABLE dep;

TRUNCATE TABLE dep;

------------------------------------------------------------------------------

CREATE SEQUENCE team_id_seq
INCREMENT BY 5
START WITH 10;

CREATE TABLE Teamz(
    id NUMBER(4),
    team_name VARCHAR2(20)
);

INSERT INTO Teamz(
    id,
    team_name
)
VALUES(
    team_id_seq.nextval,
    'a good team'
);

SELECT * FROM Teamz;

select team_id_seq.currval from dual;

DROP TABLE Teamz;
DROP SEQUENCE team_id_seq;

--------------------------creer une sequence pour un patient et un hopital------------inserer 2 patients à 2 hopitaux
CREATE TABLE Hopital(
    h_id number(4) primary key,
    nom_hopital VARCHAR2(20) not null,
    ville VARCHAR2(20) not null
);

CREATE TABLE Patient(
    p_id number(4) primary key,
    nom VARCHAR2(20) not null,
    prenom VARCHAR2(20) not null,
    gendre CHAR check (gendre = 'M' OR gendre = 'F') not null,
    age number check(age BETWEEN 0 AND 120) not null
);

CREATE TABLE Traitement(
    p_id number(4),
    h_id number(4),
    date_trait date not null,
    constraint trait_p_id_fk foreign key (p_id) references Patient (p_id),
    constraint trait_h_id_fk foreign key (h_id) references Hopital (h_id)
);

CREATE SEQUENCE Patient_seq
INCREMENT BY 1
START WITH 1;

CREATE SEQUENCE Hopital_seq
INCREMENT BY 1
START WITH 1;

INSERT INTO Patient(
    p_id,
    nom,
    prenom,
    gendre,
    age
)
VALUES (
    Patient_seq.nextval,
    'Carlos',
    'Leon',
    'M',
    23
);

INSERT INTO Patient(
    p_id,
    nom,
    prenom,
    gendre,
    age
)
VALUES (
    Patient_seq.nextval,
    'Bob',
    'Leponge',
    'M',
    10
);

INSERT INTO Hopital(
    h_id,
    nom_hopital,
    ville
)
VALUES(
    Hopital_seq.nextval,
    'CHUM',
    'Montreal'
);

INSERT INTO Hopital(
    h_id,
    nom_hopital,
    ville
)
VALUES(
    Hopital_seq.nextval,
    'ST Justine',
    'Montreal'
);

SELECT * FROM Patient;
SELECT * FROM Hopital;

DROP TABLE Traitement;
DROP TABLE Hopital;
DROP TABLE Patient;
DROP SEQUENCE Patient_seq;
DROP SEQUENCe Hopital_seq;


---------------------INDEXES--------------------

CREATE SEQUENCE team_id_seq
INCREMENT BY 5
START WITH 10;

CREATE TABLE Teamz(
    id NUMBER(4),
    team_name VARCHAR2(20)
);

INSERT INTO Teamz(
    id,
    team_name
)
VALUES(
    team_id_seq.nextval,
    'a good team'
);

create index idx_name on teamz(team_name);

DROP INDEX idx_name;
DROP TABLE Teamz;
DROP SEQUENCE team_id_seq;

------------------------SYNONYM------------------
create synonym e for employees;

select * from e;

CREATE VIEW empvu80
AS SELECT employee_id, last_name, salary
FROM EMPLOYEES
WHERE department_id = 80;

select employee_id, last_name from empvu80; -- ici par exemple on ne peut pas voir le salaire, effacer le tableau physique va aussi effacer la view

drop synonym e;
DROP VIEW empvu80;


CREATE VIEW salvu50
AS SELECT
    employee_id ID_NUMBER,
    last_name NAME,
    salary*12 ANN_SALARY
FROM employees
WHERE department_id = 50;

SELECT * FROM salvu50;

DROP VIEW salvu50;



CREATE OR REPLACE VIEW dept_sum_vu(
    name,
    minsal,
    maxsal,
    avgsal
)
AS SELECT
    d.department_name,
    MIN(e.salary),
    MAX(e.salary),
    AVG(e.salary)
FROM employees e
JOIN departments d
ON (e.department_id = d.department_id)
GROUP BY d.department_name;

SELECT * FROM dept_sum_vu;

DROP VIEW dept_sum_vu;