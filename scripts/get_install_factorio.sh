#!/usr/bin/env bash
PKGS_NAME=${PKG_NAME:="factorio.tar.gz"}
SITES_NAME=${SITE_NAME:="https://www.factorio.com/get-download/0.14.9/headless/linux64"}
DIRECTORY_NAME="/opt/factorio"

if [ -f "/opt/$PKGS_NAME" ]; then
	logger -t "$0" "File $PKGS_NAME already exists!"
else
	wget -O "/opt/$PKGS_NAME" "$SITES_NAME"
fi

if [ ! -d $DIRECTORY_NAME/factorio ]; then
	mkdir -p $DIRECTORY_NAME
	tar -xvzf "/opt/$PKGS_NAME" -C /opt/factorio
	mkdir -p $DIRECTORY_NAME/factorio/mods
	mkdir -p $DIRECTORY_NAME/factorio/saves
	cp -p /opt/world.zip $DIRECTORY_NAME/factorio/saves/world.zip
else
	logger -t "$0" "Directory $DIRECTORY_NAME already exists!"
fi

