# Гетерогенные сервисы
Доступ к другим базам данных будет осуществлен через гетерогенные сервисы.  
Для установки драйверов нужны права root. Чтобы законнектится к контейнеру от root.  
```
docker exec -ti -u 0 db_oracle /bin/bash
```
Можно скопировать данную дирректорию ```docker cp  ./heterogeneous_services/ db_oracle:/```  и запустить init.sh.  Он должен сделать все что описанно ниже, установки лицензии для MongoDB  и создание ссылок. Это надо сделать вручную.

## Настройка
#### Установить нужные драйвера
Смотри создание ссылок
#### Настройка ODBC.
Тут вся информация о том куда и через что необходимо подключится.
```
odbc.ini -> /etc/odbc.ini
```
Проверка возможности подключится:
```
isql -v <dsnname> <username> <password>
```
Где **dsnname** имя из odbc.ini, а логин и пароль от базы к которой подключаемся.
####  Настройка гетерогенного сервиса
```
# Mysql
init_hs/initMySQL.ora -> /opt/oracle/product/19c/dbhome_1/hs/admin/initMySQL.ora
# initPostgreSQL
init_hs/initPostgreSQL.ora -> /opt/oracle/product/19c/dbhome_1/hs/admin/initPostgreSQL.ora
# initMongoDB
init_hs/initMongoDB.ora -> /opt/oracle/product/19c/dbhome_1/hs/admin/initMongoDB.ora
```
#### LISTENER
Надо помнить, что в listener.ora отступы критичны.
```
listener.ora - > /opt/oracle/oradata/dbconfig/ORCLCDB/listener.ora
```
Потом выполнить
```
lsnrctl reload
lsnrctl status
```
#### TNSNAMES
Надо помнить, что в tnsnames.ora отступы критичны.
```
tnsnames.ora -> /opt/oracle/oradata/dbconfig/ORCLCDB/tnsnames.ora
```
Проверка
```
tnsping MySQL
tnsping PostgreSQL
tnsping MongoDB
```
## Создание ссылок
### Mysql
Нужно установить драйвер  
Можно поставить из репозитория по умолчанию:
```
yum install mysql-connector-odbc
```
Но я советую скачать с сайта боле новый(все тестилось через него).
https://dev.mysql.com/downloads/connector/odbc/
Пример:
```
wget https://dev.mysql.com/get/Downloads/Connector-ODBC/8.0/mysql-connector-odbc-8.0.20-1.el7.x86_64.rpm
rpm -ivh --nodeps --noscripts mysql-connector-odbc-8.0.20-1.el7.x86_64.rpm
```

#### Создание ссылки
```
create public database link "scientific_activity_mysql" connect to "andrey" identified by "qwe123" using 'MySQL';

# Проверка
select * from "edition"@"scientific_activity_mysql";
```

### Postgres
Драйвер есть в репозитории Oracle linux (ol7). Так что можно ставить его прямо оттуда.
```
yum install postgresql-odbc
```

#### Создание ссылки
```
create public database link "report_cards_postgres" connect to "andrey" identified by "qwe123" using 'PostgreSQL';
# проверка
select * from "teachers"@"report_cards_postgres";
```

### MongoDB
##### Можно мспользовать драйвер от CData.  
Инструкция https://www.cdata.com/kb/tech/mongodb-odbc-oracle-hs.rst  
Ссылка на скачивание https://www.cdata.com/drivers/mongodb/odbc/
Потом
```
# Копируем в корень контейнера
docker cp MongoDBODBCDriverforUnix.rpm db_oracle:/~
# Устанавливаем
rpm -ivh MongoDBODBCDriverforUnix.rpm
# регистрируем лицензию
/opt/cdata/cdata-odbc-driver-for-mongodb/bin/install-license.x64
```


##### Можно попытаться сделать через mongosqld.  
Инструкция https://docs.mongodb.com/bi-connector/master/tutorial/create-system-dsn/
```
wget https://info-mongodb-com.s3.amazonaws.com/mongodb-bi/v2/mongodb-bi-linux-x86_64-debian10-v2.13.4.tgz
tar -zxvf mongodb-bi-linux-x86_64-debian10-v2.13.4.tgz
```

#### Создание ссылки
```
create public database link "dormitories_mongodb" connect to "andrey" identified by "qwe123" using 'MongoDB';
```
