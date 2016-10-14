#!/usr/bin/env bash
SITES_NAME=${SITE_NAME:="https://www.factorio.com/get-download/0.14.9/headless/linux64"}

if [ -f "/opt/$PKGS_NAME" ]; then
	logger -t "$0" "File $PKGS_NAME already exists!"
else
	wget -q -O "/opt/factorio_headless_x64_0.13.20.tar.gz" "$SITES_NAME"
fi

if [ -f /opt/factorio_headless_x64_0.13.20.tar.gz ]; then
	tar -xvzf /opt/factorio_headless_x64_0.13.20.tar.gz -C /opt
	mkdir -p /opt/factorio/mod
	mkdir -p /opt/factorio/saves
else
	logger -t "$0" "Directory $DIRECTORY_NAME already exists!"
fi

