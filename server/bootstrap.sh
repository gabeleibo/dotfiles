#!/bin/bash

set -eu

export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get upgrade -y

apt-get install -qq -y \
  docker.io \
  openssh-server \

echo "Creating directories"
mkdir -p /root/code /root/secrets

echo "=> Setting up dev service"
cat > dockerdev.service <<EOF
[Unit]
Description=dockerdev
Requires=docker.service
After=docker.service
[Service]
TimeoutStartSec=0
ExecStartPre=-/usr/bin/docker kill dev
ExecStartPre=-/usr/bin/docker rm dev
ExecStartPre=/usr/bin/docker pull gabeleibo/dev:latest
ExecStart=/usr/bin/docker run -h dev -e TZ=Europe/Berlin --net=host --rm -v /var/run/docker.sock:/var/run/docker.sock -v /root/code:/root/code -v /root/secrets:/root/secrets --cap-add=SYS_PTRACE --security-opt seccomp=unconfined --privileged --name dev gabeleibo/dev:latest
[Install]
WantedBy=multi-user.target
EOF

sudo mv dockerdev.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable dockerdev
sudo systemctl start dockerdev

echo "Done!"
