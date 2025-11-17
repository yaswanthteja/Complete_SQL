select * from payments

CREATE TABLE Payments_fun (
  payment_id INT PRIMARY KEY,
  customer_name VARCHAR(50),
  amount DECIMAL(10,2),
  mode VARCHAR(30),
  payment_date DATE
);

INSERT INTO Payments_fun (payment_id, customer_name, amount, mode, payment_date)
VALUES
(1, 'Arjun', 60, 'Cash', '2020-09-24'),
(2, 'Meera', 30, 'Credit Card', '2020-04-27'),
(3, 'Ravi', 90, 'Credit Card', '2020-07-07'),
(4, 'Sneha', 50, 'Debit Card', '2020-02-12'),
(5, 'Kiran', 40, 'Mobile Payment', '2020-11-20'),
(6, 'Priya', 40, 'Debit Card', '2021-06-28'),
(7, 'Rahul', 10, 'Cash', '2021-08-25'),
(8, 'Anita', 30, 'Mobile Payment', '2021-06-17'),
(9, 'Vikram', 80, 'Cash', '2021-08-25'),
(10, 'Divya', 50, 'Mobile Payment', '2021-11-03'),
(11, 'Suresh', 70, 'Cash', '2022-11-01'),
(12, 'Neha', 60, 'Netbanking', '2022-09-11'),
(13, 'Ajay', 30, 'Netbanking', '2022-12-10'),
(14, 'Varun', 50, 'Credit Card', '2022-05-14'),
(15, 'Pooja', 30, 'Credit Card', '2022-09-25');



-- Scalar function 
SELECT UPPER(customer_name), ROUND(amount, 0)
FROM Payments_fun;

-- Aggregate function
SELECT mode, SUM(amount)
FROM Payments_fun
GROUP BY mode;

-- Date function
SELECT EXTRACT(YEAR FROM payment_date) AS year, COUNT(*)
FROM Payments_fun
GROUP BY year;





-- 1. Find the absolute difference between the highest and lowest payment amounts.

SELECT ABS(MAX(amount) - MIN(amount)) AS difference FROM Payments_fun;

-- 2. Round the average payment amount to 2 decimal places

SELECT ROUND(AVG(amount), 2) AS avg_payment FROM Payments_fun;

-- 3. Show all customer names in uppercase.
SELECT UPPER(customer_name) FROM Payments_fun;

-- 4. Extract the first 3 letters of each payment mode.
SELECT SUBSTRING(mode, 1, 3) FROM Payments_fun;

-- 5. Find all payments made in 2021.
SELECT * FROM Payments_fun WHERE YEAR(payment_date) = 2021;


-- 6. Calculate the number of days between the earliest and latest payment
SELECT DATEDIFF(MAX(payment_date), MIN(payment_date)) AS days_span FROM Payments_fun;

-- 7. Count how many payments were made by Credit Card.
SELECT COUNT(*) FROM Payments_fun WHERE mode = 'Credit Card';

-- 8. Find the total amount collected per payment mode
SELECT mode, SUM(amount) AS total_amount
FROM Payments_fun
GROUP BY mode;

