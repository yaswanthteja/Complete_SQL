

-- drop database
DROP DATABASE test;


--  create data base

CREATE DATABASE test;


-- create a table customer and with the custid,custname,city,salary columns 

CREATE TABLE if not exists customer
(
CustID int8 PRIMARY KEY,
CustName varchar(50) NOT NULL, Age int NOT NULL,
City char(50),
Salary numeric
);

-- inserting data into customer table

INSERT INTO customer
(CustID, CustName, Age, City, Salary)
VALUES
(1, 'Sam', 26, 'Delhi', 9000);


-- we can also insert data with out column names but not recommended

INSERT INTO customer 
values (2, 'Ram', 19, 'Bangalore', 11000);

-- inserting multiple values at once

INSERT INTO customer
(CustID, CustName, Age, City, Salary)
VALUES
	(3, 'Pam', 31, 'Mumbai', 6000),
	(4, 'Jam', 42, 'Pune', 10000);


-- update 4th customer age to 25

update customer
set age=25
where custID=4;


-- update the 4 th customer name to xam and age to 32

UPDATE customer
SET CustName = 'Xam', Age= 32
WHERE CustID = 4;


select * from customer;




-- Add column to the existing table

ALTER TABLE customer
ADD Email VARCHAR(100);

-- Salary from NUMERIC to INT:

ALTER TABLE customer
ALTER COLUMN Salary TYPE INT;



-- rename CustName to CustomerName:

ALTER TABLE customer
RENAME COLUMN CustName TO CustomerName;



-- removing existing column 

ALTER TABLE customer
DROP COLUMN City;



-- Delete customer row  3 from table 

DELETE
FROM customer
WHERE CustID=3;


select * from customer;



-- ignore these statements only for practice 


-- Truncate (be careful it will remove entire data from table)

-- delete complete data from table

TRUNCATE TABLE customer;


-- Delete table from database

DROP TABLE customer;


-- delete database

DROP DATABASE test;

