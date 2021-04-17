#!/usr/bin/env bash

FILES=".bash_profile .vimrc .gitconfig"
FORCE=0
time=$(date +%s)

while getopts 'f' c
do
  case $c in
    f) FORCE=1 ;;
  esac
done

mkdir ./system_originals/$time/ || exit 1
for i in $(echo $FILES| tr ";" "\n")

do
  if [ -f ~/dotfiles/system_originals/$time/$i ] && [ $FORCE = 0 ] ; then
    echo "You might be overwriting the original system files."
    exit 1
  fi
  #save files, just in case
  cp ~/$i ./system_originals/$time/$i 2> /dev/null

  cp ~/dotfiles/$i ~/$i
done

#Add vim templates
mkdir -p ~/.vim/templates 2>/dev/null
cp ./vim/templates/* ~/.vim/templates/

# TODO: I don't think this currently works.
# it might be sourcing the bqash profile for the process running the script
# Leaving for now because it makes it easier to debug 
source ~/.bash_profile
