#!/bin/bash

echo "Docker login"
echo "$DOCKER_PASSWORD" | docker login --username $DOCKER_USERNAME --password-stdin

