#!/bin/bash

set -e

# Optional: Import test library
source dev-container-features-test-lib

# Definition specific tests
check "server" toxiproxy-server -version| grep 2.7.0
check "cli" toxiproxy-cli -version | grep 2.7.0

# Report result
reportResults