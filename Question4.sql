SELECT TO_CHAR(r.rental_date, 'YYYY') AS rental_year, TO_CHAR(r.rental_date, 'Month') AS rental_month, s.store_id AS store, COUNT(r.*)  AS  rental_count
FROM store s
JOIN staff sf
ON s.store_id = sf.store_id
JOIN payment p
ON sf.staff_id = p.staff_id
JOIN rental r
ON r.rental_id = p.rental_id
GROUP BY 1,2,3
ORDER BY 1
