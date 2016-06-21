#!/bin/bash

# start script for icommands container
# runs iinit automating responses to set up icommands. 
# so the user can immediately fire off icommands as soon as they are plopped in the icom container

touch initresp
./initresp.sh initresp
iinit < initresp
rm initresp
bash

