/*
3d.  Show each employee's full name and the total number of orders they handled. Return only 
employees who handled 20 or more orders. Order by order count descending. 
*/

SELECT CONCAT(e.first_name, ' ', e.last_name) AS full_name, 
	COUNT(o.order_id) AS total_orders
FROM orders AS o
	LEFT JOIN employees AS e
	ON o.employee_id = e.employee_id
GROUP BY e.first_name, e.last_name
HAVING COUNT(o.order_id) >= 20
ORDER BY total_orders DESC;
