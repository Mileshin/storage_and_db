# Гетерогенные сервисы
Доступ к другим базам данных будет осуществлен через гетерогенные сервисы.  
Для установки драйверов нужны права root. Чтобы законнектится к контейнеру от root.  
```
docker exe -ti -u 0 db_oracle /bin/bash
```

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
```
#### LISTENER
```
listener.ora - > /opt/oracle/oradata/dbconfig/ORCLCDB/listener.ora
```
Потом выполнить
```
lsnrctl reload
lsnrctl status
```
#### TNSNAMES
```
tnsnames.ora -> /opt/oracle/oradata/dbconfig/ORCLCDB/tnsnames.ora
```
Проверка
```
tnsping MySQL
tnsping PostgreSQL
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
create public database link "scientific_activity_mysql" connect to "andrey" identified by "qwe123" using 'MySQL';;
```

### Postgres
Драйвер есть в репозитории Oracle linux (ol7). Так что можно ставить его прямо оттуда.
```
yum install postgresql-odbc
```

#### Создание ссылки
```
create public database link "report_cards_postgres" connect to "andrey" identified by "qwe123" using 'PostgreSQL';
```

### MongoDB
Можно мспользовать драйвер от CData.  
Инструкция https://www.cdata.com/kb/tech/mongodb-odbc-oracle-hs.rst  

Можно попытаться сделать через mongosqld.  
Инструкция https://docs.mongodb.com/bi-connector/master/tutorial/create-system-dsn/

#### Создание ссылки
```
create public database link "dormitories_mongodb" connect to "andrey" identified by "qwe123" using 'MongoDB';
```
