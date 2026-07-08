/*
6c.  For each order, calculate the total order value (sum of all its line totals), then classify it using the table 
below. Display order_id, order_date, status, total_order_value (rounded to 2 dp), and value_category. 
Order by total_order_value descending.
*/

SELECT o.order_id, o.order_date, o.status,
	ROUND(SUM(oi.quantity * oi.unit_price), 2) AS total_order_value,
	CASE WHEN ROUND(SUM(oi.quantity * oi.unit_price), 2) > 500000 THEN 'High Value' 
		WHEN ROUND(SUM(oi.quantity * oi.unit_price), 2) BETWEEN 100000 AND 500000 THEN 'Medium Value'
		WHEN ROUND(SUM(oi.quantity * oi.unit_price), 2) < 100000 THEN 'Low Value'
	END AS value_category
FROM orders AS o
	LEFT JOIN order_items AS oi
	ON o.order_id = oi.order_id
GROUP BY o.order_id, o.order_date, o.status
ORDER BY total_order_value DESC;
