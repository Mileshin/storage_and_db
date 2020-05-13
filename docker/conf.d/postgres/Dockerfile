FROM library/postgres
ENV POSTGRES_PASSWORD admin
COPY ./000-init.sql /docker-entrypoint-initdb.d/
