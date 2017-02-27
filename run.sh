#!/bin/bash

# Start fake display
XVFB_WHD=${XVFB_WHD:-1280x720x16}
Xvfb :99 -ac -screen 0 $XVFB_WHD -nolisten tcp &
xvfb=$!

export DISPLAY=:99

# Create empty settings directory to ignore import settings dialog
mkdir /opt/android-studio/config
printf "idea.config.path=/opt/android-studio/config\n" >> /opt/android-studio/bin/idea.properties

/opt/android-studio/bin/studio.sh /project