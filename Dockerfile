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

ADD conf/supervisord.conf /etc/supervisor/supervisord.conf

# Add games versions
ADD versions/factorio.tar.gz /opt/

# Add games saves 
ADD saves/world.zip /opt/factorio/world.zip

# Add Scripts
ADD scripts/start.sh /start.sh
ADD scripts/get_install_factorio.sh /get_install_factorio.sh
ADD scripts/services.conf /services.conf
RUN chmod 755 /start.sh
RUN chmod 755 /get_install_factorio.sh

# Create user, adding for group. Working for ssh
RUN /usr/sbin/useradd -d /home/ubuntu -s /bin/bash -p $(echo ubuntu | openssl passwd -1 -stdin) ubuntu &&\
/usr/sbin/usermod -a -G sudo ubuntu

EXPOSE 22

#CMD ["/usr/bin/supervisord", "-n", "-c",  "/etc/supervisord.conf"]
CMD ["/start.sh"]
