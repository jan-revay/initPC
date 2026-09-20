#!/bin/bash +x
. ../prelude.sh
# The script should not require any user input and should be idempotent.

# TODO install via apt or some package manager on Ubuntu 26.04
# Ubuntu 26.04 provides starship in its apot package manager
# Ubuntu 24.04 does not provide starship in apt
# TODO try to avoid passing random scripts from the internet to sh...
curl -sS https://starship.rs/install.sh | sh -s -- -y
