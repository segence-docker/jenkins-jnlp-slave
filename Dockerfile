FROM jenkinsci/jnlp-slave:alpine

USER root

RUN echo 'http://dl-cdn.alpinelinux.org/alpine/latest-stable/community' >> /etc/apk/repositories
RUN apk --no-cache add docker git-lfs

USER jenkins
