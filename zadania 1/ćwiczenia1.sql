-- Zadanie 1 --
WITH amount_per_order AS (
SELECT ord.order_id, 
	SUM(p.price*ord.quantity) AS full_amount
	FROM order_details ord
	JOIN pizzas p on p.pizza_id=ord.pizza_id
	JOIN orders o on o.order_id=ord.order_id
	WHERE o.date='2015-02-18'
	GROUP BY ord.order_id
)
SELECT AVG(full_amount) average_order_price
FROM amount_per_order

-- Zadanie 2 --
SELECT
ord.order_id
FROM pizzas p
JOIN order_details ord ON p.pizza_id = ord.pizza_id
JOIN orders o ON o.order_id = ord.order_id
JOIN pizza_types pt ON pt.pizza_type_id = p.pizza_type_id
WHERE o.date LIKE '2015-03%' 
GROUP BY ord.order_id
HAVING STRING_AGG(pt.ingredients,',')  NOT LIKE '%Pineapple%'

-- Zadanie 3 --
SELECT TOP 10
o.order_id,
SUM(p.price * ord.quantity) AS full_amount,
RANK() OVER (ORDER BY SUM(p.price * ord.quantity) DESC) AS ranking
FROM pizzas p
JOIN order_details ord ON p.pizza_id = ord.pizza_id
JOIN orders o ON o.order_id = ord.order_id 
WHERE o.date LIKE '2015-02%'
GROUP BY o.order_id;

--Zadanie 4--
--WYNIK TAKI JAK W PRZYK£ADZIE--
WITH amount_per_order AS (
SELECT ord.order_id, 
	   SUM(p.price) AS order_amount, 
	   o.date, 
	   MONTH(o.date) AS month 
	FROM order_details ord
	JOIN orders o ON ord.order_id = o.order_id
	JOIN pizzas p ON ord.pizza_id = p.pizza_id
	GROUP BY ord.order_id, o.date
),
average_per_month AS (
SELECT AVG(order_amount) AS average_month_amount, 
	  month AS month
	FROM amount_per_order 
	GROUP BY month
)
SELECT ord.order_id, 
       ord.order_amount, 
	   average_month_amount, 
	   ord.date
FROM amount_per_order ord
JOIN average_per_month ON ord.month = average_per_month.month;

--WYNIK Z ILOŒCI¥--
WITH amount_per_order AS (
SELECT ord.order_id, 
	   SUM(p.price*ord.quantity) AS order_amount, 
	   o.date, 
	   MONTH(o.date) AS month 
	FROM order_details ord
	JOIN orders o ON ord.order_id = o.order_id
	JOIN pizzas p ON ord.pizza_id = p.pizza_id
	GROUP BY ord.order_id, o.date
),
average_per_month AS (
SELECT AVG(order_amount) AS average_amount_month, 
	  month AS month
	FROM amount_per_order 
	GROUP BY month
)
SELECT ord.order_id, 
       ord.order_amount, 
	   average_amount_month, 
	   ord.date
FROM amount_per_order ord
JOIN average_per_month ON ord.month = average_per_month.month;

--Zadanie 5--
SELECT
COUNT(o.order_id) AS order_count,
o.date,
DATEPART(HOUR,o.time) AS hour
FROM orders o
WHERE o.date = '2015-01-01' 
GROUP BY o.date,DATEPART(HOUR,o.time)

--Zadanie 6--
SELECT 
SUM(ord.quantity) AS amount_sold,
pt.name,
pt.category
FROM pizza_types pt 
JOIN pizzas p ON pt.pizza_type_id = p.pizza_type_id 
JOIN order_details ord ON p.pizza_id = ord.pizza_id
JOIN orders o ON o.order_id = ord.order_id
WHERE o.date LIKE '2015-01%'
GROUP BY pt.name,pt.category
ORDER BY amount_sold DESC

--Zadanie 7--
SELECT 
p.size,
COUNT(p.size) AS count
FROM pizzas p
JOIN order_details ord ON p.pizza_id = ord.pizza_id
JOIN orders o ON o.order_id = ord.order_id
WHERE o.date LIKE '2015-02%' OR o.date LIKE '2015-03%'
GROUP BY p.size