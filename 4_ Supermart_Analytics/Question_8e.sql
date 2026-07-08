/*
8e.  Using a CTE, compute the year-over-year total revenue from delivered orders for each year in the 
dataset (2021, 2022, 2023, and the first half of 2024). Display order_year and total_revenue (rounded to 
2 dp). Order by year ascending.
*/

WITH daily_revenue AS (
	SELECT o.order_date, 
		SUM(oi.quantity * oi.unit_price * (1 - oi.discount / 100.0)) AS revenue 
	FROM orders AS o
	INNER JOIN order_items AS oi
	ON o.order_id = oi.order_id
	WHERE o.status = 'Delivered'
	GROUP BY o.order_date
)	
SELECT EXTRACT(year FROM order_date) AS order_year,
	ROUND(SUM(revenue), 2) AS total_revenue
FROM daily_revenue
GROUP BY EXTRACT(year FROM order_date)
ORDER BY order_year ASC;


