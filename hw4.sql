SELECT 'ФИО:  Чернова Кристина Сергеевна';

--top-5 самых больших таблиц базы
SELECT  pg_table_size(table_schema || '.' || table_name) FROM information_schema.tables ORDER BY pg_table_size DESC LIMIT 5;

--user_movies_agg;array_agg
DROP TABLE IF EXISTS user_movies_agg;
WITH user_movies AS (SELECT userid, array_agg(movieid) AS user_views FROM ratings GROUP BY userid HAVING userid < 10);

SELECT userid, user_views INTO public.user_movies_agg FROM user_movies WHERE userid < 10;

SELECT * FROM user_movies_agg LIMIT 3;

--cross_arr
CREATE OR REPLACE FUNCTION cross_arr (int[], int[]) 
	RETURNS int[] language sql AS 
	$FUNCTION$ 
		WITH intersection AS ( SELECT unnest($1) INTERSECT SELECT unnest($2))
		SELECT array(SELECT * FROM intersection);
	$FUNCTION$;


-- common_user_views ; всевозможные наборы u1, r1, u2, r2
DROP TABLE IF EXISTS common_user_views;
WITH user_pairs AS (SELECT umau.userid AS u1, umau.user_views AS r1,umar.userid AS u2,umar.user_views AS v2
	FROM user_movies_agg AS umau CROSS JOIN user_movies_agg AS umar WHERE umau.userid < umar.userid) 
SELECT u1, u2, cross_arr(r1::int[], r2::int[]) INTO public.common_user_views FROM user_pairs;

SELECT * FROM common_user_views LIMIT 3;

--diff_arr
CREATE OR REPLACE FUNCTION diff_arr (int[], int[]) 
RETURNS int[] language sql AS 
	$FUNCTION$ 
		WITH subtraction AS (SELECT unnest($1) EXCEPT SELECT unnest($2))
SELECT array(SELECT * FROM subtraction);
	$FUNCTION$;

SELECT * FROM common_user_views CROSS JOIN user_movies_agg LIMIT 10;
