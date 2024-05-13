#!/bin/bash

set -e

# Optional: Import test library
source dev-container-features-test-lib

# Definition specific tests
check "server" /opt/jellyfin/jellyfin/jellyfin --version 2>&1| grep 10.9.1

# Report result
reportResults