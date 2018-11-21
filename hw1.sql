SELECT ('ФИО: Чернова Кристина Сергеевна');

DROP TABLE IF EXISTS Persons CASCADE;

CREATE TABLE Persons(
id INT NOT NULL ,
fio TEXT NOT NULL,
PRIMARY KEY(id)
);

DROP TABLE IF EXISTS Films CASCADE;

CREATE TABLE Films(
title TEXT NOT NULL,
id INT NOT NULL ,
country TEXT NOT NULL,
box_office INT NOT NULL,
release_year TIMESTAMP NOT NULL,
PRIMARY KEY(id)
);

INSERT INTO Films VALUES('BadTimes at the El Royale',1, 'USA',11871984, '2018/12/31');
INSERT INTO Films VALUES('The Big Lebowski',2, 'USA',17451873,'1998/12/31');
INSERT INTO Films VALUES('Inception',3, 'USA',825532764,'2010/12/31');
INSERT INTO Films VALUES('Shutter Island',4, 'USA',294804195,'2009/12/31');
INSERT INTO Films VALUES('BlacKkKlansman',5, 'USA',84571960,'2018/12/31');

INSERT INTO Persons VALUES(1, 'Christopher Nolan');
INSERT INTO Persons VALUES(2, 'Leonardo DiCaprio');

DROP TABLE IF EXISTS Person2Content CASCADE;

CREATE TABLE Person2Content(person_id INT NOT NULL ,film_id INT NOT NULL ,persontype TEXT NOT NULL,FOREIGN KEY (person_id) REFERENCES Persons(id),FOREIGN KEY (film_id) REFERENCES Films(id));

INSERT INTO Person2Content VALUES(2,3, 'Actor');
INSERT INTO Person2Content VALUES(2,4, 'Actor');
INSERT INTO Person2Content VALUES(1,3, 'Producer');
