#!/bin/bash

dnf5 -y install --nogpgcheck --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' terra-release{,-extras}
dnf5 -y config-manager setopt "terra".enabled=true

dnf5 -y config-manager addrepo --overwrite --from-repofile=https://pkgs.tailscale.com/stable/fedora/tailscale.repo
dnf5 -y config-manager setopt "tailscale".enabled=true

set -ouex pipefail

# Packages

niri_packages=(
  "niri"
  "gnome-keyring"
  "xdg-desktop-portal-gnome"
  "xdg-desktop-portal-gtk"
  "xwayland-satellite"
  "alacritty"
  "fuzzel"
  "swaylock"
  "wireplumber"
  "waybar"
  "swaybg"
  "sddm"
)

sysadmin_packages=(
  "subscription-manager"
  "cockpit-navigator"
  "cockpit-bridge"
  "cockpit-system"
  "cockpit-selinux"
  "cockpit-networkmanager"
  "cockpit-storaged"
  "cockpit-podman"
  "cockpit-machines"
  "cockpit-kdump"
  "libguestfs-tools"
  "NetworkManager-tui"
  "virt-install"
  "virt-manager"
  "virt-viewer"
)

programming_packages=(
  "code"
  "gh"
  "git-lfs"
  "insync"
  "nodejs"
)

# including firefox because vscode needs it
utility_packages=(
  "firefox"
  "keyd"
  "neohtop"
  "syncthing"
  "stow"
  "scrcpy"
  "tailscale"
)

obs_packages=(
  "obs-studio"
  "obs-studio-plugin-droidcam"
  "obs-studio-plugin-vaapi"
  "obs-studio-plugin-webkitgtk"
)

docker_packages=(
  "docker-ce"
  "docker-ce-cli"
  "containerd.io"
  "docker-buildx-plugin"
  "docker-compose-plugin"
)

packages=(
  ${niri_packages[@]}
  ${sysadmin_packages[@]}
  ${programming_packages[@]}
  ${utility_packages[@]}
  ${docker_packages[@]}
  ${obs_packages[@]}
)

# install rpms
dnf5 install -y ${packages[@]}

dnf5 -y config-manager setopt "terra".enabled=false
dnf5 -y config-manager setopt "tailscale".enabled=false