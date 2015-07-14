#SEABASS
Baran Balkan 2015

Seabass simulates a generic iRODS 4.1.3  environment on multiple centos6 machines  using docker containers. 

The components are:
COPS: a postgres server that is used as the iCAT server. 
CRODS: models the IES
CABS:  models resource servers
COMS:  a centos6 machine with iCommands installed, used to talk to CRODS. 


This project also contains bash scripts that automate the building and running of docker containers from the images defined earlier. 

scripts that begin with the letter b are build scripts, 
and scrips that begin with the letter c are run scripts. 

#BUILD SCRIPTS:
bops.sh builds cops
brods.sh builds crods
babs.sh builds cabs
boms.sh builds coms

#RUN SCRIPTS

cbase.sh runs Seabass as a daemon, requiring either external communication, or an exec in. 

cint.sh runs Seabass interactively, placing the user in the terminal of COMS. 

