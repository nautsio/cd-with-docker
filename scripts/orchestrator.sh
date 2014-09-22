#!/bin/sh

GREEN='\e[0;92m'
RED='\e[0;31m'
NC='\e[0m'

check_output () {
  if [[ $1 != 0 ]]; then
      echo "Phase failed!"
      echo -e "${RED}$2${NC}"
      cleanup
      exit 1
  else
      echo -e "${GREEN}$2${NC}"
  fi
}


build () {
  # Build the artifact
  echo "Starting build phase"
  OUTPUT=`docker run --rm -v /home/docker/buildenv:/buildenv builder-go go-hello-world-http`
  check_output $? "$OUTPUT"
}


run () {
  echo "Starting run phase"
  STARTRUNNER=`docker run -d --name runner -v /home/docker/buildenv:/buildenv -p 80:80 runner`
  check_output $? "$STARTRUNNER"
}


test () {
  echo "Starting test phase"

  TESTER=`docker run --rm --link runner:sut tester`
  check_output $? "$TESTER"
}


deploy () {
  # Deploy the container
  echo "Starting deployment phase"
}


cleanup () {
  docker kill runner >/dev/null
  docker rm runner >/dev/null
}



build
run
test
deploy

echo "All phases succeeded!"
cleanup