#!/bin/sh
#!/usr/bin/with-contenv sh

set -e # Exit immediately if a command exits with a non-zero status.
set -u # Treat unset variables as an error.

log() {
    echo "[cont-init.d] $(basename $0): $*"
}

# Make sure some directories are created.
mkdir -p /storage

# Check if config exists. If not, copy in the sample config
if [ -f /config/xdg/config/tixati/settings2.dat ]; then
  echo "Using existing config file."
else
  echo "Using default config file."
  mkdir -p /config/xdg/config/tixati
  cp /settings2.dat /config/xdg/config/tixati/settings2.dat
fi

# Generate machine id.
log "generating machine-id..."
cat /proc/sys/kernel/random/uuid | tr -d '-' > /etc/machine-id

# Take ownership of the config directory content.
find /storage -mindepth 1 -exec chown $USER_ID:$GROUP_ID {} \;

# vim: set ft=sh :