FROM jenkins/jenkins
USER root
RUN echo "Asia/Chongqing" > /etc/timezone && dpkg-reconfigure tzdata
ADD sources.list /etc/apt/sources.list
RUN apt-get update && apt-get install -y build-essential apt-transport-https \
     ca-certificates \
     curl \
     gnupg2 \
     software-properties-common
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   stretch \
   stable"
RUN apt-get update && apt-get install -y docker-ce
USER jenkins
RUN install-plugins.sh antisamy-markup-formatter matrix-auth blueocean nodejs
