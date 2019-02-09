SHELL := /bin/bash
GIT_ROOT_DIR := $(shell echo "`pwd`/`git rev-parse --show-cdup`")

.PHONY: help init release release-force test

help: init  ## Print docs
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

init:  ## Deploy pre-commit script
	@cp -af "${GIT_ROOT_DIR}/.tools/git/hooks/pre-commit" "${GIT_ROOT_DIR}/.git/hooks/pre-commit"

test:  ## Test
	@time ./.tools/test.sh

merge:
	CurrentBrunch=`git branch | grep ^* | sed s/^[^[:blank:]][[:blank:]]//` && \
		git push && \
		git checkout develop && \
		git merge $${CurrentBrunch} && \
		git push && \
		git checkout master && \
		git merge develop && \
		git push && \
		git checkout $${CurrentBrunch}

release: test
	@./.tools/release.sh

release-force: test
	@git tag -d `${GIT_ROOT_DIR}/vultr version | sed s/^[^[:blank:]]*[[:blank:]]//` && git push origin :`laws version | sed s/^[^[:blank:]]*[[:blank:]]//`
	@./.tools/release.sh
