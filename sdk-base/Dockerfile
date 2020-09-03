FROM adoptopenjdk/openjdk8:alpine

ENV ANDROID_HOME /opt/android-sdk

RUN apk --no-cache add bash \
    && cd /opt \
    && wget https://dl.google.com/android/repository/commandlinetools-linux-6609375_latest.zip -O cmdline-tools.zip \
    && mkdir -p ${ANDROID_HOME}/cmdline-tools \
    && unzip -q cmdline-tools.zip -d ${ANDROID_HOME}/cmdline-tools \
    && rm cmdline-tools.zip

ENV PATH ${ANDROID_NDK_HOME}:${ANDROID_HOME}/platform-tools:${ANDROID_HOME}/cmdline-tools/tools/bin:${PATH}

RUN yes | sdkmanager --licenses \
    && touch /root/.android/repositories.cfg \
    && yes | sdkmanager "platform-tools" \
    && rm -rf ${ANDROID_HOME}/emulator
