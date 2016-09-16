<!-- .slide: data-background="#6B205E" -->
# Build

!SUB
# Workflow
- Get sources
- Compile sources <span class="fragment">in `builder` container</span>
- The container image is the artifact <!-- .element: class="fragment" -->

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

<ul>
<li>FROM</li>
<li>MAINTAINER</li>
<li>RUN</li>
<li>CMD</li>
<li>EXPOSE</li>
<li>ENTRYPOINT</li>
<li>ENV</li>
<li>ADD</li>
<li>VOLUME</li>
<li>USER</li>
<li>WORKDIR</li>
</ul>



!SUB
## FROM

<center>
<ul>
<li>Syntax: FROM &lt;image&gt;[:&lt;tag&gt;]</li>
<li>Sets the base image for this image</li>
<li>FROM must be the first non-comment instruction in the Dockerfile.</li>
<li>Can appear multiple times to create multiple images</li>
</ul>
</center>


!SUB
## RUN

<center>
<ul>
<li>Syntax: RUN &lt;command&gt;</li>
<li>Runs the specified command, and commits the result to the image</li>
<li>RUN can be used multiple times</li>
<center>
</ul>
</center>

!SUB
## CMD

<center>
<ul>
<li>Syntax:
<ul>
<li>CMD ["executable","param1","param2"]</li>
<li>CMD ["param1","param2"], use with <code>ENTRYPOINT</li>
<li>CMD command param1 param2</li>
</ul>
</li>
<li>Provides defaults when executing a container</li>
<li>CMD can only be used <em>one</em> time</li>
</ul>
</center>


!SUB
## ENTRYPOINT

<center>
<ul>
<li>Syntax:
<ul>
<li>ENTRYPOINT ["executable","param1","param2"]</li>
<li>ENTRYPOINT command param1 param2</li>
</ul>
</li>
<li>Similar as CMD, but cannot be overwritten with command-line parameters</li>
<li>ENTRYPOINT can only be used <em>one</em> time</li>
</ul>
</center>


!SUB
## EXPOSE

<center>
<ul>
<li>Syntax: EXPOSE &lt;port&gt; [&lt;port&gt; ...]</li>
<li>Defines which ports to expose</li>
</ul>
</center>


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



!SUB
# Creating a Docker image
<center><div style="width: 75%; height: auto;"><img src="img/create-docker-image.png"/></div></center>

!SUB
# Dockerfile

```
FROM ubuntu
RUN apt-get update && apt-get install -y apache2 && apt-get clean
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
EXPOSE 80
CMD ["/usr/sbin/apache2", "-D", "FOREGROUND"]
```

!SUB
## Docker Images

<div style="position: absolute; right: 0; top:100; width: 25%; height: auto;"><img src="img/docker-image.png"/></div>
- contain everything needed to run the app
- are portable across daemons
- have built in layers
  - ordered to actions, Add file, Expose port, Run
- are stored in a Registry

!SUB
## Docker Hub - Image Registry
<div style="position: absolute; right: 0; top:100; width: 40%; height: auto;"><img src="img/docker-hub.png"/></div>
- Contains Docker images
- Public Registry with official images
- Can host your own private Registry

!SUB
# First build
```bash
docker run -ti google/golang bash
```
inside the container:
```bash
cd /gopath
git clone https://github.com/simonvanderveldt/go-hello-world-http /gopath/src
go build go-hello-world-http
exit
```

!SUB
# Create and run image
```bash
docker ps -l
docker commit {CONTAINER ID} go-hello-world-http
docker images #go-hello-world-http image is visible
docker run -d -p 80:80 go-hello-world-http /gopath/go-hello-world-http
```

!SUB
# Does it work?
```bash
curl localhost
> Hello, world!
```

```bash  
# Stop the container
docker kill {CONTAINER ID}
```

!SUB
# Check
What have we done thus far?

What can we improve? <!-- .element: class="fragment" -->

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
