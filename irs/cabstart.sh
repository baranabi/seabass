#!/bin/bash

touch respfile
/genresp.sh respfile
/var/lib/irods/packaging/setup_irods.sh < respfile
tail -f /var/lib/irods/iRODS/server/log/rodsLog.*
