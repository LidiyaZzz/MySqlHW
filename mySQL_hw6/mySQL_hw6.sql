/*
1.
Создайте таблицу users_old, аналогичную таблице users. 
Создайте процедуру, с помощью которой можно переместить любого (одного) пользователя 
из таблицы users в таблицу users_old. 
(использование транзакции с выбором commit или rollback – обязательно)
*/

CREATE TABLE users_old LIKE users;
DROP PROCEDURE IF EXISTS move_user_to_old;
DELIMITER //
CREATE PROCEDURE move_user_to_old(new_user_id INT)
BEGIN
  START TRANSACTION;
  INSERT INTO users_old SELECT * FROM users WHERE id = new_user_id;
  DELETE FROM users WHERE id = new_user_id;
  IF ROW_COUNT() = 1 THEN
    COMMIT;
  ELSE
    ROLLBACK;
  END IF;
END //
DELIMITER;

CALL move_user_to_old(1);

/*
2.
Создайте хранимую функцию hello(), которая будет возвращать приветствие, 
в зависимости от текущего времени суток. С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", 
с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", 
с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".
*/
DROP FUNCTION IF EXISTS hello;
DELIMITER //
CREATE FUNCTION hello() RETURNS VARCHAR(20)
BEGIN
  DECLARE current_hour INT;
  SET current_hour = HOUR(NOW());
  IF current_hour >= 6 AND current_hour < 12 THEN
    RETURN 'Доброе утро';
  ELSEIF current_hour >= 12 AND current_hour < 18 THEN
    RETURN 'Добрый день';
  ELSEIF current_hour >= 18 OR current_hour < 6 THEN
    RETURN 'Добрый вечер';
  ELSE
    RETURN 'Доброй ночи';
  END IF;
END//
DELIMITER ;


/*
3.
Создайте таблицу logs типа Archive. 
Пусть при каждом создании записи в таблицах users, communities и messages 
в таблицу logs помещается время и дата создания записи, название таблицы, 
идентификатор первичного ключа.
*/

CREATE TABLE logs (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  table_name VARCHAR(50) NOT NULL,
  primary_key INT UNSIGNED NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id)
) ENGINE=ARCHIVE;


CREATE TRIGGER users_insert_trigger AFTER INSERT ON users
FOR EACH ROW
INSERT INTO logs (table_name, primary_key) VALUES ('users', NEW.id);


CREATE TRIGGER communities_insert_trigger AFTER INSERT ON communities
FOR EACH ROW
INSERT INTO logs (table_name, primary_key) VALUES ('communities', NEW.id);


CREATE TRIGGER messages_insert_trigger AFTER INSERT ON messages
FOR EACH ROW
INSERT INTO logs (table_name, primary_key) VALUES ('messages', NEW.id);


 