FROM i386/ubuntu:18.04

ADD snell-server /usr/local/bin

ADD snx_install.sh /

RUN apt-get update -y && apt-get install -y kmod libpam0g:i386 libx11-6:i386 libstdc++6:i386 libstdc++5:i386 && chmod +x snx_install.sh && ./snx_install.sh && mkdir /etc/snell && cd /usr/local/bin && chmod +x snell-server

ADD snell-server.conf /etc/snell 

CMD ["/usr/local/bin/snell-server","-c","/etc/snell/snell-server.conf"]

