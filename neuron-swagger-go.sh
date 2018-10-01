#!/usr/bin/env bash

rm -rf ./gen/
mkdir gen

swagger generate server --exclude-main -f swagger.json -t ./gen/