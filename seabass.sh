#!/bin/bash
export SEABASS_MOUNT_PATH=`pwd`

# parse options
while [[ $# -ge  1 ]]
do
key="$1"

case $key in
  -r|--resources)
  RESOURCES="$2"
  shift
  ;;
  -m|--mount)
  export SEABASS_MOUNT_PATH="$2"
  shift
  ;;
  -v|--version)
  cat VERSION
  exit 0  
  ;;
  *)

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
