#!/bin/bash

# Start script for IES container. uses genresp.sh and initresp.sh to generate responses for set up scripts
# finally starts a bash session for an interactive entrypoint. 

echo SETTING UP IRODS IES 
touch respfile
/genresp.sh respfile
/var/lib/irods/packaging/setup_irods.sh < respfile

touch initresp
/initresp.sh initresp

rm respfile initresp

bash
