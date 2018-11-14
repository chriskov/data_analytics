SELECT 'ФИО:  Чернова Кристина Сергеевна';

SELECT userId, movieId, 
	(rating - min(rating) OVER (PARTITION BY userId))/(max(rating) OVER (PARTITION BY userId) - min(rating) OVER (PARTITION BY userId)) as normed_rating,
	AVG(rating) OVER (PARTITION BY userId) AS avg_rating FROM ratings LIMIT 30;

CREATE TABLE keywords(movieId INT,tags TEXT,PRIMARY KEY(id));

\copy keywords FROM '/data/keywords.csv' DELIMITER ',' CSV HEADER;

SELECT  COUNT(*) FROM keywords;

WITH top_rated as (SELECT movieId, avg(rating) as avg_rating FROM ratings GROUP BY movieId HAVING count(*)> 50 ORDER BY 2 DESC, 1 ASC LIMIT 150)
SELECT top_rated.movieId, tags INTO top_rated_tags FROM top_rated INNER JOIN keywords ON top_rated.movieId = keywords.movieId;

\copy (SELECT * FROM top_rated_tags) TO '/data/tags.csv' DELIMITER E '\t';
