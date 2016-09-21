<!-- .slide: data-background="#6B205E" -->
<center>
# Build

!SUB
## Build workflow
- Get the application sources <!-- .element: class="fragment" -->
- Build the application/artifact <!-- .element: class="fragment" --> <span class="fragment">-> The Docker image is the artifact</span>

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
## Exercise
<br>
#Building an image

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

# See what happened in each layer that our image exists of
$ docker history go-hello-world-http
IMAGE               CREATED             CREATED BY                                      SIZE                COMMENT
62484befa0e3        10 seconds ago      bash                                            5.708 MB
002b233310bb        12 days ago         /bin/sh -c #(nop) COPY file:f6191f2c86edc9343   2.478 kB
<missing>           12 days ago         /bin/sh -c #(nop)  WORKDIR /go                  0 B
<missing>           12 days ago         /bin/sh -c mkdir -p "$GOPATH/src" "$GOPATH/bi   0 B
...
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
# Proper cleanup
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

What can we improve?
- Automate the steps to build the image <!-- .element: class="fragment" -->


!SLIDE
<!-- .slide: data-background="#6B205E" -->
<center>
# Dockerfile

!SUB
## Dockerfile
Simple DSL to describe how to build an image</p>

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


!SLIDE
<!-- .slide: data-background="#6B205E" -->
<center>
## Exercise
<br>
# Building an image using a Dockerfile

!SUB
## Dockerfile

`go-hello-world-http-v1/Dockerfile`
```dockerfile
FROM golang

RUN go get github.com/simonvanderveldt/go-hello-world-http
```

!SUB
# Build and run the image
```bash
$ docker build -t go-hello-world-http go-hello-world-http-v1
Sending build context to Docker daemon 2.048 kB
Step 1 : FROM golang
 ---> 002b233310bb
Step 2 : RUN go get github.com/simonvanderveldt/go-hello-world-http
 ---> Running in 1c4e7bf0833e
 ---> 8db642e96eed
Removing intermediate container 1c4e7bf0833e
Successfully built 8db642e96eed

# See what happened in each layer that our image exists of
$ docker history go-hello-world-http
IMAGE               CREATED             CREATED BY                                      SIZE                COMMENT
91a8a211556f        13 minutes ago      /bin/sh -c #(nop)  EXPOSE 80/tcp                0 B
de2c1fef8d39        51 minutes ago      /bin/sh -c #(nop)  CMD ["/bin/sh" "-c" "/go/b   0 B
8db642e96eed        55 minutes ago      /bin/sh -c go get github.com/simonvanderveldt   5.708 MB
002b233310bb        12 days ago         /bin/sh -c #(nop)  COPY file:f6191f2c86edc9343  2.478 kB
<missing>           12 days ago         /bin/sh -c #(nop)  WORKDIR /go                  0 B

$ docker run -d -p 80:80 go-hello-world-http /go/bin/go-hello-world-http
8ce667efcb4b2d785b4805987b798130998d65e4c75daa7a60b354e04b314005
```

!SUB
# Check
What have we done thus far?

What can we improve?
- Automatically start our application when we run the container <!-- .element: class="fragment" -->
- Declare on which port our application runs <!-- .element: class="fragment" -->

!SUB
## Enhanced Dockerfile
`go-hello-world-http-v2/Dockerfile`
```dockerfile
FROM golang

RUN go get github.com/simonvanderveldt/go-hello-world-http

CMD /go/bin/go-hello-world-http
EXPOSE 80
```

!SUB
# Build and run the enhanced image
```
$ docker build -t go-hello-world-http go-hello-world-http-v2
Sending build context to Docker daemon 2.048 kB
Step 1 : FROM golang
 ---> 002b233310bb
Step 2 : RUN go get github.com/simonvanderveldt/go-hello-world-http
 ---> Using cache
 ---> 8db642e96eed
Step 3 : CMD /go/bin/go-hello-world-http
 ---> Running in 804dd7261841
 ---> de2c1fef8d39
Step 4 : EXPOSE 80
 ---> Running in 20a26363a989
 ---> 91a8a211556f
Removing intermediate container 20a26363a989
Successfully built 91a8a211556f

$ docker run -d -P go-hello-world-http-v2
3f0b7f4f2a92d7165a832c23f2bf3a1b675f18c4ac6c2a4b1e6ccefed310237f

$ docker ps
CONTAINER ID        IMAGE                   COMMAND                  CREATED             STATUS              PORTS                   NAMES
cc245603ef5c        go-hello-world-http-v2  "/bin/sh -c /go/bin/g"   3 seconds ago       Up 2 seconds        0.0.0.0:32768->80/tcp   desperate_jones
```

!SUB
# Check
What have we done thus far?

What can we improve?
```
docker images | grep go-hello-world-http-v2
> go-hello-world-http-v2 latest d31a90b28d50 2 minutes ago 675.3 MB
```
<!-- .element: class="fragment" -->
Get rid of the build tools.
<br>We don't need/want them during run-time <!-- .element: class="fragment" -->

!SUB
# Getting rid of build tools in our image
Solution: <span class="fragment">2 images</span>
- Builder <!-- .element: class="fragment" -->
- Application <!-- .element: class="fragment" -->

!SUB
## Builder image
`builder/Dockerfile`
```dockerfile
FROM golang

ENTRYPOINT ["go", "build"]

CMD ["."]
```

```bash
$ build -t builder builder
...
Successfully built 0dede3ca803b
```

!SUB
# Build the application using the builder image
```bash
# Get the sources
$ git clone https://github.com/simonvanderveldt/go-hello-world-http go-hello-world-http-v3/go-hello-world-http
Cloning into '/Users/simon/go-hello-world-http'...
...

# Build the application using the builder image
$ cd go-hello-world-http-v3
$ docker run --rm --volume $(pwd)/go-hello-world-http:/go/src/go-hello-world-http --volume $(pwd)/build:/go builder go-hello-world-http

# We now have a built application
$ ls -hl build/go-hello-world-http
-rwxr-xr-x  1 simon  staff   5.4M Sep 20 22:13 build/go-hello-world-http
```

!SUB
# Application image
`go-hello-world-http-v3/Dockerfile`
```dockerfile
FROM debian

COPY build/go-hello-world-http /go-hello-world-http

CMD /go-hello-world-http
EXPOSE 80
```

```bash
# Build the application image
docker build -t go-hello-world-http-v3 .

# Run the application image
docker run -d -p 80:80 go-hello-world-http-v3
```

!SUB
# Result
```bash
docker images | grep hello-world-http-v3
> go-hello-world-http-v2  latest  5db0534216f3  58 seconds ago  130.8 MB
```
