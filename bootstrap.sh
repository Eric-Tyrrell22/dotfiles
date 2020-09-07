#!/usr/bin/env bash

FILES=".bash_profile .vimrc .gitconfig"

for i in $(echo $FILES| tr ";" "\n")
do
  if [ -f ~/dotfiles/system_originals/$i ]; then
    echo "You might be overwriting the original system files."
    exit 1
  fi
  #save files, just in case
  cp ~/$i ./system_originals/$i 2> /dev/null

  cp ~/dotfiles/$i ~/$i
done
