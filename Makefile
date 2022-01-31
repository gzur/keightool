
VERSION := $(shell cat VERSION)
DOCKER_REPO := "gzur/keightool"

docker.build:
	docker build -t $(DOCKER_REPO):$(VERSION) .

docker.push:
	@echo "## Pushing $(DOCKER_REPO):$(VERSION)"
	@docker push $(DOCKER_REPO):$(VERSION)
	@echo "## Pushing $(DOCKER_REPO):latest"
	@docker tag "$(DOCKER_REPO):$(VERSION)" "$(DOCKER_REPO):latest"
	@docker push "$(DOCKER_REPO):latest"


release: docker.build docker.push

k8s.install:
	$(eval CURRENT_NAMESPACE := $(shell kubectl config view -o jsonpath='{.contexts[].context.namespace}'))

	@echo "## Installing keightool into the \"$(CURRENT_NAMESPACE)\" namespace."
	@kubectl apply -f yaml/

k8s.uninstall:
	$(eval CURRENT_NAMESPACE := $(shell kubectl config view -o jsonpath='{.contexts[].context.namespace}'))
	@echo "## Removing keightool from the \"$(CURRENT_NAMESPACE)\" namespace."
	@kubectl delete -f yaml/


tag:
	git tag "v$(VERSION)"