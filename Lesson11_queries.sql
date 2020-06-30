-- ������� 1. �������� ������� logs ���� Archive. ����� ��� ������ �������� ������ � �������� users, catalogs � products � ������� logs ���������� 
-- ����� � ���� �������� ������, �������� �������, ������������� ���������� ����� � ���������� ���� name.


CREATE TABLE `logs` (
  id int(11) NOT NULL AUTO_INCREMENT,
  created_at INT(10) UNSIGNED DEFAULT NULL,
  table_name VARCHAR(255) DEFAULT NULL,
  record_id  INT( 11 ) NOT NULL,
  record_name VARCHAR(255) DEFAULT NULL,
  )
ENGINE = ARCHIVE

-- ������ ��������, ������� �� ������� � ������� ������ ������ � ������� logs
-- ��� ������� products
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


-- ��� ������� users
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

-- ��� ������� catalogs
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