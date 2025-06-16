# Connect home using WireGuard
connect-home:
    #!/bin/bash
    echo "Connecting to home"
    sudo tailscale up --exit-node fw --accept-routes

# Disconnect from home using WireGuard
disconnect-home:
    #!/bin/bash
    echo "Disconnecting from home"
    tailscale down

# Install system flatpaks
_install-isengard-flatpaks:
    #!/bin/bash
    MORDOR_FLATPAK_LIST="$(curl https://raw.githubusercontent.com/noelmiller/mordor/main/flatpaks/mordor_flatpaks | tr '\n' ' ')"
    echo "Installing Mordor Flatpaks.."
    flatpak --system -y install ${MORDOR_FLATPAK_LIST}
