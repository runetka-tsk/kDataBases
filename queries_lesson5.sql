
-- Задание 1

-- заполним текущей датой
UPDATE users SET created_at = NOW();
UPDATE users SET updated_at = NOW();

-- Задание 2
-- преобразовать колонку в формат DATETIME с сохранением значений
ALTER TABLE users ADD updated_at_dt DATETIME, ADD updated_at_dt DATETIME; -- создадим промежуточные колонки для преобразования формата
UPDATE users
SET created_at_dt = STR_TO_DATE(created_at, '%d.%m.%Y %h:%i'), 
    updated_at_dt = STR_TO_DATE(updated_at, '%d.%m.%Y %h:%i'); -- преобразуем значения из текстового формата в формат даты
-- удаляем колонки с текстовой датой
ALTER TABLE users 
    DROP created_at, DROP updated_at; 
-- переименуем новые колонки
ALTER TABLE users 
	CHANGE created_at_dt created_at datetime NULL;   
ALTER TABLE users 
	CHANGE updated_at_dt updated_at datetime NULL;

-- Задание 3
-- сортировка поля количества товаров по возрастанию, оставляя нули в конце таблицы
SELECT *
FROM storehouses_products
ORDER BY IF(value = 0, 1, 0), value;

-- Задание по агрегации данных
-- Задание 1. Вычислить средний возраст пользователей
SELECT AVG(TIMESTAMPDIFF(year, birthday_at, NOW()))
FROM users


-- Задание 2. Найти количество дней рождения, выпадающих на каждый день недели  текущего года
select count(*) as count_birthday, dayname(birthday_at + interval (year(now())-year(birthday_at)) year) as dayname_birth FROM users group by dayname_birth;




