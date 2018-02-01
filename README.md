# CustomJNLPSlave

This is a Dockerfile snippet for building custom JNLP images.

Proportions of the Dockerfile are copied from
https://github.com/jenkinsci/docker-jnlp-slave and
https://github.com/jenkinsci/docker-slave.

The intended use of this snippet is to generate custom JNLP Slave image for
kubernetes-plugin to be used as freestyle job image, as there's currently no
other way to specify container for freestyle jobs now even though multiple
containers can be configured.
