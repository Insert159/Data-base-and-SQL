-- USE db;

USE less1;

-- Выведем содержимое таблички student
SELECT *
FROM student;

-- Вывести имена, телефоны студентов
SELECT first_name, phone
FROM student;

-- Получим имя, телефон ТОЛЬКО  Виктора
SELECT first_name, phone
FROM student
WHERE first_name = "Виктор";

-- Получим имя и почту студентов, имена которых начинаются с буквы "А"
SELECT first_name, phone
FROM student
WHERE first_name LIKE "А%й";