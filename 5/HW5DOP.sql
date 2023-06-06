   -- Получение друзей пользователя с id=1 с помощью представления "друзья":

CREATE VIEW friends_view AS
SELECT f.user_id, f.friend_id, u.username AS friend_name
FROM friends f
JOIN users u ON f.friend_id = u.id;

SELECT friend_name
FROM friends_view
WHERE user_id = 1;

 --   Создание представления, в котором будут выводиться все сообщения, в которых принимал участие пользователь с id=1:


CREATE VIEW user_messages_view AS
SELECT m.message_id, m.message_text, u.username AS user_name
FROM messages m
JOIN users u ON m.user_id = u.id
WHERE m.message_id IN (
    SELECT DISTINCT message_id
    FROM messages
    WHERE user_id = 1
);

SELECT message_id, message_text
FROM user_messages_view;

 --   Получение списка медиафайлов пользователя с количеством лайков:


SELECT m.media_id, m.media_url, COUNT(l.like_id) AS likes_count
FROM media m
LEFT JOIN likes l ON m.media_id = l.media_id
WHERE m.user_id = 1
GROUP BY m.media_id, m.media_url;

  --  Получение количества групп у пользователей:



SELECT u.username, COUNT(DISTINCT g.group_id) AS group_count
FROM users u
JOIN group_members gm ON u.id = gm.user_id
JOIN groupss g ON gm.group_id = g.group_id
GROUP BY u.username;

--    Вывод 3 пользователей с наибольшим количеством лайков за медиафайлы:



SELECT u.username, SUM(l.like_id) AS likes_sum
FROM users u
JOIN media m ON u.id = m.user_id
JOIN likes l ON m.media_id = l.media_id
GROUP BY u.username
ORDER BY likes_sum DESC
LIMIT 3;