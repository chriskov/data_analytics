SELECT 'ФИО:  Чернова Кристина Сергеевна';

SELECT userId, movieId, 
--если максимальный рейтинг равен минимальному, значит всего одна оценка
CASE WHEN  max(rating) OVER (PARTITION BY userId) =  min(rating) OVER (PARTITION BY userId) THEN 1 ELSE 
	(rating - min(rating) OVER (PARTITION BY userId))/(max(rating) OVER (PARTITION BY userId) - min(rating) OVER (PARTITION BY userId)) as normed_rating,
	AVG(rating) OVER (PARTITION BY userId) AS avg_rating FROM ratings LIMIT 30;
														      
DROP TABLE IF EXISTS keywords;
														      
CREATE TABLE keywords(movieId INT,tags TEXT,PRIMARY KEY(id));

\copy keywords FROM '/data/keywords.csv' DELIMITER ',' CSV HEADER;

SELECT  COUNT(*) FROM keywords;

DROP TABLE IF EXISTS top_rated_tags;
							
WITH top_rated as (SELECT movieId, avg(rating) as avg_rating FROM ratings GROUP BY movieId HAVING count(*)> 50 ORDER BY 2 DESC, 1 ASC LIMIT 150)
SELECT top_rated.movieId, tags INTO top_rated_tags FROM top_rated INNER JOIN keywords ON top_rated.movieId = keywords.movieId;

\copy (SELECT * FROM top_rated_tags) TO '/data/tags.csv' DELIMITER E '\t';
