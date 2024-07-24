# kremi151/android-sdk

![Build Docker image](https://github.com/kremi151/docker-android-sdk/workflows/Build%20Docker%20image/badge.svg)

Minimal Docker image with Android SDK, with focus on building

## Available images

|Image name|Tag|Android platform|Has NDK|
|----------|---|----------------|-------|
|kremi151/android-sdk|base|N/A|No|
|kremi151/android-sdk|android-29|API 29 (Android 10)|No|
|kremi151/android-sdk|android-30|API 30 (Android 11)|No|
|kremi151/android-sdk|android-31|API 31 (Android 12)|No|
|kremi151/android-ndk|base|N/A|Yes|
|kremi151/android-ndk|android-29|API 29 (Android 10)|Yes|
|kremi151/android-ndk|android-30|API 30 (Android 11)|Yes|
|kremi151/android-ndk|android-31|API 31 (Android 12)|Yes|

## JDK versions

Docker images are published in two variants: With Eclipse Temurin Open JDK 11 and Open JDK 17.

For Open JDK 11, use the images with `-jdk11` tag suffix.

For Open JDK 17, use the images with `-jdk17` tag suffix.

The current default is JDK 17, so the images without specific `jdk` suffix will default to `-jdk17`.

## Scripts

The `kremi151/android-sdk` and `kremi151/android-ndk` Docker images provide the following convenience scripts which are globally available:

### makeLocalProperties

Generates the `local.properties` file to be put at the root of an Android project workspace.
The Android Gradle plugin will soon drop support for `ANDROID_HOME` and `ANDROID_NDK_HOME` environment variables and expects the configuration of the paths to be done in the `local.properties` file.
While the `kremi151/android-sdk` and `kremi151/android-ndk` Docker images will keep providing those environment variables, it also provides the `makeLocalProperties` script to generate the `local.properties` file.
