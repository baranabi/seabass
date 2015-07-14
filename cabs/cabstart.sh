#!/bin/bash

touch respfile
/genresp.sh respfile
/var/lib/irods/packaging/setup_irods.sh < respfile
