FROM kremi151/android-sdk:base

ARG ANDROID_PLATFORM_VERSION
ARG ANDROID_BUILD_TOOLS_VERSION

RUN yes | sdkmanager "platforms;${ANDROID_PLATFORM_VERSION}" "build-tools;${ANDROID_BUILD_TOOLS_VERSION}" \
    && rm -rf ${ANDROID_HOME}/emulator
