#!/bin/bash

set -e -o pipefail

DIRECTORY="$(pwd)/$(git rev-parse --show-cdup)"

"${DIRECTORY}/vultr" version
"${DIRECTORY}/vultr" server list
