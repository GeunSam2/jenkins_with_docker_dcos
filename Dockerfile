From jenkins/jenkins:lts-centos

USER root
COPY ./dcos /usr/local/bin/dcos
COPY ./jenkins.sh /usr/local/bin/jenkins.sh
COPY ./daemon.json /etc/docker/daemon.json
RUN yum -y install yum-utils device-mapper-persistent-data lvm2 wget
RUN curl -fLsSv --retry 20 -Y 100000 -y 60 -o /tmp/docker-engine-1.13.1-1.el7.centos.x86_64.rpm https://yum.dockerproject.org/repo/main/centos/7/Packages/docker-engine-1.13.1-1.el7.centos.x86_64.rpm
RUN curl -fLsSv --retry 20 -Y 100000 -y 60 -o /tmp/docker-engine-selinux-1.13.1-1.el7.centos.noarch.rpm https://yum.dockerproject.org/repo/main/centos/7/Packages/docker-engine-selinux-1.13.1-1.el7.centos.noarch.rpm
RUN yum -y localinstall /tmp/docker*.rpm || true
RUN wget https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64 -O jq
RUN chmod +x jq
RUN mv jq /usr/local/bin
