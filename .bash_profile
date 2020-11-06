parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

export PS1="\u@\h \[\033[32m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ "

# Apple likes to think they know which shell I prefer
export BASH_SILENCE_DEPRECATION_WARNING=1

# navigation helpers
alias cd..="cd .."
alias ..="cd .."
alias ...="cd ../../"
alias ....="cd ../../../"
alias .....="cd ../../../../"

# alias typos I frequently encounter
alias dc="cd" #dc is apparently a calculator
alias cdc="cd"

alias sl="ls"
alias sls="ls"

#tmux
alias t='(tmux has-session 2>/dev/null && tmux attach) || (tmux new-session)'

# git helpers
alias g="git"
alias gg="git grep"
alias gs="git status" # I'll rue the day I require ghost script.  
alias gd="cd '$(git rev-parse --show-toplevel)'"

# tools
alias grep="grep --color"

eval "$(rbenv init -)"

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
