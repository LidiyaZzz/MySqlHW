/*
1. Создайте представление, в которое попадает информация о пользователях (имя, фамилия, город и пол),
которые не старше 20 лет.
*/  

CREATE VIEW young_users AS
SELECT CONCAT(firstname, ' ', lastname) AS 'name', profiles.hometown, profiles.gender
FROM users
JOIN profiles ON users.id = profiles.user_id
WHERE timestampdiff(YEAR, profiles.birthday, now()) <= 20;

SELECT*FROM young_users;

/*
Найдите кол-во, отправленных сообщений каждым пользователем 
и выведите ранжированный список пользователей, 
указав имя и фамилию пользователя, количество отправленных сообщений 
и место в рейтинге (первое место у пользователя с максимальным количеством сообщений) . 
(используйте DENSE_RANK)
*/

CREATE VIEW ranking_users AS
SELECT 	CONCAT(firstname, ' ', lastname) AS 'name', 
		COUNT(messages.from_user_id) AS message_count,
       DENSE_RANK() OVER (ORDER BY COUNT(messages.from_user_id) DESC) AS ranking
FROM users
JOIN messages ON users.id = messages.from_user_id
GROUP BY users.id
ORDER BY ranking;

SELECT*FROM ranking_users;

/*
	Выберите все сообщения, 
    отсортируйте сообщения по возрастанию даты отправления (created_at) 
    и найдите разницу дат отправления между соседними сообщениями получившегося списка. 
    (используйте LEAD или LAG)*/


SELECT messages.id, messages.created_at,
       LEAD(messages.created_at) OVER (ORDER BY messages.created_at) - messages.created_at AS time_difference_next,
       messages.created_at - LAG(messages.created_at) OVER (ORDER BY messages.created_at) AS time_difference_previous
FROM messages
ORDER BY messages.created_at;
