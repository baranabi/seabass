FROM postgres:16

ENV POSTGRES_USER     sea
ENV POSTGRES_PASSWORD bass

COPY icatsetup.sql /docker-entrypoint-initdb.d/
