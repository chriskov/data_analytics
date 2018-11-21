
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
SELECT l1.movieid FROM links AS l1 INNER JOIN 
(SELECT movieid, AVG(rating) FROM ratings GROUP BY movieid HAVING AVG(rating) > 3.5) AS r1 ON l1.movieid = r1.movieid LIMIT 10;
-- 4.2
SELECT AVG(rating) FROM ratings INNER JOIN
(SELECT userid as uid FROM ratings GROUP BY userid HAVING count(userid) > 10) AS rs ON ratings.userid = rs.uid LIMIT 10;
	
