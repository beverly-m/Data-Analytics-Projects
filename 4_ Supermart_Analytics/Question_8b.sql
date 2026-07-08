/*
8b.  Using a CTE, identify the single best-selling product (by total quantity sold) in each category. Display 
category_name, product_name, and total_qty_sold. 
*/

WITH total_quantity_sold AS (
	SELECT ct.category_name, p.product_name,
		SUM(quantity) AS total_qty_sold, 
		ROW_NUMBER() OVER(PARTITION BY category_name ORDER BY category_name ASC, 
		SUM(quantity) DESC) AS ranking
	FROM products AS p 
		INNER JOIN order_items AS oi
		ON p.product_id = oi.product_id
		INNER JOIN categories AS ct
		ON p.category_id = ct.category_id
	GROUP BY ct.category_name, p.product_name
	ORDER BY category_name ASC, total_qty_sold DESC
)
SELECT category_name, product_name, total_qty_sold
FROM total_quantity_sold
WHERE ranking = 1;
