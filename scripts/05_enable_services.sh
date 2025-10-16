#!/bin/bash

set -ouex pipefail

groupadd docker || true
systemctl enable docker.socket

systemctl preset --global noctalia
systemctl preset --global xwayland-satellite

systemctl enable --global noctalia.service
systemctl enable --global xwayland-satellite.service
