USE lesson_6hw;

CREATE FUNCTION format_seconds(seconds INT) RETURNS TEXT
BEGIN
    DECLARE days INT;
    DECLARE hours INT;
    DECLARE minutes INT;
    DECLARE secs INT;
    DECLARE result TEXT;
    
    SET days = seconds DIV (24 * 60 * 60);
    SET seconds = seconds - (days * 24 * 60 * 60);
    SET hours = seconds DIV (60 * 60);
    SET seconds = seconds - (hours * 60 * 60);
    SET minutes = seconds DIV 60;
    SET seconds = seconds - (minutes * 60);
    
    SET result = CONCAT(days, ' days ', hours, ' hours ', minutes, ' minutes ', seconds, ' seconds');
    
    RETURN result;
END;


CREATE FUNCTION get_even_numbers() RETURNS SETOF INT
BEGIN
    DECLARE i INT := 2;
    WHILE i <= 10 DO
        RETURN NEXT i;
        SET i := i + 2;
    END WHILE;
    RETURN;
END;


