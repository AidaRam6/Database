CREATE DATABASE lab7;

CREATE TABLE countries (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    code VARCHAR(10),
    population INT
);
INSERT INTO countries (name, code, population) VALUES
('Kazakhstan', 'KZ', 18754440),
('Russia', 'RU', 144104080),
('United States', 'US', 331002651),
('Germany', 'DE', 83240525),
('France', 'FR', 67413000),
('Canada', 'CA', 38005238);

SELECT * FROM countries;

CREATE TABLE departments (
    department_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    budget INT
);
INSERT INTO departments (name, budget) VALUES
('HR', 500000),
('IT', 1200000),
('Sales', 800000),
('Marketing', 400000),
('Finance', 1000000);

SELECT * FROM departments;

CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    surname VARCHAR(100),
    department_id INT REFERENCES departments(department_id),
    salary INT
);


INSERT INTO employees (name, surname, department_id, salary) VALUES
('John', 'Doe', 1, 60000),
('Jane', 'Smith', 2, 90000),
('Alice', 'Johnson', 3, 85000),
('Bob', 'Brown', 4, 75000),
('Charlie', 'Davis', 5, 100000),
('Dave', 'Clark', 2, 110000),
('Eve', 'Adams', 3, 105000),
('Frank', 'White', 1, 55000),
('Grace', 'Miller', 4, 95000),
('Heidi', 'Wilson', 5, 115000);

SELECT * FROM employees;
--1
CREATE INDEX ind_countries_name ON countries (name);

--2
CREATE INDEX ind_employees_name_surname ON employees (name, surname);

--3
CREATE UNIQUE INDEX ind_employees_salary ON employees (salary);

--4
CREATE INDEX ind_employees_name_substring ON employees (substring(name from 1 for 4));

--5
CREATE INDEX ind_employees_departments_salary_budget
    ON employees (department_id,salary);
CREATE INDEX ind_departments_budget
ON departments (department_id, budget);




