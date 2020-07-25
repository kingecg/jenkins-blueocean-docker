FROM jenkins/jenkins
USER root
RUN echo "Asia/Chongqing" > /etc/timezone && dpkg-reconfigure tzdata
ADD sources.list /etc/apt/sources.list
ADD gpg /root/gpg
RUN apt-key add /root/gpg && apt-get update && apt-get install -y build-essential apt-transport-https \
     ca-certificates \
     gnupg2 \
     software-properties-common \
     && add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   stretch \
   stable" && apt-get update && apt-get install -y docker-ce
USER jenkins
COPY plugins /jenkins_plugins
RUN install-plugins.sh `cat /jenkins_plugins`
ENV JENKINS_USER admin
ENV JENKINS_PASS admin

# Skip initial setup
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false

COPY executors.groovy /usr/share/jenkins/ref/init.groovy.d/
COPY default-user.groovy /usr/share/jenkins/ref/init.groovy.d/

VOLUME /var/jenkins_home