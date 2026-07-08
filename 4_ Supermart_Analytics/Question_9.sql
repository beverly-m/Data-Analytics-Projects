/*
Question 9 — Employee Sales Performance Report 
SuperMart's board has requested a comprehensive Employee Sales Performance Dashboard for all 
delivered orders placed between 1 January 2021 and 30 June 2024. 
Write a single SQL query — using at least two CTEs 

Requirements: 
• Include all 35 employees, even those who handled zero delivered orders. 
• Employees with no delivered orders must show 0 for all numeric columns. 
• Order results by total_revenue descending, then employee_name ascending.
*/

WITH order_revenue AS (
	SELECT order_id, 
		SUM(quantity * unit_price * (1 - discount / 100.0)) AS revenue
	FROM order_items
	GROUP BY order_id
), employee_stats AS (
	SELECT o.employee_id, 
		COUNT(orev.order_id) AS total_delivered_orders,
		ROUND(SUM(orev.revenue), 2) AS total_revenue,
		ROUND(MAX(orev.revenue), 2) AS best_single_order 
	FROM order_revenue AS orev 
		INNER JOIN orders AS o
		ON orev.order_id = o.order_id
	WHERE status = 'Delivered'
	GROUP BY o.employee_id
)
SELECT CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
		e.role, r.region_name, 
		es.total_delivered_orders,
	    es.total_revenue,
		ROUND(es.total_revenue/es.total_delivered_orders, 2) AS avg_order_value,
		es.best_single_order,
		CASE WHEN es.total_revenue > 5000000 THEN 'Elite'
			WHEN es.total_revenue BETWEEN 1000000 AND 5000000 THEN 'Strong' 
			WHEN es.total_revenue BETWEEN 100000 AND 999999 THEN 'Developing' 
			WHEN es.total_revenue < 100000 OR es.total_revenue = 0 THEN 'Inactive' 
		END AS performance_band
FROM employees AS e
	LEFT JOIN employee_stats AS es
	ON e.employee_id = es.employee_id
	LEFT JOIN regions AS r
	ON e.region_id = r.region_id
ORDER BY total_revenue DESC, employee_name ASC;
