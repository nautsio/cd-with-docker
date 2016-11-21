<!-- .slide: data-background="#6B205E" -->
# Test

!SUB
# Test workflow
- Run the tests <!-- .element: class="fragment" --> <span class="fragment">-> with a "tester" container</span>
- Run them against the artifact we built <!-- .element: class="fragment" --> <span class="fragment"> -> our Docker image</span>

!SUB
# Build tester
`tester/Dockerfile`
```dockerfile
FROM golang

RUN apt-get update && apt-get install -y curl

COPY test.sh /test.sh

CMD /test.sh http://$SUT_PORT_80_TCP_ADDR:$SUT_PORT_80_TCP_PORT
```

```bash
docker build -t tester ./tester/
```

!SUB
# Run tests
```bash
docker run --link go-hello-world-http-v3:sut tester
Test succeeded!
```
