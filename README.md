Jenkins JNLP Slave
==================

The Docker image contains a valid user and group ID that is the same as set in [Jenkins Docker image](https://hub.docker.com/r/jenkins/jenkins/).

The user and group IDs are important when using Docker-in-Docker, that is a common use-case for CI builds. For example, integration tests can spin up a cluster of Docker containers for database testing or a Kafka cluster.

The prerequisitive is to mount `/var/run/docker.sock` into the container spun up from this image, and the Docker group ID has to be the same on the host as in this image (`gid=1000`).

There is a tag built for [Minikube](https://kubernetes.io/docs/setup/minikube/) where the group ID is `1001`.
