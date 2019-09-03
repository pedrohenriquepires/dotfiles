#!/bin/bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

source=$DIR/.hyper.js
target=$HOME/.hyper.js

if [ ! -L "$target" ]; then
  echo "Copying $source to $target"
  yes | cp -rf $source $target
fi

echo "Hyper setup successful."