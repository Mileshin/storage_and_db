CREATE TABLE people (
   id             NUMBER(6)     PRIMARY KEY,
   FirstName      VARCHAR2(30)  NOT NULL,
   LastName       VARCHAR2(30)  NOT NULL,
   patronomic     VARCHAR2(30)  NOT NULL,
   dateOfBirth    DATE          NOT NULL,
   placeOfBirth   VARCHAR2(110) NOT NULL
);
