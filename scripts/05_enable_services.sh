#!/bin/bash

set -ouex pipefail

groupadd docker || true
systemctl enable docker.socket
