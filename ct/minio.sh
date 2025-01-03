#!/usr/bin/env bash
source <(curl -s https://raw.githubusercontent.com/community-scripts/ProxmoxVE/main/misc/build.func)
# Copyright (c) 2021-2025 community-scripts ORG
# Author: Muhammad Yuga Nugraha
# License: MIT | https://github.com/community-scripts/ProxmoxVE/raw/main/LICENSE
# Source: https://min.io/

# App Default Values
APP="MinIO"
var_tags="storage;minio"
var_cpu="1"
var_ram="512"
var_disk="50"
var_os="ubuntu"
var_version="24.04"
var_unprivileged="1"

# App Output & Base Settings
header_info "$APP"
base_settings

# Core
variables
color
catch_errors


function update_script() {
   header_info
   check_container_storage
   check_container_resources
   if [[ ! -d /usr/local/bin/minio ]]; then
      msg_error "No ${APP} Installation Found!"
      exit
   fi
   msg_info "Updating $APP LXC"
   apt-get update &>/dev/null
   apt-get -y upgrade &>/dev/null
   msg_ok "Updated $APP LXC"
   exit
}

start
build_container
description

msg_ok "Completed Successfully!\n"
echo -e "${CREATING}${GN}${APP} setup has been successfully initialized!${CL}"
echo -e "${INFO}${YW} Access it using the following URL:${CL}"
echo -e "${TAB}${GATEWAY}${BGN}http://${IP}:9001${CL}"