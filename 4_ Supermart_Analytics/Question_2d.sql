/*
2d.  How many distinct customers have placed at least one order? 
What is the average number of orders per ordering customer, rounded to 2 decimal places? 
Display both figures as separate columns in a single result row. 
*/

SELECT COUNT(DISTINCT customer_id) AS customers, 
	ROUND(COUNT(order_id)::numeric / COUNT(DISTINCT customer_id)::numeric, 2) AS orders_per_customer
FROM orders;
