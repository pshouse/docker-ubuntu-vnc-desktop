FROM ubuntu:14.04
MAINTAINER Doro Wu <fcwu.tw@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
ENV HOME /root

RUN dpkg --add-architecture i386 && apt-get update
RUN apt-get install -y libc6:i386
RUN apt-get install -y wget unzip
RUN wget ftp.squeak.org/4.5/Squeak-4.5-All-in-One.zip && unzip Squeak-4.5-All-in-One.zip

#Install Squeak GUI support
RUN apt-get install -y libX11-6:i386 libice6:i386 libgl1-mesa-glx:i386 libsm6:i386

RUN apt-get update \
    && apt-get install -y --force-yes --no-install-recommends supervisor \
        openssh-server pwgen \
        net-tools \
        lxde x11vnc xvfb \
        gtk2-engines-murrine ttf-ubuntu-font-family \
        libreoffice firefox \
    && apt-get autoclean \
    && apt-get autoremove

ADD noVNC /noVNC/

ADD startup.sh /
ADD supervisord.conf /
ADD autostart /etc/xdg/lxsession/LXDE

EXPOSE 6080
EXPOSE 5900
EXPOSE 22
WORKDIR /
ENTRYPOINT ["/startup.sh"]
