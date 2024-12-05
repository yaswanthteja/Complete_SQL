

 CREATE DATABASE shopmart;


-- customer table
create table customer(customer_id int,
                     first_name varchar(100),
					 last_name varchar(100),
					 email varchar(100),
					 address_id int
					 )
copy customer(customer_id,first_name,last_name,email,address_id)
FROM 'E:\Complete_Placement\Databases\SQL_Tutorial\customer.csv'
DELIMITER ','
CSV HEADER

--payment table
create table payment(
customer int,
amount int,
mode varchar(50),
payment_date date
)

copy payment(customer,amount,mode,payment_date)
FROM 'E:\Complete_Placement\Databases\SQL_Tutorial\payment.csv'
DELIMITER ','
CSV HEADER

-- customer_CTE table

create table customer_CTE(customer_id int,
                     first_name varchar(100),
					 last_name varchar(100),
					 address_id int
					 )
copy customer(customer_id,first_name,last_name,address_id)
FROM 'E:\Complete_Placement\Databases\SQL_Tutorial\customer_CTE.csv'
DELIMITER ','
CSV HEADER


-- payment_CTE table

create table payment_CTE(
customer_id int,
amount int,
mode varchar(50),
payment_date date
)

copy payment_cte(customer_id,amount,mode,payment_date)
FROM 'E:\Complete_Placement\Databases\SQL_Tutorial\payment_CTE.csv'
DELIMITER ','
CSV HEADER

-- payment_case table

create table payment_Case(
customer_id int,
amount int,
mode varchar(50),
payment_date date
)

copy payment_cte(customer_id,amount,mode,payment_date)
FROM 'E:\Complete_Placement\Databases\SQL_Tutorial\payment_Case.csv'
DELIMITER ','
CSV HEADER

