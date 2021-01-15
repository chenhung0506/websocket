
# run in local
```
cd app && mvn clean && mvn package && java -jar ./target/websocket-0.0.1-SNAPSHOT.jar
```
# run in docker
## build image 
```
./docker/build.sh
```
## run image
```
docker run -d --name websocket -p 8080:8080 chenhung0506/chat:$(docker images | grep chenhung0506/chat | awk 'NR==1{print$2}')
```