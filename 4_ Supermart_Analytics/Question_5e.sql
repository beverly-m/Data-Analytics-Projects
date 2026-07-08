/*
5e.  For each product category, list every product alongside the total number of distinct orders it has 
appeared in and the total quantity sold. Display category_name, product_name, times_ordered, and 
total_qty_sold. Order by category_name, then total_qty_sold descending. 
*/

SELECT ct.category_name, p.product_name, 
	COUNT(oi.product_id) AS times_ordered,
	SUM(oi.quantity) AS total_qty_sold
FROM categories AS ct
	INNER JOIN products AS p
	ON ct.category_id = p.category_id
	LEFT JOIN order_items AS oi
	ON p.product_id = oi.product_id
GROUP BY ct.category_name, p.product_name
ORDER BY ct.category_name, total_qty_sold DESC;
