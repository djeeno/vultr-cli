#!/bin/bash

set -e -o pipefail

DIRECTORY="$(echo "$(pwd)/$(git rev-parse --show-cdup)" | sed 's@/$@@')"

##
# README.md
##
printf "\e[1;37m%s\e[0m\n" "$(LANG=C date) [TEST]  -- git diff README.md Testing ----------------"
LATEST=$(git ls-remote --refs --tags https://github.com/djeeno/vultr-cli.git | grep -Eo "[0-9\.]*$" | sort -V | tail -1)
perl -pe 's@(curl -LRsS https://raw.githubusercontent.com/djeeno/vultr-cli)/[^/]+/(vultr -o /tmp/vultr)@\1/'"${LATEST}"'/\2@' -i "${DIRECTORY}/README.md"
if [ -z "$(git diff ./README.md)" ]; then
  printf "\e[1;32m%s\e[0m\n" "$(LANG=C date) [INFO]  -- git diff README.md Passed ----------------"
else
  git diff ./README.md
  printf "\e[1;31m%s\e[0m\n" "$(LANG=C date) [ERROR] == git diff README.md Failed ================"
  exit 1
fi

##
# vultr
##
printf "\e[1;37m%s\e[0m\n" "$(LANG=C date) [TEST]  -- vultr Testing ----------------"
CODE=0
echo $ vultr version \
  ; "${DIRECTORY}/vultr" version \
  ; CODE=$((CODE+$?))
echo $ vultr account info \
  ; "${DIRECTORY}/vultr" account info \
  ; CODE=$((CODE+$?))
echo $ vultr server list \
  ; "${DIRECTORY}/vultr" server list \
  ; CODE=$((CODE+$?))
if [ "${CODE}" -eq 0 ]; then
  printf "\e[1;32m%s\e[0m\n" "$(LANG=C date) [INFO]  -- git diff README.md Passed ----------------"
else
  git diff ./README.md
  printf "\e[1;31m%s\e[0m\n" "$(LANG=C date) [ERROR] == git diff README.md Failed ================"
  exit 1
fi

