/*
5a.  Display the 50 most recent orders. For each, show: order_id, the customer's full name, the handling 
employee's full name, order_date, status, and shipping_city. Use INNER JOINs. Order by order_date 
descending. 
*/

SELECT o.order_id, 
	CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
	CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
	o.order_date,
	o.status,
	o.shipping_city
FROM orders AS o
	INNER JOIN customers AS c
	ON o.customer_id = c.customer_id
	INNER JOIN employees AS e
	ON o.employee_id = e.employee_id
ORDER BY order_date DESC
LIMIT 50;
