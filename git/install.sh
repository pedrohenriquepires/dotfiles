#!/bin/bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

config_source=$DIR/.gitconfig
config_target=$HOME/.gitconfig
gitignore_source=$DIR/.gitignore_global
gitignore_target=$HOME/.gitignore_global

if [ ! -L "$target" ]; then
  echo "Copying $config_source to $config_target"
  yes | cp -rf $config_source config_$target

  echo "Copying $gitignore_source to $gitignore_target"
  yes | cp -rf $gitignore_source $gitignore_target
fi

echo "Git setup successful."