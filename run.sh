#!/usr/bin/env bash

docker build . -t go-gin
docker run -i -t -p 8080:8080 go-gin