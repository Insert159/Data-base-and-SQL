USE less3;

CREATE TABLE IF NOT EXISTS `staff`
(
	`id` INT AUTO_INCREMENT PRIMARY KEY,
    `first_name` VARCHAR(45),
    `last_name` VARCHAR(45),
    `post` VARCHAR(45),
    `seniority` INT,
	`salary` INT,
    `age` INT
);
TRUNCATE staff;
INSERT `staff` (`first_name`, `last_name`,  `post`, `seniority`, `salary`,`age`)
VALUES
	 ('Вася', 'Петров', 'Начальник', 40, 100000, 60),
	 ('Петр', 'Власов', 'Начальник', 8, 70000, 30),
	 ('Катя', 'Катина', 'Инженер', 2, 70000, 25),
	 ('Саша', 'Сасин', 'Инженер', 12, 50000, 35),
	 ('Иван', 'Петров', 'Рабочий', 40, 30000, 59),
	 ('Петр', 'Петров', 'Рабочий', 20, 55000, 60),
	 ('Сидр', 'Сидоров', 'Рабочий', 10, 20000, 35),
	 ('Антон', 'Антонов', 'Рабочий', 8, 19000, 28),
	 ('Юрий', 'Юрков', 'Рабочий', 5, 15000, 25),
	 ('Максим', 'Петров', 'Рабочий', 2, 11000, 19),
	 ('Юрий', 'Петров', 'Рабочий', 3, 12000, 24),
	 ('Людмила', 'Маркина', 'Уборщик', 10, 10000, 49);
	
SELECT * FROM `staff`;

-- ORDER BY - сортировка 
SELECT post, salary
FROM staff
ORDER BY salary ; -- ASC(идет по дефолту) - по воз-ю, DESC - по уб-ю

-- Вывести имя, фамилию и возраст человека, упорядочив имена в алфавитном порядке (по убыванию: от "я" -> "а")
SELECT first_name, last_name, age
FROM staff
ORDER BY first_name DESC;

--  Выполним сортировку по имени и фамилию, сортируем по убыванию 
SELECT first_name, last_name, age
FROM staff
ORDER BY first_name DESC, last_name DESC;

-- DISTINCT, LIMIT 
SELECT DISTINCT last_name
FROM staff;

-- LIMIT 2
SELECT *
FROM staff
ORDER BY id DESC
LIMIT 2; -- id = 1, id = 2

-- Пропустить первые 4 строчки и вывести 3 следующие строчеки
SELECT *
FROM staff
LIMIT 4, 3; 

SELECT *
FROM staff
LIMIT 3 OFFSET 4;

-- Пропустите две последние строчки и получите следующие за ними 3 строчки (id = 10, id = 9 , id = 8)
SELECT *
FROM staff
ORDER BY id DESC
-- LIMIT 2, 3;
LIMIT 3 OFFSET 2;

-- 8, 9, 10
SELECT *
FROM (SELECT *
FROM staff
ORDER BY id DESC
LIMIT 2, 3) t
ORDER BY id; -- ASC

-- Группировка данных (GROUP BY)
-- Аналитика по занимаемоей должности: orders
SELECT 
	post,
	SUM(salary) AS "Суммарная ЗП сотрудников",ordersorders
    AVG(salary) AS "Средняя ЗП сотрудников",
    MAX(salary) AS "Макс ЗП среди сотрудников",
    MIN(salary) AS  "Мин ЗП среди сотрудников",
    COUNT(salary) AS "Количество сотрудников",
    MAX(salary) - MIN(salary) AS "Разница между макс и мин зарплатой"
FROM staff
GROUP BY post;

--  Cгруппируем данные о сотрудниках по возрасту
-- 1 группа - младше 20 лет
-- 2 группа - от 20 до 40
-- 3 группа - старше - 40 лет
-- Суммарная зарплата внутри каждой группы

SELECT
	CASE
		WHEN age < 20 THEN "Младше 20 лет"
        WHEN age BETWEEN 20 AND 40 THEN "От 20 до 40 лет"
        ELSE "Старше 40 лет"
	END AS name_age,
    SUM(salary)
FROM staff
GROUP BY name_age;

-- Вывести инфо о отделе сотрудников , суммарная зарплата которых превышает 150 000 рублей
SELECT 
	post, 
	SUM(salary) AS "Суммарная ЗП сотрудников"
FROM staff
GROUP BY post
HAVING SUM(salary) > 150000;

-- WHERE и HAVING
SELECT 
	post, 
	SUM(salary) AS "Суммарная ЗП сотрудников"
FROM staff
WHERE post NOT IN ("Начальник", "Рабочий")
GROUP BY post
HAVING SUM(salary) > 150000;
	