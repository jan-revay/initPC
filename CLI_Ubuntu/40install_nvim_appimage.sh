#!/bin/bash +x
. ../prelude.sh
# The script should not require any user input and should be idempotent.

# TODO implement AppImageUpdate method
# https://github.com/AppImageCommunity/AppImageUpdate
install_nvim()
{
    readonly NVIM_PATH="$HOME/.local/nvim_appimage"

    mkdir -p "${NVIM_PATH}"
    pushd "${NVIM_PATH}"
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage
    chmod u+x nvim-linux-x86_64.appimage
    ln -sTnf "${NVIM_PATH}/nvim-linux-x86_64.appimage" ~/.local/bin/nvim

    popd || exit "${EXIT_FILE_IO_ERROR}"
}

install_nvim
