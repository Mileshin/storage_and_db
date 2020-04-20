FROM library/postgres
ENV POSTGRES_PASSWORD 'root'
#ENV POSTGRES_USER 'andrey'
#ENV POSTGRES_PASSWORD 'qwe123'
#ENV POSTGRES_DB 'report_cards'
COPY ./init.sql /docker-entrypoint-initdb.d/
