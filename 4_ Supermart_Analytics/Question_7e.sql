/*
e.  Find all customers whose total lifetime revenue exceeds the average lifetime revenue across all 
ordering customers. Display their full name, city, and total revenue (rounded to 2 dp). Order by total 
revenue descending. 
*/

SELECT full_name, city, total_lifetime_revenue 
FROM (
	SELECT full_name, city, 
		ROUND(SUM(revenue), 2) AS total_lifetime_revenue
	FROM ( 
		SELECT 
			CONCAT(c.first_name, ' ', c.last_name) AS full_name, 
			c.city, 
			oi.quantity * oi.unit_price * (1 - oi.discount / 100.0) AS revenue
		FROM customers AS c
			INNER JOIN orders AS o
			ON c.customer_id = o.customer_id
			LEFT JOIN order_items AS oi
			ON o.order_id = oi.order_id
		) 
	GROUP BY full_name, city
)
WHERE total_lifetime_revenue > (
	SELECT AVG(total_lifetime_revenue) 
	FROM (
		SELECT full_name, city, 
			ROUND(SUM(revenue), 2) AS total_lifetime_revenue
		FROM ( 
			SELECT 
				CONCAT(c.first_name, ' ', c.last_name) AS full_name, 
				c.city, 
				oi.quantity * oi.unit_price * (1 - oi.discount / 100.0) AS revenue
			FROM customers AS c
				INNER JOIN orders AS o
				ON c.customer_id = o.customer_id
				LEFT JOIN order_items AS oi
				ON o.order_id = oi.order_id
		) 
	GROUP BY full_name, city
	)
)
ORDER BY total_lifetime_revenue DESC;
	
