DROP DATABASE IF EXISTS lesson_6hw;
CREATE DATABASE lesson_6hw;
USE lesson_6hw;

CREATE PROCEDURE choose_users
    @user_id INT,
    @city VARCHAR(255) = NULL,
    @group_id INT = NULL
AS
BEGIN
    DECLARE @users TABLE (user_id INT)

    IF @city IS NOT NULL
    BEGIN
        INSERT INTO @users (user_id)
        SELECT user_id
        FROM user_profile
        WHERE city = @city
          AND user_id <> @user_id
          AND user_id NOT IN (SELECT user2_id FROM friendship WHERE user1_id = @user_id)
    END

    IF @group_id IS NOT NULL
    BEGIN
        INSERT INTO @users (user_id)
        SELECT user_id
        FROM user_profile
        WHERE user_id IN (SELECT user_id FROM group_membership WHERE group_id = @group_id)
          AND user_id <> @user_id
          AND user_id NOT IN (SELECT user2_id FROM friendship WHERE user1_id = @user_id)
    END

    IF NOT EXISTS (SELECT 1 FROM @users)
    BEGIN
        INSERT INTO @users (user_id)
        SELECT f2.user2_id
        FROM friendship f1
        JOIN friendship f2 ON f1.user2_id = f2.user1_id
        WHERE f1.user1_id = @user_id
          AND f2.user2_id <> @user_id
          AND f2.user2_id NOT IN (SELECT user_id FROM @users)
    END

    SELECT TOP 5 user_id
    FROM @users
    ORDER BY NEWID()
END;


CREATE FUNCTION popularity_coefficient
    (@user_id INT)
RETURNS FLOAT
AS
BEGIN
    DECLARE @friends_count INT = (SELECT COUNT(*) FROM friendship WHERE user1_id = @user_id OR user2_id = @user_id)
    DECLARE @groups_count INT = (SELECT COUNT(*) FROM group_membership WHERE user_id = @user_id)
    DECLARE @posts_count INT = (SELECT COUNT(*) FROM post WHERE user_id = @user_id)

    RETURN (@friends_count + @groups_count + @posts_count) / 3.0
END;

CREATE PROCEDURE add_user
    (@username VARCHAR(255),
     @email VARCHAR(255),
     @city VARCHAR(255),
     @birthdate DATE)
AS
BEGIN
    DECLARE @user_id INT

    INSERT INTO user_profile (username, email, city, birthdate)
    VALUES (@username, @email, @city, @birthdate)

    SET @user_id = SCOPE_IDENTITY()

    INSERT INTO friendship (user1_id, user2_id)
    SELECT @user_id, user_id
    FROM user_profile
    WHERE user_id <> @user_id
      AND city = @city
      AND ABS(DATEDIFF(YEAR, birthdate, @birthdate)) <= 5
      AND NEWID() <= 0.1 -- вероятность 10% добавления в друзья

    INSERT INTO group_membership (user_id, group_id)
    SELECT @user_id, group_id
    FROM group_profile
    WHERE city = @city
      AND NEWID() <= 0.05 -- вероя


