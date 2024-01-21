#!/bin/bash

set -e

# Optional: Import test library
source dev-container-features-test-lib

# Feature specific tests
check "toxiproxy-server-init-exists" bash -c "ls /usr/local/share/toxiproxy-server-init.sh"

# Report result
reportResults