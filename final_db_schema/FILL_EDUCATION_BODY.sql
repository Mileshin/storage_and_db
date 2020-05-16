CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY FILL_EDUCATION AS

  FUNCTION existsGroup(GR_NUM IN VARCHAR2) return boolean is
    begin
        for r in (select 1 from "EDUCATION"."GROUPS"
        WHERE groupNumber = GR_NUM)
            loop return true;
            end loop;
        return false;
    end;

    FUNCTION BOOL(V IN NUM) return CHAR is
      begin
          IF (N = 0) THEN
          RETURN 'N';
          END IF;
          RETURN 'Y';
      end;

  PROCEDURE GET_POSTGRES_DATA AS
  BEGIN

  -- PEOPLE
    INSERT INTO "EDUCATION"."PEOPLE" (id, FirstName, LastName, patronymic, dateOfBirth, placeOfBirth)
    SELECT "id", "firstname", "lastname", "patronymic", "dateofbirth", "placeofbirth"
    FROM "people"@"report_cards_postgres"
    MINUS
    SELECT id, FirstName, LastName, patronymic, dateOfBirth, placeOfBirth
    FROM "EDUCATION"."PEOPLE";
    COMMIT;

  -- WORKERS
    INSERT INTO "EDUCATION"."WORKERS" (idEmployee, idPerson, department, position, workStart, workEnd, university)
    SELECT "id", "peopleid", "department", "positions", "workstart", "workend", "university"
    FROM "teachers"@"report_cards_postgres"
    where "peopleid" in (SELECT id FROM "EDUCATION"."PEOPLE")
    MINUS
    SELECT idEmployee, idPerson, department, position, workStart, workEnd, university
    FROM "EDUCATION"."WORKERS";
    COMMIT;

  -- STUDENTS
    FOR J IN (SELECT * FROM "students"@"report_cards_postgres"
      WHERE "id" NOT IN (SELECT IDSTUDENT FROM "EDUCATION"."STUDENTS"))
    LOOP
      IF NOT (existsGroup(J."group_num")) THEN
        INSERT INTO "EDUCATION"."GROUPS" (groupNumber, studyProgram, specialty)
        VALUES (J."group_num", J."faculty", J."specialty");
      END IF;
      INSERT INTO "EDUCATION"."STUDENTS" (IDSTUDENT, IDPERSON, GROUPNUMBER, STUDYTYPE, FACULTY, SPECIALTY, STUDYFORM)
        VALUES (J."id", J."peopleid", J."group_num", J."studystandart", J."faculty", J."specialty", J."studyform");
    END LOOP;
    COMMIT;

  -- CURRICULM
    INSERT INTO "EDUCATION"."CURRICULM" (id, groupNumber, subject, lecture, practice)
      SELECT "id", "group_num", "subject", "lecture", "practice"
      FROM "curriculum"@"report_cards_postgres" P
      where P."group_num" in (SELECT groupNumber FROM "EDUCATION"."GROUPS")
      AND P."id" NOT IN (SELECT ID FROM "EDUCATION"."CURRICULM");
    COMMIT;
    NULL;

  END GET_POSTGRES_DATA;


  PROCEDURE GET_MYSQL_DATA AS
  BEGIN
  -- PEOPLE
    INSERT INTO "EDUCATION"."PEOPLE" (id, FirstName, LastName, patronymic, dateOfBirth, placeOfBirth)
    SELECT * FROM "people"@"scientific_activity_mysql";
    MINUS
    SELECT id, FirstName, LastName, patronymic, dateOfBirth, placeOfBirth
    FROM "EDUCATION"."PEOPLE";
    COMMIT;

  -- CONFERENCE
    INSERT INTO "EDUCATION"."CONFERENCE" (id, name, location, conference_date)
    SELECT * FROM "conference"@"scientific_activity_mysql" M
    WHERE M."id" NOT IN (SELECT ID FROM "EDUCATION"."CONFERENCE");
    COMMIT;

  -- SCIENCEPROJECT
    INSERT INTO "EDUCATION"."SCIENCEPROJECT" (id, name, researchField)
    SELECT * FROM "scienceProject"@"scientific_activity_mysql" M
    WHERE M."id" NOT IN (SELECT ID FROM "EDUCATION"."SCIENCEPROJECT");
    COMMIT;

  -- SCIENCEPROJECT
      INSERT INTO "EDUCATION"."SCIENCEPROJECT" (id, name, researchField)
      SELECT * FROM "scienceProject"@"scientific_activity_mysql" M
      WHERE M."id" NOT IN (SELECT ID FROM "EDUCATION"."SCIENCEPROJECT");
      COMMIT;

  -- EDITION
      INSERT INTO "EDUCATION"."EDITION" (id, name, volume, location, type, language)
        SELECT * FROM "edition"@"scientific_activity_mysql" M
          WHERE M."id" NOT IN (SELECT ID FROM "EDUCATION"."EDITION");
      COMMIT;

  -- PUBLICATION
      INSERT INTO "EDUCATION"."PUBLICATION" (id, name, publicationDate, citationIndex, idEdition)
        SELECT * FROM "publication"@"scientific_activity_mysql" M
          WHERE M."id" NOT IN (SELECT ID FROM "EDUCATION"."PUBLICATION");
      COMMIT;

  -- LIBRARYCARD
    INSERT INTO "EDUCATION"."LIBRARYCARD" (id, pickUpDate, returnDate, idPeople, idEdition)
      SELECT * FROM "libraryCard"@"scientific_activity_mysql" M
        WHERE M."id" NOT IN (SELECT ID FROM "EDUCATION"."LIBRARYCARD");
    COMMIT;

  -- PEOPLE_CONFERENCE
    INSERT INTO "EDUCATION"."PEOPLE_CONFERENCE" (id, idPeople, idConference)
      SELECT * FROM "people_conference"@"scientific_activity_mysql" M
        WHERE M."id" NOT IN (SELECT ID FROM "EDUCATION"."PEOPLE_CONFERENCE");
    COMMIT;

  -- PEOPLE_PUBLICATION
    INSERT INTO "EDUCATION"."PEOPLE_PUBLICATION" (id, idPeople, idPublication, mainAuthor)
    SELECT "id", "idPeople", "idPublication",
           BOOL("mainAuthor") FROM "people_publication"@"scientific_activity_mysql" M
    WHERE M."id" NOT IN (SELECT ID FROM "EDUCATION"."PEOPLE_PUBLICATION");
    COMMIT;

  -- PEOPLE_CIENCEPROJECT
    INSERT INTO "EDUCATION"."PEOPLE_CIENCEPROJECT" (id, idPeople, idScienceProject,
       participationStart, participationEnd)
      SELECT * FROM "people_scienceProject"@"scientific_activity_mysql" M
        WHERE M."id" NOT IN (SELECT ID FROM "EDUCATION"."PEOPLE_CIENCEPROJECT");
    COMMIT;
    NULL;
  END GET_MYSQL_DATA;

  PROCEDURE GET_ORACLE_DATA AS
  BEGIN
  -- PEOPLE
    INSERT INTO "EDUCATION"."PEOPLE" (id, FirstName, LastName, patronymic, dateOfBirth, placeOfBirth)
    SELECT id, FirstName, LastName, patronymic, dateOfBirth, placeOfBirth
    FROM "ANDREY"."PEOPLE" WHERE id NOT IN (SELECT id FROM "EDUCATION"."PEOPLE")
    MINUS
    SELECT id, FirstName, LastName, patronymic, dateOfBirth, placeOfBirth
    FROM "EDUCATION"."PEOPLE";
    COMMIT;

  -- WORKERS
    INSERT INTO "EDUCATION"."WORKERS" (idEmployee, idPerson, department, position, workStart, workEnd)
    SELECT idEmployee, idPerson, department, position, workStart, workEnd
    FROM "ANDREY"."WORKERS"
    where idPerson in (SELECT id FROM "EDUCATION"."PEOPLE")
    MINUS
    SELECT idEmployee, idPerson, department, position, workStart, workEnd
    FROM "EDUCATION"."WORKERS";
    COMMIT;

  -- GROUPS
    MERGE INTO "EDUCATION"."GROUPS" EG
    USING (   SELECT groupNumber, studyProgram, specialty, qualification, studyYear
       FROM "ANDREY"."GROUPS") AG
       ON (EG.groupNumber = AG.groupNumber)
       WHEN MATCHED THEN UPDATE SET EG.studyProgram = AG.studyProgram,
        EG.specialty = AG.specialty,
        EG.qualification = AG.qualification,
        EG.studyYear = AG.studyYear
       WHEN NOT MATCHED THEN INSERT (EG.groupNumber, EG.studyProgram,
          EG.specialty, EG.qualification, EG.studyYear)
          VALUES (AG.groupNumber, AG.studyProgram,
            AG.specialty, AG.qualification, AG.studyYear);
    COMMIT;

    -- STUDENTS
    MERGE INTO "EDUCATION"."STUDENTS" E
    USING (SELECT IDSTUDENT, IDPERSON, GROUPNUMBER, STUDYTYPE, STUDYFORM
       FROM "ANDREY"."STUDENTS") A
       ON (E.IDSTUDENT = A.IDSTUDENT)
       WHEN MATCHED THEN UPDATE SET E.STUDYTYPE = A.STUDYTYPE,
        E.STUDYFORM = A.STUDYFORM
       WHEN NOT MATCHED THEN INSERT (E.IDSTUDENT, E.IDPERSON,
         E.GROUPNUMBER, E.STUDYTYPE, E.STUDYFORM)
          VALUES (A.IDSTUDENT, A.IDPERSON,
            A.GROUPNUMBER, A.STUDYTYPE, A.STUDYFORM);
    COMMIT;

  -- CURRICULM
    MERGE INTO "EDUCATION"."CURRICULM" E
    USING (SELECT id, groupNumber, subject, idEmployee, time, classroom
       FROM "ANDREY"."CURRICULM") A
       ON (E.id = A.id)
       WHEN MATCHED THEN UPDATE SET E.idEmployee = A.idEmployee,
        E.time = A.time,
        E.classroom = A.classroom
       WHEN NOT MATCHED THEN INSERT (E.id, E.groupNumber, E.subject,
         E.idEmployee, E.time, E.classroom)
          VALUES (A.id, A.groupNumber, A.subject, A.idEmployee, A.time, A.classroom);
    COMMIT;

  -- GRADES
    INSERT INTO "EDUCATION"."GRADES" E (id, idStudent, idEmployee, subject, gradeDate, grade, letter)
      SELECT id, idStudent, idEmployee, subject, gradeDate, grade, letter
      FROM "ANDREY"."GRADES" A WHERE id NOT IN (SELECT id FROM "EDUCATION"."GRADES");
    COMMIT;

    NULL;
  END GET_ORACLE_DATA;

  PROCEDURE GET_MONGODB_DATA AS
  BEGIN
  -- PEOPLE
    INSERT INTO "EDUCATION"."PEOPLE" (id, FirstName, LastName, patronymic, dateOfBirth, placeOfBirth)
    SELECT "id", "firstName", "lastName", "patronomic", "dateOfBirth", "placeOfBirth"
     FROM "people"@"dormitories_mongodb";
    MINUS
    SELECT id, FirstName, LastName, patronymic, dateOfBirth, placeOfBirth
    FROM "EDUCATION"."PEOPLE";
    COMMIT;

  -- DORMITORIES
    INSERT INTO "EDUCATION"."DORMITORIES" (place, numberOfRooms)
      SELECT "place", "numberOfRooms" FROM "dormitories"@"dormitories_mongodb" M
        WHERE M."place" NOT IN (SELECT place FROM "EDUCATION"."DORMITORIES");
    COMMIT;

  -- ROOMS
  INSERT INTO "EDUCATION"."ROOMS" (dormitories, roomNumber, roomSize, numLodgers, disinfection, bedbugs)
    SELECT "dormitories", "roomNumber", "roomSize", "numLodgers", TO_DATE("disinfection", 'YYYY-MM-DD'), "bedbugs"
     FROM "rooms"@"dormitories_mongodb" M
      WHERE M."roomNumber" NOT IN (SELECT roomNumber FROM "EDUCATION"."ROOMS");
  COMMIT;

  -- LODGER
  INSERT INTO "EDUCATION"."LODGER" (lodger, peopleId, dormitories,
     roomNumber, rebuke, residenceStart, residenceEnd, paymentAmount)
    SELECT "lodger", "peopleId", "roomNumber", "dormitories", "rebuke", TO_DATE("residenceStart", 'YYYY-MM-DD'),
    TO_DATE("residenceEnd", 'YYYY-MM-DD'), "paymentAmount"
     FROM "lodger"@"dormitories_mongodb" M
      WHERE M."lodger" NOT IN (SELECT lodger FROM "EDUCATION"."LODGER");
  COMMIT;

  -- ATTENDANCE
  INSERT INTO "EDUCATION"."ATTENDANCE" (lodger, time, attendance)
    SELECT "lodger", TO_DATE("time", 'YYYY-MM-DD hh24:mI:ss'), "attendance"
     FROM "attendance"@"dormitories_mongodb" M
    MINUS
    SELECT lodger, time, attendance FROM "EDUCATION"."ATTENDANCE";
  COMMIT;



    NULL;
  END GET_MONGODB_DATA;


END FILL_EDUCATION;
