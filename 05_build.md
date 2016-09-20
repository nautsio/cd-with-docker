<!-- .slide: data-background="#6B205E" -->
<center>
# Build

!SUB
## Docker Images

<div style="position: absolute; right: 0; top:100; width: 25%; height: auto;"><img src="img/docker-image.png"/></div>
- Contain everything needed to run the app
- Are portable across daemons
- Are created using a simple DSL
- Can be shared by pushing them to an artifact store

!SUB
## Docker Image Layers

!SUB
## Filesystems
<center>
<p>
		Linux requires two filesystems<br/>
<img src="img/docker-filesystems-generic.png" style="width: 50%; height: 50%;" />
</p>
</center>


!SUB
## Multiple rootfs
<center>
<p>
		Docker supports multiple rootfs<br/>
<img src="img/docker-filesystems-multiroot.png" style="width: 50%; height: 50%;" />
</p>
</center>


!SUB
## Docker Image
<center>
<p>
		Read-only layers are called images<br/>
<img src="img/docker-filesystems-debian.png" style="width: 50%; height: 50%;" />
</p>
</center>


!SUB
## Stacking images
<center>
<p>
		Images can depend on other images, called parents<br/>
<img src="img/docker-filesystems-multilayer.png" style="width: 50%; height: 50%;" />
</p>
</center>


!SUB
## Writable containers
<center>
<p>
		On top of images docker creates writable containers<br/>
<img src="img/docker-filesystems-busyboxrw.png" style="width: 50%; height: 50%;" />
</p>
</center>


!SLIDE <!-- .slide: data-background="#6B205E" -->
<center>
# Build exercise: Building an image

!SUB
# Build the application
```bash
$ docker run -ti google/golang bash
root@1cb333018404:/go#
# Now we're inside the container!

# Build the application
root@1cb333018404:/go# go get github.com/simonvanderveldt/go-hello-world-http

# Exit the container
root@1cb333018404:/go# exit
# Now we're outside the container again
```

!SUB
# Layers advantage: track what's changed
```bash
# Show the last container that was created
$ docker ps -l
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS                      PORTS               NAMES
1cb333018404        golang              "bash"              3 minutes ago       Exited (0) 13 seconds ago                       clever_fermi

# Show our changes
$ docker d diff <CONTAINER ID>
C /go
C /go/bin
A /go/bin/go-hello-world-http
C /go/src
A /go/src/github.com
A /go/src/github.com/simonvanderveldt
A /go/src/github.com/simonvanderveldt/go-hello-world-http
A /go/src/github.com/simonvanderveldt/go-hello-world-http/.git
...
```

!SUB
# Create the image
```bash
# Now create an image from our container
$ docker commit <CONTAINER ID> go-hello-world-http
sha256:34d091010050c9e94de643af60b4196dc132ad6f20825d779ab70bccf1f732b0

# Verify the image was created
$ docker images
REPOSITORY                           TAG                 IMAGE ID            CREATED             SIZE
go-hello-world-http                  latest              34d091010050        14 seconds ago      675.4 MB
```

!SUB
# Create a container from the image
```bash
$ docker run -d -p 80:80 go-hello-world-http /go/bin/go-hello-world-http

# Check that the container is running
$ docker ps
CONTAINER ID        IMAGE                 COMMAND                  CREATED              STATUS              PORTS                NAMES
491462e89e35        go-hello-world-http   "/go/bin/go-hello-wor"   About a minute ago   Up About a minute   0.0.0.0:80->80/tcp   admiring_spence

# Check if the application works
$ curl 192.168.99.100
> Hello, world!
```

!SUB
# Cleanup
```bash
# Stop the container
$ docker stop <CONTAINER ID>

# Check that the container is no longer running
$ docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
```

!SUB
# Cleanup part 2
Stopped containers are not automatically removed!

