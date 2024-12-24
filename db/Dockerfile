FROM postgres:17

ENV POSTGRES_DB='webpraia_database' \
    POSTGRES_USER='webpraiaadmin' \
    POSTGRES_PASSWORD='webpraiaadmin'

EXPOSE 5432

COPY ./init.sql /docker-entrypoint-initdb.d/
