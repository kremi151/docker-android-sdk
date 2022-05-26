#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Expected JDK version as parameter"
    exit 1
fi
OPENJDK_VERSION="$1"

while read p; do
  if [[ $p != android-* ]]; then
    continue
  fi
  ANDROID_PLATFORM=$(echo "$p" | cut -d, -f 1)
  BUILD_TOOLS=$(echo "$p" | cut -d, -f 2)

  echo "Build SDK image for $ANDROID_PLATFORM"
  docker build -t "kremi151/android-sdk:${ANDROID_PLATFORM}-jdk$OPENJDK_VERSION" --build-arg OPENJDK_VERSION="$OPENJDK_VERSION" --build-arg ANDROID_PLATFORM_VERSION=$ANDROID_PLATFORM --build-arg ANDROID_BUILD_TOOLS_VERSION=$BUILD_TOOLS sdk-platform

  echo "Build NDK image for $ANDROID_PLATFORM"
  docker build -t "kremi151/android-ndk:${ANDROID_PLATFORM}-jdk$OPENJDK_VERSION" --build-arg OPENJDK_VERSION="$OPENJDK_VERSION" --build-arg ANDROID_PLATFORM_VERSION=$ANDROID_PLATFORM --build-arg ANDROID_BUILD_TOOLS_VERSION=$BUILD_TOOLS ndk-platform

done <images.csv
