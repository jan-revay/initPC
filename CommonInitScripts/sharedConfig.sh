#!/bin/bash -x
# WARNING: this scripts expects ./CommonInitScripts as a working directory

# TODO rename to snake case shared_configs_install.sh
# TODO cd working directory to ./CommonInitScripts in this script
# see: https://stackoverflow.com/questions/59895/how-do-i-get-the-directory-where-a-bash-script-is-located-from-within-the-script

. ../prelude.sh

# ==== Enable git hooks ====

pushd ../.git/hooks/ || exit ${EXIT_FILE_IO_ERROR}
ln -s --force ../../pre-commit-hook.sh pre-commit
popd || exit ${EXIT_FILE_IO_ERROR}

. git_config.sh.ps1
. mkdirs.sh
. install_dotfiles.sh
