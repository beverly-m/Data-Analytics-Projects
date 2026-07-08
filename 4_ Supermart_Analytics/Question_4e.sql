/*
4e.  Find all customers whose city name contains the letter sequence 'an' (case-insensitive — e.g. Kano, 
Kaduna). Display first_name, last_name, and city. Order by city, then last_name.
*/

SELECT first_name, last_name, city
FROM customers
WHERE city ILIKE '%an%' OR city ILIKE '%na%'
ORDER BY city, last_name;