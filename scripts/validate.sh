#!/bin/bash

echo "Extract versions from Dockerfiles"
CMAKE_VERSION=$(cat ndk-base/Dockerfile | grep -oP 'ENV CMAKE_VERSION ([0-9]+\.[0-9]+)$')
CMAKE_VPATCH=$(cat ndk-base/Dockerfile | grep -oP 'ENV CMAKE_PATCH_VERSION ([0-9]+)$')
CMAKE_VERSION="$CMAKE_VERSION.$CMAKE_VPATCH"
echo "Defined CMake version: $CMAKE_VERSION"
NINJA_VERSION=$(cat ndk-base/Dockerfile | grep -oP 'ENV NINJA_VERSION ([0-9]+\.[0-9]+(?:\.[0-9]+))$')
echo "Defined Ninja version: $NINJA_VERSION"

validate_ndk () {
  echo "Validate installed CMake in $1"
  DOUTPUT=$(docker run --rm $1 cmake --version)
  if [[ "$DOUTPUT" =~ $CMAKE_VERSION ]]; then
  else
    >&2 echo "Expected CMake version $CMAKE_VERSION in $1, but got $DOUTPUT"
    exit 1
  fi
  echo "Validate installed Ninja in $1"
  DOUTPUT=$(docker run --rm $1 ninja --version)
  if [[ "$DOUTPUT" =~ $NINJA_VERSION ]]; then
  else
    >&2 echo "Expected Ninja version $NINJA_VERSION in $1, but got $DOUTPUT"
    exit 1
  fi
}

validate_ndk kremi151/android-ndk:base

while read p; do
  if [[ $p != android-* ]]; then
    continue
  fi
  fi
  ANDROID_PLATFORM=$(echo "$p" | cut -d, -f 1)
  validate_ndk kremi151/android-ndk:$ANDROID_PLATFORM
done <images.csv
