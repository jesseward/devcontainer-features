#!/bin/bash

set -e

# Optional: Import test library
source dev-container-features-test-lib

# Definition specific tests
check "server" /opt/jellyfin/jellyfin/jellyfin --version| grep 10.8.13.0

# Report result
reportResults