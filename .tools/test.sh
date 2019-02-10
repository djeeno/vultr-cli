#!/bin/bash

set -e -o pipefail

DIRECTORY="$(pwd)/$(git rev-parse --show-cdup)"

"${DIRECTORY}/vultr" version
set -x
"${DIRECTORY}/vultr" account info
"${DIRECTORY}/vultr" server list
