/*
4d.  Retrieve all products whose names contain "combo", "kit", or "pack" anywhere in the name (case
insensitive). Use ILIKE with OR. Display product_name, category_id, and unit_price.
*/

SELECT product_name, category_id, unit_price
FROM products
WHERE product_name ILIKE '%combo%'
	OR product_name ILIKE '%kit%'
	OR product_name ILIKE '%pack%';

