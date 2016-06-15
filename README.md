# seabass

seabass is a virtual iRODS environment comprising docker containers organized via docker compose. 


## how to run

the component containers can be tweaked and run on your own using your own docker/docker-compose acumen.

however, a simple script is provided to help get a simple set up running quickly. 

### seabass.sh
usage:

./seabass.sh [[-r/--resources] <# of desired resource servers>]

the -r or --resources option allows you to define a number of resource servers to include in the cluster of containers. 

By default, when the flag is unused, seabass spins up 0 resource servers, and the cluster only comprises the icat container, and the ies container. 



## architecture





### containers
