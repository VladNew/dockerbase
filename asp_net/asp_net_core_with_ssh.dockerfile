#https://docs.docker.com/engine/examples/running_ssh_service/
FROM microsoft/dotnet-samples:aspnetapp

RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:screencast' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config


ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile
EXPOSE 22 80
CMD ["/usr/sbin/sshd", "-D"]
