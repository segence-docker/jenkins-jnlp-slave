ORGANIZATION := segence
REPOSITORY := $(shell basename -s .git `git config --get remote.origin.url`)
VERSION := $(shell git tag --points-at HEAD)

JENKINS_UID := 1000

ifneq (,$(findstring minikube,$(VERSION)))
    JENKINS_GID := 1001
else
    JENKINS_GID := 1000
endif

all:
	@echo "Use a specific goal. To list all goals, type 'make help'"

.PHONY: build # Builds Docker image
build:
	@git submodule init
	@git submodule update --recursive --remote
	@docker build --tag jenkins/slave:3.27-1-alpine --build-arg uid=$(JENKINS_UID) --build-arg gid=$(JENKINS_GID) docker-slave
	@docker build --tag jenkins/jnlp-slave:latest docker-jnlp-slave
	@docker build -t $(ORGANIZATION)/$(REPOSITORY):$(VERSION) .

.PHONY: push # Pushes Docker image
push:
	@docker push $(ORGANIZATION)/$(REPOSITORY):$(VERSION)

.PHONY: help # Generate list of targets with descriptions
help:
	@grep '^.PHONY: .* #' Makefile | sed 's/\.PHONY: \(.*\) # \(.*\)/\1: \2/'
