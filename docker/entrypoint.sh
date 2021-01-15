#!/bin/bash
mkdir -p config
mkdir -p logs
while read line || [[ -n ${line} ]];
do
    eval echo "$line" >> config/application.properties
done < docker/template/application.template

while read line || [[ -n ${line} ]];
do
    eval echo "$line" >> config/dbconfig.properties
done < docker/template/dbconfig.template

#sleep 1000

java -jar websocket-0.0.1-SNAPSHOT.jar
