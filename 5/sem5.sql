USE lesson3;

SELECT *
FROM staff;

-- Ранжированиие
-- Вывести список всех сотрудников и укажем место в рейтинге по зарплатам (от max -> min)
SELECT
	DENSE_RANK() OVER (ORDER BY salary DESC) AS "Место в рейтинге по ЗП",
	post,
    salary,
    CONCAT(first_name, " ", last_name) AS "fullname"
FROM staff;

-- Внутри каждой специальности укажем место по ЗП (рейтинг внутри специальности)
SELECT
	DENSE_RANK() OVER (PARTITION BY post ORDER BY salary DESC) AS "Место в рейтинге по ЗП",
	post,
    salary,
    CONCAT(first_name, " ", last_name) AS "fullname"
FROM staff;

-- Вывести самых высокооплачиваемых сотрудников внутри каждой должности 
SELECT 
	DISTINCT post,
    salary,
    `rank` -- Ранг сотрудника по ЗП
FROM (SELECT
	DENSE_RANK() OVER (PARTITION BY post ORDER BY salary DESC) AS `rank`,
	post,
    salary,
    CONCAT(first_name, " ", last_name) AS "fullname"
FROM staff) AS rank_list
WHERE `rank` = 1;  -- Если ранг равен 1, то этот сотрудник получает высокую ЗП 


-- Агрегация 
-- Вывести всех сотрудников рамках должности и рассчитать
-- суммарную ЗП для специальности (1)
-- процентное соотношение каждой ЗП от общей суммы по должности  (2)
-- среднюю ЗП по должности (3)
-- процентное соотношение каждой ЗП к средней ЗП по должности  (4)

SELECT
	CONCAT(first_name, " ", last_name) AS "fullname",
    salary,
    post,
    SUM(salary) OVER w AS "sum_salary",
    ROUND(salary * 100 / SUM(salary) OVER w, 3)  AS "Процент от суммарной ЗП",
    AVG(salary) OVER w AS "avg_salary",
    ROUND(salary * 100 / AVG(salary) OVER w, 3)  AS "Процент от средней ЗП"
FROM staff
WHERE post NOT IN ("Уборщик", "Начальник") -- WHERE post != "Уборщик" OR post != "Начальник"
WINDOW w AS (PARTITION BY post);


SELECT
	age,
	CONCAT(first_name, " ", last_name) AS "fullname",
    salary,
    post,
    LEAD(age, 1, 0) OVER (ORDER BY age DESC) AS "Следующий возраст", -- Смещение вперед на 1 строчку и вместо NULL будет проставляться значение 0
    LAG(age, 1, 0) OVER (ORDER BY age DESC) AS "Прошлый возраст" -- Смещение назад на 1 строчку и вместо NULL будет проставляться значение 0
FROM staff;

SELECT
	age,
	CONCAT(first_name, " ", last_name) AS "fullname",
    salary,
    post,
    LEAD(age) OVER (ORDER BY age DESC) AS "Следующий возраст", -- Смещение вперед на 1 строчку 
    LAG(age) OVER (ORDER BY age DESC) AS "Прошлый возраст" -- Смещение назад на 1 строчку 
FROM staff;

-- Представления (VIEW) 
SELECT
	post,
    COUNT(*)
FROM staff
GROUP BY post
ORDER BY COUNT(*); -- Вывод: название специальности и количество специалистов ,  все это сортируется
-- и выводим от самого маленького количества людей в штате к большому

-- Создание представления
CREATE OR REPLACE VIEW count_post AS
SELECT
	post,
    COUNT(*)
FROM staff
GROUP BY post
ORDER BY COUNT(*); 

-- Вызов представления
SELECT * -- Получаю из count_post: 	post, COUNT(*)
FROM count_post
WHERE post != "Уборщик";

ALTER VIEW count_post
AS
SELECT
	post,
    COUNT(*),
    SUM(salary)
FROM staff
GROUP BY post
ORDER BY COUNT(*); 

SELECT * -- Получаю из count_post: 	post, COUNT(*)
FROM count_post
WHERE post != "Уборщик";


DROP VIEW count_post;