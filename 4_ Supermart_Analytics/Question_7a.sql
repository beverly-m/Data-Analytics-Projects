/*
7a.  Find all products whose unit_price is above the average unit price of all products in the catalogue. 
Display product_name, category_id, and unit_price. Order by unit_price descending. 
*/

SELECT product_name, category_id, unit_price
FROM products 
WHERE unit_price > (
	SELECT AVG(unit_price)
	FROM products
	)
ORDER BY unit_price DESC;
