#!/usr/bin/env bash

PORT=${PORT}

#clean
if  [ ! -d "_output" ]; then
  mkdir _output
fi
rm -rf ./_output/debug
mkdir ./_output/debug

go build -o ./_output/debug/neuron-agent .

ENV=DEV \
PORT=${PORT} \
DB="root:123456@tcp(127.0.0.1:3307)" \
./_output/debug/neuron-agent

