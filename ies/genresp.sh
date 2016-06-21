#!/bin/bash



# simple enough script that
# generates the responses for the iRODS post install setup script. 
# can edit for your own setup configuration. 
# as is this one generates responses of default values for the configuration.  

RESPFILE=$1

printf "\n"         >  $RESPFILE                            # service account user ID
printf "\n"         >> $RESPFILE                            # service account group ID
printf "\n"         >> $RESPFILE                            # zone rame
printf "\n"         >> $RESPFILE                            # service port #
printf "\n"         >> $RESPFILE                            # starting port #
printf "\n"         >> $RESPFILE                            # ending port #
printf "\n"         >> $RESPFILE                            # vault path
printf "\n"         >> $RESPFILE                            # zonekey
printf "\n"         >> $RESPFILE                            # negotiatior key
printf "\n"         >> $RESPFILE                            # control plane port
printf "\n"         >> $RESPFILE                            # control plane key
printf "\n"         >> $RESPFILE                            # schema validation base uri
printf "\n"         >> $RESPFILE                            # iRODS admin account
printf "password\n" >> $RESPFILE                            # iRODS admin password
printf "\n"         >> $RESPFILE                            # confirm iRODS settings
printf "icat\n"     >> $RESPFILE                            # database hostname
printf "\n"         >> $RESPFILE                            # database port
printf "\n"         >> $RESPFILE                            # database DB name
printf "\n"         >> $RESPFILE                            # database admin username
printf "password\n" >> $RESPFILE                            # database admin password
printf "\n"         >> $RESPFILE                            # confirm database settings


