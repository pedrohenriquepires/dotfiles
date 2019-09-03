#!/bin/bash
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
cat $DIR/banner.txt
vimrc_source=$DIR/vimrc
vimrc_target=$HOME/.vimrc

if [ ! -L "$vimrc_target" ]; then
  echo "Creating a symbolic link from $vimrc_source to $vimrc_target"
  ln -s $vimrc_source $vimrc_target
fi

# Installs Vundle if needed
if [ ! -d "$HOME/.vim/bundle/Vundle.vim" ]; then
  echo "Installing Vundle.vim..."
  git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
  echo "Vundle.vim installed successfuly."
fi

# Copy all themes to /colors
mkdir -p $HOME/.vim/colors
cp $DIR/colors/* $HOME/.vim/colors/

if [ ! -L "$HOME/.vim/snippets" ]; then
  echo "Configuring custom snippets..."
  ln -s $DIR/snippets $HOME/.vim/snippets
  echo "Snippets configured successfuly."
fi

# Installs Vundle plugins
echo "Installing Vundle plugins..."
vim +PluginInstall +qall
echo "Plugins installed successfuly."

echo "Vim setup successful."
