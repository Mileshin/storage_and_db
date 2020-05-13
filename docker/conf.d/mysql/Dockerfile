FROM library/mysql
ENV MYSQL_ROOT_PASSWORD 'root'
COPY ./000-init.sql /docker-entrypoint-initdb.d/
