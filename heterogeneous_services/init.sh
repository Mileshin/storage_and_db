#!/bin/sh

# install drivers
yum install -y vim wget postgresql-odbc mysql-connector-odbc

wget https://dev.mysql.com/get/Downloads/Connector-ODBC/8.0/mysql-connector-odbc-8.0.20-1.el7.x86_64.rpm
rpm -ivh --nodeps --noscripts mysql-connector-odbc-8.0.20-1.el7.x86_64.rpm

rpm -ivh MongoDBODBCDriverforUnix.rpm

# Create odbc file
cp ./odbc.ini  /etc/odbc.ini
# Mysql
cp init_hs/initMySQL.ora  /opt/oracle/product/19c/dbhome_1/hs/admin/initMySQL.ora
# initPostgreSQL
cp init_hs/initPostgreSQL.ora  /opt/oracle/product/19c/dbhome_1/hs/admin/initPostgreSQL.ora
# initMongoDB
cp init_hs/initMongoDB.ora  /opt/oracle/product/19c/dbhome_1/hs/admin/initMongoDB.ora

# LISTENER
cp listener.ora /opt/oracle/oradata/dbconfig/ORCLCDB/listener.ora
lsnrctl reload

#TNSNAMES
cp tnsnames.ora  /opt/oracle/oradata/dbconfig/ORCLCDB/tnsnames.ora

sed -i 's/UTF-16/UTF-8/' /opt/cdata/cdata-odbc-driver-for-mongodb/lib/cdata.odbc.mongodb.ini
