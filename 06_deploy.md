<!-- .slide: data-background="#6B205E" -->
# Deploy

!SUB
# Deployment workflow
- Deploy the artifact<span class="fragment"> (container image) to the Docker Hub</span>

!SUB
## Docker Hub - Image Registry
<div style="position: absolute; right: 0; top:100; width: 40%; height: auto;"><img src="img/docker-hub.png"/></div>
- Contains Docker images
- Public Registry with official images
- Can host your own private Registry

!SUB
# Running a container
<br />
<center><div style="width: 75%; height: auto;"><img src="img/run-docker-container.png"/></div></center>

!SLIDE
<!-- .slide: data-background="#6B205E" -->
# Exercises: Deploy with Docker

!SUB
# Optional: push to Docker Hub
```
docker login
docker push {DOCKER_USERNAME}/go-hello-world-http-v2
```
