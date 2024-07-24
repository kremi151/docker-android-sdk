#!/bin/sh

if [ "$#" -ne 1 ]; then
    echo "Expected JDK version as parameter"
    exit 1
fi
OPENJDK_VERSION="$1"

echo "Load .env"
. .env

echo "Build NDK base image"
docker build -t "kremi151/android-ndk:base-jdk${OPENJDK_VERSION}" \
    --build-arg OPENJDK_VERSION="$OPENJDK_VERSION" \
    --build-arg CMAKE_VERSION="$CMAKE_VERSION" \
    --build-arg NINJA_VERSION="$NINJA_VERSION" \
    ndk-base
