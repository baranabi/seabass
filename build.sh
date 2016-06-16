#!/bin/bash
echo \n\n BUILDING ICAT \n\n
docker build -t seabass/icat    icat/.
echo \n\n BUILDING IES \n\n
docker build -t seabass/ies     ies/.
echo \n\n BUILDING IRS \n\n
docker build -t seabass/irs     irs/.
echo \n\n BUILDING ICOM \n\n
docker build -t seabass/icom    icom/.
