ARG BASEIMAGE=openjdk:8-jdk
FROM ${BASEIMAGE}

# this image assumes compatible version of JAVA has been installed

# copied from jenkins/slave
ENV HOME /home/jenkins
RUN groupadd -g 10000 jenkins
RUN useradd -c "Jenkins user" -d $HOME -u 10000 -g 10000 -m jenkins

ARG JENKINS_SLAVE_VERSION=3.16
ARG AGENT_WORKDIR=/home/jenkins/agent

RUN curl --create-dirs -sSLo /usr/share/jenkins/slave.jar https://repo.jenkins-ci.org/public/org/jenkins-ci/main/remoting/${JENKINS_SLAVE_VERSION}/remoting-${JENKINS_SLAVE_VERSION}.jar \
  && chmod 755 /usr/share/jenkins \
  && chmod 644 /usr/share/jenkins/slave.jar

USER jenkins
ENV AGENT_WORKDIR=${AGENT_WORKDIR}
RUN mkdir /home/jenkins/.jenkins && mkdir -p ${AGENT_WORKDIR}

VOLUME /home/jenkins/.jenkins
VOLUME ${AGENT_WORKDIR}
WORKDIR /home/jenkins

# copied from jenkins/jnlp-slave
# some env-vars are reserved by jenkins-slave see the script for detail
COPY jenkins-slave /usr/local/bin/jenkins-slave
ENTRYPOINT ["jenkins-slave"]
