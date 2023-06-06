SELECT * FROM less3.staff;

-- Отсортируйте данные по полю заработная плата (salary) в порядке: убывания; возрастания
SELECT salary From staff 
ORDER BY salary DESC;

SELECT salary From staff 
ORDER BY salary;


-- Выведите 5 максимальных заработных плат (saraly)

SELECT * FROM staff
ORDER BY salary DESC
LIMIT 5;


-- Посчитайте суммарную зарплату (salary) по каждой специальности (роst)

SELECT distinct post, SUM(salary) AS "Суммарная ЗП сотрудников"
FROM staff
GROUP BY post;

-- Найдите кол-во сотрудников с специальностью (post) «Рабочий» в возрасте от 24 до 49 лет включительно.
SELECT COUNT(*) FROM staff 
WHERE post = 'Рабочий' AND age BETWEEN 24 AND 49;


-- Найдите количество специальностей

SELECT COUNT(DISTINCT post) AS num_specialties FROM staff;


-- Выведите специальности, у которых средний возраст сотрудников меньше 30 лет включительно.

SELECT post, AVG(age) AS avg_age
FROM staff
GROUP BY post
HAVING avg_age <= 30;