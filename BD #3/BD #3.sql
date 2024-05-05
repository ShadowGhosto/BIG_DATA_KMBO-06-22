SELECT order_id, COUNT(quantity) as count_quantity
FROM order_details
GROUP BY order_id
HAVING COUNT(quantity) > 5
ORDER BY count_quantity ASC;

SELECT *
FROM sqlite_schema;

SELECT pizza_name, pizza_ingredients
FROM pizza;

SELECT pizza_name, category_name, pizza_ingredients
FROM pizza, category
where category_name = "Veggie" or category_name = "Chicken";

SELECT pizza_name, category_name, pizza_ingredients
FROM pizza, category
WHERE pizza_ingredients LIKE "%Mozzarella Cheese%";

SELECT order_id,  DATE(order_datetime) AS date, TIME(order_datetime) AS time
FROM orders 
WHERE date >= '2015-04-01' AND date <= '2015-08-31' AND NOT (time > '13:00:00' AND time < '17:00:00');

SELECT order_id, COUNT(quantity) as count_quantity
FROM order_details
GROUP BY order_id
ORDER BY count_quantity DESC
LIMIT 10;

SELECT orders.order_id, DATE(order_datetime) AS date, TIME(order_datetime) AS time, COUNT(order_details.quantity) as count_quantity 
FROM orders 
JOIN order_details ON orders.order_id = order_details.order_id 
GROUP BY orders.order_id 
ORDER BY count_quantity DESC, date ASC, time ASC 
LIMIT 10;

SELECT pizza.pizza_name, "size".size_name, pizza_size.unit_price, category.category_name AS category, pizza.pizza_ingredients AS ingredients
FROM pizza
JOIN category ON pizza.category_id = category.category_id
JOIN pizza_size ON pizza.pizza_id = pizza_size.pizza_id
JOIN "size" ON pizza_size.size_id = "size".size_id
GROUP BY pizza.pizza_name;

SELECT COUNT(*) 
FROM pizza
JOIN category ON pizza.category_id = category.category_id
JOIN pizza_size ON pizza.pizza_id = pizza_size.pizza_id
JOIN order_details ON pizza_size.pizza_size_id = order_details.pizza_size_id
JOIN "size" ON pizza_size.size_id = "size".size_id
WHERE order_details.quantity != 1;

SELECT *, DATE(order_datetime) AS date, TIME(order_datetime) AS time, SUM(pizza_size.unit_price * order_details.quantity) AS total_price 
FROM orders 
JOIN order_details ON orders.order_id = order_details.order_id 
JOIN pizza_size ON order_details.pizza_size_id = pizza_size.pizza_size_id 
JOIN pizza ON pizza_size.pizza_id = pizza.pizza_id 
JOIN size ON pizza_size.size_id = size.size_id 
JOIN category ON pizza.category_id = category.category_id
GROUP BY orders.order_id;

CREATE VIEW order_summary_ AS SELECT *, DATE(order_datetime) AS date, TIME(order_datetime) AS time, SUM(pizza_size.unit_price * order_details.quantity) AS total_price 
FROM orders 
JOIN order_details ON orders.order_id = order_details.order_id 
JOIN pizza_size ON order_details.pizza_size_id = pizza_size.pizza_size_id 
JOIN pizza ON pizza_size.pizza_id = pizza.pizza_id 
JOIN size ON pizza_size.size_id = size.size_id 
JOIN category ON pizza.category_id = category.category_id 
GROUP BY orders.order_id;

SELECT category.category_name, SUM(order_details.quantity * pizza_size.unit_price) AS total_revenue 
FROM orders 
JOIN order_details ON orders.order_id = order_details.order_id 
JOIN pizza_size ON order_details.pizza_size_id = pizza_size.pizza_size_id 
JOIN pizza ON pizza_size.pizza_id = pizza.pizza_id 
JOIN category ON pizza.category_id = category.category_id 
GROUP BY category.category_name 
ORDER BY total_revenue DESC;

SELECT "size".size_name, COUNT(order_details.quantity) as count_orders
FROM pizza 
JOIN category ON pizza.category_id = category.category_id
JOIN pizza_size ON pizza.pizza_id = pizza_size.pizza_id
JOIN order_details ON pizza_size.pizza_size_id = order_details.pizza_size_id
JOIN orders ON orders.order_id = order_details.order_id
JOIN "size" ON pizza_size.size_id = "size".size_id
WHERE DATE(orders.order_datetime) > '2015-07-01' AND DATE(orders.order_datetime) < '2015-12-31'
GROUP BY "size".size_name
ORDER BY count_orders DESC 
LIMIT 1;