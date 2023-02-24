




## Given the following table named "orders" in an SQL database:



![image](https://user-images.githubusercontent.com/93423367/221240584-79a751fe-e967-43e3-875c-12ecf3307c94.png)

## Write an SQL query to retrieve the total order value for each customer.

```
SELECT customer_id, SUM(order_total) AS total_order_value
FROM orders
GROUP BY customer_id;

```

output

![image](https://user-images.githubusercontent.com/93423367/221240806-1c368452-fa88-4b82-8268-edff5d9ab3ee.png)



