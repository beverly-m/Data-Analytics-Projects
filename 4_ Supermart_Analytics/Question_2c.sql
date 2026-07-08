/*
2c.  Across all rows in order_items, calculate: the total revenue generated, the average revenue per line 
item, the maximum revenue from a single line item, and the minimum revenue from a single line item. 
Round all values to 2 decimal places and label each column clearly. 
*/

WITH order_items_revenue AS (
	SELECT *,
		ROUND(quantity * unit_price * (1 - discount / 100.0), 2) AS revenue
	FROM order_items
)
SELECT product_id,
	(SELECT SUM(revenue) FROM order_items_revenue) AS total_revenue,
	ROUND(AVG(revenue), 2) AS avg_revenue_per_line_item,
	ROUND(MAX(revenue), 2) AS max_revenue_per_line_item,
	ROUND(MIN(revenue), 2) AS min_revenue_per_line_item
FROM order_items_revenue
GROUP BY product_id;