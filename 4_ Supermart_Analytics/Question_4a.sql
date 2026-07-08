/*
4a. SuperMart wants to run a Gmail campaign. Retrieve the first_name, last_name, and email of all 
customers whose email address ends with @gmail.com. Order alphabetically by last_name.
*/

SELECT first_name, last_name, email
FROM customers
WHERE email LIKE '%@gmail.com'
ORDER BY last_name ASC;