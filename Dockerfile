# Use Ubuntu 22.04 LTS image...
FROM ubuntu:22.04

# Set environment
ENV LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US \
    DEBIAN_FRONTEND=noninteractive

# Install OpenJDK 17 LTS...
RUN apt-get update -yqq \
    && apt-get install -y curl openjdk-17-jdk wget unzip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Download and install SmartPay CA roots...
RUN wget -q -O /tmp/smartpay.lan-ca.crt https://www.smartpay-software.ro/smartpay/smartpay.lan-ca.crt \
    && wget -q -O /tmp/smartpay.wan-ca.crt https://www.smartpay-software.ro/smartpay/smartpay.wan-ca.crt \
    && keytool -import -cacerts -alias smartpay.lan -file /tmp/smartpay.lan-ca.crt -storepass changeit -noprompt \
    && keytool -import -cacerts -alias smartpay.wan -file /tmp/smartpay.wan-ca.crt -storepass changeit -noprompt \
    && keytool -list -cacerts -storepass changeit -alias smartpay.lan \
    && keytool -list -cacerts -storepass changeit -alias smartpay.wan \
    && rm -f /tmp/smartpay.lan-ca.crt /tmp/smartpay.wan-ca.crt

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
    'platforms;android-34' \
    'platforms;android-33' \
    'platforms;android-32' \
    'platforms;android-31' \
    'platforms;android-30' \
    'platforms;android-29' \
    'platforms;android-28' \
    'platforms;android-27' \
    'platforms;android-26' \
    'platforms;android-25' \
    'platforms;android-24' \
    'platforms;android-23' \
    'build-tools;35.0.1' \
    'build-tools;35.0.0' \
    'build-tools;34.0.0' \
    'build-tools;33.0.3' \
    'build-tools;33.0.2' \
    'build-tools;33.0.1' \
    'build-tools;33.0.0' \
    'build-tools;32.0.0' \
    'build-tools;31.0.0' \
    'build-tools;30.0.3' \
    'build-tools;30.0.2' \
    'build-tools;30.0.1' \
    'build-tools;30.0.0' \
    'build-tools;29.0.3' \
    'build-tools;29.0.2' \
    'build-tools;29.0.1' \
    'build-tools;29.0.0' \
    'build-tools;28.0.3' \
    'build-tools;28.0.2' \
    'build-tools;28.0.1' \
    'build-tools;28.0.0' \
    'build-tools;27.0.3' \
    'build-tools;27.0.2' \
    'build-tools;27.0.1' \
    'build-tools;27.0.0' \
    'build-tools;26.0.3' \
    'build-tools;26.0.2' \
    'build-tools;26.0.1' \
    'build-tools;26.0.0' \
    'build-tools;25.0.3' \
    'build-tools;25.0.2' \
    'build-tools;25.0.1' \
    'build-tools;25.0.0' \
    'build-tools;24.0.3' \
    'build-tools;24.0.2' \
    'build-tools;24.0.1' \
    'build-tools;24.0.0' \
    'build-tools;23.0.3' \
    'build-tools;23.0.2' \
    'build-tools;23.0.1' \
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

# Set artifactory environment...
ENV ARTIFACTORY_TOKEN=''

# Set default command...
CMD ["/bin/bash"]
