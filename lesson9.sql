-- Практическое задание по теме “Транзакции, переменные, представления”

-- 1. В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных. 
-- Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции.
START TRANSACTION; 
INSERT INTO sample.users SELECT * FROM shop.users WHERE id = 1;
DELETE FROM shop.users WHERE id = 1 LIMIT 1;
COMMIT;




-- 2. Создайте представление, которое выводит название name товарной позиции из таблицы products 
-- и соответствующее название каталога name из таблицы catalogs.
CREATE VIEW view_names AS     
SELECT products.name p_name, catalogs.name c_name       
FROM products, catalogs
WHERE  catalogs.id = products.catalog_id;



-- Практическое задание по теме “Хранимые процедуры и функции, триггеры"
-- 1. Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток. 
-- С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать фразу "Добрый день",
-- с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".
DELIMITER // 
	CREATE PROCEDURE `hello` () 
	BEGIN 
	    DECLARE currtimes TIME; 
	   	DECLARE v_morning TIME;
	   	DECLARE v_day TIME;
	   	DECLARE v_evening TIME;
	   	DECLARE v_night TIME;
	   
	    SET currtimes = CURTIME(); 
	    SET v_morning = ('06:00:00');
	    SET v_day = ('12:00:00');
	    SET v_evening = ('18:00:00');
  	    SET v_night = ('12:00:00');
	   
	   
	    CASE 
	        WHEN currtimes > v_morning and currtimes < v_day THEN 
	            select ('Good morning!');
 	        WHEN currtimes > v_day and currtimes < v_evening THEN 
	            select ('Good day!');
   	        WHEN currtimes > v_evening and currtimes < v_night THEN 
	            select ('Good evening!');
	        ELSE 
	            select ('Good night!'); 
	    END CASE; 
	END // 
	
CALL hello();	




-- 2. В таблице products есть два текстовых поля: name с названием товара и description с его описанием. Допустимо присутствие 
-- обоих полей или одно из них. Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема. Используя триггеры, добейтесь 
-- того, чтобы одно из этих полей или оба поля были заполнены. При попытке присвоить полям NULL-значение необходимо отменить операцию.

DELIMITER //
CREATE 
 TRIGGER shop.products_trigger_update
  BEFORE UPDATE
  ON shop.products
  FOR EACH ROW
BEGIN
  if (NEW.name is null or NEW.description is null) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ошибка сохранения записи. Поле name или description должны быть заполнены.';
  END if;
end//
DELIMITER ;



DELIMITER //
CREATE 
 TRIGGER shop.products_trigger_create
  BEFORE CREATE
  ON shop.products
  FOR EACH ROW
BEGIN
  if (NEW.name is null or NEW.description is null) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ошибка сохранения записи. Поле name или description должны быть заполнены.';
  END if;
end//
DELIMITER ;
