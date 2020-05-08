# Гетерогенные сервисы
Доступ к другим базам данных будет осуществлен через гетерогенные сервисы.  

## Настройка
#### Установить нужные драйвера
Смотри ниже
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
initORCLCDB.ora -> /opt/oracle/product/19c/dbhome_1/hs/admin/initORCLCDB.ora
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

## Mysql
Нужно скачать драйвер  Н
https://dev.mysql.com/downloads/connector/odbc/
Пример:
```
wget https://dev.mysql.com/get/Downloads/Connector-ODBC/8.0/mysql-connector-odbc-8.0.20-1.el7.x86_64.rpm
rpm -ivh -nodeps --noscripts mysql-connector-odbc-8.0.20-1.el7.x86_64.rpm
```
Или попытаться поставить из репозитория по умолчанию:
```
yum install mysql-connector-odbc
```
