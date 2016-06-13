#!/bin/bash

docker-compose up -d cops crods

while [[ $# > 1 ]]
do
key="$1"

case $key in
  -r|--resources)
  RESOURCES="$2"
  docker-compose scale cabs=$RESOURCES
  shift
  ;;
  *)

  ;;
esac
shift
done

