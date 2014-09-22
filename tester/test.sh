#!/bin/bash

OUTPUT=`curl -s $1`
EXPECTED_OUTPUT="Hello, world!"

GREEN='\e[0;92m'
RED='\e[0;31m'
NC='\e[0m'

if [ "$OUTPUT" == "$EXPECTED_OUTPUT" ]; then
    echo -e "${GREEN}Test succeeded!${NC}"
    exit 0
else
    echo -e "${RED}Test failed!${NC}"
    echo -e "${RED}Expected: $EXPECTED_OUTPUT${NC}"
    echo -e "${RED}Got: $OUTPUT${NC}"
    exit 1
fi