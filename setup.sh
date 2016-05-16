#!/bin/bash

echo starting ICAT container cops
docker run -d --name cops -h icat seabass/cops
echo starting IES container crods
docker run -dt -P --name crods -h crods --link cops seabass/crods
echo starting RS container cabs
docker run -dt -P --name cabs -h cabs --link crods seabass/cabs
