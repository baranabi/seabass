#!/bin/bash
# generates responses for iinit
RESPFILE=$1

printf 'ies\n'       >  $RESPFILE 
printf '1247\n'      >> $RESPFILE 
printf 'rods\n'      >> $RESPFILE 
printf 'tempZone\n'  >> $RESPFILE 
printf 'password\n'  >> $RESPFILE 
