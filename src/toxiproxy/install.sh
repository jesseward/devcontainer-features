#!/bin/sh
set -e

echo "Installing feature 'toxiproxy'"

INSTALL_VERSION=${VERSION:-latest}
INSTALL_ARCH=${ARCH:-amd64}

INSTALL_DIR=/usr/local/bin


install_binaries() {

    _url="https://github.com/Shopify/toxiproxy/releases/download/${INSTALL_VERSION}/"

    if [ "${INSTALL_VERSION}" = "latest" ]; then
        _url="https://github.com/Shopify/toxiproxy/releases/latest/download/"
    fi

    for _comp in cli server; do
        echo "Fetching Toxiproxy-${_comp} version=${INSTALL_VERSION}, arch=${INSTALL_ARCH}"
        wget -O ${INSTALL_DIR}/toxiproxy-${_comp} "${_url}/toxiproxy-${_comp}-linux-${INSTALL_ARCH}"
        chmod +x ${INSTALL_DIR}/toxiproxy-${_comp}
    done
}

install_init() {
    tee /usr/local/share/toxiproxy-server-init.sh << 'EOF'
#!/bin/sh
set -e

echo "Starting Toxiproxy Server version=${VERSION}"
/usr/local/bin/toxiproxy-server  >/tmp/toxiproxy-server.log 2>&1

set +e

# Execute whatever commands were passed in (if any). This allows us
# to set this script to ENTRYPOINT while still executing the default CMD.
exec "$@"
EOF

    chmod +x /usr/local/share/toxiproxy-server-init.sh
    chown ${USERNAME}:root /usr/local/share/toxiproxy-server-init.sh
}


install_binaries
install_init