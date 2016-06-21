
-- icatsetup.sql
-- this script sets up the postgresql ICAT db. 
-- creates db, default irods role with all privileges.
CREATE DATABASE "ICAT";
CREATE USER irods WITH PASSWORD 'password';
GRANT ALL PRIVILEGES ON DATABASE "ICAT" to irods;
