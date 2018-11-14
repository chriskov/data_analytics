SELECT 'ФИО:  Чернова Кристина Сергеевна';
--Служебные функции БД
SELECT table_name FROM information_schema.tables LIMIT 1;
--Специфические функции Postgres
--1
SELECT userID, array_agg(movieId) AS user_views FROM ratings WHERE userID=1;
--2
DROP TABLE IF EXISTS user_movies_agg;
SELECT userID, user_views INTO public.user_movies_agg FROM (SELECT userID, array_agg(movieId) AS user_views FROM ratings WHERE userID=1) WHERE userID=1;
SELECT * FROM user_movies_agg LIMIT 3;
--3
CREATE OR REPLACE FUNCTION cross_arr (int[], int[]) RETURNS int[] language sql AS $FUNCTION$ тело_функции ; $FUNCTION$;
--4 
SELECT agg.userId AS u1, agg.userId AS u2, agg.array_agg AS ar1, agg.array_agg AS ar2 from user_movies_agg AS agg
DROP TABLE IF EXISTS common_user_views;
WITH user_pairs AS (
  SELECT 1 AS u1, 2 AS u2, 1 AS ar1, 2 AS ar2
) SELECT u1, u2, cross_arr(ar1, ar2) INTO public.common_user_views FROM user_pairs;
SELECT * FROM common_user_views LIMIT 3;
CREATE OR REPLACE FUNCTION diff_arr (int[], int[]) RETURNS int[] language sql AS $FUNCTION$ тело_функции ; $FUNCTION$;
SELECT * FROM common_user_views CROSS JOIN user_movies_agg LIMIT 10;
