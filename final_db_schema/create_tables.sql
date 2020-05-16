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
   studyProgram   VARCHAR2(100)   NOT NULL,
   specialty      VARCHAR2(100)   NOT NULL,
   qualification  VARCHAR2(100),
   studyYear      NUMBER(1)      CHECK (studyYear > 0 and studyYear < 6)
);

/*Oracle, Postgres*/
CREATE TABLE "EDUCATION"."STUDENTS" (
   idStudent       NUMBER(6)     PRIMARY KEY,
   idPerson        NUMBER(6)     NOT NULL,
   groupNumber     VARCHAR2(10)  NOT NULL,
   studyType       VARCHAR2(10),
   faculty        CHARACTER   VARYING(110),
   specialty      CHARACTER   VARYING(110),
   studyForm      VARCHAR2(10)
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
   subject         VARCHAR2(100)  NOT NULL,
   idEmployee      NUMBER(6),
   time            DATE,
   classroom       VARCHAR2(10),
   lecture         VARCHAR2(30),
   practice        VARCHAR2(30),
   CONSTRAINT fk_groups_curriculum
   FOREIGN KEY (groupNumber)
    REFERENCES "EDUCATION"."GROUPS"(groupNumber),
   CONSTRAINT fk_worker_curriculum
   FOREIGN KEY (idEmployee)
    REFERENCES "EDUCATION"."WORKERS"(idEmployee)
);

/*Mysql*/
CREATE TABLE "EDUCATION"."CONFERENCE" (
   id             NUMBER(6)         PRIMARY KEY,
   name           VARCHAR2(100)      NOT NULL,
   location       VARCHAR2(100)      NOT NULL,
   conference_date  DATE              NOT NULL
);

/*Mysql*/
CREATE TABLE "EDUCATION"."SCIENCEPROJECT" (
   id             NUMBER(6)   PRIMARY KEY,
   name           VARCHAR2(100)  NOT NULL,
   researchField  VARCHAR2(100)  NOT NULL
);

/*Mysql*/
CREATE TABLE "EDUCATION"."EDITION" (
   id             NUMBER(6)     PRIMARY KEY,
   name           VARCHAR2(100)  NOT NULL,
   volume         VARCHAR2(100)  NOT NULL,
   location       VARCHAR2(100)  NOT NULL,
   type           VARCHAR2(100)  NOT NULL,
   language       VARCHAR2(30)  NOT NULL
);

/*Mysql*/
CREATE TABLE "EDUCATION"."PUBLICATION" (
   id              NUMBER(6)      PRIMARY KEY,
   name            VARCHAR2(100)   NOT NULL,
   publicationDate DATE           NOT NULL,
   citationIndex   NUMBER(6)      NOT NULL,
   idEdition       NUMBER(6)      NOT NULL,
   CONSTRAINT fk_edition_publication
   FOREIGN KEY (idEdition)
    REFERENCES "EDUCATION"."EDITION"(id) ON DELETE CASCADE
);

/*Mysql*/
CREATE TABLE "EDUCATION"."LIBRARYCARD" (
   id              NUMBER(6)   PRIMARY KEY,
   pickUpDate      DATE    DEFAULT SYSDATE,
   returnDate      DATE,
   idPeople        NUMBER(6)   NOT NULL,
   idEdition       NUMBER(6)   NOT NULL,
   CONSTRAINT fk_people_librarycard
   FOREIGN KEY (idPeople)
    REFERENCES "EDUCATION"."PEOPLE"(id) ON DELETE CASCADE,
    CONSTRAINT fk_edition_librarycard
    FOREIGN KEY (idEdition)
     REFERENCES "EDUCATION"."EDITION"(id) ON DELETE CASCADE
);

/*Mysql*/
CREATE TABLE "EDUCATION"."PEOPLE_CONFERENCE" (
   id              NUMBER(6)  PRIMARY KEY,
   idPeople        NUMBER(6)  NOT NULL,
   idConference    NUMBER(6)  NOT NULL,
   CONSTRAINT fk_people_PEOPLE_CONFERENCE
   FOREIGN KEY (idPeople)
    REFERENCES "EDUCATION"."PEOPLE"(id) ON DELETE CASCADE,
    CONSTRAINT fk_conference_PEOPLE_CONFERENCE
    FOREIGN KEY (idConference)
     REFERENCES "EDUCATION"."CONFERENCE"(id) ON DELETE CASCADE
);

