CREATE DATABASE IF NOT EXISTS less2hw; 

USE less2hw;

CREATE TABLE IF NOT EXISTS sales
(
    id INT PRIMARY KEY AUTO_INCREMENT, 
    order_date YEAR, 
    count_product INT NOT NULL
);


INSERT INTO sales
VALUES 
	(1, 2022, 156),
	(2, 2022, 180),
    (3, 2022, 121),
    (4, 2022, 124), 
    (5, 2022, 341);

SELECT 
	id AS "id заказа",
CASE
	WHEN count_product < 100 THEN "Маленький заказ"
    WHEN count_product between 100 AND 300 THEN "Средний заказ"
    ELSE "Большой заказ"
END AS "Тип заказа"
FROM sales;



# Создайте таблицу “orders”, заполните ее значениями. 
#Покажите “полный” статус заказа, используя оператор CASE
USE less2hw;

CREATE TABLE IF NOT EXISTS orders
(
    id INT PRIMARY KEY AUTO_INCREMENT, 
    employee_id VARCHAR(20), 
    amount DECIMAL,
    order_status VARCHAR(20)
);


INSERT INTO orders
VALUES 
	(1, 'e03', 15.00, 'OPEN'),
	(2, 'e03', 25.50,'OPEN'),
    (3, 'e03', 100.70,'CLOSED'),
    (4, 'e03', 22.18,'OPEN'), 
    (5, 'e03', 9.50,'CANSELLED');

SELECT 
	order_status AS "status",
CASE
	WHEN order_status = 'OPEN' THEN "Order is in open state"
    WHEN order_status = 'CLOSED' THEN "Order is closed"
    ELSE "Order is cancelled"
END AS "full_order_status"
FROM orders;

