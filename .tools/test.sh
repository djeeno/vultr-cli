#!/bin/bash

set -e -o pipefail

DIRECTORY="$(echo "$(pwd)/$(git rev-parse --show-cdup)" | sed 's@/$@@')"

"${DIRECTORY}/vultr" version
set -x
"${DIRECTORY}/vultr" account info
"${DIRECTORY}/vultr" server list
