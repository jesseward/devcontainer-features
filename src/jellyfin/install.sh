#!/bin/sh
set -e
INSTALL_VERSION=${VERSION:-10.9.1}
JELLYFIN_ARCH=${ARCH:-amd64}
JELLYFIN_HOME=/opt/jellyfin

echo "Installing feature 'Jellyfin v${INSTALL_VERSION}' for ${JELLYFIN_ARCH}"

check_packages() {
  if ! dpkg -s "$@" >/dev/null 2>&1; then
    apt-get update -y
    apt-get -y install --no-install-recommends "$@"
  fi
}

# see the install notes at https://jellyfin.org/docs/general/installation/linux#linux-generic-amd64
install_binaries() {
    _release="jellyfin_${INSTALL_VERSION}-${JELLYFIN_ARCH}.tar.gz"
    mkdir -p ${JELLYFIN_HOME}
    cd ${JELLYFIN_HOME}
    echo "Fetching Jellyfin version=${_release}"
    curl -LO https://repo.jellyfin.org/files/server/linux/latest-stable/${JELLYFIN_ARCH}/${_release}
    echo "Extracting Jellyfin version=${_release} to path=${JELLYFIN_HOME}"
    tar xvzf ${_release}
    rm ${_release}
    ln -s jellyfin_${INSTALL_VERSION} jellyfin
    mkdir -p data cache config log
    PATH=/usr/bin find ${JELLYFIN_HOME} -type d -execdir chmod 755 "{}" \;
    chmod -R a+w $JELLYFIN_HOME
}

install_init() {
    tee /usr/local/share/jellyfin-init.sh << 'EOF'
#!/bin/sh
set -e

JELLYFINDIR="/opt/jellyfin"

$JELLYFINDIR/jellyfin/jellyfin \
 -d $JELLYFINDIR/data \
 -C $JELLYFINDIR/cache \
 -c $JELLYFINDIR/config \
 -l $JELLYFINDIR/log

set +e

# Execute whatever commands were passed in (if any). This allows us
# to set this script to ENTRYPOINT while still executing the default CMD.
exec "$@"
EOF

    chmod +x /usr/local/share/jellyfin-init.sh
    chown ${USERNAME}:root /usr/local/share/jellyfin-init.sh
}


check_packages curl ca-certificates ffmpeg
install_binaries
install_init
