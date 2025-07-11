#!/bin/bash

set -ouex pipefail

# configure terra repo
dnf5 -y install --nogpgcheck --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' terra-release{,-extras}

# configure tailscale repo
dnf5 -y config-manager addrepo --overwrite --from-repofile=https://pkgs.tailscale.com/stable/fedora/tailscale.repo

sed -i 's@enabled=0@enabled=1@g' /etc/yum.repos.d/negativo17-fedora-multimedia.repo

# enable ublue-os and nerd-fonts copr repos
dnf5 -y copr enable ublue-os/packages
dnf5 -y copr enable che/nerd-fonts

dnf5 -y config-manager setopt "*akmods*".priority=1
dnf5 -y config-manager setopt "*terra*".priority=2 "*terra*".exclude="nerd-fonts topgrade"

dnf5 -y install v4l2loopback /tmp/akmods-rpms/kmods/*v4l2loopback*.rpm

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
  "pavucontrol"
  "mako"
  "nautilus"
  "polkit-kde"
  "qt6-qtquickcontrols2"
  "qt6-qtsvg"
  "ntfs-3g"
  "nm-connection-editor"
  "network-manager-applet"
  "blueman"
)

fonts=(
  "nerd-fonts"
  "twitter-twemoji-fonts"
  "google-noto-sans-cjk-fonts"
  "lato-fonts"
  "fira-code-fonts"
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
  "chezmoi"
  "gh"
  "git-lfs"
  "insync"
  "neovim"
  "nodejs"
  "ublue-brew"
  "zellij"
)

# including firefox because vscode needs it
utility_packages=(
  "brightnessctl"
  "fastfetch"
  "firefox"
  "keyd"
  "kdenlive"
  "seahorse"
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
  ${fonts[@]}
)

# install rpms
dnf5 install -y ${packages[@]}

# for brew
curl -Lo /usr/share/bash-prexec https://raw.githubusercontent.com/ublue-os/bash-preexec/master/bash-preexec.sh

# disable repos

# terra
dnf5 -y config-manager setopt "terra".enabled=false

# negativo17
sed -i 's@enabled=0@enabled=1@g' /etc/yum.repos.d/negativo17-fedora-multimedia.repo

# tailscale
dnf5 config-manager setopt "*tailscale*".enabled=0

# packages
dnf5 -y copr disable ublue-os/packages

# fonts
dnf5 -y copr disable che/nerd-fonts

# rpmfusion
dnf5 -y config-manager setopt "*fedora-multimedia*".enabled=0
