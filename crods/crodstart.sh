#!/bin/bash
echo SETTING UP IRODS IES IE
touch respfile
/genresp.sh respfile
/var/lib/irods/packaging/setup_irods.sh < respfile

touch initresp
/initresp.sh initresp
iinit < initresp

rm respfile initresp

bash
