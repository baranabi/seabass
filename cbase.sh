#!/bin/bash

docker run -d --name cops -h icat bascibaran/cops
docker run -dt -P --name crods -h crods --link cops bascibaran/crods
docker run -dt -P --name cabs -h cabs --link crods bascibaran/cabs