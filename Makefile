
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

docker.shell: 
	docker run -it  $(DOCKER_REPO):$(VERSION) fish

# k8s stuff
k8s.up:
	$(eval CURRENT_NAMESPACE := $(shell kubectl config view --minify -o jsonpath='{..namespace}'))
	@echo "## Installing keightool into the \"$(CURRENT_NAMESPACE)\" namespace."
	@kubectl apply -f yaml/

k8s.down:
	$(eval CURRENT_NAMESPACE := $(shell kubectl config view --minify -o jsonpath='{..namespace}'))
	@echo "## Removing keightool from the \"$(CURRENT_NAMESPACE)\" namespace."
	@kubectl delete -f yaml/

k8s.shell: 
	kubectl exec -it $(shell kubectl get pods -l app=keightool -o jsonpath='{@.items[0].metadata.name}') -- bash

# release stuff for CI
release: docker.build docker.push


ship: tag ##  Docker build / push is handled by Github Actions
	git push --tags

tag:
	git tag "v$(VERSION)"
