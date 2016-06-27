#!/bin/bash


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
  echo "help option"
  exit 1
  ;;
  \?)
  echo "INVALID OPTION"
  exit 1
  ;;
  :)
  echo "required argument not found!"
  exit 1
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
