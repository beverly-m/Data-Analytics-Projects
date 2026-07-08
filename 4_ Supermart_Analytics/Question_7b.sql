/*
7b.  List all customers who have placed at least one order. Display their full name and city. Solve this using 
a subquery with IN — do not use a JOIN. 
*/

SELECT CONCAT(first_name, ' ', last_name) AS full_name,
	city
FROM customers
WHERE customer_id IN (
	SELECT DISTINCT customer_id 
	FROM orders
)
