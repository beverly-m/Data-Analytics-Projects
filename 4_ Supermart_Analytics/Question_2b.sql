/*
2b.  For each product category, calculate the minimum, maximum, and average unit_price of products 
in that category. 
Round the average to 2 decimal places. 
Display category_name (not just the ID). 
Order by average price descending. 
*/

SELECT p.category_id,
	c.category_name,
	MIN(p.unit_price) AS min_price,
	MAX(p.unit_price) AS max_price,
	ROUND(AVG(p.unit_price), 2) AS avg_price
FROM products AS p
	LEFT JOIN categories AS c
	ON p.category_id = c.category_id
GROUP BY p.category_id, c.category_name
ORDER BY avg_price DESC;