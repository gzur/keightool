
VERSION := $(shell cat VERSION)
DOCKER_REPO := "gzur/keightool"

docker.build:
	@docker build -t $(DOCKER_REPO):$(VERSION) .

docker.release:
	@echo "## Pushing $(DOCKER_REPO):$(VERSION)"
	@docker push $(DOCKER_REPO):$(VERSION)
	@echo "## Pushing $(DOCKER_REPO):latest"
	@docker tag "$(DOCKER_REPO):$(VERSION)" "$(DOCKER_REPO):latest"
	@docker push "$(DOCKER_REPO):latest"