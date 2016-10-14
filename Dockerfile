FROM ubuntu:14.04

MAINTAINER fessoga <fessoga5@gmail.com>


RUN apt-get update && apt-get install -y --force-yes curl && \ 
    apt-get install -y --force-yes bash \
    curl \
    openssh-client \
    openssh-server \
    fping \
    vim \
    sudo \
    wget \
    supervisor \
    git \
    rsyslog \
    python-yaml \
    sendmail  && \
    mkdir -p /var/run/sshd && \
    mkdir -p /home/www && \
    chown www-data:www-data -R /home/www && \
    mkdir -p /var/log/supervisor && \
    mkdir -p /var/log/celery && \
    mkdir -p /opt/factorio

# INSTALL BYRADIUSMQ IRKNET SERVER
ADD versions/byradiusmq_0.0-2.deb /opt/byradiusmq_0.0-2.deb
RUN dpkg -i /opt/byradiusmq_0.0-2.deb

# Get timezone
RUN echo "Asia/Irkutsk" | tee /etc/timezone && \
dpkg-reconfigure --frontend noninteractive tzdata

# Add games saves 
ADD saves/world.zip /opt/factorio/world.zip

# Add Scripts
ADD scripts/start.sh /start.sh
ADD scripts/get_install_factorio.sh /get_install_factorio.sh
ADD scripts/services.conf /services.conf

# Add template
ADD playbooks/roles /etc/ansible/roles
ADD conf/factorio.yaml /opt/factorio/factorio.yaml
ADD conf/factorio.yaml /opt/factorio/factorio_map.yaml
ADD conf/server-settings.jinja /opt/factorio/server-settings.jinja
ADD conf/map-get-settings.jinja /opt/factorio/map-get-settings.jinja

RUN chmod 755 /start.sh
RUN chmod 755 /get_install_factorio.sh

# Create user, adding for group. Working for ssh
RUN /usr/sbin/useradd -d /home/ubuntu -s /bin/bash -p $(echo ubuntu | openssl passwd -1 -stdin) ubuntu &&\
/usr/sbin/usermod -a -G sudo ubuntu

EXPOSE 22

#CMD ["/usr/bin/supervisord", "-n", "-c",  "/etc/supervisord.conf"]
CMD ["/start.sh"]

