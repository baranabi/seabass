#!/bin/bash

RESPFILE=$1

#1 irods service account name
printf "\n"       > $RESPFILE                      
#2 irods service group name
printf "\n"      >> $RESPFILE                      
#3 irods server port 
printf "\n"      >> $RESPFILE                      
#4 port range begin
printf "\n"      >> $RESPFILE                      
#5 port range end
printf "\n"      >> $RESPFILE                      
#6 vault directory
printf "\n"      >> $RESPFILE                      
#7 zone key
printf "\n"      >> $RESPFILE                      
#8 negotiation key
printf "\n"      >> $RESPFILE                      
#9 control plane port
printf "\n"      >> $RESPFILE                      
#10 control plane key
printf "\n"      >> $RESPFILE                      
#11 schema validation base uri
printf "\n"      >> $RESPFILE                      
#12 admin username
printf "\n"      >> $RESPFILE                      
#13 confirm settings
printf "\n"      >> $RESPFILE                           
#14 IES server hostname
printf "ies\n"         >> $RESPFILE                      
#15 zone name
printf "tempZone\n"     >> $RESPFILE                   
#16 confirm settings
printf "\n"      >> $RESPFILE                          
#17 admin password
printf "password\n"      >> $RESPFILE                          
