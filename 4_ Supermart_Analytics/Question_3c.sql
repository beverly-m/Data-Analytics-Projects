/*
3c.  Find all products whose total quantity sold across all order_items exceeds 50 units. 
Display product_id, product_name, and total quantity sold. Order by total quantity descending. 
*/

SELECT o.product_id, p.product_name, 
	SUM(o.quantity) AS total_quantity_sold
FROM order_items AS o
	LEFT JOIN products AS p
	ON o.product_id = p.product_id
GROUP BY o.product_id, p.product_name
HAVING SUM(o.quantity) > 50
ORDER BY total_quantity_sold DESC;
