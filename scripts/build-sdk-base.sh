#!/bin/sh

if [ "$#" -ne 1 ]; then
    echo "Expected JDK version as parameter"
    exit 1
fi
OPENJDK_VERSION="$1"

echo "Build SDK base image"
docker build -t "kremi151/android-sdk-jdk${OPENJDK_VERSION}:base" --build-arg OPENJDK_VERSION="$OPENJDK_VERSION" sdk-base

