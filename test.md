!SLIDE
## Test
- Run tests <span class="fragment">from `tester` container</span>
- Artifact container is the System Under Test <!-- .element: class="fragment" -->

!SUB
### Build tester
`tester/Dockerfile`
```dockerfile
FROM google/golang

RUN apt-get update && apt-get install -y curl

ADD test.sh /test.sh

RUN chmod +x /test.sh

CMD /test.sh http://$SUT_PORT_80_TCP_ADDR:$SUT_PORT_80_TCP_PORT
```
```bash
docker build -t tester ./tester/
```

!SUB
### Run tests
```bash
docker run --link go-hello-world-http-v2:sut tester
```

!SUB
### Test result
The test fails :(

Make the test pass!
