if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

export PS1="\u@\h \[\033[32m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ "
export EDITOR=$(which vim)

# Apple likes to think they know which shell I prefer
export BASH_SILENCE_DEPRECATION_WARNING=1

cd () {
	builtin cd $1
	ls -ltr
}

# We'll see if I ever remember to use this ...
extract () {
  if [ -f $1 ] ; then
      case $1 in
          *.tar.bz2)   tar xvjf $1    ;;
          *.tar.gz)    tar xvzf $1    ;;
          *.bz2)       bunzip2 $1     ;;
          *.rar)       rar x $1       ;;
          *.gz)        gunzip $1      ;;
          *.tar)       tar xvf $1     ;;
          *.tbz2)      tar xvjf $1    ;;
          *.tgz)       tar xvzf $1    ;;
          *.zip)       unzip $1       ;;
          *.Z)         uncompress $1  ;;
          *.7z)        7z x $1        ;;
          *)           echo "don't know how to extract '$1'..." ;;
      esac
  else
      echo "'$1' is not a valid file!"
  fi
}

gb () {
  NUM="${1:-10}"
  git branch --sort=-committerdate | head -n $NUM
}

# needs to be created for vim
# only needs to run once per machine, but putting in bash
# profile because it's easier
mkdir -p $HOME/.vim/swapfiles

# Run at shell start
export PATH="/usr/local/opt/openjdk/bin:$PATH"

# Rust
. "$HOME/.cargo/env"

# Ruby
eval "$(rbenv init -)"

# Node
export PATH="/home/eric/.local/share/fnm:$PATH"
eval "$(fnm env --use-on-cd --shell bash)"

# go
export PATH="/home/eric/go/bin:$PATH"

