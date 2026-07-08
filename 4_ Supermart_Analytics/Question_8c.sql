/*
8c.  Using two chained CTEs, analyse monthly performance for the year 2023 only: 
• CTE 1: Total revenue per calendar month in 2023 (all statuses). 
• CTE 2: The average monthly revenue across all months of 2023. 
• Final query: Each month number, total revenue (rounded to 2 dp), and a column called 
vs_average — set to 'Above Average' if that month beat the average, otherwise 'Below Average'. 
Order by month ascending. 
*/

WITH total_revenue_per_month AS (
	SELECT EXTRACT(month FROM o.order_date) AS month_number,
		ROUND(SUM(oi.quantity * oi.unit_price * (1 - oi.discount / 100.0)), 2) AS total_revenue
	FROM orders AS o
		LEFT JOIN order_items AS oi
		ON o.order_id = oi.order_id
	WHERE EXTRACT(year FROM o.order_date) = 2023
	GROUP BY EXTRACT(month FROM o.order_date)
), avg_monthly_revenue AS (
	SELECT ROUND(AVG(total_revenue), 2) AS avg_revenue
	FROM total_revenue_per_month
) 
SELECT month_number, total_revenue, 
	CASE WHEN total_revenue > (SELECT avg_revenue FROM avg_monthly_revenue) 
			THEN 'Above Average'
		WHEN total_revenue < (SELECT avg_revenue FROM avg_monthly_revenue)
			THEN 'Below Average' 
		END AS vs_average
FROM total_revenue_per_month;
