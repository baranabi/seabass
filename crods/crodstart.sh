#!/bin/bash
echo "SETTING UP POSTGRES ICAT SERVER"
psql -h icat -U postgres -f icatsetup.sql


echo INSTALLING IRODS
rpm -i irods-*.rpm
echo IRODS INSTALLED

echo SETTING UP IRODS!
#/autoconf.exp
touch respfile
/genresp.sh respfile
/var/lib/irods/packaging/setup_irods.sh < respfile
