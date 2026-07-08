/*
7c.  Find all products that have never appeared in any order. Display product_id, product_name, 
category_id, and unit_price. 
*/

SELECT product_id, product_name, category_id, unit_price
FROM products
WHERE product_id NOT IN (
	SELECT DISTINCT product_id
	FROM order_items
);
