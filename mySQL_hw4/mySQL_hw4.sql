# 1. Подсчитать общее количество лайков, которые получили пользователи младше 12 лет.

SELECT profiles.user_id AS 'id пользователя младше 12 лет', COUNT(likes.media_id) AS 'общее количество лайков'
FROM profiles
JOIN media ON profiles.user_id = media.user_id
LEFT JOIN likes ON media.id = likes.media_id
WHERE YEAR(CURRENT_DATE) - profiles.birthday < 12
GROUP BY profiles.user_id;

# 2. Определить кто больше поставил лайков (всего): мужчины или женщины.
SELECT 
 profiles.gender AS gender, 
 COUNT(likes.user_id) AS likes_count
FROM likes
JOIN profiles ON profiles.user_id = likes.user_id
GROUP BY profiles.gender;

# 3. Вывести всех пользователей, которые не отправляли сообщения.
SELECT users.id AS 'id пользователя'
FROM users
LEFT JOIN messages ON users.id = messages.from_user_id
WHERE messages.from_user_id IS NULL;

# 4. Пусть задан некоторый пользователь. Из всех друзей этого пользователя найдите человека, который больше всех написал ему сообщений.
SELECT messages.from_user_id, COUNT(messages.id) AS message_count
FROM messages
JOIN (
  SELECT initiator_user_id, target_user_id
  FROM friend_requests
  WHERE status = 'approved' AND (initiator_user_id = 1 OR target_user_id = 1)
) AS fr ON messages.from_user_id = fr.initiator_user_id OR messages.from_user_id = fr.target_user_id
WHERE messages.to_user_id = 5
GROUP BY messages.from_user_id
ORDER BY message_count DESC
LIMIT 1;