
# navigation helpers
alias cd..="cd .."
alias ..="cd .."
alias ...="cd ../../"
alias ....="cd ../../../"
alias .....="cd ../../../../"

# alias typos I frequently encounter
alias cdc="cd"

alias sl="ls"
alias sls="ls"

#tmux
alias t='(tmux has-session 2>/dev/null && tmux attach) || (tmux new-session)'

# git helpers
alias g="git"
alias gg="git grep"
alias gs="git status" # I'll rue the day I require ghost script.  
alias gd='cd "$(git rev-parse --show-toplevel)"'
alias f='git ci --fixup=$(git log --grep "fixup" --invert-grep -n 1 --format="%H")'
squash() {
  # Find the first non-fixup commit
  REV=$(git log --grep="^[^fixup!]" --pretty=format:"%h" | head -n 1)

  # Make a squash commit and start the interactive rebase
  git rebase -i --autosquash $REV^
}

#kubectl
alias kk='kubectl'
alias kkgc='kk config get-contexts'
alias kkuc='kk config use-context'
setns () { kk config set-context --current --namespace="$@"; }

#docker-compose helpers
alias dc="docker-compose"
alias dcu="docker-compose up"
alias dcd="docker-compose down"

# tools
alias grep="grep --color"

# avoids confusion of fresh installs
alias vi='vim'

cd () {
	builtin cd $1
	ls -ltr
}
