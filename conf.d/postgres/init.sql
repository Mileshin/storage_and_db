CREATE USER andrey WITH PASSWORD 'qwe123';
CREATE DATABASE report_cards;
ALTER USER andrey VALID UNTIL 'infinity';
\c report_cards
GRANT ALL PRIVILEGES ON DATABASE TO  andrey;
GRANT USAGE ON SCHEMA public TO andrey;

CREATE TABLE students (
   id             int         PRIMARY KEY,
   FirstName      CHARACTER   VARYING(30)    NOT NULL,
   LastName       CHARACTER   VARYING(30)    NOT NULL,
   Patronymic     CHARACTER   VARYING(30),
   university     CHARACTER   VARYING(110)   NOT NULL,
   studyStandart  boolean                    NOT NULL,
   studyForm      boolean                    NOT NULL,
   faculty        CHARACTER   VARYING(110)   NOT NULL,
   specialty      CHARACTER   VARYING(110)   NOT NULL
);

CREATE TABLE teachers (
   id             int         PRIMARY KEY,
   FirstName      CHARACTER   VARYING(30)    NOT NULL,
   LastName       CHARACTER   VARYING(30)    NOT NULL,
   Patronymic     CHARACTER   VARYING(30),
   university     CHARACTER   VARYING(110)   NOT NULL
);

CREATE TABLE curriculum (
   id             int         PRIMARY KEY,
   Subject        CHARACTER   VARYING(30)    NOT NULL,
   semester       int         CHECK (semester > 0 and semester < 11) NOT NULL,
   lecture        CHARACTER   VARYING(30)    NOT NULL,
   practice       CHARACTER   VARYING(30)    NOT NULL,
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
