/*
8a.  Using a single CTE, calculate the total revenue per customer across all their orders (all statuses). 
From the outer query, return only the top 10 customers by revenue. Display customer_id, full name, city, 
and total_revenue rounded to 2 dp. 
*/

WITH total_revenue_per_customer AS (
	SELECT c.customer_id, 
		CONCAT(c.first_name, ' ', c.last_name) AS full_name, 
		c.city,
		ROUND(
			SUM(quantity * unit_price * (1 - discount / 100.0)), 2
			) AS total_revenue
	FROM customers AS c
		INNER JOIN orders AS o 
		ON c.customer_id = o.customer_id 
		LEFT JOIN order_items AS oi
		ON o.order_id = oi.order_id 
	GROUP BY c.customer_id, c.first_name, c.last_name
)
SELECT customer_id, full_name, city, total_revenue
FROM total_revenue_per_customer
ORDER BY total_revenue DESC
LIMIT 10;
