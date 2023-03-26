.PHONY: check
check:
	@helm install --dry-run --debug redis-cluster --generate-name

RELEASE_NAME = "redis-cluster"

.PHONY: apply
apply:
	@helm install $(RELEASE_NAME) redis-cluster

.PHONY: delete
delete:
	@helm delete $(RELEASE_NAME)

.PHONY: reload
reload:
	helm delete $(RELEASE_NAME) ; helm install $(RELEASE_NAME) redis-cluster

.PHONY: test
test: lint reload
	@bin/wait_setup.sh
	@helm test redis-cluster --logs

.PHONY: lint
lint:
	helm lint --strict redis-cluster
