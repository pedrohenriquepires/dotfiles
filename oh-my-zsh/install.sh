#!/bin/bash

# Install Oh-My-ZSH if it is not already installed
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source=$DIR/.zshrc
target=$HOME/.zshrc

if [ ! -L "$target" ]; then
  echo "Copying $source to $target"
  yes | cp -rf $source $target
fi

mkdir -p $ZSH_CUSTOM/plugins/
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions

# Copy all themes to /themes
mkdir -p $ZSH_CUSTOM/themes/
cp $DIR/themes/* $ZSH_CUSTOM/themes/

echo "Oh-My-Zsh setup successful."