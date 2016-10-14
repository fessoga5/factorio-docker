## Introduction
This is a Dockerfile to build a container image for factorio-headless server.

## Structure
1. Download and untar https://www.factorio.com/get-download/0.13.20/headless/linux64
2. Create config file for map and game, using ANSIBLE.
	/opt/factorio/bin/x64/factorio --create /opt/factorio/world.zip --map-gen-settings map-generation.json

3. Start game with via supervisord
	/opt/factorio/bin/x64/factorio --start-server-load-latest --server-settings /opt/factorio/server-settings.json /opt/factorio/world.zip

## ENVIRONMENT
Running with ENV:
	docker run -e FACTORIO_GAME_PASSWORD="my_password" --name factorio-server-1 factorio-server:latest

Settings for map:
	"FACTORIO_MAP_COMMENT": "Sizes can be specified as none, very-low, low, normal, high, very-high"

	"FACTORIO_MAP_TERRAIN_SEGMENTATION": "normal"

	"FACTORIO_MAP_WATER": "normal"

	"FACTORIO_MAP_WIDTH": 0

	"FACTORIO_MAP_HEIGHT": 0

	"FACTORIO_MAP_STARTING_AREA": "normal"

	"FACTORIO_MAP_PEACEFUL_MODE": false

	"FACTORIO_MAP_COAL": {"frequency": "normal", "size": "normal", "richness": "normal"}

	"FACTORIO_MAP_COPPERORE": {"frequency": "normal", "size": "normal", "richness": "normal"}

	"FACTORIO_MAP_CRUDEOIL": {"frequency": "normal", "size": "normal", "richness": "normal"}

	"FACTORIO_MAP_ENEMYBASE": {"frequency": "normal", "size": "normal", "richness": "normal"}

	"FACTORIO_MAP_IRONORE": {"frequency": "normal", "size": "normal", "richness": "normal"}

	"FACTORIO_MAP_STONE": {"frequency": "normal", "size": "normal", "richness": "normal"}


Settings for server:
	"FACTORIO_NAME": "Name of the game as it will appear in the game listing"

	"FACTORIO_DESCRIPTION": "Description of the game that will appear in the listing"

	"FACTORIO_MAX_PLAYERS": "0"

	"FACTORIO_VISIBILITY": "public"

	"FACTORIO_COMMENT_CREDENTIALS": "Your factorio.com login credentials. Required for games with visibility public"

	"FACTORIO_USERNAME": ""

	"FACTORIO_PASSWORD": ""

	"FACTORIO_COMMENT_TOKEN": "Authentication token. May be used instead of 'password' above."

	"FACTORIO_TOKEN": ""

	"FACTORIO_GAME_PASSWORD": ""

	"FACTORIO_COMMENT_VERIFY_USER_IDENTITY": "When set to true, the server will only allow clients that have a valid Factorio.com account"

	"FACTORIO_VERIFY_USER_IDENTITY": true


## Version: 
0.13.20 (headless)
https://www.factorio.com/get-download/0.13.20/headless/linux64

## Documentation for Factorio
manual: https://wiki.factorio.com/index.php?title=Multiplayer/ru

## Create image
docker build -t factorio-server:latest .

## Start image

docker run -e FACTORIO_GAME_PASSWORD="my_password" --name factorio-server-1 factorio-server:latest
