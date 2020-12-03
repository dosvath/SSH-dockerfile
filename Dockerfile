FROM ubuntu:latest

RUN apt update

RUN apt install  openssh-server sudo -y

COPY ssh_config /etc/ssh/ssh_config
COPY sshd_config /etc/ssh/sshd_config
COPY krb5.conf /etc/krb5.conf
COPY common-account /etc/pam.d/common-account
COPY common-auth /etc/pam.d/common-auth
COPY common-password /etc/pam.d/common-password
COPY common-session /etc/pam.d/common-session

RUN useradd -rm -d /home/ubuntu -s /bin/bash -g root -G sudo -u 1000 test 

RUN usermod -aG sudo test

RUN service ssh start

RUN  echo 'test:test' | chpasswd

EXPOSE 22

CMD ["/usr/sbin/sshd","-D"]
