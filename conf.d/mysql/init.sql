CREATE USER 'andrey'@'%' IDENTIFIED BY 'qwe123';
GRANT ALL PRIVILEGES ON *.* TO 'andrey'@'%';
CREATE DATABASE scientific_activity;
FLUSH PRIVILEGES;
use scientific_activity;

CREATE TABLE people (
   id             int         PRIMARY KEY,
   FirstName      CHARACTER   VARYING(30)    NOT NULL,
   LastName       CHARACTER   VARYING(30)    NOT NULL,
   Patronymic     CHARACTER   VARYING(30),
   position       CHARACTER   VARYING(110)   NOT NULL
);
