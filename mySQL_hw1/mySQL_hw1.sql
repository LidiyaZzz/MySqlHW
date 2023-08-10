DROP DATABASE IF EXISTS mySQL_hw1;
CREATE DATABASE mySQL_hw1;
USE mySQL_hw1;

# 1. Создайте таблицу с мобильными телефонами. Заполните БД данными
CREATE TABLE mobile_phones(
id INT PRIMARY KEY AUTO_INCREMENT,
product_name VARCHAR(10) NOT NULL,
manufacturer VARCHAR(10) NOT NULL,
product_count DOUBLE,
price DOUBLE);

INSERT INTO mobile_phones(product_name,manufacturer,product_count,price) VALUES 
	('iPhone X','Apple',3,76000),
	('iPhone 8','Apple',2,51000),
	('Galaxy S9','Samsung',2,56000),
	('Galaxy S8','Samsung',1,41000),
	('P20 Pro','Huawei',5,36000);
   
# 2. Выведите название, производителя и цену для товаров, количество которых превышает 2   
SELECT product_name, manufacturer, price FROM mobile_phones WHERE product_count > 2;

# 3. Выведите весь ассортимент товаров марки “Samsung”
SELECT * FROM mobile_phones WHERE manufacturer = 'Samsung';