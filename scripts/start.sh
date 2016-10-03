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


# SUPERVISOR
# Supervisor configurate
SupervisorTemplateGenerate(){
	# $1 = program name, $2 = command
	PROGRAM_NAME=${1}
	TEMPLATE_LIST=${2}
	TEMPLATE_SUPERVISOR="[program:$PROGRAM_NAME]\ncommand=$TEMPLATE_LIST\nautostart=true\nautorestart=true\nstartretries=100000000\nstdout_logfile=syslog\nstderr_logfile=syslog\n"
	logger -t "Preconfigure" "Add supervisor program name: $PROGRAM_NAME, command:  $TEMPLATE_LIST"
	echo "Add supervisor program name: $PROGRAM_NAME, command:  $TEMPLATE_LIST"
	printf "$TEMPLATE_SUPERVISOR" > /etc/supervisor/conf.d/$PROGRAM_NAME
}
# Services

cat services.conf | while read line;
do
	array=(${line})
	SERVICENAME=${array[0]}
	SERVICECMD=${array[@]/$SERVICENAME}
	#"${!SERVICENAME}"
	
	if [ ${!SERVICENAME:="True"} = "True" ]; then
		SupervisorTemplateGenerate "$SERVICENAME" "$SERVICECMD"
	fi
done

# Start supervisord and services
/usr/bin/supervisord -n -c /etc/supervisor/supervisord.conf
