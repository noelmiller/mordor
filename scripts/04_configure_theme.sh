#!/bin/bash

set -ouex pipefail

git clone -b master --depth 1 https://github.com/keyitdev/sddm-astronaut-theme.git /usr/share/sddm/themes/sddm-astronaut-theme

sudo cp -r /usr/share/sddm/themes/sddm-astronaut-theme/Fonts/* /usr/share/fonts/

sed -i 's#ConfigFile=Themes/astronaut.conf#ConfigFile=Themes/jake_the_dog.conf#' /usr/share/sddm/themes/sddm-astronaut-theme/metadata.desktop
