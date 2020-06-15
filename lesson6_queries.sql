-- Задание 2
-- У заданного пользователя найти друга, который с ним больше всего общался
-- т.е. ищем пользователя, который написал больше всех сообщений нашему пользователю
-- (возможно, нужно учесть и ответные сообщения от нашего пользователя, но этого явно из условия задачи не следует)


-- пользователь, написавший самое большое количество сообщений заданному пользователю
   select from_user_id, count(id) as count_messages  
	FROM messages 	
	WHERE to_user_id = 1 
	group by from_user_id 
	order by count_messages desc 
	limit 1;

-- он же, с именем
   select from_user_id, 
   (select firstname from users where id = from_user_id) as firs_name_user,
   count(id) as count_messages  
	FROM messages 	
	WHERE to_user_id = 1 
	group by from_user_id 
	order by count_messages desc 
	limit 1;
	
-- то же, с выбором только из сообщений друзей
  select from_user_id, 
   (select firstname from users where id = from_user_id) as firs_name_user,
   count(id) as count_messages  
	FROM messages 	
	WHERE to_user_id = 1  and from_user_id in 
	(
		SELECT initiator_user_id FROM friend_requests WHERE (target_user_id = 1) AND status='approved' -- ИД друзей, заявку которых я подтвердил
	    union
	    SELECT target_user_id FROM friend_requests WHERE (initiator_user_id = 1) AND status='approved' -- ИД друзей, подрвердивших мою заявку
	)
	group by from_user_id 
	order by count_messages desc 
	limit 1;


-- Задание 3. Подсчитать общее количество лайков, которые получили 10 самых молодых пользователей

select sum(counts_likes.count_l) 
from
(select user_id as u_id,  
birthday,
(SELECT 
	COUNT(*)	 
FROM likes 
WHERE media_id IN (select id from media where user_id = u_id)
) as count_l
from profiles 
order by birthday desc 
limit 10) as counts_likes;



-- Задание 4.  Кто поставил больше всего лайков, мужчины или женщины?

select count(likes_g.gender) as count_likes,
gender 
from
	(select user_id as u_id,
	(select gender from profiles where user_id = u_id)  as gender
	from likes) as likes_g
group by likes_g.gender
order by count_likes desc  
limit 1;



-- Задание 5
-- Найти 10 пользователей, которые наименее активны
-- выберем пользователей, которые поставили меньше всего лайков и написали меньше всего постов и сообщений


select count_activites.user_id,
sum(count_activites.a_count) as activites
from 
(SELECT COUNT(id) AS a_count, user_id
  FROM media
  GROUP BY user_id
 union
SELECT COUNT(id) AS a_count, user_id
  FROM likes
  GROUP BY user_id
union
SELECT COUNT(id) AS a_count, from_user_id as user_id
  FROM messages 
  GROUP BY user_id) as count_activites
group by count_activites.user_id
order by activites asc
limit 10;
