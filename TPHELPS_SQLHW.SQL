

use sakila;

#1a
 Select first_name, last_name
 From actor;
 
 #1b
SELECT CONCAT(first_name, " " , last_name) as Actor_Name FROM actor;

#2a
SELECT actor_id, first_name, last_name
    FROM actor 
    WHERE first_name LIKE 'Joe';

#2b
SELECT first_name, last_name
    FROM actor 
    WHERE last_name LIKE '%Gen%';
    
#2c
SELECT last_name, first_name
    FROM actor 
    WHERE last_name LIKE '%LI%';
    
#2d
SELECT country, country_id
FROM country
WHERE country IN ('Afghanistan' , 'Bangladesh', 'China');

#3a
ALTER TABLE actor ADD description BLOB;

#3b
ALTER TABLE actor DROP COLUMN description;

#4a
Select last_name, COUNT(*) FROM actor GROUP BY last_name;

#4b
 SELECT last_name, COUNT(*)
FROM actor
GROUP BY last_name
HAVING COUNT(*) >1 ;

#4c
UPDATE actor
SET first_name = "HARPO"
WHERE first_name = "GROUCHO" AND last_name = "WILLIAMS";

#see changes
Select first_name, last_name from actor where first_name = "HARPO";

#4d
UPDATE actor SET first_name = "GROUCHO" WHERE first_name = "HARPO";

#5a
SHOW CREATE TABLE address;

#6a
SELECT staff.first_name, staff.last_name, address.address
FROM staff
INNER JOIN address ON staff.address_id=address.address_id;

#6b
SELECT staff.first_name, staff.last_name, SUM(amount) as total_sales
	FROM staff INNER JOIN payment
    ON payment.staff_id=staff.staff_id
    WHERE payment.payment_date LIKE '2005-08%'
    GROUP BY payment.staff_id;

#6c
SELECT title, COUNT(actor_id) AS Num_of_Actors
	FROM film INNER JOIN film_actor
	ON film.film_id=film_actor.film_id
    GROUP BY title;

#6d
SELECT film.title, COUNT(inventory.film_id) as Num_of_Copies
	FROM film INNER JOIN inventory
    ON film.film_id=inventory.film_id
    WHERE film.title = 'HUNCHBACK IMPOSSIBLE';

#6e
SELECT customer.first_name, customer.last_name, SUM(payment.amount) as total_spent
	FROM customer INNER JOIN payment
    ON payment.customer_id=customer.customer_id
    GROUP BY customer.customer_id
    ORDER BY last_name ASC;
    
#7a
SELECT title
FROM film
WHERE language_id IN
(
  SELECT language_id
  FROM film
  WHERE language_id = 1
  )
  AND (title LIKE "K%") OR (title LIKE "Q%");

#7b
SELECT first_name, last_name
FROM actor
WHERE actor_id in
	(SELECT actor_id FROM film_actor
    WHERE film_id IN
		(SELECT film_id FROM film
        WHERE title = "Alone Trip")
        );

#7c
SELECT customer.first_name, customer.last_name, customer.email
	FROM customer INNER JOIN customer_list
    ON customer_list.id=customer.customer_id
    WHERE customer_list.country = 'CANADA';
    

#7d
SELECT title FROM film_list
WHERE category = "Family";

#7e
SELECT film.title, COUNT(*) as Times_Rented
	FROM rental, film, inventory
    WHERE film.film_id=inventory.film_id AND rental.inventory_id=inventory.inventory_id
	GROUP BY inventory.film_id
	ORDER BY COUNT(*) DESC, film.title ASC;
    
#7f
SELECT store, manager, total_sales from sales_by_store;
#OR?
SELECT store.store_id, SUM(amount) AS revenue
FROM store INNER JOIN staff 
ON store.store_id = staff.store_id
INNER JOIN payment 
ON payment.staff_id = staff.staff_id
GROUP BY store.store_id;

#7G
SELECT 
    store.store_id, city.city, country.country
FROM store INNER JOIN address 
	ON store.address_id = address.address_id
	INNER JOIN city 
    ON address.city_id = city.city_id
	INNER JOIN country ON city.country_id = country.country_id;
    
#7H
SELECT name, SUM(payment.amount) AS gross_revenue
FROM category  INNER JOIN film_category
	ON film_category.category_id = category.category_id
	INNER JOIN inventory  ON inventory.film_id = film_category.film_id
	INNER JOIN rental  ON rental.inventory_id = inventory.inventory_id
	INNER JOIN payment  ON payment.rental_id = rental.rental_id
	GROUP BY name
	ORDER BY gross_revenue DESC
	LIMIT 5;

#8A
CREATE VIEW top_5_genres AS
SELECT name, SUM(payment.amount) AS gross_revenue
FROM category INNER JOIN film_category
ON film_category.category_id = category.category_id
	INNER JOIN inventory  ON inventory.film_id = film_category.film_id
	INNER JOIN rental  ON rental.inventory_id = inventory.inventory_id
	INNER JOIN payment ON payment.rental_id = rental.rental_id
	GROUP BY name
	ORDER BY gross_revenue DESC
	LIMIT 5;
    
#8B
SELECT * from top_5_genres;

#8C
DROP VIEW top_5_genres;


