
VERSION := $(shell cat VERSION)
DOCKER_REPO := "gzur/keightool"

# k8s stuff - this is here to make it easier to override the image
IMAGE ?= $(DOCKER_REPO)
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

k8s.up:
	$(eval CURRENT_NAMESPACE := $(shell kubectl config view --minify -o jsonpath='{..namespace}'))
	
	@echo "## Installing keightool into the \"$(CURRENT_NAMESPACE)\" namespace."
	@echo "## keightool is running the $(IMAGE) image. Overide by supplying `IMAGE=your-image` to the make command"
	cat yaml/* | sed 's~gzur/keightool~$(IMAGE)~g' | kubectl apply -n $(CURRENT_NAMESPACE) -f -

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
