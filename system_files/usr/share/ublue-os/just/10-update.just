# vim: set ft=make :

alias upgrade := update

# Update system, flatpaks, and containers all at once
update:
    #!/usr/bin/bash

    # Source brew if we are not in an interactive session
    [[ $- != *i* ]] && source <(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

    /usr/bin/topgrade --config /usr/share/ublue-os/topgrade.toml --keep
