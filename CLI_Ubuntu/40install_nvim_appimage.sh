#!/bin/bash +x
. ../prelude.sh
# The script should not require any user input and should be idempotent.

# TODO implement AppImageUpdate method
# https://github.com/AppImageCommunity/AppImageUpdate
# TODO - consider compiling nvim myself or using tar.gz
install_nvim()
{
    readonly NVIM_DOWNLOAD_PATH="/opt/nvim"
    readonly NVIM_INSTALL_PATH="/usr/local/bin/nvim"

    sudo mkdir -p "${NVIM_DOWNLOAD_PATH}"
    pushd "${NVIM_DOWNLOAD_PATH}"
    sudo curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage
    sudo chmod u+x nvim-linux-x86_64.appimage
    # I benchmarked it. The extracted AppImage has around 50ms faster startup
    sudo ./nvim-linux-x86_64.appimage --appimage-extract
    sudo ln -sfTn "${NVIM_DOWNLOAD_PATH}/squashfs-root/AppRun" "${NVIM_INSTALL_PATH}"

    if ! sudo update-alternatives --set editor "${NVIM_INSTALL_PATH}"; then
        sudo update-alternatives --install /usr/bin/editor editor "${NVIM_INSTALL_PATH}" 100
        sudo update-alternatives --set editor "${NVIM_INSTALL_PATH}"
    fi

    popd || exit "${EXIT_FILE_IO_ERROR}"
}

install_nvim
