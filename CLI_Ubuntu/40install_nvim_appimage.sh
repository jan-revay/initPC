#!/bin/bash +x
. ../prelude.sh
# The script should not require any user input and should be idempotent.

# TODO implement AppImageUpdate method
# https://github.com/AppImageCommunity/AppImageUpdate
# TODO - consider compiling nvim myself or using tar.gz
# TODO .tar.gz is quicker it seems - see:
# hyperfine --warmup 10 './nvim "+qa" ~/initPC/Ubuntu/10packages.sh' '/usr/local/bin/nvim "+qa" ~/initPC/Ubuntu/10packages.sh'
# TODO - benchmark multiple scenarios and use .tar.gz instead?
# TODO - try compiling from source with tuned flags and compare to .tar.gz
install_nvim()
{
    sudo apt-get -y remove neovim
    readonly NVIM_DOWNLOAD_PATH="/opt/nvim"
    readonly NVIM_INSTALL_PATH="/usr/local/bin/nvim"

    sudo mkdir -p "${NVIM_DOWNLOAD_PATH}"
    pushd "${NVIM_DOWNLOAD_PATH}"
    sudo curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage
    sudo chmod u+x nvim-linux-x86_64.appimage
    sudo rm -rf ./squashfs-root
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
