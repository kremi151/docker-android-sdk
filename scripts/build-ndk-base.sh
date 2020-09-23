#!/bin/sh

echo "Build NDK base image"
docker build -t kremi151/android-ndk:base ndk-base
