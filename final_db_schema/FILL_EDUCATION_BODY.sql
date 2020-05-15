CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY FILL_EDUCATION AS

  FUNCTION existsGroup(GR_NUM IN VARCHAR2) return boolean is
    begin
        for r in (select 1 from "EDUCATION"."GROUPS"
        WHERE groupNumber = GR_NUM)
            loop return true;
            end loop;
        return false;
    end;

  PROCEDURE GET_POSTGRES_DATA AS
  BEGIN
    INSERT INTO "EDUCATION"."PEOPLE" (id, FirstName, LastName, patronymic, dateOfBirth, placeOfBirth)
    SELECT "id", "firstname", "lastname", "patronymic", "dateofbirth", "placeofbirth"
    FROM "people"@"report_cards_postgres"
    MINUS
    SELECT id, FirstName, LastName, patronymic, dateOfBirth, placeOfBirth
    FROM "EDUCATION"."PEOPLE";
    COMMIT;

    INSERT INTO "EDUCATION"."WORKERS" (idEmployee, idPerson, department, position, workStart, workEnd, university)
    SELECT "id", "peopleid", "department", "positions", "workstart", "workend", "university"
    FROM "teachers"@"report_cards_postgres"
    where "peopleid" in (SELECT id FROM "EDUCATION"."PEOPLE")
    MINUS
    SELECT idEmployee, idPerson, department, position, workStart, workEnd, university
    FROM "EDUCATION"."WORKERS";
    COMMIT;


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
    NULL;
  END GET_POSTGRES_DATA;


  PROCEDURE GET_MYSQL_DATA AS
  BEGIN
    -- TODO: Implementation required for PROCEDURE FILL_EDUCATION.GET_MYSQL_DATA
    NULL;
  END GET_MYSQL_DATA;

  PROCEDURE GET_ORALCE_DATA AS
  BEGIN
    /*INSERT INTO "EDUCATION"."GROUPS" (groupNumber, studyProgram, specialty, qualification, studyYear)
    SELECT "id", "peopleid", "department", "positions", "workstart", "workend", "university"
    FROM "teachers"@"report_cards_postgres"
    where "peopleid" in (SELECT id FROM "EDUCATION"."PEOPLE")
    MINUS
    SELECT idEmployee, idPerson, department, position, workStart, workEnd, university
    FROM "EDUCATION"."WORKERS";
    COMMIT;*/
    NULL;
  END GET_ORALCE_DATA;

  PROCEDURE GET_MONGODB_DATA AS
  BEGIN
    -- TODO: Implementation required for PROCEDURE FILL_EDUCATION.GET_MONGODB_DATA
    NULL;
  END GET_MONGODB_DATA;


END FILL_EDUCATION;
