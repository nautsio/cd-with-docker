<!-- .slide: data-background="#6B205E" -->
# Docker

<center>
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
# Docker features

- Docker engine
- Dockerfiles
- Docker hub


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

!SUB
## Docker commands
<center>
<ul>
<li>Runtime</li>
<li>Information</li>
<li>Filesystem</li>
<li>Images</li>
<li>Repository</li>
</ul>
</center>

!SUB
## Runtime
<center>
<table>
<tbody>
<tr>
<td>ps</td>
<td>List containers</td>
</tr>
<tr>
<td>kill</td>
<td>Kill a running container</td>
</tr>
<tr>
<td>restart</td>
<td>Restart a running container</td>
</tr>
<tr>
<td>rm</td>
<td>Remove a container</td>
</tr>
<tr>
<td>run</td>
<td>Run a command in a new container</td>
</tr>
<tr>
<td>start</td>
<td>Start a stopped container</td>
</tr>
<tr>
<td>stop</td>
<td>Stop a running container</td>
</tr>
<tr>
<td>wait</td>
<td>Block until a container stops, then print its exit code</td>
</tr>
</tbody>
</table>
</center>

!SUB
## Information
<center>
<table>
<tbody>
<tr>
<td>info</td>
<td>Display system-wide information</td>
</tr>
<tr>
<td>inspect</td>
<td>Return low-level information on a container</td>
</tr>
<tr>
<td>logs</td>
<td>Fetch the logs of a container</td>
</tr>
<tr>
<td>port</td>
<td>Lookup the public-facing port which is NAT-ed to PRIVATE_PORT</td>
</tr>
<tr>
<td>attach</td>
<td>Attach to a running container</td>
</tr>
</tbody>
</table>
</center>

!SUB
## Filesystems
<center>
<table>
<tbody>
<tr>
<td>insert</td>
<td>Insert a file in an image</td>
</tr>
<tr>
<td>diff</td>
<td>Inspect changes on a container's filesystem</td>
</tr>
<tr>
<td>commit</td>
<td>Create a new image from a container's changes</td>
</tr>
</tbody>
</table>
</center>

!SUB
## Images
<center>
<table>
<tbody>
<tr>
<td>build</td>
<td>Build a container from a Dockerfile</td>
</tr>
<tr>
<td>import</td>
<td>Create a new filesystem image from the contents of a tarball</td>
</tr>
<tr>
<td>export</td>
<td>Stream the contents of a container as a tar archive</td>
</tr>
<tr>
<td>images</td>
<td>List images</td>
</tr>
<tr>
<td>rmi</td>
<td>Remove an image</td>
</tr>
<tr>
<td>history</td>
<td>Show the history of an image</td>
</tr>
</tbody>
</table>
</center>

!SUB
## Repository
<center>
<table>
<tbody>
<tr>
<td>login</td>
<td>Register or Login to the docker registry server</td>
</tr>
<tr>
<td>pull</td>
<td>Pull an image or a repository from the docker registry server</td>
</tr>
<tr>
<td>push</td>
<td>Push an image or a repository to the docker registry server</td>
</tr>
<tr>
<td>search</td>
<td>Search for an image in the docker index</td>
</tr>
<tr>
<td>tag</td>
<td>Tag an image into a repository</td>
</tr>
</tbody>
</table>
</center>

!SLIDE
<!-- .slide: data-background="#6B205E" -->
# Exercises: Docker

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
