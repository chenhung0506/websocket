#!/bin/bash
REPO=chenhung0506
CONTAINER=chat
TAG=$(git rev-parse --short HEAD)-$(date '+%Y%m%d-%H%M') 
# DOCKER_IMAGE=$REPO/$CONTAINER:$TAG
DOCKER_IMAGE=$REPO/$CONTAINER:$TAG

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

BUILDROOT=$DIR/../
echo $BUILDROOT

#cmd="cd ../ && mvn clean && mvn package -DskipTests -U"
#bash -c "$cmd"

cmd="docker build \
  -t $DOCKER_IMAGE \
  -f $DIR/Dockerfile \
  $BUILDROOT"
echo $cmd
eval $cmd