/*Mysql*/
CREATE TABLE "EDUCATION"."PEOPLE_PUBLICATION" (
  id              NUMBER(6)  PRIMARY KEY,
  idPeople        NUMBER(6)  NOT NULL,
  idPublication   NUMBER(6)  NOT NULL,
  mainAuthor      CHAR(1) CHECK (mainAuthor IN ('N','Y')),
  CONSTRAINT fk_people_PEOPLE_PUBLICATION
  FOREIGN KEY (idPeople)
   REFERENCES "EDUCATION"."PEOPLE"(id) ON DELETE CASCADE,
   CONSTRAINT fk_conference_PEOPLE_PUBLICATION
   FOREIGN KEY (idPublication)
    REFERENCES "EDUCATION"."PUBLICATION"(id) ON DELETE CASCADE
);

/*Mysql*/
CREATE TABLE "EDUCATION"."PEOPLE_CIENCEPROJECT" (
   id                      NUMBER(6)   PRIMARY KEY,
   idPeople                NUMBER(6)  NOT NULL,
   idScienceProject        NUMBER(6)  NOT NULL,
   participationStart      DATE       NOT NULL,
   participationEnd        DATE,
   CONSTRAINT fk_people_PEOPLE_CIENCEPROJECT
   FOREIGN KEY (idPeople)
    REFERENCES "EDUCATION"."PEOPLE"(id) ON DELETE CASCADE,
    CONSTRAINT fk_conference_PEOPLE_CIENCEPROJECT
    FOREIGN KEY (idScienceProject)
     REFERENCES "EDUCATION"."SCIENCEPROJECT"(id) ON DELETE CASCADE
);

/*MongDB*/
CREATE TABLE "EDUCATION"."DORMITORIES" (
   place          VARCHAR2(100)  PRIMARY KEY,
   numberOfRooms  NUMBER(5)  NOT NULL
 );

/*MongDB*/
CREATE TABLE "EDUCATION"."ROOMS" (
  dormitories   VARCHAR2(100)   NOT NULL,
  roomNumber    VARCHAR2(10)    NOT NULL,
  roomSize      VARCHAR2(10)    NOT NULL,
  numLodgers    NUMBER(1)       NOT NULL,
  disinfection  DATE,
  bedbugs       CHAR(1) CHECK (bedbugs IN ('N','Y')),
  PRIMARY KEY(dormitories,roomNumber),
  CONSTRAINT fk_DORMITORIES_ROOMS
  FOREIGN KEY (dormitories)
   REFERENCES "EDUCATION"."DORMITORIES"(place) ON DELETE CASCADE
);

/*MongDB*/
CREATE TABLE "EDUCATION"."LODGER" (
  lodger        NUMBER(6)     PRIMARY KEY,
  peopleId      NUMBER(6)     NOT NULL,
  dormitories   VARCHAR2(100) NOT NULL,
  roomNumber    VARCHAR2(10)  NOT NULL,
  rebuke        VARCHAR2(256) NOT NULL,
  residenceStart DATE         NOT NULL,
  residenceEnd   DATE,
  paymentAmount  NUMBER(5)    NOT NULL,
  CONSTRAINT fk_people_LODGER
  FOREIGN KEY (peopleId)
   REFERENCES "EDUCATION"."PEOPLE"(id) ON DELETE CASCADE,
   CONSTRAINT fk_ROOMS_LODGER
   FOREIGN KEY (dormitories, roomNumber)
    REFERENCES "EDUCATION"."ROOMS"(dormitories) ON DELETE CASCADE
);

/*MongDB*/
CREATE TABLE "EDUCATION"."ATTENDANCE" (
  lodger        NUMBER(6),
  time          DATE,
  attendance    VARCHAR2(7) CHECK (attendance IN ('arrived','left')),
  PRIMARY KEY(lodger,time,attendance),
  CONSTRAINT fk_LODGER_ATTENDANCE
  FOREIGN KEY (lodger)
   REFERENCES "EDUCATION"."LODGER"(lodger) ON DELETE CASCADE
);
