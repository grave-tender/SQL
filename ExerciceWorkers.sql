CREATE TABLE Workers (
    employee_id NUMBER(16),
    first_name VARCHAR2(20),
    last_name VARCHAR2(25) NOT NULL,
    email VARCHAR2(25) NOT NULL,
    phone_number VARCHAR2(20),
    hire_date DATE NOT NULL,
    job_id VARCHAR2(10) NOT NULL,
    salary NUMBER(8,2),
    commission_pct NUMBER(2,2),
    manager_id NUMBER(6),
    department_id NUMBER(4),
    CONSTRAINT wrk_employee_id PRIMARY KEY(employee_id),
    CONSTRAINT wrk_email_uk UNIQUE (email),
    CONSTRAINT wrk_salary_ck CHECK (salary > 0),
    CONSTRAINT wrk_manager_fk FOREIGN KEY (manager_id) REFERENCES EMPLOYEES (employee_id),
    CONSTRAINT wrk_dept_fk FOREIGN KEY (department_id) REFERENCES departments (department_id)
);

DROP CONSTRAINT emp_email_uk;

DROP TABLE Workers;