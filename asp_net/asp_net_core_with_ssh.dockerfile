#https://docs.docker.com/engine/examples/running_ssh_service/
#https://superuser.com/questions/844101/docker-login-via-ssh-always-asks-for-password
FROM microsoft/dotnet-samples:aspnetapp
ENV USER ubuntu
RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN adduser --disabled-password --gecos "" $USER
RUN adduser $USER sudo
ADD authorized_keys /home/$USER/.ssh/authorized_keys
RUN chown $USER /home/$USER/.ssh/authorized_keys
RUN chown -R $USER:$USER /home/$USER/.ssh/authorized_keys
RUN chmod 700 /home/$USER/.ssh/authorized_keys
EXPOSE 22
CMD    ["/usr/sbin/sshd", "-D"]
