
## Deploy
- Deploy the artifact<span class="fragment"> (container image) to the Docker Hub</span>

!SUB
## Running a container
<center><div style="width: 75%; height: auto;"><img src="img/run-docker-container.png"/></div></center>


!SLIDE
## Exercises


!SUB
### Optional: push to Docker Hub
```
docker login
docker push {DOCKER_USERNAME}/go-hello-world-http-v2
```


!SUB
## running tomcat

```
# Start a tomcat container
$ DOCKER_ID=$(docker run -P -d <docker-hub-name>/tomcat7:v0.1)

# docker inspect show details about the container
$ docker inspect $DOCKER_ID

# Obtain mapped port of port 8080 of the container
$ PORT=$(docker port $DOCKER_ID 8080)

# access tomcat via mapped port
$ curl http://localhost:$PORT

# Obtain ip address of container
$ IPADDRESS=$(docker inspect -f '{{.NetworkSettings.IPAddress}}' $DOCKER_ID)

# http request on image IP address
$ curl http://$IPADDRESS:8080
```

!SUB

## creating a farm of tomcat

```
count=0
TOMCAT_IPS=""

while [ $count -lt 5 ] ; do
  DOCKER_ID=$(docker run -P –d <docker-hub-name>/tomcat7:v0.1)
  IPADDRESS=$(docker inspect -f '{{.NetworkSettings.IPAddress}}' $DOCKER_ID)
  TOMCAT_IPS="$TOMCAT_IPS $IPADDRESS"
  count=$(($count + 1))
done

echo all tomcats : $TOMCAT_IPS
```
