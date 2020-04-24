# storage_and_db
Storage and db labs

Запуск необходимо выполнять с помощью команды `docker-compose up -d --build`. Можно без ** build **, но тогда образ не пересоберется. Выключать с помощью `docker-compose down`.

Предварительно нужно создать образ для oralce и прописать в соответствующий Dockerfile.

Из-за Oracle все запускается очень долго.

Таблицы и пользователи генерируются автоматически.

На ip 2987 весит adminer, который в той же сети, что и базы данных. Через него можно легко ими управлять(хотя консоль ван лав!).

## Postgres
В базе данных report_cards будет 4 таблицы: 
- curriculum
- grades
- students
- teachers

## Mysql
В базе данных scientific_activity будет 6 таблиц:
- people
- conference
- scienceProject
- edition
- publication
- libraryCard

И 3 вспомогательных таблицы:
- people_conference
- people_publication
- people_scienceProject

## Oracle
В базе данных будет 6 таблиц:
- people
- workers
- groups
- students
- grades
- curriculum

С Oracle как всегда все плохо.  Можно использовать официальный образ от Oracle или собрать его самому. Официальный образ у меня по-нормальному так и не завелся, как и у большинства пользователей. 
#### образ от oracle
Надо отдельно подтягивать образ с их сайта. На сайте нас ждет apex, боль и страдания. Надо залогиниться и поставить кучу галочек, иначе ничего не заработает. https://container-registry.oracle.com/pls/apex/f?p=113:1:::NO:1:P1_BUSINESS_AREA:3

После этого выполнить команды:
```
docker login container-registry.oracle.com
docker pull container-registry-london.oracle.com/database/standard:12.1.0.2
```
Надо учесть, что образ весит 5 гигов.

Потом можно запустить образ. При этом база данных по-нормальному не поднимется. Надо зайти в сам контейнер и все настроить. 

Сначала нужно установить ORACLE_SID, так как он по какой-то причине не устанавливается.

#### образ своими руками
Хорошая инструкция
https://nicholasgribanov.name/docker-sozdanie-kontejnera-s-bazoj-dannyx-oracle/
Только образ запускается, судя по всему, на одном ядре, что не очень быстро.

В любом случае, из-за особенностей oracle автоматически подсунуть ему скрипты не очень-то получается.

Пароль от администратора нужно будет глянуть в логах.

В общем, все очень легко и приятно, если все делать по инструкции. Даже легче, чем с официальным образом(так быть не должно, но это oracle).

## MongoDb
В базе данных dormitories будет 4 коллекции:
- people
- rooms
- dormitories
- lodger

Управлять mongo лучше через mongo-express. Adminer не умеет в mongo.  
Mongo в docker не всегда подгружает скрипты, поэтому лучше сделать все вручную.  
Зайти в контейнер
```
docker exec -ti db_mongo /bin/bash
```
подключиться к базе
```
mongo -u root -p qwe123 --authenticationDatabase admin
```
И выполнить все из init.js
