# Extra exercises

!SUB
## Miniaturize the image
We don't need build-time tools during run-time

!SUB
### Extract the artifacts using a volume
```
docker run --rm -v /home/vagrant/buildenv:/gopath builder-go go build -v go-hello-world-http
```

!SUB
## Pipeline-in-a-box
We want to be host-agnostic

Run the Continuous Delivery Pipeline as a container itself
