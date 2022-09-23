FROM i386/ubuntu:18.04

ADD snx_install.sh /

ADD openvpn-install.sh /

RUN apt-get update -y && apt-get install -y kmod libpam0g:i386 libx11-6:i386 libstdc++6:i386 libstdc++5:i386 net-tools iputils-ping wget vim openvpn easy-rsa && chmod +x snx_install.sh && ./snx_install.sh && mkdir -p /dev/net && mknod /dev/net/tun c 10 200 && chmod 600 /dev/net/tun && chmod +x openvpn-install.sh

EXPOSE 1194

#CMD /usr/bin/start-vpn

