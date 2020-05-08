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


CREATE TABLE conference (
   id             int         PRIMARY KEY,
   name           CHARACTER   VARYING(50)    NOT NULL,
   location       CHARACTER   VARYING(70)    NOT NULL,
   date           DATE        NOT NULL
);

CREATE TABLE scienceProject (
   id             int         PRIMARY KEY,
   name           CHARACTER   VARYING(100)    NOT NULL,
   researchField  CHARACTER   VARYING(100)    NOT NULL
);

CREATE TABLE edition (
   id             int         PRIMARY KEY,
   name           CHARACTER   VARYING(30)    NOT NULL,
   volume         CHARACTER   VARYING(30)    NOT NULL,
   location       CHARACTER   VARYING(70)    NOT NULL,
   type           CHARACTER   VARYING(10)    NOT NULL,
   language       CHARACTER   VARYING(30)    NOT NULL
);

CREATE TABLE publication (
   id              int         PRIMARY KEY,
   name            CHARACTER   VARYING(50)    NOT NULL,
   publicationDate DATE        NOT NULL,
   citationIndex   int         NOT NULL,
   idEdition       int         NOT NULL,
   FOREIGN KEY (idEdition)   
    REFERENCES edition (id) 
    ON UPDATE CASCADE 
    ON DELETE CASCADE
);

CREATE TABLE libraryCard (
   id              int         PRIMARY KEY,
   pickUpDate      DATETIME     NOT NULL DEFAULT   CURRENT_TIMESTAMP,
   returnDate      DATETIME,
   idPeople        int         NOT NULL,
   idEdition       int         NOT NULL,
   FOREIGN KEY (idPeople)   
    REFERENCES people (id) 
    ON UPDATE CASCADE 
    ON DELETE CASCADE,
   FOREIGN KEY (idEdition)   
    REFERENCES edition (id) 
    ON UPDATE CASCADE 
    ON DELETE CASCADE
);

CREATE TABLE people_conference (
   id              int         PRIMARY KEY,
   idPeople        int         NOT NULL,
   idConference    int         NOT NULL,
   FOREIGN KEY (idPeople)   
    REFERENCES people (id) 
    ON UPDATE CASCADE 
    ON DELETE CASCADE,
   FOREIGN KEY (idConference)   
    REFERENCES conference (id) 
    ON UPDATE CASCADE 
    ON DELETE CASCADE
);

CREATE TABLE people_publication (
   id              int         PRIMARY KEY,
   idPeople        int         NOT NULL,
   idPublication   int         NOT NULL,
   mainAuthor      boolean     NOT NULL,
   FOREIGN KEY (idPeople)   
    REFERENCES people (id) 
    ON UPDATE CASCADE 
    ON DELETE CASCADE,
   FOREIGN KEY (idPublication)   
    REFERENCES publication (id) 
    ON UPDATE CASCADE 
    ON DELETE CASCADE
);

CREATE TABLE people_scienceProject (
   id                      int         PRIMARY KEY,
   idPeople                int         NOT NULL,
   idScienceProject        int         NOT NULL,
   participationStart      DATE        NOT NULL,
   participationEnd        DATE,
   FOREIGN KEY (idPeople)   
    REFERENCES people (id) 
    ON UPDATE CASCADE 
    ON DELETE CASCADE,
   FOREIGN KEY (idScienceProject)   
    REFERENCES scienceProject (id) 
    ON UPDATE CASCADE 
    ON DELETE CASCADE
);
