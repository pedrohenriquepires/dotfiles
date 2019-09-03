#!/bin/bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

source=$DIR/.gitconfig
target=$HOME/.gitconfig

if [ ! -L "$target" ]; then
  echo "Copying $source to $target"
  yes | cp -rf $source $target
fi

echo "Git setup successful."