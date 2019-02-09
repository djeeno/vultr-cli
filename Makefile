SHELL := /bin/bash
GIT_ROOT_DIR := $(shell echo "`pwd`/`git rev-parse --show-cdup`")

.PHONY: help init release release-force test

help: init  ## print docs
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

init:
	@cp -af "${GIT_ROOT_DIR}/.tools/git/hooks/pre-commit" "${GIT_ROOT_DIR}/.git/hooks/pre-commit"

test:  ## run test script
	@time ./.tools/test.sh

merge:  ## merge and push all branchs
	CurrentBrunch=`git branch | grep ^* | sed s/^[^[:blank:]][[:blank:]]//` && \
		git push && \
		git checkout develop && \
		git merge $${CurrentBrunch} && \
		git push && \
		git checkout master && \
		git merge develop && \
		git push && \
		git checkout $${CurrentBrunch}

release: test  ## add and push release tag
	@./.tools/release.sh

release-force: test  ## force push release tag 
	@git tag -d `${GIT_ROOT_DIR}/vultr version | sed s/^[^[:blank:]]*[[:blank:]]//` && git push origin :`laws version | sed s/^[^[:blank:]]*[[:blank:]]//`
	@./.tools/release.sh
