#!/bin/bash

docker run -d --name cops -h icat postgres:9.3
docker run -dt -P --name crods -h crods --link cops seabass/crods
docker run -dt -P --name cabs -h cabs --link crods seabass/cabs
docker run -dt -P --name coms -h coms --link crods seabass/coms
