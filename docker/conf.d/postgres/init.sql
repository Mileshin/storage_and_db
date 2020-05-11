CREATE USER andrey WITH PASSWORD 'qwe123';
CREATE DATABASE report_cards;
ALTER USER andrey VALID UNTIL 'infinity';
\c report_cards
GRANT USAGE ON SCHEMA public TO andrey;
GRANT ALL PRIVILEGES ON DATABASE report_cards TO  andrey;
\c report_cards

CREATE TABLE people (
   id             int         PRIMARY KEY,
   FirstName      CHARACTER   VARYING(30)    NOT NULL,
   LastName       CHARACTER   VARYING(30)    NOT NULL,
   Patronymic     CHARACTER   VARYING(30),
   dateOfBirth    DATE        NOT NULL,
   placeOfBirth   CHARACTER   VARYING(30)   NOT NULL,
   UNIQUE (FirstName, LastName, Patronymic, dateOfBirth, placeOfBirth)
 );

CREATE TABLE students (
   id             int         PRIMARY KEY,
   peopleId       int         REFERENCES "people" ("id"),
   university     CHARACTER   VARYING(110)   NOT NULL,
   studyStandart  boolean                    NOT NULL,
   studyForm      boolean                    NOT NULL,
   faculty        CHARACTER   VARYING(110)   NOT NULL,
   specialty      CHARACTER   VARYING(110)   NOT NULL,
   group_num      CHARACTER   VARYING(10)    NOT NULL
);

CREATE TABLE teachers (
   id             int         PRIMARY KEY,
   peopleId       int         REFERENCES "people" ("id"),
   positions      CHARACTER   VARYING(100)   NOT NULL,
   department     CHARACTER   VARYING(100)   NOT NULL,
   university     CHARACTER   VARYING(110)   NOT NULL,
   workStart       DATE          NOT NULL,
   workEnd         DATE
);

CREATE TABLE curriculum (
   id             int         PRIMARY KEY,
   Subject        CHARACTER   VARYING(30)    NOT NULL,
   semester       int         CHECK (semester > 0 and semester < 11) NOT NULL,
   lecture        CHARACTER   VARYING(30)    NOT NULL,
   practice       CHARACTER   VARYING(30)    NOT NULL,
   group          CHARACTER   VARYING(30)    NOT NULL,
   exam           boolean                    NOT NULL
);

CREATE TABLE grades (
   idStudent      int         NOT  NULL   REFERENCES "students" ("id"),
   idTeacher      int         NOT  NULL   REFERENCES "teachers" ("id"),
   idSubject      int         NOT  NULL   REFERENCES "curriculum" ("id"),
   grade          real        CHECK (grade >= 0 and grade <= 100) NOT NULL,
   date_of_change date,
   PRIMARY KEY (idStudent,idTeacher,idSubject)
);

CREATE FUNCTION grade_stamp() RETURNS trigger AS $grade_stamp$
    BEGIN
        NEW.date_of_change := to_char(current_timestamp, 'yyyy-mm-dd');
        RETURN NEW;
    END;
$grade_stamp$ LANGUAGE plpgsql;

CREATE TRIGGER grade_stamp BEFORE INSERT OR UPDATE ON grades
    FOR EACH ROW EXECUTE PROCEDURE grade_stamp();

GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO andrey;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO andrey;
