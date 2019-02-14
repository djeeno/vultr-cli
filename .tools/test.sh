#!/bin/bash

set -e -o pipefail

DIRECTORY="$(echo "$(pwd)/$(git rev-parse --show-cdup)" | sed 's@/$@@')"
BIN_NAME=vultr
LATEST=$(git ls-remote --refs --tags https://github.com/djeeno/${BIN_NAME}-cli.git | grep -Eo "[0-9\.]*$" | sort -V | tail -1) || true

##
# README.md
##
printf "\e[1;37m%s\e[0m\n" "$(LANG=C date) [TEST]  -- git diff README.md Testing ----------------"
perl -pe 's@(curl -LRsS https://raw.githubusercontent.com/djeeno/'"${BIN_NAME}"'-cli)/[^/]+/('"${BIN_NAME}"' -o /tmp/'"${BIN_NAME}"')@\1/'"${LATEST:="0.0.1"}"'/\2@' -i "${DIRECTORY}/README.md"
if [ -z "$(git diff ./README.md)" ]; then
  printf "\e[1;32m%s\e[0m\n" "$(LANG=C date) [INFO]  -- git diff README.md Passed ----------------"
else
  git diff ./README.md
  printf "\e[1;31m%s\e[0m\n" "$(LANG=C date) [ERROR] == git diff README.md Failed ================"
  exit 1
fi

##
# ${BIN_NAME}
##
printf "\e[1;37m%s\e[0m\n" "$(LANG=C date) [TEST]  -- ${BIN_NAME} Testing ----------------"
CODE=0
echo $ ${BIN_NAME} version \
  ; "${DIRECTORY}/${BIN_NAME}" version \
  ; CODE=$((CODE+$?))
echo $ ${BIN_NAME} account info \
  ; "${DIRECTORY}/${BIN_NAME}" account info \
  ; CODE=$((CODE+$?))
echo $ ${BIN_NAME} server list \
  ; "${DIRECTORY}/${BIN_NAME}" server list \
  ; CODE=$((CODE+$?))
if [ "${CODE}" -eq 0 ]; then
  printf "\e[1;32m%s\e[0m\n" "$(LANG=C date) [INFO]  -- git diff README.md Passed ----------------"
else
  git diff ./README.md
  printf "\e[1;31m%s\e[0m\n" "$(LANG=C date) [ERROR] == git diff README.md Failed ================"
  exit 1
fi

