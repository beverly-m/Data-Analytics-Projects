/*
8d.  Using CTEs, produce a customer frequency segmentation report. Calculate how many total orders 
each customer has placed, then classify each customer using the table below. Return one row per 
segment showing the segment label and customer_count. Order by customer_count descending. 
*/

WITH customer_orders AS (
	SELECT c.customer_id, 
		COUNT(o.order_id) AS orders
	FROM customers AS c 
	LEFT JOIN orders AS o
	ON c.customer_id = o.customer_id
	GROUP BY c.customer_id
) 
SELECT 
	CASE WHEN orders >= 8 THEN 'High Frequency' 
		WHEN orders BETWEEN 4 AND 7 THEN 'Regular' 
		WHEN orders BETWEEN 1 AND 3 THEN 'Occasional' 
		WHEN orders = 0 THEN 'Inactive'
	END AS segment,
	COUNT (customer_id) AS customer_count
FROM customer_orders
GROUP BY (
	CASE WHEN orders >= 8 THEN 'High Frequency' 
		WHEN orders BETWEEN 4 AND 7 THEN 'Regular' 
		WHEN orders BETWEEN 1 AND 3 THEN 'Occasional' 
		WHEN orders = 0 THEN 'Inactive'
	END
)
ORDER BY customer_count DESC;
