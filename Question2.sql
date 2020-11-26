SELECT fullname, film_title, rental_count, SUM(rental_count) OVER (PARTITION BY fullname ORDER BY rental_count) appereance
FROM (SELECT CONCAT( a.first_name, ' ', a.last_name) AS fullname, f.title AS film_title, c.name AS category_name, COUNT(r.*) AS rental_count
FROM category c
JOIN film_category fc
ON c.category_id = fc.category_id
JOIN film f
ON f.film_id = fc.film_id
JOIN inventory i
ON i.film_id = f.film_id
JOIN rental r
ON r.inventory_id = i.inventory_id
JOIN film_actor fa
ON fa.film_id = f.film_id
JOIN actor a
ON a.actor_id = fa.actor_id
WHERE c.name IN ('Family', 'Music' , 'Animation', 'Children', 'Classics', 'Comedy')
GROUP BY 1,2,3
ORDER BY 1 ) sub
ORDER BY 1
