#!/bin/bash
echo ">>> BUILDING CONTAINER <<<"
make SOFTWARE_RELEASE_VER=$(cat package.json | grep version | cut -d '"' -f4) DOCKER_TAG=$(cat package.json | grep version | cut -d '"' -f4) build-image
echo ">>> DONE! <<<"

echo ">>> STARTING CONTAINER <<<"
make DOCKER_TAG=$(cat package.json | grep version | cut -d '"' -f4) CONTAINER_NAME=share run-container
echo ">>> DONE! <<<"
