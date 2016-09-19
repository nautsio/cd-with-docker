<!-- .slide: data-background="#6B205E" -->
<center>
#Continuous Delivery

with

![Docker logo](img/docker-logo-no-text.png) <!-- .element: class="noborder" -->

**Maarten van den Ende** mvandenende@xebia.com <br />
**Simon van der Veldt** svanderveldt@xebia.com

!SLIDE
<!-- .slide: data-background="#6B205E" center -->
# Preparations

!SUB
# Install required software

Install docker for your platform
- [Linux](https://docs.docker.com/engine/installation/linux/)
- [OS X](https://docs.docker.com/engine/installation/mac/#/docker-toolbox)
- [Windows](https://docs.docker.com/toolbox/toolbox_install_windows/)

Also install git
- [Linux](https://git-scm.com/download/linux)
- [OS X](https://git-scm.com/download/mac)
- [Windows](https://git-for-windows.github.io/)

!SUB
# Verify Docker installation

Open a terminal
```bash
docker info
Containers: 6
 Running: 0
 Paused: 0
 Stopped: 6
Images: 187
Server Version: 1.12.0
...
```

!SUB
# Get the workshop files

[github.com/nautsio/cd-with-docker](https://github.com/nautsio/cd-with-docker)

```bash
git clone https://github.com/nautsio/cd-with-docker.git
cd cd-with-docker
```
