#!/bin/bash

echo "Push SDK base image"
docker push kremi151/android-sdk:base

echo "Push NDK base image"
docker push kremi151/android-ndk:base

while read p; do
  if [[ $p != android-* ]]; then
    continue
  fi

  ANDROID_PLATFORM=$(echo "$p" | cut -d, -f 1)

  echo "Push SDK $ANDROID_PLATFORM image"
  docker push kremi151/android-sdk:$ANDROID_PLATFORM

  echo "Push NDK $ANDROID_PLATFORM image"
  docker push kremi151/android-ndk:$ANDROID_PLATFORM
  
done <images.csv
