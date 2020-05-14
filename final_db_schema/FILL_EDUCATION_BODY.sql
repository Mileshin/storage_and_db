CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY FILL_EDUCATION AS

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

    NULL;
  END GET_POSTGRES_DATA;


  PROCEDURE GET_MYSQL_DATA AS
  BEGIN
    -- TODO: Implementation required for PROCEDURE FILL_EDUCATION.GET_MYSQL_DATA
    NULL;
  END GET_MYSQL_DATA;

  PROCEDURE GET_ORALCE_DATA AS
  BEGIN
    -- TODO: Implementation required for PROCEDURE FILL_EDUCATION.GET_ORALCE_DATA
    NULL;
  END GET_ORALCE_DATA;

  PROCEDURE GET_MONGODB_DATA AS
  BEGIN
    -- TODO: Implementation required for PROCEDURE FILL_EDUCATION.GET_MONGODB_DATA
    NULL;
  END GET_MONGODB_DATA;

END FILL_EDUCATION;
