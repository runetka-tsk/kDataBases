-- Задание 1. Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, catalogs и products в таблицу logs помещается 
-- время и дата создания записи, название таблицы, идентификатор первичного ключа и содержимое поля name.


CREATE TABLE `logs` (
  id int(11) NOT NULL AUTO_INCREMENT,
  created_at INT(10) UNSIGNED DEFAULT NULL,
  table_name VARCHAR(255) DEFAULT NULL,
  record_id  INT( 11 ) NOT NULL,
  record_name VARCHAR(255) DEFAULT NULL,
  )
ENGINE = ARCHIVE

-- Создим триггеры, которые на вставку в таблицы делают делают в таблицу logs
-- для таблицы products
DELIMITER //
CREATE 
 TRIGGER shop.products_trigger_insert
  AFTER INSERT
  ON shop.products
  FOR EACH ROW
BEGIN
      INSERT INTO 'logs'
    (   'created_at',
        'table_name',
		'record_id',
		'record_name')
    VALUES
    (    NOW(),
        'products',
        NEW.id,
        NEW.name);
END//
DELIMITER ;


-- для таблицы users
DELIMITER //
CREATE 
 TRIGGER shop.users_trigger_insert
  AFTER INSERT
  ON shop.users
  FOR EACH ROW
BEGIN
      INSERT INTO 'logs'
    (   'created_at',
        'table_name',
		'record_id',
		'record_name')
    VALUES
    (   NOW(),
        'users',
        NEW.id,
        NEW.name);
END//
DELIMITER ;

-- для таблицы catalogs
DELIMITER //
CREATE 
 TRIGGER shop.catalogs_trigger_insert
  AFTER INSERT
  ON shop.catalogs
  FOR EACH ROW
BEGIN
      INSERT INTO 'logs'
    (   'created_at',
        'table_name',
		'record_id',
		'record_name')
    VALUES
    (   NOW(),
        'catalogs',
        NEW.id,
        NEW.name);
END//
DELIMITER ;