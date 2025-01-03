#!/usr/bin/env bash

# Copyright (c) 2021-2025 tteck
# Author: tteck (tteckster)
# License: MIT
# https://github.com/community-scripts/ProxmoxVE/raw/main/LICENSE

source /dev/stdin <<< "$FUNCTIONS_FILE_PATH"
color
verb_ip6
catch_errors
setting_up_container
network_check
update_os

msg_info "Installing Dependencies"
$STD apt-get install -y curl
$STD apt-get install -y sudo
$STD apt-get install -y mc
msg_ok "Installed Dependencies"

msg_info "Installing MinIO"
$STD wget https://dl.min.io/server/minio/release/linux-amd64/archive/minio_20241218131544.0.0_amd64.deb -O minio.deb
$STD dpkg -i minio.deb
rm minio.deb
msg_ok "Installed WireGuard"

groupadd -r minio-user
useradd -M -r -g minio-user minio-user

msg_info "Creating Config for MinIO"
cat <<EOF >/etc/default/minio
MINIO_OPTS="--console-address :9001"
MINIO_ROOT_USER=minioadmin
MINIO_ROOT_PASSWORD=minioadmin
MINIO_VOLUMES="/mnt/data"
EOF
msg_ok "Created Config for MinIO"

motd_ssh
customize

msg_info "Cleaning up"
$STD apt-get -y autoremove
$STD apt-get -y autoclean
msg_ok "Cleaned"