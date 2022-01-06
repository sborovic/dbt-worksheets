FROM ubuntu:20.04

# Prerequisites
RUN apt update && apt install -y curl git unzip xz-utils zip libglu1-mesa wget
RUN DEBIAN_FRONTEND=noninteractive TZ=Europe/Belgrade apt install -y openjdk-8-jdk

# Set up a non-root user
RUN useradd -ms /bin/bash developer
USER developer
ENV APP_PATH=/home/developer
WORKDIR $APP_PATH

# Install Flutter
RUN wget https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_2.8.1-stable.tar.xz -O - | tar xJ 
ENV PATH="$PATH:$APP_PATH/flutter/bin"

# Prepare Android directories and system variables
RUN mkdir android-sdk
ENV ANDROID_SDK_ROOT=$APP_PATH/android-sdk
RUN mkdir .android && touch .android/repositories.cfg

# Set up Android SDK
RUN wget -O sdk-tools.zip https://dl.google.com/android/repository/commandlinetools-linux-7583922_latest.zip
RUN unzip sdk-tools.zip && rm sdk-tools.zip
RUN mkdir ./android-sdk/cmdline-tools/
RUN mv cmdline-tools android-sdk/cmdline-tools/latest
ENV PATH=$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:$ANDROID_SDK_ROOT/platform-tools
RUN yes | sdkmanager --licenses
RUN sdkmanager "platform-tools" "platforms;android-31" "build-tools;31.0.0"
RUN flutter doctor --android-licenses

# Copy the authorized adbkey
COPY ./.adbkey $APP_PATH/.android/adbkey

# Create the Flutter app directory 
WORKDIR $APP_PATH/app

