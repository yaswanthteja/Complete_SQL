
drop table customers_j
drop table products_j
drop table orders_j
drop table payments_j


CREATE TABLE Customers_j (
  customer_id INT PRIMARY KEY,
  customer_name VARCHAR(50),
  city VARCHAR(50),
  signup_date TIMESTAMP
);

INSERT INTO Customers_j VALUES
(1, 'Ajay', 'Hyderabad', '2023-01-15 10:30:00'),
(2, 'Bobby', NULL, '2023-03-10 14:45:00'),     
(3, 'Charan', 'Mumbai', '2023-05-20 09:00:00'),
(4, 'Diana', 'Hyderabad', '2024-02-05 16:20:00'),
(5, 'Ethan', 'Chennai', '2024-07-12 11:10:00'),
(6, 'Phani', NULL, '2024-09-01 08:00:00'),      
(7, 'Gagan', 'Delhi', '2024-09-15 12:00:00');

select * from customers_j;




CREATE TABLE Products_j (
  product_id INT PRIMARY KEY,
  product_name VARCHAR(50),
  category VARCHAR(30),
  price NUMERIC
);

INSERT INTO Products_j VALUES
(101, 'Laptop', 'Electronics', 75000),
(102, 'Phone', 'Electronics', 35000),
(103, 'Shoes', 'Fashion', 2500),
(104, 'Watch', 'Fashion', 5000),
(105, 'Book', 'Education', 800),
(106, 'Tablet', 'Electronics', 25000),
(107, 'Headphones', 'Electronics', 3000),
(108, 'Bag', 'Fashion', 1500),
(109, 'Pen', 'Education', 50),
(110, 'Camera', 'Electronics', 45000);


CREATE TABLE Orders_j (
  order_id INT PRIMARY KEY,
  customer_id INT,
  product_id INT,
  order_date TIMESTAMP,
  quantity INT,
  FOREIGN KEY (customer_id) REFERENCES Customers_j(customer_id),
  FOREIGN KEY (product_id) REFERENCES Products_j(product_id)
);

INSERT INTO Orders_j VALUES
(1001, 1, 101, '2024-01-20 09:15:00', 1),
(1002, 2, 103, '2024-03-15 12:00:00', 2),
(1003, 3, 102, '2024-05-10 18:30:00', 1),
(1004, 1, 105, '2024-06-25 09:15:00', 3),   
(1005, 4, 104, '2024-08-05 14:00:00', 1),
(1006, 5, 103, '2024-09-12 14:00:00', 1),   
(1007, 1, 102, '2024-09-12 14:00:00', 1),  
(1008, 2, 101, '2024-10-01 10:00:00', 1),
(1009, 3, 105, '2024-10-02 15:30:00', 2),
(1010, 4, 102, '2024-10-05 20:00:00', 1),
(1011, 5, 104, '2024-10-06 09:45:00', 1),
(1012, 1, 103, '2024-10-07 14:00:00', 2),
(1013, 2, 105, '2024-10-07 14:00:00', 1),   
(1014, 3, 101, '2024-10-08 11:15:00', 1),
(1015, 4, 103, '2024-10-09 16:30:00', 3),
(1016, 5, 102, '2024-10-10 18:00:00', 1);  









CREATE TABLE Payments_j (
  payment_id INT PRIMARY KEY,
  order_id INT,
  amount NUMERIC,
  mode VARCHAR(20),
  payment_date TIMESTAMP,
  FOREIGN KEY (order_id) REFERENCES Orders_j(order_id)
);

INSERT INTO Payments_j VALUES
(5001, 1001, 75000, 'Credit Card', '2024-01-20 09:20:00'),
(5002, 1002, 5000, 'UPI', '2024-03-15 12:05:00'),
(5003, 1003, 35000, 'Debit Card', '2024-05-10 18:35:00'),
(5004, 1004, 2400, NULL, '2024-06-25 09:20:00'),   -- NULL mode
(5005, 1005, 5000, 'Credit Card', '2024-08-05 14:05:00'),
(5006, 1006, 2500, 'Cash', '2024-09-12 14:05:00'),
(5007, 1007, 35000, 'UPI', '2024-09-12 14:05:00'),
(5008, 1008, 75000, 'Credit Card', '2024-10-01 10:05:00'),
(5009, 1009, 1600, 'UPI', '2024-10-02 15:35:00'),
(5010, 1010, 35000, 'Debit Card', '2024-10-05 20:05:00'),
(5011, 1011, 5000, NULL, '2024-10-06 09:50:00'),   -- NULL mode
(5012, 1012, 5000, 'Cash', '2024-10-07 14:05:00'),
(5013, 1013, 800, 'UPI', '2024-10-07 14:05:00'),
(5014, 1014, 75000, 'Credit Card', '2024-10-08 11:20:00'),
(5015, 1015, 7500, 'Debit Card', '2024-10-09 16:35:00'),
(5016, 1016, 35000, 'Credit Card', '2024-10-10 18:05:00');





select * from customers_j;

select * from products_j;

select * from orders_j;

select * from payments_j;





--  1. List all customers and their orders(products) (even if no payment yet)


SELECT c.customer_name, o.order_id, pr.product_name
FROM Customers_j c
LEFT JOIN Orders_j o 
		ON c.customer_id = o.customer_id
LEFT JOIN Products_j pr 
		ON o.product_id = pr.product_id;





-- 2. Show all payments with customer names


