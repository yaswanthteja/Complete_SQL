
-- create a table with columns with correct data types with matching csv header(headings) 

CREATE TABLE Payments (
  customer_id INT,
  amount INT,
  mode VARCHAR(30),
  payment_date DATE
);


COPY Payments 
FROM 'Your location/payment.csv'  -- make sure add correct csv location 
DELIMITER ',' 
CSV HEADER;

select * from payments;