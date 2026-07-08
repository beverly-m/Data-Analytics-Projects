/*
6a.  Assign a price tier label to every product using the table below. Display product_name, 
category_name (joined from categories), unit_price, and price_tier. Order by unit_price ascending.
*/

SELECT p.product_name, c.category_name, p.unit_price,
	CASE WHEN unit_price < 10000 THEN 'Budget'
		WHEN unit_price BETWEEN 10000 AND 99999 THEN 'Mid-Range'
		WHEN unit_price >= 100000 THEN 'Premium'
	END AS price_tier
FROM products AS p
	LEFT JOIN categories AS c
	ON p.category_id = c.category_id
ORDER BY unit_price ASC;