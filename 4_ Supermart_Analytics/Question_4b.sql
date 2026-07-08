/*
4b.  A product manager needs a list of all products whose names include the word "set" anywhere, 
regardless of case. Use ILIKE. Display product_name, category_id, and unit_price, ordered by 
unit_price descending.
*/

SELECT product_name, category_id, unit_price
FROM products
WHERE product_name ILIKE '%set%'
ORDER BY unit_price DESC;
