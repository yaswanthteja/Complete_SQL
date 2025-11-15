-- Create the Products table
CREATE TABLE Products (
  ProductID INT PRIMARY KEY,
  ProductName VARCHAR(50) NOT NULL,
  Category VARCHAR(30),
  Price INT,
  Stock INT
);

-- Insert sample data
INSERT INTO Products (ProductID, ProductName, Category, Price, Stock)
VALUES
(1, 'Laptop', 'Electronics', 55000, 25),
(2, 'Headphones', 'Electronics', 1500, 100),
(3, 'Coffee Mug', 'Kitchen', 300, 200),
(4, 'Office Chair', 'Furniture', 7000, 15),
(5, 'Smartphone', 'Electronics', 25000, 40),
(6, 'Blender', 'Kitchen', 1800, 60),
(7, 'Desk Lamp', 'Furniture', 1200, 80),
(8, 'Monitor', 'Electronics', 12000, 30);



-- using select fetch all table details

select * from products;


-- fetch only productname and price

select productname,price from products;



-- Show all products in the "Electronics" category

select * 
from products
where category='Electronics';


-- List products with price greater than ₹5000
SELECT ProductName, Price FROM Products
WHERE Price > 5000;


-- Show products with stock between 30 and 100
SELECT ProductName, Stock FROM Products
WHERE Stock BETWEEN 30 AND 100;



-- List all furniture items sorted by stock (descending)

SELECT ProductName, Stock FROM Products
WHERE Category = 'Furniture'
ORDER BY Stock DESC;



--Show top 3 most expensive products
SELECT ProductName, Price FROM Products
ORDER BY Price DESC
LIMIT 3;


-- Skip the first 2 cheapest products and show the next 3

SELECT ProductName, Price FROM Products
ORDER BY Price ASC
LIMIT 3
OFFSET 2




