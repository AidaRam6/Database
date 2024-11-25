
--1
CREATE OR REPLACE FUNCTION increase_value(input_value INT)
RETURNS INT AS $$
BEGIN
    RETURN input_value + 10;
END;
$$ LANGUAGE plpgsql;


--2
CREATE OR REPLACE FUNCTION compare_numbers1(
    num1 INT,
    num2 INT,
    OUT result TEXT
)
 AS $$
BEGIN
    IF num1 > num2 THEN
        result := 'Большее';
    ELSIF num1 = num2 THEN
        result := 'Равное';
    ELSE
        result := 'Меньшее';
    END IF;
END;
$$ LANGUAGE plpgsql;

SELECT compare_numbers1(5,6);


--3
CREATE OR REPLACE FUNCTION NUMBER_SERIES(N INT)
RETURNS TEXT
AS $$
DECLARE
    I INT := 1;
    SERIES TEXT := '';
BEGIN
    WHILE I <= N LOOP
        SERIES := SERIES || I || CASE WHEN I < N THEN ', ' ELSE '' END;
        I := I + 1;
    END LOOP;
    RETURN SERIES;
END;
$$
LANGUAGE PLPGSQL;
SELECT NUMBER_SERIES(5);


--4
 CREATE OR REPLACE FUNCTION FIND_EMPLOYEE(ENAME VARCHAR)
RETURNS TABLE(ID INT, NAME VARCHAR, SALARY INT)
AS $$
BEGIN
    RETURN QUERY
    SELECT E.ID, E.NAME, E.SALARY
    FROM EMPLOYEES1 E
    WHERE E.NAME = ENAME;
END;
$$
LANGUAGE PLPGSQL;
SELECT FIND_EMPLOYEE('bbb');



--5
CREATE TABLE products (
    id_product SERIAL PRIMARY KEY,
    name VARCHAR(255),
    price FLOAT,
    category VARCHAR(100)
);

INSERT INTO products (name, category, price)
VALUES
    ('Smartphone', 'Electronics', 599.99),
    ('Laptop', 'Electronics', 899.99),
    ('Shirt', 'Clothing', 29.99),
    ('Jeans', 'Clothing', 49.99);

CREATE OR REPLACE FUNCTION list_products(categoryname VARCHAR)
RETURNS TABLE(id_product INT, name VARCHAR, price FLOAT)
AS $$
BEGIN
    RETURN QUERY
    SELECT p.id_product, p.name, p.price
    FROM products p
    WHERE p.category = categoryname;
END;
$$ LANGUAGE PLPGSQL;
SELECT * FROM list_products('Electronics');


--6
CREATE TABLE employees1 (
    id SERIAL PRIMARY KEY,
    name VARCHAR(45),
    salary NUMERIC(44),
    bonus NUMERIC(55)
);

INSERT INTO employees1 (name, salary, bonus)
VALUES
    ('bbb', 45, 47),
    ('ddd', 64, 86),
    ('ccc', 56, 89);


DROP FUNCTION IF EXISTS calculate_bonus(emp_id INT);

CREATE OR REPLACE FUNCTION calculate_bonus(emp_id INT)
RETURNS NUMERIC
AS $$
DECLARE
    salary NUMERIC;
    bonus NUMERIC;
BEGIN

    SELECT e.salary INTO salary
    FROM employees1 e
    WHERE e.id = emp_id;


    bonus := salary * 0.10;
    RETURN bonus;
END;
$$ LANGUAGE PLPGSQL;

DROP FUNCTION IF EXISTS update_salary(emp_id INT);

CREATE OR REPLACE FUNCTION update_salary(emp_id INT)
RETURNS NUMERIC
AS $$
DECLARE
    bonus NUMERIC;
    new_salary NUMERIC;
BEGIN

    bonus := calculate_bonus(emp_id);


    SELECT e.salary INTO new_salary
    FROM employees1 e
    WHERE e.id = emp_id;


    new_salary := new_salary + bonus;


    RETURN new_salary;
END;
$$ LANGUAGE PLPGSQL;

SELECT update_salary(1);


--7
CREATE OR REPLACE FUNCTION complex_calculation(num INT, txt VARCHAR, OUT result TEXT)
AS $$
DECLARE
    num_res INT;
    txt_res VARCHAR;
BEGIN
    <<MAIN_BLOCK>>
    BEGIN
        <<SUBBLOCK_NUMERIC>>
        BEGIN
            num_res := num * num;
        END;
        <<SUBBLOCK_STRING>>
        BEGIN
            txt_res := reverse(txt);
        END;

        result := 'Numeric result: ' || num_res || ', String result: ' || txt_res;
    END;
END;
$$ LANGUAGE PLPGSQL;
SELECT complex_calculation(5, 'aida');
