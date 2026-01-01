

CREATE TABLE Transactions_d (
    transaction_id   SERIAL PRIMARY KEY,
    customer_name    VARCHAR(50),
    city             VARCHAR(50),
    transaction_ts   TIMESTAMP,     -- stores both date and time
    amount           NUMERIC(10,2),
    mode             VARCHAR(20)    -- UPI, Credit Card, NetBanking
);


INSERT INTO Transactions_d (transaction_id, customer_name, city, transaction_ts, amount, mode)
VALUES
-- Same date & time (duplicates for practice)
(1, 'Ravi Kumar', 'Hyderabad', '2024-03-10 14:45:00', 1500.00, 'UPI'),
(2, 'Priya Sharma', 'Mumbai',    '2024-03-10 14:45:00', 2500.00, 'Credit Card'),
(3, 'Arjun Reddy', 'Delhi',      NULL,                   3200.00, 'NetBanking'),
(4, 'Sneha Iyer',  'Chennai',    '2024-04-01 12:00:00',  NULL,    'UPI'),
(5, 'Kiran Patel', 'Ahmedabad',  '2024-03-12 16:20:00',  4999.00, 'Credit Card'),
(6, 'Meera Joshi', 'Pune',       '2024-03-15 11:05:00',  3499.00, 'NetBanking'),
(7, 'Anil Verma',  'Kolkata',    '2024-04-05 19:30:00',  7999.00, 'UPI'),
(8, 'Lakshmi Menon','Kochi',     '2024-04-10 08:10:00',  1200.00, 'UPI'),
(9, 'Rahul Singh', 'Lucknow',    '2024-05-01 09:00:00',  2200.00, 'Credit Card'),
(10,'Neha Gupta',  'Jaipur',     '2024-05-01 09:00:00',  2200.00, 'UPI'), 
(11,'Vikram Rao',  'Bengaluru',  '2024-06-15 21:15:00',  15000.00,'NetBanking'),
(12,'Pooja Nair',  'Thiruvananthapuram','2024-06-20 07:45:00', 1800.00,'UPI'),
(13,'Suresh Das',  'Patna',      '2024-07-10 13:30:00',  NULL,    'Credit Card'),
(14,'Ananya Roy',  'Kolkata',    '2024-07-10 13:30:00',  5600.00, 'UPI'), 
(15,'Manoj Mehta', 'Surat',      '2024-08-25 17:00:00',  9999.00, 'NetBanking'),
(16,'Divya Kapoor','Delhi',      '2024-08-25 17:00:00',  9999.00, 'Credit Card'), 
(17,'Santosh Yadav','Nagpur',    '2024-09-05 22:10:00',  4500.00, 'UPI'),
(18,'Kavita Pillai','Chennai',   '2024-09-05 22:10:00',  4500.00, 'UPI'), 
(19,'Deepak Sharma','Noida',     '2024-10-01 06:30:00',  3000.00, 'Credit Card'),
(20,'Meena Rathi', 'Indore',     '2024-10-01 06:30:00',  3000.00, 'NetBanking'); 


SELECT * FROM transactions_d;




-- retrive only date 

SELECT cast(transaction_ts as Date) as Onlydate
from transactions_d;


-- retrive date using shorthand ::Date
SELECT transaction_ts::Date as only_date
from transactions_d;




-- retrive only time

SELECT CAST(transaction_ts AS TIME) AS only_time
FROM Transactions_d;



-- Coverts time zones

-- Convert to UTC
SELECT transaction_ts AT TIME ZONE 'UTC' AS utc_time
FROM Transactions_d;

-- Convert to IST
SELECT transaction_ts AT TIME ZONE 'Asia/Kolkata' AS ist_time
FROM Transactions_d;



-- retrive full date using to_char

SELECT to_char(transaction_ts,'YYYY-MM-DD') as Fulldate
from transactions_d;


-- retrive month day using to_char
SELECT to_char(transaction_ts, 'MM-DD') as Month_day
from transactions_d;


-- round the timestampz 
SELECT date_trunc('year',transaction_ts) as YEAR
from transactions_d;



-- extract year, month,day from timestampz format

SELECT EXTRACT(YEAR FROM transaction_ts) AS year,
       EXTRACT(MONTH FROM transaction_ts) AS month,
       EXTRACT(DAY FROM transaction_ts) AS day
FROM Transactions_d;



-- Time Zone helps to change time zone 

SELECT transaction_ts AT TIME ZONE 'Asia/Kolkata' AS ist_time,
       transaction_ts AT TIME ZONE 'UTC' AS utc_time
FROM Transactions_d;


-- fetch current timestamp
SELECT NOW() AS current_timestamp;


-- CURRENT_DATE / CURRENT_TIME : Returns just the current date or time.


SELECT CURRENT_DATE AS today,
       CURRENT_TIME AS current_time;




-- TIMEOFDAY(): Returns a text string with current time info.
SELECT TIMEOFDAY();





-- Extract

-- Extract year, month, day
SELECT transaction_id,
       EXTRACT(YEAR FROM transaction_ts) AS year,
       EXTRACT(MONTH FROM transaction_ts) AS month,
       EXTRACT(QUARTER FROM transaction_ts) AS quater,
       EXTRACT(WEEK FROM transaction_ts) AS week,
       EXTRACT(DAY FROM transaction_ts) AS day,
       EXTRACT(HOUR FROM transaction_ts) AS hour,
       EXTRACT(MINUTE FROM transaction_ts) AS minute,
       EXTRACT(DOW FROM transaction_ts) AS dow,
       EXTRACT(DOY FROM transaction_ts) AS doy
FROM Transactions_d;







-- Round down timestamps to a unit (month, day, hour), Group by month and give monthly revenue trends.
SELECT DATE_TRUNC('month', transaction_ts) AS month,
       SUM(amount) AS total_revenue
FROM Transactions_d
GROUP BY DATE_TRUNC('month', transaction_ts);



-- Identify duplicates where multiple customers transacted at the same timestamp.

SELECT transaction_ts, COUNT(*) AS num_transactions
FROM Transactions_d
GROUP BY transaction_ts
HAVING COUNT(*) > 1;


-- Transactions in March 2024:

SELECT * 
FROM Transactions_d
WHERE EXTRACT(MONTH FROM transaction_ts) = 3
  AND EXTRACT(YEAR FROM transaction_ts) = 2024;


-- Weekend transactions:


SELECT * 
FROM Transactions_d
WHERE EXTRACT(DOW FROM transaction_ts) IN (0,6);  -- Sunday=0, Saturday=6




-- Add or subtract intervals, or calculate differences.


-- Add 7 days
SELECT transaction_ts + INTERVAL '7 days' AS next_week
FROM Transactions_d;

-- Difference from now
SELECT AGE(NOW(), transaction_ts) AS time_since_transaction
FROM Transactions_d;
