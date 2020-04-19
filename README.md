# storage_and_db
Storage and db labs

Запуск необходимо выполнять с помощью команды `docker-compose up -d --build`. Выключать с помощью `docker-compose down`.

Таблицы и пользователи генерируются автоматически.

На ip 2987 весит adminer, который в той же сети, что и базы данных. Через него можно легко ими управлять(хотя консоль ван лав!).

## Postgres
В базе данных будет 4 таблицы: 
    curriculum
    grades
    students
    teachers
