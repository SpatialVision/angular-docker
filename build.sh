#!/bin/bash
: ${TARGET_ENV?"Need to set TARGET_ENV e.g. TARGET_ENV=node0-10 TARGET_ENV=node6"}

source env-$TARGET_ENV.sh

echo "Building to $IMAGE_TAG using $DOCKER_FILE"
docker build -t $IMAGE_TAG -f $DOCKER_FILE .
