# Use Ubuntu 22.04 LTS image...
FROM ubuntu:22.04

# Install OpenJDK 17 LTS...
RUN apt-get update -yqq \
    && apt-get install -y curl openjdk-17-jdk wget unzip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set Android environment...
ENV ANDROID_HOME=/opt/android-sdk-linux \
    ANDROID_SDK_HOME=/opt/android-sdk-linux \
    ANDROID_SDK_ROOT=/opt/android-sdk-linux \
    ANDROID_SDK=/opt/android-sdk-linux

# Update path...
ENV PATH=${PATH}:${ANDROID_HOME}/cmdline-tools/bin:${ANDROID_HOME}/cmdline-tools/latest/bin:${ANDROID_HOME}/build-tools/35.0.0:${ANDROID_HOME}/platform-tools

# Install Android command line tools...
RUN mkdir -p ${ANDROID_HOME} \
    && cd ${ANDROID_HOME} \
    && wget -q https://dl.google.com/android/repository/commandlinetools-linux-13114758_latest.zip -O android-commandline-tools.zip \
    && unzip -q android-commandline-tools.zip -d ${ANDROID_HOME} \
    && rm -f android-commandline-tools.zip

# Create repositories configuration file...
RUN mkdir -p ~/.android \
    && touch ~/.android/repositories.cfg

# Accept Android SDK licenses...
RUN yes | sdkmanager --sdk_root=${ANDROID_HOME} --licenses --verbose

# Install Android SDK packages...
RUN yes | sdkmanager --sdk_root=${ANDROID_HOME} --verbose \
    "cmdline-tools;latest" \
    'platform-tools' \
    'platforms;android-35' \
    'build-tools;35.0.1' \
    'build-tools;35.0.0' \
    'tools'

# Create work directory...
RUN mkdir -p /workspace

# Set work directory...
WORKDIR /workspace

# Create gradle cache directory...
RUN mkdir -p /workspace/.gradle \
    && chmod 777 /workspace/.gradle

# Set gradle cache directory...
ENV GRADLE_USER_CACHE=/workspace/.gradle

# Set default command...
CMD ["/bin/bash"]