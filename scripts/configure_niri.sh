#!/bin/bash

set -ouex pipefail

# Use Catppuccin Mocha theme for SDDM
sed -i '/^\[Theme\]/,/^\[/{s/^Current=.*/Current=catppuccin-mocha/}' /etc/sddm.conf