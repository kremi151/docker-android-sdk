FROM kremi151/android-sdk:base

ENV CMAKE_VERSION 3.18
ENV CMAKE_PATCH_VERSION 1
ENV ANDROID_NDK_VERSION r21c
ENV NINJA_VERSION 1.10.1

ENV ANDROID_NDK_HOME /opt/android-ndk
ENV CMAKE_HOME /opt/cmake

RUN mkdir -p /opt/tmp \
    && cd /opt/tmp \
    && wget https://dl.google.com/android/repository/android-ndk-${ANDROID_NDK_VERSION}-linux-x86_64.zip -O android-ndk.zip \
    && unzip -q android-ndk.zip \
    && mv ./android-ndk-${ANDROID_NDK_VERSION} ${ANDROID_NDK_HOME} \
    && cd ${ANDROID_NDK_HOME} \
    && rm -rf /opt/tmp

ENV PATH ${ANDROID_NDK_HOME}/prebuilt/linux-x86_64/bin:${PATH}

RUN mkdir -p ${CMAKE_HOME} \
    && cd ${CMAKE_HOME} \
    && wget https://cmake.org/files/v${CMAKE_VERSION}/cmake-${CMAKE_VERSION}.${CMAKE_PATCH_VERSION}-Linux-x86_64.tar.gz -O cmake.tar.gz \
    && tar -xzf cmake.tar.gz \
    && rm cmake.tar.gz

ENV CMAKE_HOME ${CMAKE_HOME}/cmake-${CMAKE_VERSION}.${CMAKE_PATCH_VERSION}-Linux-x86_64

ENV PATH ${CMAKE_HOME}/bin:${PATH}

RUN cd ${CMAKE_HOME}/bin \
    && wget https://github.com/ninja-build/ninja/releases/download/v${NINJA_VERSION}/ninja-linux.zip \
    && unzip -q ninja-linux.zip -d . \
    && rm ninja-linux.zip
