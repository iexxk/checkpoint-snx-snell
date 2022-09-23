FROM i386/ubuntu:18.04

ADD vpnsetup.sh /

ADD snx_install.sh /

RUN apt-get update -y && apt-get install -y kmod libpam0g:i386 libx11-6:i386 libstdc++6:i386 libstdc++5:i386 net-tools iputils-ping wget vim strongswan && chmod +x vpnsetup.sh && ./vpnsetup.sh

#ADD ./etc/* /etc/
#ADD ./bin/* /usr/bin

#EXPOSE 500/udp 4500/udp

#CMD /usr/bin/start-vpn

