-- Q1 - List all customers who live in Texas
-- Way-1
SELECT first_name, last_name 
FROM customer WHERE address_id IN( 
		SELECT address_id FROM address
		WHERE district = 'Texas');

-- Way-2
SELECT first_name, last_name FROM customer c
JOIN address a
ON c.address_id = a.address_id 
WHERE a.district = 'Texas';
---------------------------------------------
-- Q2 Get all payments above $6.99 with the Customer’s full name

SELECT first_name, last_name FROM customer c
WHERE customer_id IN (	
	SELECT customer_id FROM payment p
	WHERE p.amount > 6.99);
---------------------------------------------
-- Q3 Show all customer names who have made payments over $175
SELECT first_name, last_name FROM customer c
WHERE customer_id IN (	
	SELECT customer_id FROM payment p
	GROUP BY p.customer_id
	HAVING sum(p.amount) > 175);
---------------------------------------------
-- Q4 List all customers that live in Argentina
SELECT first_name, last_name FROM customer c   -- GET name AND lastname 
WHERE c.address_id IN (
	SELECT address_id FROM address a           -- GET Addres id
	WHERE a.city_id IN(
		SELECT city_id FROM city ci		       -- GET city id
		WHERE ci.country_id IN(
			SELECT country_id FROM country     -- GET country id
			WHERE country = 'Argentina')
		)
	);
---------------------------------------------
-- Q5 Which film category has the least movies in it 
SELECT "name" FROM category c
WHERE c.category_id = (
	SELECT category_id FROM film_category fc
	GROUP BY category_id
	ORDER BY count(category_id) ASC
	LIMIT 1);
----------------------------------------------
-- Q6 What film had the most actors in it
SELECT title FROM film f
WHERE f.film_id = (
	SELECT film_id FROM film_actor fa
	GROUP BY film_id
	ORDER BY count(film_id) DESC
	LIMIT 1);
-----------------------------------------------
-- Q7 Which actor has been in the least movies?
SELECT first_name, last_name FROM actor a
WHERE a.actor_id = (
	SELECT actor_id FROM film_actor fa
	GROUP BY actor_id
	ORDER BY count(actor_id) ASC
	LIMIT 1);
-----------------------------------------------
-- Q8 Which country has the most cities?
SELECT country FROM country c2
WHERE c2.country_id = (
	SELECT country_id FROM city c
	GROUP BY city_id
	ORDER BY count(city_id) DESC
	LIMIT 1);
------------------------------------------------
-- Q9 List the actors who have been in more than 3 films but less than 6.
SELECT first_name, last_name FROM actor a
WHERE a.actor_id IN (
	SELECT actor_id FROM film_actor fa
	GROUP BY actor_id
	HAVING count(actor_id) BETWEEN 3 AND 15);




