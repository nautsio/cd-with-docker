<!-- .slide: data-background="#6B205E" -->
# Deploy

!SUB
# Deployment workflow
- Store the build artifact in an artifact store <!-- .element: class="fragment" -->
- Get the build artifact from the artifact store and run it where we want it to run <!-- .element: class="fragment" -->

!SUB
## Docker hub
<div style="position: absolute; right: 0; top:100; width: 40%; height: auto;"><img src="img/docker-hub.png"/></div>
- Docker's own (public) artifact store
- Contains Docker images
  - Official/upstream images
  - Your own images
- Images can be private
- Can automatically build `Dockerfile`s


!SLIDE <!-- .slide: data-background="#6B205E" -->
<center>
## Exercise
<br>
# Push an image to the Docker Hub

!SUB
# Push your image to the Docker Hub

Create a Docker Hub account at https://hub.docker.com

```
docker login
docker push <DOCKER HUB USERNAME>/go-hello-world-http-v2
```
