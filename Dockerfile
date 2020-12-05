FROM ubuntu:latest

RUN apt update

RUN apt install  openssh-server sudo -y

RUN apt install krb5-user sudo -y

COPY sshd_config /etc/ssh/sshd_config
COPY krb5.conf /etc/krb5.conf

RUN mkdir /share

RUN useradd -rm -d /home/ubuntu -s /bin/bash -g root -G sudo -u 1000 test

RUN usermod -aG sudo test

RUN service ssh start

RUN  echo 'test:test' | chpasswd

EXPOSE 22

CMD ["/usr/sbin/sshd","-D"]
