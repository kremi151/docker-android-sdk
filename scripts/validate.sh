#!/bin/bash

set -euo pipefail

if [ "$#" -ne 1 ]; then
    echo "Expected JDK version as parameter"
    exit 1
fi
OPENJDK_VERSION="$1"

echo "Load .env"
export $(grep -v '^#' .env | xargs)

echo "$PATH"

echo "Defined CMake version: $CMAKE_VERSION"

validate_ndk () {
  echo "Validate installed CMake in $1"
  DOUTPUT=$(docker run --rm $1 cmake --version)
  if [[ "$DOUTPUT" =~ $CMAKE_VERSION ]]; then
    echo "$DOUTPUT"
  else
    >&2 echo "Expected CMake version $CMAKE_VERSION in $1, but got $DOUTPUT"
    exit 1
  fi

  echo "Validate that Ninja is installed correctly in $1"
  docker run --rm $1 ninja --version
}

validate_ndk "kremi151/android-ndk:base-jdk${OPENJDK_VERSION}"

while read p; do
  if [[ $p != android-* ]]; then
    continue
  fi
  ANDROID_PLATFORM=$(echo "$p" | cut -d, -f 1)
  validate_ndk "kremi151/android-ndk:${ANDROID_PLATFORM}-jdk${OPENJDK_VERSION}"
done <images.csv
