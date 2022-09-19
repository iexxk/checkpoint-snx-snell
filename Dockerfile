FROM kedu/snx-checkpoint-vpn:latest

ADD snell-server /usr/local/bin

RUN mkdir /etc/snell && cd /usr/local/bin && chmod +x snell-server

ADD snell-server.conf /etc/snell 

CMD ["/usr/local/bin/snell-server","-c","/etc/snell/snell-server.conf"]
