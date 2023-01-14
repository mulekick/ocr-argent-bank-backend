#!/bin/bash

# start mongodb in a docker container
# map container port 27017 to host port

# variables
volume='vol-argent-bank'
db='cnt-argent-bank-db'
dbmapping='27017:27017'

# start db
if [[ $1 = 'start' ]]; then

    # create database volume
    docker volume ls | grep "$volume" || docker volume create -d local "$volume"

    # start database container (no auth)
    docker container start "$db" || docker container run -d --name "$db" -p "$dbmapping" --mount type=volume,source="$volume",target=/data mongo:latest mongod

# stop db
elif [[ $1 = 'stop' ]]; then

    # stop database container
    docker container stop "$db"

fi