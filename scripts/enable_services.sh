#!/bin/bash

set -ouex pipefail

systemctl enable docker.socket
# systemctl add-wants niri.service mako.service
# systemctl add-wants niri.service waybar.service
# systemctl add-wants niri.service swaybg.service
