/*
6d.  Using a single query with CASE inside an aggregate, count how many products in each category fall 
into each price tier. Display one row per category with columns: category_name, budget_count, 
mid_range_count, premium_count. 
*/

SELECT ct.category_name,
	COUNT(
		CASE WHEN p.unit_price < 10000 THEN 1 END
	) AS budget_count,
	COUNT(
		CASE WHEN p.unit_price BETWEEN 10000 AND 99999 THEN 1 END
	) AS mid_range_count,
	COUNT(
		CASE WHEN p.unit_price >= 100000 THEN 1 END
	) AS premium_count
FROM categories AS ct
	INNER JOIN products AS p
	ON ct.category_id = p.category_id
GROUP BY ct.category_name;