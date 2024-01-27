#!/bin/bash

set -e

# Optional: Import test library
source dev-container-features-test-lib

# Feature specific tests
check "jellyfin-init-exists" bash -c "ls /usr/local/share/jellyfin-init.sh"

# Report result
reportResults