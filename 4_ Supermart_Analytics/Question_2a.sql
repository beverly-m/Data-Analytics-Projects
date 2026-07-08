/* 
2a.  How many orders exist for each status? 
Display the status, the count, and each status as a percentage of all orders, rounded to 2 decimal places. 
Label the percentage column pct_of_total. Order by count descending. 
*/

WITH total_orders AS (
	SELECT status,
		(SELECT COUNT(*) 
			FROM orders) AS total
	FROM orders
) 
SELECT status, 
	COUNT(status) AS count_of_orders,
	ROUND(
		(COUNT(status)::numeric / total::numeric) * 100, 2
		) AS pct_of_total
FROM total_orders
GROUP BY status, total
ORDER BY count_of_orders DESC;
