FROM mysql:5.6

ARG UID
ARG GUID
ARG USER=mysql
RUN usermod -u $UID $USER && groupmod -g $GUID $USER

# Configuring OS
RUN echo 'alias ll="ls -l --color"' >>  /etc/bash.bashrc

WORKDIR backup