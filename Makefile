SHELL := /bin/bash
GIT_ROOT_DIR := $(shell echo "`pwd`/`git rev-parse --show-cdup`" | sed 's@/$$@@')

.PHONY: help init release release-force test

help:  ## Print docs
	@# init
	@cp -af "${GIT_ROOT_DIR}/.tools/git/hooks/pre-commit" "${GIT_ROOT_DIR}/.git/hooks/pre-commit"
	@# help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-16s\033[0m %s\n", $$1, $$2}'

test:  ## Run test script
	@time ./.tools/test.sh

merge:  ## Merge and push
	CurrentBrunch=`git branch | grep ^* | sed s/^[^[:blank:]][[:blank:]]//` && \
		git push && \
		git checkout develop && \
		git merge $${CurrentBrunch} && \
		git push && \
		git checkout master && \
		git merge develop && \
		git push && \
		git checkout $${CurrentBrunch}

release: test  ## Add tag and push tag for release
	@./.tools/release.sh

release-force: test  ## Force push release tag 
	@git tag -d `${GIT_ROOT_DIR}/vultr version | sed s/^[^[:blank:]]*[[:blank:]]//` && git push origin :`vultr version | sed s/^[^[:blank:]]*[[:blank:]]//`
	@./.tools/release.sh
