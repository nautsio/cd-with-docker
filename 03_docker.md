<!-- .slide: data-background="#6B205E" -->
<center>
# Docker

![Docker logo](img/docker-logo-no-text.png) <!-- .element: class="noborder" -->

!SUB
## What's Docker?

> Docker is the world's leading&nbsp; software containerization platform

_[docker.com](https://www.docker.com)_

!SUB
## But what is it really?

- Process running in isolation (filesystem, resources, networking, user)
- Images you can share/reuse
- Simple DSL to describe how to build images
- Artifact store to share images


!SUB
# Docker has taken the world by Storm!

- 400.000.000 downloads
- 300.000+ Dockerized applications
- 50.000+ third party projects on Github
- 150.000.000 dollar in funding

!SUB
# Why? It Supports True DevOps!
<br />
<center><div style="width: 75%; height: auto;"><img src="img/true-devops.jpg"/></div></center>


!SUB
# Separation of Concerns
<br />
<center><div style="width: 75%; height: auto;"><img src="img/devops-concerns.png"/></div></center>


!SLIDE
<!-- .slide: data-background="#6B205E" -->
<center>
## Exercise
<br>
# Docker first steps

!SUB
## Getting Started

```
# Show Docker help text to list all possible commands
$ docker
Usage: docker [OPTIONS] COMMAND [arg...]
       docker [ --help | -v | --version ]

A self-sufficient runtime for containers.

Options:

  --config=~/.docker              Location of client config files
  -D, --debug                     Enable debug mode
  -H, --host=[]                   Daemon socket(s) to connect to
  -h, --help                      Print usage
  -l, --log-level=info            Set the logging level
  --tls                           Use TLS; implied by --tlsverify
  --tlscacert=~/.docker/ca.pem    Trust certs signed only by this CA
  --tlscert=~/.docker/cert.pem    Path to TLS certificate file
  --tlskey=~/.docker/key.pem      Path to TLS key file
  --tlsverify                     Use TLS and verify the remote
  -v, --version                   Print version information and quit

Commands:
    attach    Attach to a running container
    build     Build an image from a Dockerfile
    commit    Create a new image from a container's changes
...
```

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
