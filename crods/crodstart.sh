#!/bin/bash
echo SETTING UP POSTGRES ICAT DATABASE
psql -h icat -U sea -W bass -f icatsetup.sql
echo ICAT DB CONFIGURED!

echo INSTALLING IRODS
rpm -i  ftp://ftp.renci.org/pub/irods/releases/4.1.8/centos7/irods-icat-4.1.8-centos7-x86_64.rpm
rpm -i  ftp://ftp.renci.org/pub/irods/releases/4.1.8/centos7/irods-database-plugin-postgres-1.8-centos7-x86_64.rpm
echo IRODS INSTALLED

echo SETTING UP IRODS IES IE
touch respfile
/genresp.sh respfile
/var/lib/irods/packaging/setup_irods.sh < respfile
