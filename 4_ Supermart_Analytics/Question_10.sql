/*
Question 10 — Customer Lifetime Value Report 
Management also wants to understand customer purchasing behaviour over the lifetime of the business. 
*/

WITH customer_stats AS (
	SELECT customer_id, 
		COUNT(order_id) AS total_orders,
		COUNT(CASE WHEN status = 'Delivered' THEN 1 END) AS delivered_orders,
		COUNT(CASE WHEN status = 'Cancelled' THEN 1 END) AS cancelled_orders
	FROM orders
	GROUP BY customer_id
), customer_revenue AS (
	SELECT o.customer_id, 
		ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount / 100.0)), 2) AS lifetime_revenue
	FROM orders AS o
		LEFT JOIN order_items AS oi
		ON o.order_id = oi.order_id
	GROUP BY o.customer_id
)
SELECT CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
	c.city, EXTRACT(year FROM c.registration_date) AS registration_year,
	COALESCE(cs.total_orders, 0) AS total_orders, 
	COALESCE(cs.delivered_orders, 0) AS delivered_orders, 
	COALESCE(cs.cancelled_orders, 0) AS cancelled_orders,
	COALESCE(cr.lifetime_revenue, 0) AS lifetime_revenue, 
	COALESCE(ROUND(cr.lifetime_revenue/cs.total_orders, 2), 0) AS avg_order_value,
	CASE WHEN cr.lifetime_revenue > 500000 
			AND cs.delivered_orders >= 5 THEN 'VIP'
		WHEN cr.lifetime_revenue BETWEEN 100000 AND 500000 
			OR cs.delivered_orders BETWEEN 2 AND 4 THEN 'Loyal' 
		WHEN cs.delivered_orders = 1 THEN 'One-Time Buyer' 
		WHEN cs.delivered_orders = 0 
			AND cs.total_orders >= 1 THEN 'No Conversions' 
		WHEN cs.total_orders = 0 OR cs.total_orders IS NULL THEN 'Inactive' 
	END AS customer_segment
FROM customers AS c
	LEFT JOIN customer_stats AS cs
	ON c.customer_id = cs.customer_id
	LEFT JOIN customer_revenue AS cr
	ON c.customer_id = cr.customer_id
WHERE EXTRACT(year FROM registration_date) < 2024
ORDER BY lifetime_revenue DESC, customer_name ASC;
