#!/bin/bash


wrong(){ echo "run seabass.sh -h for help"; exit 1;}

usage()
{
 echo -e "usage: ./seabass.sh [OPTIONS]";
 echo -e "       ./seabass.sh [ -h (help) | -v (version info)]" ; 
 echo -e "\nOptions:\n"; 
 echo -e "-r  argument is number of resource containers to spin up. (default = 0)"; 
 echo -e "-m  argument is path of filesystem to mount to icom:/home (default = .) "; 
 echo -e "-v  print version number and quit.";
 echo -e "-h  prints usage." 
 exit 0;
}





# default mount path 
export SEABASS_MOUNT_PATH=`pwd`
# default number of resources
RESOURCES="0"

#getopts to parse options
while getopts ":r:m:vh" opt; do
case $opt in
  r)
  RESOURCES="$2"
  ;;
  m)
  export SEABASS_MOUNT_PATH="$2"
  ;;
  v)
  cat VERSION
  exit 0  
  ;;
  h)
  usage
  ;;
  \?)
  echo "ERROR : INVALID OPTION!"
  wrong
  ;;
  :)
  echo "ERROR : MISSING ARGUMENT!"
  wrong
  ;;
esac
shift
done
# spin up the containers
docker-compose up -d icat ies icom
if [ $RESOURCES -ne 0 ]
then
  docker-compose scale irs=$RESOURCES
fi

# rename resources
docker ps --format "{{.Image}},{{.ID}},{{.Names}}" > psparsed.csv
perl rescnamer.pl $RESOURCES
rm psparsed.csv

# drop into interactive session

clear
docker exec -it icom bash
