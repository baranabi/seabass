#!/bin/bash

docker run -d --name cops -h icat bascibaran/cops
docker run -it --name crods -h crods --link cops bascibaran/crods
