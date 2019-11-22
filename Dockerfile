From jenkins/jenkins:lts-centos

USER root
COPY ./dcos /usr/local/bin/dcos
COPY ./jenkins.sh /usr/local/bin/jenkins.sh
COPY ./daemon.json /etc/docker/daemon.json
RUN yum -y install yum-utils device-mapper-persistent-data lvm2 wget
RUN yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
RUN yum install docker-ce docker-ce-cli containerd.io -y --nobest
RUN wget https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64 -O jq
RUN chmod +x jq
RUN mv jq /usr/local/bin
