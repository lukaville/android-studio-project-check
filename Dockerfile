FROM ubuntu:xenial

ENV ANDROID_SDK_URL https://dl.google.com/android/repository/tools_r25.2.3-linux.zip
ENV STUDIO_DOWNLOAD_URL https://dl.google.com/dl/android/studio/ide-zips/2.2.3.0/android-studio-ide-145.3537739-linux.zip
ENV KOTLIN_PLUGIN_URL https://plugins.jetbrains.com/files/6954/31110/kotlin-plugin-1.0.5-release-Studio2.2-3.zip
ENV CHECK_PLUGIN_URL https://github.com/lukaville/android-studio-project-check/releases/download/v0.1/android-studio-project-check.zip
ENV IDEA_INSPECTOR_VERSION 0e37430
ENV ANDROID_VERSION 25

RUN apt-get update

# Install requirements
RUN apt-get install -y openjdk-8-jdk xvfb lib32z1 lib32ncurses5 lib32stdc++6 git vim ant wget unzip
ENV JAVA_HOME /usr/lib/jvm/java-1.8.0-openjdk-amd64/

RUN apt-get clean
RUN apt-get purge

# Android Studio
RUN wget $STUDIO_DOWNLOAD_URL -O /tmp/studio.zip && unzip -d /opt /tmp/studio.zip && rm /tmp/studio.zip
RUN wget $KOTLIN_PLUGIN_URL -O /tmp/kotlin.zip && unzip -d /opt/android-studio/plugins /tmp/kotlin.zip && rm /tmp/kotlin.zip
RUN wget $CHECK_PLUGIN_URL -O /tmp/android-studio-project-check.zip && unzip -d /opt/android-studio/plugins /tmp/android-studio-project-check.zip && rm /tmp/android-studio-project-check.zip

# Android SDK
RUN wget $ANDROID_SDK_URL -O android-sdk.zip && \
    unzip android-sdk.zip -d /opt/android-sdk && \
    rm -f android-sdk.zip

ENV ANDROID_HOME /opt/android-sdk/
ENV PATH ${PATH}:${ANDROID_HOME}/tools/:${ANDROID_HOME}/platform-tools
RUN echo "y" | android update sdk --all --no-ui --filter "platform-tools,android-$ANDROID_VERSION"

COPY run.sh /
ENTRYPOINT ["/run.sh"]