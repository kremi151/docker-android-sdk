FROM alpine:3.9

ENV ANDROID_PLATFORM_VERSION android-30
ENV ANDROID_BUILD_TOOLS_VERSION 30.0.0

ENV ANDROID_HOME /opt/android-sdk

RUN apk --no-cache add openjdk8 \
    && cd /opt \
    && wget https://dl.google.com/android/repository/commandlinetools-linux-6609375_latest.zip -O cmdline-tools.zip \
    && mkdir -p ${ANDROID_HOME}/cmdline-tools \
    && unzip -q cmdline-tools.zip -d ${ANDROID_HOME}/cmdline-tools \
    && rm cmdline-tools.zip

ENV PATH ${ANDROID_NDK_HOME}:${ANDROID_HOME}/platform-tools:${ANDROID_HOME}/cmdline-tools/tools/bin:${PATH}

RUN yes | sdkmanager --licenses \
    && touch /root/.android/repositories.cfg \
    && yes | sdkmanager "platform-tools" "platforms;${ANDROID_PLATFORM_VERSION}" "build-tools;${ANDROID_BUILD_TOOLS_VERSION}" \
    && rm -rf ${ANDROID_HOME}/emulator
