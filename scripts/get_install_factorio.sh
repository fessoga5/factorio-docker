#!/usr/bin/env bash
SITES_NAME=${SITE_NAME:="https://www.factorio.com/get-download/0.14.9/headless/linux64"}

if [ -f "/opt/$PKGS_NAME" ]; then
	logger -t "$0" "File $PKGS_NAME already exists!"
else
	wget -O "/opt/factorio_headless_x64_0.13.20.tar.gz" "$SITES_NAME"
fi

if [ ! -d /opt/factorio ]; then
	mkdir -p /opt/factorio
	tar -xvzf "/opt/factorio_headless_x64_0.13.20.tar.gz" -C /opt/factorio
	mkdir -p /opt/factorio/mods
	mkdir -p /opt/factorio/saves
else
	logger -t "$0" "Directory $DIRECTORY_NAME already exists!"
fi

