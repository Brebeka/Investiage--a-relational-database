WITH t1 AS (SELECT CONCAT(c.first_name, ' ', c.last_name) AS full_name,  c.email, ci.city, p.amount, DATE_TRUNC('month',p.payment_date) paymonth,
CASE WHEN p.payment_date <= '2007-04-01' THEN 'last_two_month'
ELSE 'frist_two_month' END AS payment_month
FROM payment p
JOIN customer c
ON p.customer_id = c.customer_id
JOIN address a
ON a.address_id = c.address_id
JOIN city ci
ON ci.city_id = a.city_id)
SELECT full_name, email, city, SUM(amount) total_payment
FROM t1
GROUP BY 1,2,3
ORDER BY 4 DESC
LIMIT 10



SELECT *
FROM (WITH t2 AS (WITH t1 AS (SELECT CONCAT(c.first_name, ' ', c.last_name) AS full_name,  c.email, ci.city, p.amount, DATE_TRUNC('month',p.payment_date) paymonth,
CASE WHEN p.payment_date <= '2007-04-01' THEN 'last_two_month'
ELSE 'frist_two_month' END AS payment_month
FROM payment p
JOIN customer c
ON p.customer_id = c.customer_id
JOIN address a
ON a.address_id = c.address_id
JOIN city ci
ON ci.city_id = a.city_id)
SELECT  full_name, payment_month, SUM(amount) SUM_last_2_month
FROM T1
WHERE payment_month = 'last_two_month'
GROUP BY 1,2),

t3 AS (WITH t1 AS (SELECT CONCAT(c.first_name, ' ', c.last_name) AS full_name,  c.email, ci.city, p.amount, DATE_TRUNC('month',p.payment_date) paymonth,
CASE WHEN p.payment_date <= '2007-04-01' THEN 'last_two_month'
ELSE 'frist_two_month' END AS payment_month
FROM payment p
JOIN customer c
ON p.customer_id = c.customer_id
JOIN address a
ON a.address_id = c.address_id
JOIN city ci
ON ci.city_id = a.city_id)
SELECT  full_name, payment_month, SUM(amount) SUM_first_2_month
FROM T1
WHERE payment_month = 'frist_two_month'
GROUP BY 1,2)
SELECT t2.full_name, sum_last_2_month - sum_first_2_month AS difference
FROM t2
JOIN t3
ON t3.full_name = t2.full_name
ORDER BY 2) alias
WHERE difference < 0
