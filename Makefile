CRYSTAL_BIN ?= $(shell which crystal)

.PHONY: spec
spec:
	$(CRYSTAL_BIN) spec --verbose

test: spec