SELECT p.payment_id, c.customer_name, p.amount, p.mode
FROM Payments_j p
JOIN Orders_j o ON p.order_id = o.order_id
JOIN Customers_j c ON o.customer_id = c.customer_id;





-- 3. Find customers who have never placed an order



SELECT c.customer_name
FROM Customers_j c
LEFT JOIN Orders_j o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;




-- 4. Total spending per customer


SELECT c.customer_name, SUM(p.amount) AS total_spent
FROM Customers_j c
JOIN Orders_j o ON c.customer_id = o.customer_id
JOIN Payments_j p ON o.order_id = p.order_id
GROUP BY c.customer_name
ORDER BY total_spent DESC;





select * from customers_j;

select * from products_j;

select * from orders_j;

select * from payments_j;



-- 5. Find payments with missing mode (NULL values) and customer name, amount and date of payment



SELECT p.payment_id, c.customer_name, p.amount, p.payment_date
FROM Payments_j p
JOIN Orders_j o ON p.order_id = o.order_id
JOIN Customers_j c ON o.customer_id = c.customer_id
WHERE p.mode IS NULL;


-- 6. Monthly revenue report for 2024




SELECT TO_CHAR(p.payment_date, 'YYYY-MM') AS month,
       SUM(p.amount) AS revenue,
       COUNT(*) AS transactions
FROM Payments_j p
WHERE EXTRACT(YEAR FROM p.payment_date) = 2024
GROUP BY TO_CHAR(p.payment_date, 'YYYY-MM')
ORDER BY month;

/*
TO_CHAR is a formatting function in SQL (postgresql, oracle)

It converts a date or timestamp into a string with the format you specify.

 TO_CHAR(p.payment_date, 'YYYY-MM') turns the full timestamp (like 2024-10-07 14:05:00) into a simple string like 2024-10.

*/






-- 7. Detect simultaneous transactions (same timestamp)


SELECT p.payment_date, c.customer_name, pr.product_name, p.amount
FROM Payments_j p
JOIN Orders_j o ON p.order_id = o.order_id
JOIN Customers_j c ON o.customer_id = c.customer_id
JOIN Products_j pr ON o.product_id = pr.product_id
WHERE p.payment_date IN (
  SELECT payment_date
  FROM Payments_j
  GROUP BY payment_date
  HAVING COUNT(*) > 1
)
ORDER BY p.payment_date;



-- 8. Top 3 customers by spending in October 2024

SELECT c.customer_name, SUM(p.amount) AS total_spent
FROM Customers_j c
JOIN Orders_j o ON c.customer_id = o.customer_id
JOIN Payments_j p ON o.order_id = p.order_id
WHERE p.payment_date BETWEEN '2024-10-01' AND '2024-10-31'
GROUP BY c.customer_name
ORDER BY total_spent DESC
LIMIT 3;



-- 9. Products with no orders

SELECT pr.product_name
FROM Products_j pr
LEFT JOIN Orders_j o ON pr.product_id = o.product_id
WHERE o.order_id IS NULL;




-- 10 Daily revenue report with highest transaction per day


SELECT DATE(p.payment_date) AS day,
       SUM(p.amount) AS total_revenue,
       MAX(p.amount) AS highest_transaction
FROM Payments_j p
GROUP BY DATE(p.payment_date)
ORDER BY day;


-- 11 . Find least‑selling products (fewest orders)

SELECT pr.product_name, COUNT(o.order_id) AS total_orders
FROM Products_j pr
LEFT JOIN Orders_j o ON pr.product_id = o.product_id
GROUP BY pr.product_name
ORDER BY total_orders ASC;



-- 12. count order per product


SELECT pr.product_id, pr.product_name,
       COUNT(o.order_id) AS total_orders
FROM Products_j pr
LEFT JOIN Orders_j o ON pr.product_id = o.product_id
GROUP BY pr.product_id, pr.product_name
ORDER BY total_orders DESC;



-- 13. Flat Discount on All Products (10%)

SELECT product_name,
       price AS original_price,
       ROUND(price * 0.90, 2) AS discounted_price
FROM Products_j;


-- 14. Category‑Based Discount (Electronics 15%)

SELECT product_name, category,
       price AS original_price,
       CASE 
         WHEN category = 'Electronics' THEN ROUND(price * 0.85, 2)
         ELSE price
       END AS discounted_price
FROM Products_j;



-- 15 Most Selling Products → 5% Discount

SELECT pr.product_name,
       pr.price AS original_price,
       ROUND(pr.price * 0.95, 2) AS discounted_price
FROM Products_j pr
JOIN Orders_j o ON pr.product_id = o.product_id
GROUP BY pr.product_name, pr.price
ORDER BY COUNT(o.order_id) DESC
LIMIT 3;   

-- 16 . Least Selling Products → 30% Discount


SELECT pr.product_name,
       pr.price AS original_price,
       ROUND(pr.price * 0.70, 2) AS discounted_price
FROM Products_j pr
LEFT JOIN Orders_j o ON pr.product_id = o.product_id
GROUP BY pr.product_name, pr.price
ORDER BY COUNT(o.order_id) ASC
LIMIT 3;   -- bottom 3 least selling



-- 17 . Before vs After Discount Revenue (20% off all)

SELECT pr.product_name,
       SUM(p.amount) AS original_sales,
       SUM(p.amount * 0.80) AS discounted_sales
FROM Products_j pr
JOIN Orders_j o ON pr.product_id = o.product_id
JOIN Payments_j p ON o.order_id = p.order_id
GROUP BY pr.product_name;







