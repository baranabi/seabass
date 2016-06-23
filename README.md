# seabass

seabass is a virtual iRODS environment comprising docker containers organized via docker compose. 


## how to run

the component containers can be tweaked and run on your own using your own docker/docker-compose acumen.

however, a simple script is provided to help get a simple set up running quickly. 

### seabass.sh
usage:

./seabass.sh [[-r/--resources] <#  of desired resource servers>] [[-v/--volumes] < desired mount path>]

the -r or --resources option allows you to define a number of resource servers to include in the cluster of containers. 

the -v or --volumes option allows you to specify the path that will be mounted in the home directory of the icom container. 
WARNING: THE MOUNT IS WRITABLE, SO WHAT YOU DO IN SEABASS WILL AFFECT YOUR DATA IN REAL LIFE. 


By default, when the resource  flag is unused, seabass spins up 0 resource servers, and the cluster only comprises the icat container, and the ies container. When the volumes flag is unused, the current directory, or . is mounted to icom's home directory. 

## architecture

Each subdirectory {icat,ies,irs,icom} contains the Dockerfiles and other necessary files for the component containers. 
Each subdirectory also contains a markdown file that goes into more detail concerning each container,
but a cursory overview will be given here. 

Also a basic idea of the relationship among these services can be seen in the docker-compose.yml file in which you can see
how the services attach to eachother.

### containers
though icom is the designated icommands container, iinit has been set up in every container save icat,
so icommands can be run from any container (except for icat).  


# icom
icom is the iCommands container. When using seabass using the seabass.sh script, the user will be placed into an interactive terminal session inside this container. 

The home directory inside this container is a mount point for a path specified by environment variable SEABASS_MOUNT_PATH
The container has both read and write access to the mounted filesystem, so be careful!

When the user is plopped into this container on start up, they will have icommands set up as an administrator.  

# icat

icat is a postgres container used by the ies container to store the icat database. 
This is to have a separate and specific spot where the metadata catalog lives, for easy metadata  access.  

# ies

this container is the iRODS ies. is connected to the icat database.        

# irs
This container is the iRODS resource server, that is servers that are not connected to the icat database. 
This is the scalable component of this set up. An arbitrary number of these resource containers can be spun up
with the -r flag in the seabass.sh script. The default is none of these resource servers are added. 



