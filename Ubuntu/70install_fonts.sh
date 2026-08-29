#!/bin/bash +x
. ../prelude.sh
# The script should not require any user input and should be idempotent.
#

# OLD code
# mkdir -p ~/.local/share/fonts
# cd /tmp
# wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
# unzip JetBrainsMono.zip -d ~/.local/share/fonts/JetBrainsMonoNerd
# sudo fc-cache -fv

# TODO test and check the new code
# TODO try more fonts
FONT_DIR="$HOME/.local/share/fonts/JetBrainsMonoNerd"
FONT_NAME="JetBrainsMono Nerd Font"

# Check if the font is already installed
if fc-list : family | grep -F "$FONT_NAME"; then
    echo "Font '$FONT_NAME' is already installed. Skipping installation."
else
    # Create font directory if it doesn't exist
    mkdir -p "$FONT_DIR"
    # Download and install the font
    cd /tmp
    wget -q --show-progress "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip"
    unzip -q -o JetBrainsMono.zip -d "$FONT_DIR"
    rm -f JetBrainsMono.zip

    # TODO research whether this fc-cache is enough (in comparison to refreshing without dir with sudo)
    # Update font cache (no sudo needed for user fonts)
    fc-cache -fv "$FONT_DIR"

    echo "Font '$FONT_NAME' installed successfully."
fi
