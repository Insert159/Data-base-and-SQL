DROP DATABASE IF EXISTS lesson_5hw;
CREATE DATABASE lesson_5hw;
USE lesson_5hw;

CREATE TABLE cars
(
	id INT NOT NULL PRIMARY KEY,
    name VARCHAR(45),
    cost INT
);

INSERT cars
VALUES
	(1, "Audi", 52642),
    (2, "Mercedes", 57127 ),
    (3, "Skoda", 9000 ),
    (4, "Volvo", 29000),
	(5, "Bentley", 350000),
    (6, "Citroen ", 21000 ), 
    (7, "Hummer", 41400), 
    (8, "Volkswagen ", 21600);
    
SELECT *
FROM cars;

CREATE VIEW cars_under_25000 AS
SELECT id, name, cost
FROM (
  SELECT id, name, cost, ROW_NUMBER() OVER (ORDER BY cost ASC) as row_num
  FROM cars
  WHERE cost <= 25000
) AS cars_under
WHERE row_num <= 100;

  --  Изменение существующего представления:


ALTER VIEW cars_under_25000
AS
SELECT id, name, cost
FROM (
  SELECT id, name, cost, ROW_NUMBER() OVER (ORDER BY cost ASC) as row_num
  FROM cars
  WHERE cost <= 30000
) AS cars_under
WHERE row_num <= 100;

 --   Создание представления для автомобилей марки "Шкода" и "Ауди":


CREATE VIEW audi_skoda_cars AS
SELECT id, name, cost
FROM cars
WHERE name IN ('Audi', 'Skoda');


ALTER TABLE stations
ADD COLUMN time_to_next_station INT;

UPDATE stations
SET time_to_next_station = LEAD(time) OVER (ORDER BY id) - time;
