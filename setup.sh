#!/bin/bash

DEV=~/dev

# Setup dev dir
mkdir -p ${DEV}

# Install zsh
sudo dnf install zsh util-linux-user exa
export RUNZSH="no"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
ln -sf ${PWD}/.zshrc ~/

# Install tmux
git -C ${DEV}/base16-tmux pull || git clone git@github.com:tinted-theming/base16-tmux.git ${DEV}/base16-tmux
sudo dnf install tmux
ln -sf $PWD/.tmux.conf ~

#install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Install alacritty
ALACRITTY_SRC=${DEV}/alacritty
sudo dnf install cmake freetype-devel fontconfig-devel libxcb-devel libxkbcommon-devel g++
git -C ${ALACRITTY_SRC} pull || git clone https://github.com/alacritty/alacritty.git ${ALACRITTY_SRC}
cd ${ALACRITTY_SRC}
cargo build --release
sudo ln -sf ${ALACRITTY_SRC}/target/release/alacritty /usr/local/bin
sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
sudo desktop-file-install extra/linux/Alacritty.desktop
sudo update-desktop-database
cd -
ln -sf ${PWD}/.alacritty.yml ~

# Install vscode
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
dnf check-update
sudo dnf install code

# Install Helix
sudo dnf copr enable varlad/helix
sudo dnf install helix

# Link config files
ln -sf $PWD/.config/* ~/.config

