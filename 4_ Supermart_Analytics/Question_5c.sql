/* 
5c.  Produce a detailed order line report containing every row in order_items. For each row show: 
order_id, order_date, customer full name, product_name, quantity, unit_price, discount, and a 
calculated column line_total using the revenue formula. Order by order_id ascending, then 
product_name ascending. 
*/

SELECT oi.order_id, o.order_date, 
	CONCAT(c.first_name, ' ', c.last_name) AS customer_name, 
	p.product_name, oi.quantity, oi.unit_price, oi.discount, 
	ROUND(oi.quantity * oi.unit_price * (1 - oi.discount / 100.0), 2) AS line_total
FROM order_items AS oi
	LEFT JOIN orders AS o
	ON oi.order_id = o.order_id
	LEFT JOIN customers AS c
	ON o.customer_id = c.customer_id
	LEFT JOIN products AS p
	ON oi.product_id = p.product_id
ORDER BY oi.order_id ASC, p.product_name DESC;
