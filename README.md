# data_analytics
Data Analytics Course

HW1 

Зайти на Кинопоиск, найти 5 любимых фильмов и сделать по ним табличку с данными.
Табличка films:

title - название (текст)
id (число) соответствует film_id в табличке persons2content
country страна (тест)
box_office сборы в долларах (число)
release_year год выпуска (timestamp)
Табличка persons

id (число) - соответствует person_id в табличке persons2content
fio (текст) фамилия, имя
Табличка persons2content

person_id (число) - id персоны
film_id (число) - id контента
person_type (текст) тип персоны (актёр, режиссёр и т.д.)
Тим образом реализуется схема БД "Звезда" с центром в табличке persons2content