```bash
# Check that the container actually still exists
$ docker ps -a
CONTAINER ID        IMAGE                 COMMAND                  CREATED              STATUS              PORTS                NAMES
491462e89e35        go-hello-world-http   "/go/bin/go-hello-wor"   About a minute ago   Up About a minute   0.0.0.0:80->80/tcp   admiring_spence

# Remove the container
$ docker rm <CONTAINER ID>

# Check that the container no longer exists
$ docker ps -a
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS                    PORTS               NAMES
```

!SUB
# Check
What have we done thus far?

What can we improve? <!-- .element: class="fragment" -->

!SUB
# Dockerfile

!SLIDE
!SUB
<center>
## How to build an image?

!SUB
## Dockerfile

<p>Simple format</p>

```
# Comment
INSTRUCTION arguments
```

<p style="clear: both;"><br/>See <a href="https://docs.docker.com/engine/reference/builder/">https://docs.docker.com/engine/reference/builder/</a></p>

!SUB
## Instructions
- FROM
- COPY
- RUN
- CMD
- EXPOSE
- ENV
- And more

!SUB
## FROM
- Syntax: `FROM <image>:<tag>`
- Sets the base image for this image
- FROM must be the first non-comment instruction in the Dockerfile

!SUB
## COPY
- Syntax:
  - `COPY <source> <destination>`
  - `COPY ["<source>", "<destination>"]`
- Copies files from the local machine into the image

!SUB
## RUN
- Syntax: `RUN <command>`
- Runs the specified command, and commits the result to the image
- RUN can be used multiple times

!SUB
## CMD
- Syntax:
  - `CMD command param1 param2`
  - `CMD ["executable", "param1", "param2"]`
- Provides defaults when executing a container
- CMD can only be used *one* time

!SUB
## EXPOSE
- Syntax: `EXPOSE <port>`
- Defines which ports to expose

!SUB
## ENV
- Syntax: `<key> <value>`
- Sets environment variables in the image

!SUB
# Build using Dockerfile
`go-hello-world-http/Dockerfile`
```dockerfile
FROM google/golang

ENV GOPATH /gopath

WORKDIR /gopath

RUN git clone https://github.com/simonvanderveldt/go-hello-world-http /gopath/src

RUN go build go-hello-world-http
```

!SUB
# Build and run image
```bash
docker build -t go-hello-world-http ./go-hello-world-http
docker run -d -p 80:80 go-hello-world-http /gopath/go-hello-world-http
```

!SUB
# Check
What can we improve?
```
docker images | grep go-hello-world-http
> go-hello-world-http latest d31a90b28d50 2 minutes ago 565.3 MB
```

!SUB
# Getting rid of our build-time tools
We don't need them during run-time


Solution: 2 Dockerfiles <!-- .element: class="fragment" -->

- Generic builder <!-- .element: class="fragment" -->
- Application <!-- .element: class="fragment" -->

!SUB
## Generic builder
`builder/Dockerfile`
```dockerfile
FROM google/golang

ENV GOPATH /gopath

WORKDIR /gopath

ENTRYPOINT ["go", "build"]

CMD ["."]
```

```
docker build -t builder ./builder
```

!SUB
# Build the application
```bash
git clone https://github.com/simonvanderveldt/go-hello-world-http /home/docker/cd-with-docker/go-hello-world-http-v2/src
docker run --rm --volume /home/docker/cd-with-docker/go-hello-world-http-v2/:/gopath builder go-hello-world-http
```
Build artifact is now available at

`/home/docker/cd-with-docker/go-hello-world-http-v2`

!SUB
# Application
`go-hello-world-http-v2/Dockerfile`
```dockerfile
FROM busybox:ubuntu-14.04

EXPOSE 80

ADD go-hello-world-http /go-hello-world-http

ENTRYPOINT /go-hello-world-http
```
```bash
docker build -t go-hello-world-http-v2 ./go-hello-world-http-v2
docker run -d -p 80:80 --name go-hello-world-http-v2 go-hello-world-http-v2
```

!SUB
# Result
```
docker images | grep hello-world-http-v2
> go-hello-world-http-v2 latest 903b479cd26c 2 minutes ago 11.3 MB
```
