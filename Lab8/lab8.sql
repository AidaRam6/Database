CREATE DATABASE lab8;

--2
CREATE TABLE salesman (
    salesman_id INTEGER,
    name VARCHAR(50),
    city VARCHAR(50),
    commission FLOAT
);
INSERT INTO salesman (salesman_id, name, city, commission) VALUES
(5001, 'James Hoog', 'New York', 0.15),
(5002, 'Nail Knite', 'Paris', 0.13),
(5005, 'Pit Alex', 'London', 0.11),
(5006, 'Mc Lyon', 'Paris', 0.14),
(5003, 'Lauson Hen', 'San Jose', 0.12),
(5007, 'Paul Adam', 'Rome', 0.13);

SELECT * FROM salesman;

CREATE TABLE customers (
    customer_id INTEGER,
    cust_name VARCHAR(50),
    city VARCHAR(50),
    grade INTEGER,
    salesman_id INTEGER
);
INSERT INTO customers (customer_id, cust_name, city, grade, salesman_id) VALUES
(3002, 'Nick Rimando', 'New York', NULL, 5001),
(3005, 'Graham Zusi', 'California', 200, 5002),
(3007, 'Brad Guzan', 'London', NULL, 5005),
(3004, 'Fabian Johns', 'Paris', 300, 5006),
(3009, 'Geoff Camero', 'Berlin', 100, 5003),
(3008, 'Julian Green', 'London', 300, 5002);

SELECT * FROM customers;

CREATE TABLE orders (
    ord_no INTEGER,
    purch_amt FLOAT,
    ord_date DATE,
    customer_id INTEGER,
    salesman_id INTEGER
);

INSERT INTO orders (ord_no, purch_amt, ord_date, customer_id, salesman_id) VALUES
(70001, 150.5, '2012-10-05', 3005, 5002),
(70009, 270.65, '2012-09-10', 3001, 5005),
(70002, 65.26, '2012-10-05', 3002, 5001),
(70004, 110.5, '2012-08-17', 3009, 5003),
(70007, 948.5, '2012-09-10', 3005, 5002),
(70005, 2400.6, '2012-07-27', 3007, 5001),
(70008, 5760, '2012-09-10', 3002, 5001);

SELECT* FROM orders;

--3
CREATE ROLE junior_dev WITH LOGIN;

--4
CREATE VIEW salesmen AS SELECT* FROM salesman WHERE city = 'New York';

--5

CREATE VIEW oders AS
    SELECT o.ord_no, s.name AS salesman_name, c.cust_name AS customer_name
    FROM orders o
    JOIN salesman s ON o.salesman_id = s.salesman_id
    JOIN customers c ON o.customer_id=c.customer_id;

grant all privileges on oders to junior_dev;
--6
CREATE VIEW high AS SELECT * FROM  customers WHERE grade = (SELECT MAX(grade) FROM customers);
GRANT SELECT ON high TO junior_dev;

--7
CREATE VIEW salesman_num AS SELECT city,COUNT(salesman_id) AS salesman_count FROM salesman GROUP BY city ;

--8
CREATE VIEW each_salesman AS
SELECT s.name AS csalesman_name
FROM salesman s
JOIN customers c ON s.salesman_id = c.salesman_id
GROUP BY s.name
HAVING COUNT(c.customer_id) > 1;



--9
CREATE ROLE intern;
GRANT junior_dev TO intern;

