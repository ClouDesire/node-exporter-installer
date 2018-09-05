#!/bin/sh -e
VERSION=0.16.0
RELEASE=node_exporter-${VERSION}.linux-amd64

_check_root () {
    if [ $(id -u) -ne 0 ]; then
        echo "Please run as root" >&2;
        exit 1;
    fi
}

_install_curl () {
    if [ -x "$(command -v curl)" ]; then
        return
    fi

    if [ -x "$(command -v apt-get)" ]; then
        apt-get update
        apt-get -y install curl
    elif [ -x "$(command -v yum)" ]; then
        yum -y install curl
    else
        echo "No known package manager found" >&2;
        exit 1;
    fi
}

_check_root
_install_curl

cd /tmp
curl -sSL https://github.com/prometheus/node_exporter/releases/download/v${VERSION}/${RELEASE}.tar.gz | tar xz
mkdir -p /opt/node_exporter
mv ${RELEASE}/node_exporter /opt/node_exporter/
rm -rf /tmp/${RELEASE}

if [ -x "$(command -v systemctl)" ]; then
    cat << EOF > /lib/systemd/system/node-exporter.service
[Unit]
Description=Prometheus agent
After=network.target
StartLimitIntervalSec=0

[Service]
Type=simple
Restart=always
RestartSec=1
ExecStart=/opt/node_exporter/node_exporter

[Install]
WantedBy=multi-user.target
EOF

    systemctl enable node-exporter
    systemctl start node-exporter
elif [ -x "$(command -v chckconfig)" ]; then
    cat << EOF >> /etc/inittab
::respawn:/opt/node_exporter/node_exporter
EOF
elif [ -x "$(command -v initctl)" ]; then
    cat << EOF > /etc/init/node-exporter.conf
start on runlevel [23456]
stop on runlevel [016]
exec /opt/node_exporter/node_exporter
respawn
EOF

    initctl reload-configuration
    stop node-exporter || true && start node-exporter
else
    echo "No known service management found" >&2;
    exit 1;
fi
