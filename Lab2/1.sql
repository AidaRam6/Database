--1
CREATE DATABASE lab2;

--2
CREATE TABLE countries(
    country_id SERIAL PRIMARY KEY,
    country_name VARCHAR(50),
    region_id INTEGER,
    population INTEGER
);

--3
INSERT INTO countries (country_id, country_name,population) VALUES (13,'US',345000000);

--4
INSERT INTO countries (country_id, country_name) VALUES(2,'Kazakhstan');

--5
INSERT INTO countries (country_name,region_id,population) VALUES('Italy',NULL,58000000);

--6
INSERT INTO countries (country_name,region_id,population)VALUES
                                                             ('France',8,67000000),
                                                             ('Germany',9,84000000),
                                                             ('Spain',5,47000000);
--7
ALTER TABLE countries ALTER country_name SET DEFAULT 'Kazakhstan';

--8
INSERT INTO countries(country_name,country_id,population) VALUES
                                                             (DEFAULT,12,34000000);

--9
ALTER TABLE countries ALTER region_id SET DEFAULT 3;
ALTER TABLE countries ALTER population SET DEFAULT 20000000;
INSERT INTO countries (country_name,region_id,population) VALUES(DEFAULT,DEFAULT,DEFAULT);

--10
CREATE TABLE countries_new AS TABLE countries WITH NO DATA;

--11
INSERT INTO countries_new SELECT*FROM countries;

--12
UPDATE countries SET region_id = 1 WHERE region_id is NULL;

--13
SELECT country_name,population * 1.1 AS "New Populatoin" FROM countries;

--14
DELETE FROM countries WHERE population < 10000000;

--15
DELETE FROM countries_new WHERE country_id IN (SELECT country_id FROM countries)  RETURNING * ;

--16
DELETE FROM countries returning *;


