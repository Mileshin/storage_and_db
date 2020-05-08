CREATE TABLE people (
   id             NUMBER(6)     PRIMARY KEY,
   FirstName      VARCHAR2(30)  NOT NULL,
   LastName       VARCHAR2(30)  NOT NULL,
   patronomic     VARCHAR2(30)  NOT NULL,
   dateOfBirth    DATE          NOT NULL,
   placeOfBirth   VARCHAR2(110) NOT NULL
);

CREATE TABLE workers (
   idEmployee      NUMBER(6)     PRIMARY KEY,
   idPerson        NUMBER(6)     NOT NULL,
   department      VARCHAR2(50)  NOT NULL,
   position        VARCHAR2(100) NOT NULL,
   workStart       DATE          NOT NULL,
   workEnd         DATE,          
   CONSTRAINT fk_people_workers
   FOREIGN KEY (idPerson)
    REFERENCES people(id)
);

CREATE TABLE groups (
   groupNumber    VARCHAR2(10)   PRIMARY KEY,  
   studyForm      VARCHAR2(10)   NOT NULL
   CONSTRAINT
      checkForm   CHECK (studyForm IN ('full-time','extramural')),
   studyProgram   VARCHAR2(70)   NOT NULL,
   specialty      VARCHAR2(70)   NOT NULL,
   qualification  VARCHAR2(20)   NOT NULL,
   studyYear      NUMBER(1)      CHECK (studyYear > 0 and studyYear < 6) NOT NULL
);

CREATE TABLE students (
   idStudent       NUMBER(6)     PRIMARY KEY,
   idPerson        NUMBER(6)     NOT NULL,
   groupNumber     VARCHAR2(10)  NOT NULL,
   studyType       VARCHAR2(10)  NOT NULL,
   CONSTRAINT
      checkType    CHECK (studyType IN ('budget','contracted')),
   CONSTRAINT fk_people_students
   FOREIGN KEY (idPerson)
    REFERENCES people(id),
   CONSTRAINT fk_groups_students
   FOREIGN KEY (groupNumber)
    REFERENCES groups(groupNumber)
);

CREATE TABLE grades (
   id              NUMBER(6)     PRIMARY KEY,
   idStudent       NUMBER(6)     NOT NULL,
   subject         VARCHAR2(70)  NOT NULL,
   gradeDate       DATE          default sysdate   NOT NULL,
   grade           FLOAT         CHECK (grade >= 0 and grade <= 100) NOT NULL,
   letter          VARCHAR2(6)   CHECK (letter in ('A','B','C','D','E','pass','fail'))  NOT NULL,
   CONSTRAINT fk_students_grades
   FOREIGN KEY (idStudent)
    REFERENCES students(idStudent)
);

CREATE TABLE curriculum (
   id              NUMBER(6)     PRIMARY KEY,
   groupNumber     VARCHAR2(10)  NOT NULL,
   subject         VARCHAR2(10)  NOT NULL,
   idEmployee      NUMBER(6)     NOT NULL,
   time            DATE          NOT NULL,
   classroom       VARCHAR2(10)  NOT NULL,
   CONSTRAINT fk_groups_curriculum
   FOREIGN KEY (groupNumber)
    REFERENCES groups(groupNumber),
   CONSTRAINT fk_worker_curriculum
   FOREIGN KEY (idEmployee)
    REFERENCES workers(idEmployee)
);
