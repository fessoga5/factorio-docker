## Introduction
This is a Dockerfile to build a container image for factorio-headless server.

## Version: 
https://www.factorio.com/get-download/0.14.9/headless/linux64

## Documentation for Factorio
manual: https://wiki.factorio.com/index.php?title=Multiplayer/ru

## Create image
docker build -t factorio:latest .

## Start image
docker run --name test factorio

## Introducing
Docker start /start.sh, which wget https://www.factorio.com/get-download/0.14.9/headless/linux64 and create command for supervisord /opt/factorio/factorio/bin/x64/factorio --start-server /opt/factorio/world.zip.
Supervisord start sshd and Factorio server.

## P.S.
world.zip custom map with very good resources and password 123321
