ARG OPENJDK_VERSION=11
FROM eclipse-temurin:${OPENJDK_VERSION}-alpine

ENV ANDROID_HOME /opt/android-sdk

RUN apk --no-cache add bash \
    && mkdir -p /opt/android-scripts \
    && cd /opt \
    && wget https://dl.google.com/android/repository/commandlinetools-linux-6609375_latest.zip -O cmdline-tools.zip \
    && mkdir -p ${ANDROID_HOME}/cmdline-tools \
    && unzip -q cmdline-tools.zip -d ${ANDROID_HOME}/cmdline-tools \
    && rm cmdline-tools.zip

COPY android-scripts/* /opt/android-scripts/

RUN find /opt/android-scripts/ -type f -iname "*" -exec chmod -v +x {} \;

ENV PATH /opt/android-scripts:${ANDROID_HOME}/platform-tools:${ANDROID_HOME}/cmdline-tools/tools/bin:${PATH}

RUN yes | sdkmanager --licenses \
    && touch /root/.android/repositories.cfg \
    && yes | sdkmanager "platform-tools"
