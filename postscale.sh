#!/bin/bash


RESOURCES=$1
docker ps --format "{{.Image}},{{.ID}},{{.Names}}" > psparsed.csv
perl rescnamer.pl $RESOURCES
rm psparsed.csv
