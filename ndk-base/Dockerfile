ARG OPENJDK_VERSION=17
FROM kremi151/android-sdk:base-jdk${OPENJDK_VERSION}

ARG CMAKE_VERSION

ENV ANDROID_NDK_VERSION r25c

ENV ANDROID_NDK_HOME /opt/android-ndk
ENV CMAKE_HOME /opt/cmake

COPY android-scripts/* /opt/android-scripts/

RUN mkdir -p /opt/tmp \
    && cd /opt/tmp \
    && wget https://dl.google.com/android/repository/android-ndk-${ANDROID_NDK_VERSION}-linux.zip -O android-ndk.zip \
    && unzip -q android-ndk.zip \
    && mv ./android-ndk-${ANDROID_NDK_VERSION} ${ANDROID_NDK_HOME} \
    && cd ${ANDROID_NDK_HOME} \
    && rm -rf /opt/tmp \
    && find /opt/android-scripts/ -type f -iname "*" -exec chmod -v +x {} \;

ENV PATH ${ANDROID_NDK_HOME}/prebuilt/linux-x86_64/bin:${PATH}

RUN mkdir -p ${CMAKE_HOME} \
    && cd ${CMAKE_HOME} \
    && wget https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/cmake-${CMAKE_VERSION}-linux-x86_64.tar.gz -O cmake.tar.gz \
    && tar -xzf cmake.tar.gz \
    && rm cmake.tar.gz \
    && apk --no-cache add libc6-compat ninja-build

ENV CMAKE_HOME ${CMAKE_HOME}/cmake-${CMAKE_VERSION}-linux-x86_64

ENV PATH ${CMAKE_HOME}/bin:/usr/lib/ninja-build/bin:${PATH}
