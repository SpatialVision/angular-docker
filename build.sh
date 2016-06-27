#!/bin/bash
source env.sh
echo "Building to $IMAGE_TAG"
docker build -t $IMAGE_TAG -f Dockerfile .
