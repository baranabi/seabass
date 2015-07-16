# seabass
Dockerized iRODS 4.1.3 environment distributed on multiple centos:6 containers. 
The subdirectories specify the docker containers that comprise seabass. 


##CONTAINERS

###cops
the cops container models a postgres server that is used as the iCAT db

###crods
this container links to the iCAT server and acts as the IES. Primary hinge point.

###cabs
this container models a resource server, a server not in communication with the iCAT, but in communication with IES

###coms
this container is the primary user interface to the iRODS setup, a minimal centos 6 environment with iCommands set up. 

##SCRIPTS
Seabass is controlled primarily by bash scripts. Can be 

###build.sh
builds docker images out of the files in the subdirectories. 
image name format seabass/<containername>

###sbase.sh
runs seabass as a daemon, crods is exposed on port 1247, you can either exec into coms, 
or from the host machine. 

###sint.sh
runs seabass interactively, plopping the user in a bash terminal in the coms container. 

###sstop.sh
stops and removes everything. SHUT IT DOWN! IT'S HABBEDING! AAARGH!
