#!/bin/bash

echo stopping containers
docker stop cops crods cabs
echo removing containers
docker rm cops crods cabs
