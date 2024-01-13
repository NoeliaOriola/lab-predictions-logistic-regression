USE Sakila;

-- 1. SQL queries to extract relevant information: Film features and Rental features
-- 2. Creating a query to determine films rented in May 2005
SELECT
    f.film_id,
    f.title AS film_title,
    f.release_year,
    f.length,
    f.rating,
    f.language_id,
    f.rental_duration,
    f.rental_rate,
    f.replacement_cost,
    COUNT(r.rental_id) AS num_rentals
FROM
    film f
LEFT JOIN
    inventory i ON f.film_id = i.film_id
LEFT JOIN
    rental r ON i.inventory_id = r.inventory_id
    AND EXTRACT(YEAR_MONTH FROM r.rental_date) = 200505
GROUP BY
    f.film_id, film_title, release_year, length, rating, language_id, rental_duration, rental_rate, replacement_cost;

-- Getting unique Film Titles and Rented Status in May 2005. creating list of unique film titles and a boolen indicating if it was rented in May 2005.

SELECT 
    f.title AS film_title,
    CASE WHEN COUNT(r.rental_id) > 0 THEN 1 ELSE 0 END AS rented_in_may
FROM
    film f
LEFT JOIN
    inventory i ON f.film_id = i.film_id
LEFT JOIN
    rental r ON i.inventory_id = r.inventory_id
    AND EXTRACT(YEAR_MONTH FROM r.rental_date) = 200505
GROUP BY
    f.title;
    
    -- 3. Read data into a PnadasDataframe
SELECT f.film_id, f.title, 
       CASE WHEN r.rental_date IS NOT NULL THEN 1 ELSE 0 END AS rented_in_may
FROM film AS f
LEFT JOIN inventory AS i ON f.film_id = i.film_id
LEFT JOIN rental AS r ON i.inventory_id = r.inventory_id
WHERE YEAR(r.rental_date) = 2005 AND MONTH(r.rental_date) = 5

