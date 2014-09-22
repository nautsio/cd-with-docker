# Continuous Delivery Pipeline
![Continuous Deployment Pipeline](img/continuous-deployment-pipeline.png) <!-- .element: class="noborder" -->

!SLIDE
![Docker logo](img/docker-logo.png) <!-- .element: class="noborder" -->

!SUB
## Docker introduction
A portable, lightweight application runtime and packaging tool.

_[docker.com](https://www.docker.com)_

!SUB
## Docker features

- Docker engine
- Dockerfiles
- Docker hub


!SLIDE
# Docker advantages
for
# Continuous Delivery

!SUB
## Faster
- Containers are fast!
- Slow one-time event happen only once on image creation not on instance creation

!NOTE
One-time example initialisation of the app has to happen just once. Fort example for test and production, same artifact is started which had it's initialization done @ build time

!SUB
## Better
- Isolation
- Scalability
- Consistent/reproducible results
- Portable/host-independent
- Infrastructure as code
- Immutable infrastructure
- Chaos monkey/gorilla

!SUB
## Cheaper
- Less overhead


!SLIDE
# Continuous Delivery Pipeline
with

![Docker logo](img/docker-logo-no-text.png) <!-- .element: class="noborder" -->


!SLIDE
## Code
- Develop
- Commit
- Post-commit hook triggers new "delivery"


!SLIDE
## Build
- Get sources
- Compile sources <span class="fragment">in `builder` container</span>
- The container image is the artifact <!-- .element: class="fragment" -->

!SUB
### Builder
As builder we use the de-facto container for a language

In this case `google/golang`

!SUB
### First build
```
docker run -ti google/golang bash
```

```
git clone https://github.com/simonvanderveldt/go-hello-world-http /gopath/src
cd /gopath
go build go-hello-world-http
```

!SUB
### Create image
```
docker ps -l
docker commit {CONTAINER ID} go-hello-world-http
```

!SUB
### Run image
```
docker run -ti go-hello-world-http /gopath/go-hello-world-http
```

!SUB
### Build using Dockerfile
`Dockerfile`
```
FROM google/golang

WORKDIR /gopath

ADD ./buildenv /gopath

RUN go build go-hello-world-http
```

!SUB
### Build image
```
git clone https://github.com/simonvanderveldt/go-hello-world-http ./buildenv/src
docker build -t go-hello-world-http .
```

!SUB
### Run image
```
docker run -ti go-hello-world-http /gopath/go-hello-world-http
```


!SLIDE
## Test
- Run tests <span class="fragment">from `tester` container</span>
- Artifact container is the System Under Test <!-- .element: class="fragment" -->

!SUB
### Build tester
`Dockerfile`
```
FROM google/golang

RUN apt-get update && apt-get install -y curl

ADD test.sh /test.sh

CMD /test.sh http://$SUT_PORT_80_TCP_ADDR:$SUT_PORT_80_TCP_PORT
```
```
docker build -t tester ./tester/
```

!SUB
### Run Sytem Under Test
```
docker run -d -p 80:80 --name sut go-hello-world-http /gopath/go-hello-world-http
```

!SUB
### Run tests
```
docker run --link sut:sut 
```


!SLIDE
## Deploy
- Deploy the artifact<span class="fragment"> (container image) to the Docker registry</span>
