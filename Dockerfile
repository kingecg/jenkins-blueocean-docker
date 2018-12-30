FROM jenkins/jenkins
USER root
RUN echo "Asia/Chongqing" > /etc/timezone && dpkg-reconfigure tzdata
ADD sources.list /etc/apt/sources.list
ADD gpg /root/gpg
RUN apt-key add /root/gpg && apt-get update && apt-get install -y build-essential apt-transport-https \
     ca-certificates \
     curl \
     gnupg2 \
     software-properties-common \
     docker-ce
USER jenkins
RUN install-plugins.sh antisamy-markup-formatter matrix-auth blueocean nodejs
