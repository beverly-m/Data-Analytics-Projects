/*
3a.  Count the number of customers who registered each year between 2018 and 2024. 
Display the registration year and the count. 
Order by year ascending. 
*/

SELECT EXTRACT(YEAR from registration_date) AS registration_year, 
	COUNT(customer_id) AS customers_registered
FROM customers
GROUP BY EXTRACT(YEAR from registration_date)
ORDER BY registration_year ASC;