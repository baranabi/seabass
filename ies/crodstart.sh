#!/bin/bash
echo SETTING UP IRODS IES 
touch respfile
/genresp.sh respfile
/var/lib/irods/packaging/setup_irods.sh < respfile

touch initresp
/initresp.sh initresp

rm respfile initresp

bash
