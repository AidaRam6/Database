CREATE DATABASE lab1;
\c  lab1
CREATE table users(
    id SERIAL PRIMARY KEY,
    firstname VARCHAR(50),
    lastname  VARCHAR(50)
);

ALTER TABLE users
ADD COLUMN isadmin INTEGER DEFAULT 0;

ALTER TABLE users
ALTER COLUMN isadmin TYPE BOOLEAN USING isadmin::BOOLEAN;

ALTER TABLE users
ALTER COLUMN isadmin SET DEFAULT FALSE;

CREATE TABLE tasks (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    user_id INTEGER
);

DROP TABLE tasks;

\c postgres
DROP DATABASE lab1;

