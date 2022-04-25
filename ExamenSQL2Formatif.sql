--------------Deletion----------------
DROP TABLE Orders;
DROP TABLE Customer;
DROP TABLE Salesperson;
DROP TABLE highAchiever;


------------creation----------

CREATE TABLE Salesperson(
    salesperson_id NUMBER(2),
    name VARCHAR(30),
    age NUMERIC(2),
    salary NUMERIC(6),
    constraint sperson_id_pk PRIMARY KEY (salesperson_id),
    constraint sperson_id_min CHECK (salesperson_id > 0),
    constraint sperson_salary_100_200k check (salary BETWEEN 100 AND 200000)
);

CREATE TABLE Customer(
    customer_id NUMERIC(2),
    name VARCHAR(30),
    city VARCHAR(30),
    industry_type VARCHAR(1),
    constraint cust_id_pk PRIMARY KEY (customer_id),
    constraint cust_id_min CHECK (customer_id > 0),
    constraint cust_Industry_type_J_P check (Industry_Type IN ('J','P'))
);

CREATE TABLE Orders(
    order_id NUMERIC(2),
    order_date DATE,
    cust_id NUMERIC(2),
    salesperson_id NUMERIC(2),
    amount NUMERIC(6),
    constraint order_id_pk PRIMARY KEY (order_id),
    constraint sperson_id_fk foreign key (salesperson_id) references Salesperson (salesperson_id),
    constraint cust_id_fk foreign key (cust_id) references Customer (customer_id),
    constraint order_amount_100_100k check (amount BETWEEN 100 AND 100000)
);



------------Garble Testing
/*
INSERT INTO Salesperson (salesperson_id, name, age, salary) VALUES (
    1,
    'chat',
    18,
    100055
);
INSERT INTO Salesperson (salesperson_id, name, age, salary) VALUES (
    2,
    'chat2',
    18,
    100055
);
INSERT INTO Salesperson (salesperson_id, name, age, salary) VALUES (
    3,
    'chat3',
    18,
    155
);

INSERT INTO Customer (customer_id, name, city, industry_Type) VALUES (
    1,
    'Carlos',
    'Montreal',
    'P'
);

INSERT INTO Orders(order_id, order_date, salesperson_id, amount)
VALUES(
    1,
    TO_DATE('08-02-96', 'DD-MM-YYYY'),
    (
        SELECT salesperson_id
        FROM Salesperson
        WHERE salesperson_id = 1
    ),
    100
);


*/

-----------Question 2----------------
CREATE TABLE highAchiever(
    name VARCHAR(30),
    age NUMBER(2)
);

INSERT INTO highAchiever ( name, age )
SELECT name, age
FROM Salesperson
WHERE salary >= 100000;

SELECT * FROM highAchiever;

---------SOLUTION ASMA---------subquery
-- CREATE TABLE highAchiever (name, age) AS
-- SELECT name, age
-- FROM Salesperson
-- WHERE salary > 100000;

--------------Inserting Data-----------

INSERT INTO Salesperson ( salesperson_id, name, age, salary )
VALUES( 1, 'Abe', 61, 140000 );
INSERT INTO Salesperson ( salesperson_id, name, age, salary )
VALUES( 2, 'Bob', 34, 44000 );
INSERT INTO Salesperson ( salesperson_id, name, age, salary )
VALUES( 5, 'Chris', 34, 40000 );
INSERT INTO Salesperson ( salesperson_id, name, age, salary )
VALUES( 7, 'Dan', 41, 52000 );
INSERT INTO Salesperson ( salesperson_id, name, age, salary )
VALUES( 8, 'Ken', 57, 115000 );
INSERT INTO Salesperson ( salesperson_id, name, age, salary )
VALUES( 11, 'Joe', 38, 38000);

