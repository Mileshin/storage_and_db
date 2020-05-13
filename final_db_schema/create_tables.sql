/* Oracle, Postgres, Mysql, Mongo*/
CREATE TABLE "EDUCATION"."PEOPLE" (
   id             NUMBER(6)     PRIMARY KEY,
   FirstName      VARCHAR2(30)  NOT NULL,
   LastName       VARCHAR2(30)  NOT NULL,
   patronymic     VARCHAR2(30)  NOT NULL,
   dateOfBirth    DATE          NOT NULL,
   placeOfBirth   VARCHAR2(110) NOT NULL,
   UNIQUE (FirstName, LastName, patronymic, dateOfBirth, placeOfBirth)
);

/*Oracle, Postgres*/
CREATE TABLE "EDUCATION"."WORKERS" (
   idEmployee      NUMBER(6)     PRIMARY KEY,
   idPerson        NUMBER(6)     NOT NULL,
   department      VARCHAR2(100) NOT NULL,
   position        VARCHAR2(100) NOT NULL,
   workStart       DATE          NOT NULL,
   workEnd         DATE,
   university      VARCHAR2(110)   NOT NULL,
   CONSTRAINT fk_people_workers
   FOREIGN KEY (idPerson)
    REFERENCES "EDUCATION"."PEOPLE"(id)
);

/*Oracle*/
CREATE TABLE "EDUCATION"."GROUPS" (
   groupNumber    VARCHAR2(10)   PRIMARY KEY,
   studyProgram   VARCHAR2(70)   NOT NULL,
   specialty      VARCHAR2(70)   NOT NULL,
   qualification  VARCHAR2(20)   NOT NULL,
   studyYear      NUMBER(1)      CHECK (studyYear > 0 and studyYear < 6) NOT NULL
);

/*Oracle, Postgres*/
CREATE TABLE "EDUCATION"."STUDENTS" (
   idStudent       NUMBER(6)     PRIMARY KEY,
   idPerson        NUMBER(6)     NOT NULL,
   groupNumber     VARCHAR2(10)  NOT NULL,
   studyType       VARCHAR2(10)  NOT NULL,
   faculty        CHARACTER   VARYING(110),
   specialty      CHARACTER   VARYING(110),
   studyForm      VARCHAR2(10)   NOT NULL
   CONSTRAINT
      checkForm   CHECK (studyForm IN ('full-time','extramural')),
   CONSTRAINT
      checkType    CHECK (studyType IN ('budget','contracted')),
   CONSTRAINT fk_people_students
   FOREIGN KEY (idPerson)
    REFERENCES "EDUCATION"."PEOPLE"(id),
   CONSTRAINT fk_groups_students
   FOREIGN KEY (groupNumber)
    REFERENCES "EDUCATION"."GROUPS"(groupNumber)
);

/*Oracle, Postgres*/
CREATE TABLE "EDUCATION"."GRADES" (
   id              NUMBER(6)     PRIMARY KEY,
   idStudent       NUMBER(6)     NOT NULL,
   idEmployee      NUMBER(6)     NOT NULL,
   subject         VARCHAR2(70)  NOT NULL,
   gradeDate       DATE          default sysdate   NOT NULL,
   grade           FLOAT         CHECK (grade >= 0 and grade <= 100) NOT NULL,
   letter          VARCHAR2(6)   CHECK (letter in ('A','B','C','D','E','pass','fail'))  NOT NULL,
   CONSTRAINT fk_students_grades
   FOREIGN KEY (idStudent)
    REFERENCES "EDUCATION"."STUDENTS"(idStudent),
   CONSTRAINT fk_grades_curriculum
   FOREIGN KEY (idEmployee)
    REFERENCES "EDUCATION"."WORKERS"(idEmployee)
);

/*Oracle, postgres*/
CREATE TABLE "EDUCATION"."CURRICULM" (
   id              NUMBER(6)     PRIMARY KEY,
   groupNumber     VARCHAR2(10),
   subject         VARCHAR2(10)  NOT NULL,
   idEmployee      NUMBER(6),
   time            DATE          NOT NULL,
   classroom       VARCHAR2(10)  NOT NULL,
   lecture         VARCHAR2(30)  NOT NULL,
   practice        VARCHAR2(30)  NOT NULL,
   CONSTRAINT fk_groups_curriculum
   FOREIGN KEY (groupNumber)
    REFERENCES "EDUCATION"."GROUPS"(groupNumber),
   CONSTRAINT fk_worker_curriculum
   FOREIGN KEY (idEmployee)
    REFERENCES "EDUCATION"."WORKERS"(idEmployee)
);
