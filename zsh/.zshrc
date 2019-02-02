ZSH_THEME="minimal"
CASE_SENSITIVE="false"
HYPHEN_INSENSITIVE="true"
DISABLE_AUTO_UPDATE="false"
DISABLE_LS_COLORS="false"
DISABLE_AUTO_TITLE="true"
ENABLE_CORRECTION="false"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
HIST_STAMPS="dd.mm.yyyy"
ZSH_DISABLE_COMPFIX="true"

plugins=(
  git
  extract
  pass
  rsync
  tmux
  docker
  gitignore
  go
  node
  npm
  nvm
  osx
  autojump
)

addToPath() {
  if [[ -d $1 ]]; then
    export PATH=$1:$PATH
  fi
}

export PATH=$HOME/bin:/usr/local/bin:$PATH

addToPath ~/.npm-global/bin
addToPath ~/go/bin

export EDITOR=nvim
export ZSH="/Users/xdefrag/.oh-my-zsh"
export LANG=en_US.UTF-8
export GOPATH=~/go
export GOBIN=~/go/bin

export GO111MODULE=on

alias v=nvim
alias vi=nvim
alias vim=nvim

alias k=kubectl
alias kgp=kubectl get pods

alias e=etcdctl

alias p=pass
alias df=df -h

# Zsh
source $ZSH/oh-my-zsh.sh

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# heroku autocomplete setup
HEROKU_AC_ZSH_SETUP_PATH=~/Library/Caches/heroku/autocomplete/zsh_setup && test -f $HEROKU_AC_ZSH_SETUP_PATH && source $HEROKU_AC_ZSH_SETUP_PATH;

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.cargo ] && source ~/.cargo/env
[ -f ~/.phpbrew ] && source ~/.phpbrew/bashrc
export PATH="/usr/local/sbin:$PATH"
