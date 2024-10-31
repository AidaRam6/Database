--1
CREATE DATABASE lab6;

--2
CREATE TABLE locations(
    location_id SERIAL PRIMARY KEY,
    postal_code VARCHAR(12) ,
    street_address VARCHAR(25) ,
    city VARCHAR(30) ,
    state_province VARCHAR(12)

);
SELECT * FROM locations;

CREATE TABLE departments(
    department_id SERIAL PRIMARY KEY,
    department_name VARCHAR(50) UNIQUE  ,
    budget INTEGER,
    location_id INTEGER REFERENCES locations
);
SELECT * FROM departments;


CREATE TABLE employees(
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR (50),
    email VARCHAR(50),
    phone_number VARCHAR(20),
    salary INTEGER,
    department_id INTEGER REFERENCES departments
);
SELECT * FROM employees;
--3
SELECT
    employees.first_name,
    employees.last_name,
    employees.department_id,
    departments.department_name
FROM
    employees
JOIN
    departments ON employees.department_id = departments.department_id;

--4
SELECT employees.first_name,
       employees.last_name,
       employees.department_id,
       departments.department_name
FROM employees
JOIN departments ON employees.department_id = departments.department_id
WHERE employees.department_id IN(80,40);

--5
SELECT
    employees.first_name,
    employees.last_name,
    departments.department_name AS department,
    locations.city,
    locations.state_province
FROM
    employees
JOIN
    departments ON employees.department_id = departments.department_id
JOIN
    locations ON departments.location_id = locations.location_id;

--6
SELECT
      departments.department_id,
      departments.department_name,
      departments.budget,
      employees.first_name,
      employees.last_name,
      employees.employee_id
FROM
    departments
LEFT JOIN
    employees ON departments.department_id = employees.department_id;

--7
SELECT
    employees.first_name,
    employees.last_name,
    employees.department_id,
    departments.department_name
FROM
    employees
LEFT JOIN
    departments ON employees.department_id = departments.department_id;

