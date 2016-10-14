#!/bin/bash
# ENVIROMENT = default_value
# ALIAS: "www.irknet.ru"
# NAME: "irknet.ru"  
# HTTPS: True
# SSL: True
# REPO: ssh://git@gitlab01.core.irknet.lan:7777/irknet/irknet.git
# PATH: /home/www/irknet.ru
# PASSWORD: ubuntu

# Disable Strict Host checking for non interactive git clones

if [ ! -z "$PASSWORD" ] ; then
	# Change password for user ubuntu
	echo "ubuntu:${PASSWD}" | /usr/sbin/chpasswd
fi

# Start script for factorio
./get_install_factorio.sh


# Services
echo "127.0.0.1" >> /etc/ansible/hosts
# Generate factorio config files
ansible-playbook /etc/ansible/factorio.yaml --connection=local
ansible-playbook /etc/ansible/factorio_map.yaml --connection=local
# Create map
/opt/factorio/bin/x64/factorio --create /opt/factorio/world.zip --map-gen-settings /opt/factorio/map-get-settings.json

# Configure supervisord for factorio
ansible-playbook /etc/ansible/supervisor.yaml --connection=local

# Start supervisord and services
/usr/bin/supervisord -n -c /etc/supervisor/supervisord.conf
