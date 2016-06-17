#!/bin/bash

docker-compose up -d icat ies icom

while [[ $# > 1 ]]
do
key="$1"

case $key in
  -r|--resources)
  RESOURCES="$2"
  docker-compose scale irs=$RESOURCES
  shift
  ;;
  *)

  ;;
esac
shift
done


# generate .csv, formatted metadata from docker ps to help us rename the resources. 
docker ps --format "{{.Image}},{{.ID}},{{.Names}}" > psparsed.csv

perl rescnamer.pl

docker exec -it icom bash
