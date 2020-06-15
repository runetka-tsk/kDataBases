use shop;

-- Задание 1. Вывести список пользователей, которые осущетсвили хоть один заказ

SELECT users.name
FROM users
RIGHT JOIN orders ON users.id = orders.user_id
GROUP BY users.name
ORDER BY users.name;

-- Задание 2. Вывести список товаров и разделов, соответствующих товару

SELECT products.name, catalogs.name 
FROM products
LEFT JOIN catalogs ON catalogs.id = products.catalog_id;


-- Задание 3. Вывести русские названия городов для рейсов.
-- поля таблицы flights 'from' и 'to' заменила на  'city_from' и 'city_to' - иначе ругается на зарезервированные имена


select flights.id, c1.name AS from_name, c2.name AS to_name FROM flights
JOIN cities AS c1 ON c1.label = flights.city_from
JOIN cities AS c2 ON c2.label = flights.city_to
ORDER BY flights.id;