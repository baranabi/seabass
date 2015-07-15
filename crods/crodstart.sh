#!/bin/bash
echo "SETTING UP POSTGRES ICAT SERVER"
psql -h icat -U postgres -f icatsetup.sql


echo INSTALLING IRODS
rpm -i ftp://ftp.renci.org/pub/irods/releases/4.1.3/centos6/irods-icat-4.1.3-centos6-x86_64.rpm
rpm -i ftp://ftp.renci.org/pub/irods/releases/4.1.3/centos6/irods-database-plugin-postgres93-1.5-centos6-x86_64.rpm
echo IRODS INSTALLED

echo SETTING UP IRODS!
#/autoconf.exp
touch respfile
/genresp.sh respfile
/var/lib/irods/packaging/setup_irods.sh < respfile
