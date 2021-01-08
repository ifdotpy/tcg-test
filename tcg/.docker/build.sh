#!/bin/bash

set -e
set -u
set -x

docker build \
  -t iflead/tcg:"$VERSION" \
  -t iflead/tcg:latest \
  -f tcg/.docker/production/Dockerfile \
  --build-arg VERSION="$VERSION" tcg
