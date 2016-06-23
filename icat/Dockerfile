FROM postgres:9.4

# postgres container
# used by ies to house the icat db. 
ENV POSTGRES_USER     sea
ENV POSTGRES_PASSWORD bass

COPY icatsetup.sql /docker-entrypoint-initdb.d/
