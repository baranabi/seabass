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
docker exec -it icom bash
