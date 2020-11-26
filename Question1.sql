SELECT c.name AS category_name, COUNT(r.*) AS rental_count
FROM category c
JOIN film_category fc
ON c.category_id = fc.category_id
JOIN film f
ON f.film_id = fc.film_id
JOIN inventory i
ON i.film_id = f.film_id
JOIN rental r
ON r.inventory_id = i.inventory_id
WHERE c.name IN ('Family', 'Music' , 'Animation', 'Children', 'Classics', 'Comedy')
GROUP BY 1
ORDER BY 2