INSERT INTO Customer ( customer_id, name, city, Industry_Type)
VALUES ( 4, 'Samsonic', 'pleasant', 'J' );
INSERT INTO Customer ( customer_id, name, city, Industry_Type)
VALUES ( 6, 'Panasung', 'oaktown', 'J' );
INSERT INTO Customer ( customer_id, name, city, Industry_Type)
VALUES ( 7, 'Samony', 'jackson', 'P' );
INSERT INTO Customer ( customer_id, name, city, Industry_Type)
VALUES ( 9, 'Orange', 'Jackson', 'P' );

INSERT INTO Orders ( order_id, order_date, cust_id, salesperson_id, amount)
VALUES ( 10, TO_DATE('08-02-1996', 'MM-DD-YYYY'), 4, 2, 540 );
INSERT INTO Orders ( order_id, order_date, cust_id, salesperson_id, amount)
VALUES ( 20, TO_DATE('01-30-1999', 'MM-DD-YYYY'), 4, 8, 1800 );
INSERT INTO Orders ( order_id, order_date, cust_id, salesperson_id, amount)
VALUES ( 30, TO_DATE('07-14-1995', 'MM-DD-YYYY'), 9, 1, 460 );
INSERT INTO Orders ( order_id, order_date, cust_id, salesperson_id, amount)
VALUES ( 40, TO_DATE('01-29-1998', 'MM-DD-YYYY'), 7, 2, 2400 );
INSERT INTO Orders ( order_id, order_date, cust_id, salesperson_id, amount)
VALUES ( 50, TO_DATE('02-03-1998', 'MM-DD-YYYY'), 6, 7,600 );
INSERT INTO Orders ( order_id, order_date, cust_id, salesperson_id, amount)
VALUES ( 60, TO_DATE('03-02-1998', 'MM-DD-YYYY'), 6, 7, 720 );
INSERT INTO Orders ( order_id, order_date, cust_id, salesperson_id, amount)
VALUES ( 70, TO_DATE('05-06-1998', 'MM-DD-YYYY'), 9, 7, 150 );

--------------Questions---------------
-- a. The names of all salespeople that have an order with Samsonic.
SELECT s.name
FROM Salesperson s
JOIN Orders o
ON (s.salesperson_id = o.salesperson_id)
JOIN Customer c
ON (o.cust_id = c.customer_id)
WHERE c.name = 'Samsonic';

-- b. The names of all salespeople that do not have any order on the date 1/29/98 --CHRIS DOIT ETRE DANS LE OUTPUT, solution Liu Yong Jiang --MINUS
SELECT s.name
FROM Salesperson s
JOIN Orders o
ON (s.salesperson_id = o.salesperson_id)
WHERE o.salesperson_id NOT IN (
    SELECT o.salesperson_id
    FROM Orders o
    WHERE o.order_date = '29-JAN-98'
)
GROUP BY s.name;

-- c. The names of salespeople that have 2 or more orders.
SELECT s.name
FROM Salesperson s
JOIN Orders o
ON (s.salesperson_id = o.salesperson_id)
GROUP BY s.name
HAVING COUNT(o.salesperson_id) >= 2;

-- d. The names of customer that have the name starts with "S". 
SELECT c.name
FROM Customer c
WHERE c.name LIKE 'S%';

-- e. The names of customers that have in the second
--letter "a" in their names.
SELECT c.name
FROM Customer c
WHERE c.name LIKE '_a%';

-- f. Change the salary of sales person Dan to 150000. Verify your change
SELECT s.name, s.salary FROM Salesperson s WHERE s.name = 'Dan';

UPDATE Salesperson s
SET s.salary = 150000
WHERE s.name = 'Dan';

SELECT s.name, s.salary FROM Salesperson s WHERE s.name = 'Dan';

-- g. Delete the order 70. 
SELECT * FROM Orders;

DELETE FROM Orders o
WHERE o.order_id = 70;

SELECT * FROM Orders;

-- h. List  all orders with the following details: order_number, Amount, order_date, 
--SalesPerson name, Customer name, 
SELECT o.order_id, o.amount, o.order_date, s.name salesperson_name, c.name customer_name
FROM Salesperson s
JOIN Orders o
ON (s.salesperson_id = o.salesperson_id)
JOIN Customer c
ON (o.cust_id = c.customer_id);


