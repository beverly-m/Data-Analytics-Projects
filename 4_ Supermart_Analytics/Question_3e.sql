/*
3e.  For each year in the dataset (2021–2024), show the total number of orders placed and the count of 
distinct customers who ordered that year. 
Order by year ascending. 
*/

SELECT EXTRACT(year FROM order_date) AS "year", 
	COUNT(*) AS orders_placed, 
	COUNT(DISTINCT customer_id) AS customers_ordered
FROM orders
GROUP BY EXTRACT(year FROM order_date)
ORDER BY year ASC;
