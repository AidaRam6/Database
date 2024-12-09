CREATE DATABASE lab10;
CREATE TABLE books(
    book_id INTEGER PRIMARY KEY ,
    title VARCHAR (100),
    author VARCHAR (100),
    price DECIMAL,
    quantity INTEGER
);
INSERT INTO books (book_id, title, author, price,quantity) VALUES (
                                                                   (1,' Database 100', 'A.Smith', 40.00, 10),
                                                                   (2, 'Learn SQL',' B.Johnson', 35.00, 15 ),
                                                                   (3,' Advanced DB',' C.Lee', 50.00, 5)
                                                                  );
CREATE TABLE customers (
    customer_id INTEGER PRIMARY KEY,
    name VARCHAR (100),
    email VARCHAR (100)
);
INSERT INTO customers (customer_id, name, email) VALUES (
                                                         (101,'John Doe', 'johndoe@example.com'),
                                                         (102,'Jane Doe', 'janedoe@example.com')
                                                        );

CREATE TABLE orders (
    order_id INTEGER PRIMARY KEY,
    book_id INTEGER,
    customer_id INTEGER,
    order_date DATE,
    quantity INTEGER,
    FOREIGN KEY (book_id) REFERENCES books(book_id),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

--1
BEGIN TRANSACTION;

INSERT INTO Orders (order_id, book_id, customer_id, order_date, quantity)
VALUES (1, 1, 101, '14.06.2006', 2);

UPDATE Books
SET quantity = quantity - 2
WHERE book_id = 1;

COMMIT;

--2
BEGIN;

DO $$
DECLARE
    available_quantity INT;
BEGIN
    SELECT quantity INTO available_quantity
    FROM Books
    WHERE book_id = 3;

    IF available_quantity < 10 THEN
        RAISE NOTICE 'Недостаточно книг на складе. Транзакция откатывается.';
        ROLLBACK;
    ELSE
        INSERT INTO Orders (order_id, book_id, customer_id, order_date, quantity)
        VALUES (2, 3, 102, CURRENT_DATE, 10);

        UPDATE Books
        SET quantity = quantity - 10
        WHERE book_id = 3;

        COMMIT;
    END IF;
END;
$$;

--3
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
BEGIN TRANSACTION;


UPDATE Books
SET price = 42.00
WHERE book_id = 1;

COMMIT;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
BEGIN TRANSACTION;


SELECT price FROM Books WHERE book_id = 1;


COMMIT;

--4
BEGIN TRANSACTION;

UPDATE Customers
SET email = 'newemail@example.com'
WHERE customer_id = 101;

COMMIT;