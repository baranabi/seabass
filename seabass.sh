#!/bin/bash
export SEABASS_MOUNT_PATH=`pwd`

# parse options
while [[ $# > 1 ]]
do
key="$1"

case $key in
  -r|--resources)
  RESOURCES="$2"
  shift
  ;;
  -v|--volumes)
  export SEABASS_MOUNT_PATH="$2"
  shift
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
perl rescnamer.pl
rm psparsed.csv

# drop into interactive session
docker exec -it icom bash
