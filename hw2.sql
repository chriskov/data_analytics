SELECT 'ФИО:  Чернова Кристина Сергеевна';
-- 1.2
SELECT * FROM links WHERE imdbid LIKE '%42' AND movieid BETWEEN 100 AND 1000 LIMIT 10;
-- 2.1
SELECT IMDBID FROM LINKS INNER JOIN ratings ON links.movieid=ratings.movieid WHERE ratings.rating=5 LIMIT 10;
-- 3.1
SELECT COUNT(*) FROM LINKS LEFT JOIN ratings ON links.movieid=ratings.movieid WHERE ratings.rating IS NULL;
-- 3.2
SELECT userid, avg(rating) AS average_rating FROM ratings GROUP BY userid having AVG(rating) > 3.5 ORDER BY 2 DESC LIMIT 10;
-- 4.1
SELECT imdbid FROM links LEFT JOIN ratings ON links.movieid=ratings.movieid WHERE ratings.rating >3.5 LIMIT 10;
-- 4.2
SELECT AVG(rating) FROM ratings WHERE userid IN (SELECT userid FROM (SELECT userid,count(*) as co from ratings GROUP BY userid) as test WHERE co>10);
