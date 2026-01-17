#!/usr/bin/env sh
# Gradle startup script for POSIX

GRADLE_VERSION=8.2

if [ ! -d "$HOME/.gradle/wrapper/dists/gradle-$GRADLE_VERSION-bin" ]; then
    echo "Downloading Gradle $GRADLE_VERSION..."
    mkdir -p "$HOME/.gradle/wrapper/dists"
fi

exec gradle "$@"
