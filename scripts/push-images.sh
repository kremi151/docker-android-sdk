#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Expected JDK version as parameter"
    exit 1
fi
OPENJDK_VERSION="$1"

OPENJDK_DEFAULT_VERSION="17"

echo "Push SDK base image"
docker push "kremi151/android-sdk:base-jdk${OPENJDK_VERSION}"

echo "Push NDK base image"
docker push "kremi151/android-ndk:base-jdk${OPENJDK_VERSION}"

if [ "$OPENJDK_VERSION" = "$OPENJDK_DEFAULT_VERSION" ]; then
  docker tag "kremi151/android-sdk:base-jdk${OPENJDK_VERSION}" kremi151/android-sdk:base
  docker push kremi151/android-sdk:base

  docker tag "kremi151/android-ndk:base-jdk${OPENJDK_VERSION}" kremi151/android-ndk:base
  docker push kremi151/android-sdk:base
fi

while read p; do
  if [[ $p != android-* ]]; then
    continue
  fi

  ANDROID_PLATFORM=$(echo "$p" | cut -d, -f 1)

  echo "Push SDK $ANDROID_PLATFORM image"
  docker push "kremi151/android-sdk:${ANDROID_PLATFORM}-jdk${OPENJDK_VERSION}"

  echo "Push NDK $ANDROID_PLATFORM image"
  docker push "kremi151/android-ndk:${ANDROID_PLATFORM}-jdk${OPENJDK_VERSION}"

  if [ "$OPENJDK_VERSION" = "$OPENJDK_DEFAULT_VERSION" ]; then
    docker tag "kremi151/android-sdk:${ANDROID_PLATFORM}-jdk${OPENJDK_VERSION}" "kremi151/android-sdk:$ANDROID_PLATFORM"
    docker push "kremi151/android-sdk:$ANDROID_PLATFORM"

    docker tag "kremi151/android-ndk:${ANDROID_PLATFORM}-jdk${OPENJDK_VERSION}" "kremi151/android-ndk:$ANDROID_PLATFORM"
    docker push "kremi151/android-ndk:$ANDROID_PLATFORM"
  fi
  
done <images.csv
