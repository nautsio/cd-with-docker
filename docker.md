![Docker logo](img/docker-logo.png) <!-- .element: class="noborder" -->

!SUB
## What is Docker?
Docker is an open platform for developers and sysadmins to build, ship, and run distributed applications.

_[docker.com](https://www.docker.com)_


- Container management for Linux
- Abstraction for DevOps workflow
- Adds images, image repository and version control to containers

!SUB
## Docker, the goodies

You get all the goodies of virtual machine per appliance, but without the cost.

- Filesystem isolation
- Resource isolation
- Network isolation

And it is fast!

!SUB
## Docker features

- Docker engine
- Dockerfiles
- Docker hub


!SUB
## Why Docker?


!SUB
## Docker has taken the world by Storm!

- 400.000.000 downloads
- 300.000+ Dockerized applications
- 50.000+ third party projects on Github
- 150.000.000 dollar in funding

!SUB
## Why? It Supports True DevOps!
<center><div style="width: 75%; height: auto;"><img src="img/true-devops.jpg"/></div></center>


!SUB
## Separation of Concerns
<center><div style="width: 75%; height: auto;"><img src="img/devops-concerns.png"/></div></center>



!SLIDE
![Docker logo](img/docker-logo-no-text.png) <!-- .element: class="noborder" -->
## Exercises

!SUB
## Getting Started

```
# Show all running containers
$ docker ps
CONTAINER ID        IMAGE                                     COMMAND                  CREATED             STATUS              PORTS                                              NAMES
```


!SUB
## Run a container
```
$ docker run debian /bin/echo "hello world"
Unable to find image 'debian:latest' locally
latest: Pulling from library/debian
8ad8b3f87b37: Already exists
Digest: sha256:2340a704d1f8f9ecb51c24d9cbce9f5ecd301b6b8ea1ca5eaba9edee46a2436d
Status: Downloaded newer image for debian:latest
hello world
```


!SUB
## Run an interactive container
```
$ docker run -ti debian
root@d83aa96f567a:/# whoami
root

root@d83aa96f567a:/# uname -a
Linux d83aa96f567a 4.4.16-boot2docker #1 SMP Fri Jul 29 00:13:24 UTC 2016 x86_64 GNU/Linux

root@d83aa96f567a:/# docker ps
bash: docker: command not found

root@d83aa96f567a:/# exit
```
